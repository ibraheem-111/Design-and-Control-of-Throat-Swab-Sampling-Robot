import numpy as np
from numpy import linalg as LA

def IKfunction(a,b,c,x,y,T):
    Rt=np.array([x,y,T])
    pi=np.pi
    a=a*pi/180
    b=b*pi/180
    c=c*pi/180
    R=10.620943523
    r=6
    #cranklength
    d=5.9
    #leglength
    s=12
    #Beta
    Be=np.array([118, 2, -122, 122, -2, -118])
    Be=Be*pi/180
    mu=(41.54666139/2)*(pi/180)
    R1=np.array([R*np.cos(mu), R*np.sin(mu), 0])
    #1.shape=(3,1)
    #1=R1.transpose()
    R6=np.array([R*np.cos(-mu), R*np.sin(-mu), 0])
    #6.shape=(3,1)
    #6=R6.transpose()
    R2=np.array([R*np.cos((2*pi/3)-mu), R*np.sin((2*pi/3)-mu), 0])
    #2.shape=(3,1)
    #2=R2.transpose()
    R3=np.array([R*np.cos((2*pi/3)+mu), R*np.sin((2*pi/3)+mu), 0])
    #3.shape=(3,1)
    #3=R3.transpose()
    R4=np.array([R*np.cos((4*pi/3)-mu), R*np.sin((4*pi/3)-mu), 0])
    #R4.shape=(3,1)
    #4=R4.transpose()
    R5=np.array([R*np.cos((4*pi/3)+mu), R*np.sin((4*pi/3)+mu), 0])
    #R5.shape=(3,1)
    #5=R5.transpose()
    Rb=np.array([ R1, R2, R3, R4, R5, R6])
    Rb=Rb.transpose()

    mu=(50/2)*(pi/180)
    rt1=np.array([r*np.cos((pi/3)-mu), r*np.sin((pi/3)-mu), 0])
    rt2=np.array([r*np.cos((pi/3)+mu), r*np.sin((pi/3)+mu), 0])
    rt3=np.array([r*np.cos(pi-mu), r*np.sin(pi-mu), 0])
    rt4=np.array([r*np.cos(pi+mu), r*np.sin(pi+mu), 0])
    rt5=np.array([r*np.cos((5*pi/3)-mu), r*np.sin((5*pi/3)-mu), 0])
    rt6=np.array([r*np.cos((5*pi/3)+mu), r*np.sin((5*pi/3)+mu), 0])
    # rt1.shape=(3,1)
    # rt2.shape=(3,1)
    # rt3.shape=(3,1)
    # rt4.shape=(3,1)
    # rt5.shape=(3,1)
    # rt6.shape=(3,1)
    rt=np.array([rt1,rt2,rt3,rt4,rt5,rt6])
    rt=rt.transpose()

    rotx=np.array([[1, 0, 0],[0, np.cos(a), -np.sin(a)],[0, np.sin(a), np.cos(a)]])
    roty=np.array([[np.cos(b), 0, np.sin(b)],[0, 1, 0],[-np.sin(b), 0, np.cos(b)]])
    rotz=np.array([[np.cos(c), np.sin(c), 0],[-np.sin(c), np.cos(c), 0],[ 0, 0, 1]])
    BTR=(rotx.dot(roty)).dot(rotz)
    r=BTR.dot(rt)
    Rtp=np.array([Rt, Rt, Rt, Rt, Rt, Rt])
    Rtp=Rtp.transpose()
    L=Rtp+r-Rb
    LL=LA.norm(L,axis=0)
    sm=(np.power(s,2))*(np.ones(6))
    dm=(np.power(d,2))*(np.ones(6))
    gamma=sm-dm-(np.power(LL,2))
    #1D array row vector
    X1=np.array([np.cos(Be),np.sin(Be),np.zeros(6)])
    Y1=np.array([[0, 0, 0, 0, 0, 0],[0, 0, 0, 0, 0, 0],[1, 1, 1, 1, 1, 1]])
    #(gamma-2*d*dot(X1,L))*(x^2)+(4*d*dot(Y1,L))*(x)+(2*d*dot(X1,L))+gamma
    E=-2*d*np.multiply(X1,L).sum(axis=0)
    #E=2*d*dot(X1,L);
    F=-2*d*np.multiply(Y1,L).sum(axis=0)
    #F=2*d*dot(Y1,L);
    t=np.divide(F,(gamma+E))

    sqrt=np.sqrt(np.square(E)+np.square(F)-np.square(gamma)) #./(gamma-E)
    u=np.divide(sqrt,(gamma+E))
    al=2*np.arctan(t+u)
    al=al*180/pi
    return al