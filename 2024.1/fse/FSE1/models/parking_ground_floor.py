import RPi.GPIO as GPIO
import time
from models.parking_floor import ParkingFloor


class GroundFloorParking(ParkingFloor):
    def __init__(self, config_file_path):
        super().__init__(config_file_path)

    def load_config(self, config_file_path):
        super().load_config(config_file_path)
        # Configurações adicionais, se necessário

    def count_cars(self):
        # Implementação específica para contagem de carros no primeiro andar
        entering_pin = self.config_file["input"][1]["gpio"]
        leaving_pin = self.config_file["input"][3]["gpio"]
        GPIO.add_event_detect(entering_pin, GPIO.RISING, callback=lambda x: self.calculate_qtd_cars_entering(entering_pin))
        GPIO.add_event_detect(leaving_pin, GPIO.RISING, callback=lambda x: self.calculate_qtd_cars_leaving(leaving_pin))

    def calculate_qtd_cars_entering(self, pin):
        # Específico para abrir a cancela de entrada
        motor = self.config_file["output"][4]["gpio"]
        GPIO.output(motor, GPIO.HIGH)
        time.sleep(2)
        GPIO.output(motor, GPIO.LOW)
        self.status_parking["type"] = 'car_is_entering'
        self.send_socket(self.status_parking)

    def calculate_qtd_cars_leaving(self, pin):
        # Específico para abrir a cancela de saída
        motor = self.config_file["output"][5]["gpio"]
        GPIO.output(motor, GPIO.HIGH)
        time.sleep(2)
        GPIO.output(motor, GPIO.LOW)
        self.status_parking["type"] = 'car_is_leaving'
        self.send_socket(self.status_parking)
