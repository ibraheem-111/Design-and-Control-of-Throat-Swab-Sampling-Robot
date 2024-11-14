import time
from board import SCL, SDA
import busio
from adafruit_motor import servo
from adafruit_pca9685 import PCA9685
i2c = busio.I2C(SCL, SDA)
pca = PCA9685(i2c)
pca.frequency = 50
servo1 = servo.Servo(pca.channels[0], min_pulse=525, max_pulse=2325)
servo2 = servo.Servo(pca.channels[1], min_pulse=525, max_pulse=2325)
servo3 = servo.Servo(pca.channels[2], min_pulse=525, max_pulse=2325)
servo4 = servo.Servo(pca.channels[3], min_pulse=525, max_pulse=2325)
servo5 = servo.Servo(pca.channels[4], min_pulse=525, max_pulse=2325)
servo6 = servo.Servo(pca.channels[5], min_pulse=525, max_pulse=2325)
from IKfunction import *
import paho.mqtt.client as mqtt
translate=0;
b=0.0
a=0.0
c=0.0
x=0.0
y=0.0
z=9.8
a1=105.0
a2=87.0
a3=90.0
a4=85.0
a5=80.0
a6=100.0
a1i=a1

a2i=a2
a3i=a3
a4i=a4
a5i=a5
a6i=a6
pos = np.array([a1-a1i, a2-a2i, a3-a3i, a4-a4i, a5-a5i, a6-a6i])
def on_connect (client, userdata, flags, rc):
    print("connected with result code" + str(rc))
    client.subscribe("X")
    client.subscribe("Y")
    client.subscribe("Z")
    client.subscribe("a")
    client.subscribe("b")
    client.subscribe("c")
    client.subscribe("translation")

def on_message(client, userdata, msg):
    global x
    global y
    global z
    global a
    global b
    global c
    global translate
    if msg.topic=='Z':
        z=float(msg.payload)
    elif msg.topic=='Y':
        y=float(msg.payload)
    elif msg.topic=='X':
        x=float(msg.payload)
    elif msg.topic=='a':
        a=float(msg.payload)
    elif msg.topic=='b':
        b=float(msg.payload)
    elif msg.topic=='c':
        c=float(msg.payload)
    elif msg.topic=='translation':
        translate=float(msg.payload)
    print(msg.topic+"="+msg.payload.decode("utf-8"))

def on_subscribe(client, userdata, mid, granted_qos):
    print ('Subscribed')
    client = mqtt.Client()
    client.connect("localhost", 1883, 60)
    #client.connect("192.168.100.13",1883)
    client.on_connect = on_connect
    client.on_subscribe = on_subscribe
    client.on_message = on_message
    client.loop_start()
    while True:
        if translate==4:
            if z<=13:
                z=z+0.1
        elif translate==2:
            if z>=7:
                z=z-0.1
        elif translate==8:
            y=y-0.1
        elif translate==16:
            y=y+0.1
        elif translate==32:
            x=x+0.1
        elif translate==1024:
            x=x-0.1
        elif translate==1:
            b=0.0
            a=0.0
            c=0.0
            x=0.0
            y=0.0
            z=9.8
        al=IKfunction(a,b,c,x,y,z)
        print(al)
        #al=al.astype(int)
        temp=al-pos
        ti=10
        j=temp/ti
        #print(j)
        opos = np.array([a1, a2, a3, a4, a5, a6])
        for i in range(ti):
            a1 = a1+j[0]
            a2 = a2-j[1]
            a3 = a3+j[2]
            a4 = a4-j[3]
            a5 = a5+j[4]
            a6 = a6-j[5]
            servo1.angle= a1
            servo2.angle= a2
            servo3.angle= a3
            servo4.angle= a4
            servo5.angle= a5
            servo6.angle= a6
            #time.sleep(0.01)
        
        npos = np.array([a1, a2, a3, a4, a5, a6])
        pos = np.array([(a1-a1i), -(a2-a2i), (a3-a3i), -(a4-a4i), (a5-a5i), -(a6-a6i)])
