import socket
import RPi.GPIO as GPIO
import json
import time
from threading import Thread

class ParkingFloor:
    def __init__(self, config_file_path):
        self.load_config(config_file_path)
        self.initialize_response()
        self.socket_init()

    def load_config(self, config_file_path):
        with open(config_file_path) as file:
            self.config_file = json.load(file)
        GPIO.setwarnings(False)
        GPIO.setmode(GPIO.BCM)
        for output in self.config_file['output']:
            GPIO.setup(output['gpio'], GPIO.OUT)
        for inp in self.config_file['input']:
            GPIO.setup(inp['gpio'], GPIO.IN, pull_up_down=GPIO.PUD_DOWN)

    def initialize_response(self):
        self.state = [{"state": 0} for _ in range(8)]
        self.status_parking = {
            "id": self.config_file['floor_id'],
            "vaga": -1,
            "state": self.state,
            "type": "status_parking",
            "entry_sensor": 0,
            "exit_sensor": 0
        }
      

    def socket_init(self):
        ip = self.config_file["ip_central"]
        port = int(self.config_file["porta_central"])
        addr = (ip, port)
        while True:
            try:
                self.floor_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                self.floor_socket.connect(addr)
                print("Socket conectado")
                break
            except Exception as e:
                print(f"Erro ao iniciar o socket: {e}")
                time.sleep(1)

    def listen_socket(self):
        while True:
            try:
                data = self.floor_socket.recv(1024)
                if not data:
                    print('Mensagem não recebida')
                    break
                received_message = data.decode('utf-8')
                received_message = json.loads(received_message)
                print(received_message)
                self.execute_command(received_message)
            except json.JSONDecodeError:
                print("Erro de decodificação JSON.")
            except Exception as e:
                print(f"Erro ao receber dados: {e}")
                break
            time.sleep(1)
        self.floor_socket.close()

    def execute_command(self, received_message):
        try:
            lotado = self.config_file["output"][3]["gpio"]
            if received_message.get(f"SINAL_DE_LOTADO_FECHADO_{self.config_file['floor_id']}") == 1:
                GPIO.output(lotado, GPIO.HIGH)
            elif received_message.get(f"SINAL_DE_LOTADO_FECHADO_{self.config_file['floor_id']}") == 0:
                GPIO.output(lotado, GPIO.LOW)
        except Exception as e:
            print(f"Erro ao executar comando: {e}")

    def send_socket(self, message):
        try:
            data = json.dumps(message)
            data = data.encode()
            self.floor_socket.send(data)
        except Exception as e:
            print(f"Erro ao tentar enviar mensagem: {e}")
            self.floor_socket.close()
            self.socket_init()

    def set_gpio_for_slot(self, slot):
        gpio_pins = [self.config_file["output"][i]["gpio"] for i in range(3)]
        
        end_1 = GPIO.HIGH if slot in [2, 4, 6, 8] else GPIO.LOW
        end_2 = GPIO.HIGH if slot in [3, 4, 7, 8] else GPIO.LOW
        end_3 = GPIO.HIGH if slot in [5, 6, 7, 8] else GPIO.LOW
        
        GPIO.output(gpio_pins, (end_1, end_2, end_3))

    def vacancy_monitor(self):
        while True:
            for counter in range(1, 9):  # Vagas de 1 a 8
                self.set_gpio_for_slot(counter)
                time.sleep(0.1)
                entering = GPIO.input(self.config_file["input"][0]["gpio"])
                if entering == 1 and self.state[counter-1]["state"] == 0:
                    self.state[counter-1]["state"] = 1
                    self.status_parking["vaga"] = counter
                    print(self.status_parking)
                    self.send_socket(self.status_parking)
                elif entering == 0 and self.state[counter-1]["state"] == 1:
                    self.state[counter-1]["state"] = 0
                    self.status_parking["vaga"] = counter
                    print(self.status_parking)
                    self.send_socket(self.status_parking)

    def count_cars(self):
        while True:
            first_pin = self.config_file["input"][1]["gpio"]
            second_pin = self.config_file["input"][2]["gpio"]
            if GPIO.input(first_pin) and not GPIO.input(second_pin):
                self.calculate_qtd_cars_entering()
            if not GPIO.input(first_pin) and GPIO.input(second_pin):
                self.calculate_qtd_cars_leaving()

    def calculate_qtd_cars_entering(self):
        time.sleep(2)

    def calculate_qtd_cars_leaving(self):
        time.sleep(2)

    def run(self):
        monitoring = Thread(target=self.vacancy_monitor, args=())
        monitoring.start()
        count_thread = Thread(target=self.count_cars, args=())
        count_thread.start()
        self.listen_socket()
