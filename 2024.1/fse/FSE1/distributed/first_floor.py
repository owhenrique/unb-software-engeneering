import sys
import os
from threading import Thread

# Adiciona o diretório raiz ao sys.path
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from models.parking_floor import ParkingFloor


if __name__ == '__main__':
    first_floor = ParkingFloor('../configs/config_first_floor.json')
    first_floor_thread = Thread(target=first_floor.run)
    first_floor_thread.start()
    first_floor_thread.join()
