import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BCM)

botao = 16
leds = [23, 24, 25]

GPIO.setup(botao, GPIO.IN, pull_up_down = GPIO.PUD_DOWN)
GPIO.setup(leds, GPIO.OUT)

def trataBotao():
    while GPIO.input(botao):
        GPIO.output(leds, GPIO.LOW)
        print("LEDS LIGADOS...")
    
    print("aguardando botao ser pressionado...")

def estadoInicialLEDS():
    GPIO.output(leds, GPIO.HIGH)


GPIO.add_event_detect(botao, GPIO.RISING)

while True:
    estadoInicialLEDS()

    if GPIO.event_detected(botao):
        trataBotao()