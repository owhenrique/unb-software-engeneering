import socket
from threading import Thread
import json
from uuid import uuid4
from datetime import datetime
import sys
import os

# Adiciona o diretório raiz ao sys.path
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from utils.print_parking_state import print_parking_state
from utils.calculate_parking_fee import calculate_parking_fee



class ParkingLot:
    def __init__(self):
        self.total_value = 0
        self.command = {"SINAL_DE_LOTADO_FECHADO_1": 0, "SINAL_DE_LOTADO_FECHADO_2": 0, "SINAL_DE_LOTADO_FECHADO_3": 0}
        self.parking_floors = {1: ParkingFloor(), 2: ParkingFloor(), 3: ParkingFloor()}
        self.carWithUnknownId = {"car_id": "", "entering_time": None}
        self.carLeavingInformations = {"spotWillBeFree": None, "idFloorSpotWillBeFree": None}
        self.state = [[{"state": 0} for _ in range(8)] for _ in range(3)]

    def present_menu(self, connections):
        """Apresenta o menu para interagir com os andares do estacionamento."""
        while True:
            try:
                print_parking_state(self.state)
                print("----------------- Menu --------------\n" +
                      "1. Fechar o estacionamento\n" +
                      "2. Abrir o estacionamento\n" +
                      "3. Bloquear primeiro andar\n" +
                      "4. Desbloquear primeiro andar\n" +
                      "5. Bloquear segundo andar\n" +
                      "6. Desbloquear segundo andar\n" +
                      "7. Ver status do estacionamento\n" +
                      "8. Sair")
                option = int(input())
                if option == 8:
                    sys.exit()
                elif option == 1 and self.command["SINAL_DE_LOTADO_FECHADO_1"] == 0:
                    self.command["SINAL_DE_LOTADO_FECHADO_1"] = 1
                    ParkingLotServer.send_socket(connections[0], self.command)
                elif option == 2:
                    if sum(floor.qtd_cars for floor in self.parking_floors.values()) < 16:
                        self.command["SINAL_DE_LOTADO_FECHADO_1"] = 0
                    else:
                        print("Estacionamento já está lotado")
                    ParkingLotServer.send_socket(connections[0], self.command)
                elif option == 3:
                    self.command["SINAL_DE_LOTADO_FECHADO_2"] = 1
                    ParkingLotServer.send_socket(connections[1], self.command)
                elif option == 4:
                    if self.parking_floors[2].qtd_cars < 8:
                        self.command["SINAL_DE_LOTADO_FECHADO_2"] = 0
                    else:
                        print("Andar 2 já está lotado")
                    ParkingLotServer.send_socket(connections[1], self.command)
                elif option == 5:
                    self.command["SINAL_DE_LOTADO_FECHADO_3"] = 1
                    ParkingLotServer.send_socket(connections[2], self.command)
                elif option == 6:
                    if self.parking_floors[3].qtd_cars < 8:
                        self.command["SINAL_DE_LOTADO_FECHADO_3"] = 0
                    else:
                        print("Andar 3 já está lotado")
                    ParkingLotServer.send_socket(connections[2], self.command)
                else:
                    print("Comando inválido. Por favor, escolha uma opção válida.")
            except ValueError:
                print("Comando inválido. Por favor, digite um número.")

            print()


class ParkingFloor:
    def __init__(self):
        self.qtd_cars = 0
        self.parking_spaces = 8
        self.times = [{"car_id": "", "entering_time": None} for _ in range(8)]
        

class ParkingLotServer:
    def __init__(self):
        self.host = 'localhost'
        self.port = 10031
        self.parking_lot = ParkingLot()

    def receive(self, connection, floor_number):
        while True:
            try:
                data = connection.recv(2048)
                if not data:
                    print('Message not received')
                    break
                data = json.loads(data.decode('utf-8'))

                print(f"data: {data}")
                print(f"floor_number: {floor_number}")
                print(f"----------------------------")

                if int(data["id"]) == floor_number:
                    floor = self.parking_lot.parking_floors[floor_number]

                    if data["type"] == "car_is_entering":
                        self.parking_lot.carWithUnknownId["car_id"] = str(uuid4())
                        self.parking_lot.carWithUnknownId["entering_time"] = datetime.now()
                        print(f"Car allocated with temporary id {self.parking_lot.carWithUnknownId['car_id']}: {self.parking_lot.carWithUnknownId['entering_time']}")


                    elif data["type"] == "car_is_leaving":
                        vaga = self.parking_lot.carLeavingInformations["spotWillBeFree"]
                        idFloorSpotWillBeFree = self.parking_lot.carLeavingInformations["idFloorSpotWillBeFree"]

                        car_entering_time = self.parking_lot.parking_floors[idFloorSpotWillBeFree].times[vaga]["entering_time"]
                        
                        print(f"vaga: {car_entering_time}")
                        print(f"car_entering_time: {car_entering_time}")
                        print(f"datetime.now(): {datetime.now()}")
                        print(f"----------------------------------------------")

                        self.parking_lot.total_value += calculate_parking_fee(
                            car_entering_time, datetime.now()
                        )
                        print(f"Updated total value: {self.parking_lot.total_value}")

                        self.parking_lot.parking_floors[idFloorSpotWillBeFree].times[vaga]["entering_time"] = None
                        self.parking_lot.parking_floors[idFloorSpotWillBeFree].times[vaga]["car_id"] = ""


                        if self.parking_lot.parking_floors[1].qtd_cars == 8 and self.parking_lot.parking_floors[2].qtd_cars == 8 and self.parking_lot.parking_floors[3].qtd_cars:
                            self.command["SINAL_DE_LOTADO_FECHADO_1"] = 1

                        elif floor.qtd_cars == 8 and floor_number != 1:
                            self.parking_lot.command[f"SINAL_DE_LOTADO_FECHADO_{floor_number}"] = 1
                        elif floor.qtd_cars < 8:
                            self.parking_lot.command[f"SINAL_DE_LOTADO_FECHADO_{floor_number}"] = 0

                        self.send_socket(connection, self.parking_lot.command)

                    elif data["type"] == "status_parking":
                        estados = self.parking_lot.state
                        dataEstados = data["state"]
                        print(f"estados: {estados}")
                        print(f"dataEstados: {dataEstados}")
                        self.parking_lot.state[floor_number-1] = data["state"]

                        vaga = data.get("vaga") - 1
                       
                        if data["state"][vaga]["state"] == 0:  # Car is leaving
                            self.parking_lot.carLeavingInformations["spotWillBeFree"] = vaga
                            self.parking_lot.carLeavingInformations["idFloorSpotWillBeFree"] = floor_number

                            floor.qtd_cars -= 1

                            if floor.qtd_cars < 8:
                                self.parking_lot.command[f"SINAL_DE_LOTADO_FECHADO_{floor_number}"] = 0
                                self.send_socket(connection, self.parking_lot.command)
                        else:  # Car is entering
                            floor.times[vaga]["car_id"] = self.parking_lot.carWithUnknownId["car_id"]
                            floor.times[vaga]["entering_time"] = self.parking_lot.carWithUnknownId["entering_time"]

                            floor.qtd_cars += 1
                            if floor.qtd_cars == 8:
                                if floor_number != 1:
                                    print(f"Acendeu: {floor_number}!")
                                    self.parking_lot.command[f"SINAL_DE_LOTADO_FECHADO_{floor_number}"] = 1
                                    self.send_socket(connection, self.parking_lot.command)
                                    
                                    print(f"Quantidade de carros no 1 andar: {self.parking_lot.parking_floors[1].qtd_cars}")
                                    print(f"Quantidade de carros no 2 andar: {self.parking_lot.parking_floors[2].qtd_cars}")
                                    print(f"Quantidade de carros no 3 andar: {self.parking_lot.parking_floors[3].qtd_cars}")


                                    if (self.parking_lot.parking_floors[1].qtd_cars == 8 and self.parking_lot.parking_floors[2].qtd_cars == 8 and self.parking_lot.parking_floors[3].qtd_cars == 8):
                                        self.parking_lot.command[f"SINAL_DE_LOTADO_FECHADO_1"] = 1
                                        
                                        self.send_socket(connection, self.parking_lot.command)
                            else:
                                self.parking_lot.command[f"SINAL_DE_LOTADO_FECHADO_{floor_number}"] = 0
                                self.send_socket(connection, self.parking_lot.command)

            except Exception as e:
                print(f"Erro ao receber dados: {e}")
                break


    @staticmethod
    def send_socket(connection, command):
        try:
            command_socket = json.dumps(command).encode()
            connection.send(command_socket)
        except Exception as e:
            print(f"Erro ao tentar enviar mensagem: {e}")
            connection.close()

    def socket_init(self):
        server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        addr = self.host, self.port
        server.bind(addr)
        server.listen()
        print("Iniciando conexao do socket")
        connected_socket = []
        try:
            while True:
                conn, addr = server.accept()
                connected_socket.append(conn)
                listen_thread = Thread(target=self.receive, args=(conn, len(connected_socket)))
                listen_thread.start()
                if len(connected_socket) == 3:  # Inicia o menu quando todos os andares estiverem conectados
                    send_thread = Thread(target=self.parking_lot.present_menu, args=(connected_socket,))
                    send_thread.start()
        except Exception as e:
            print(f"Erro na inicialização do socket: {e}")
        finally:
            server.close()


if __name__ == '__main__':
    parking_lot_server = ParkingLotServer()
    parking_lot_server.socket_init()
