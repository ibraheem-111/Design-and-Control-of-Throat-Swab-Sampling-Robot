import paho.mqtt.client as mqtt
import time
from IKfunction import *

def on_connect (client, userdata, flags, rc):
    print("connected with result code" + str(rc))
    client.subscribe("X")
    client.subscribe("Y")
    client.subscribe("Z")

def on_message(client, userdata, msg):
    global th_abort
    global t
    if 'abort' in msg.payload.decode("utf-8"):
        if t.is_alive():
            t.cancel()
        th_abort = True
    else:
        print(msg.payload.decode("utf-8"))

def on_subscribe(client, userdata, mid, granted_qos):
    print ('Subscribed')

t = None
th_abort = False

client = mqtt.Client()

client.on_connect = on_connect
client.on_subscribe = on_subscribe
client.on_message = on_message
client.connect("localhost", 1883, 60)
client.connect("192.168.1.101",1883)
client.loop_start()

while th_abort == False:
    client.on_message=client.on_message