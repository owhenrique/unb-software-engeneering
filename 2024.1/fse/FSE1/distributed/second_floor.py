import sys
import os
from threading import Thread

# Adiciona o diretório raiz ao sys.path
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from models.parking_floor import ParkingFloor

if __name__ == '__main__':
    second_floor = ParkingFloor('../configs/config_second_floor.json')
    second_floor_thread = Thread(target=second_floor.run)
    second_floor_thread.start()
    second_floor_thread.join()
