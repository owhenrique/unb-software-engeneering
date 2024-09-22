import sys
import os
from threading import Thread


# Adiciona o diretório raiz ao sys.path
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from models.parking_ground_floor import GroundFloorParking



if __name__ == '__main__':
    ground_floor = GroundFloorParking('../configs/config_ground_floor.json')
    ground_floor_thread = Thread(target=ground_floor.run)
    ground_floor_thread.start()
    ground_floor_thread.join()

