clc
clear
Rt=[0 0 10.4]';
a=0*pi/180;
b=0*pi/180;
c=0*pi/180;
R=10.620943523;
r=6;
%servoangle
%cranklength
d=5.9;
%leglength
s=12;
%Beta
Be=[118, 2, -122, 122, -2, -118 ]'.*pi/180;
%Be=[0 0 0 0 0 0 ]'.*pi/180;
mu=(41.54666139/2)*(pi/180);
R1=[R*cos(mu), R*sin(mu), 0]';
R6=[R*cos(-mu), R*sin(-mu), 0]';
R2=[R*cos((2*pi/3)-mu), R*sin((2*pi/3)-mu), 0]';
R3=[R*cos((2*pi/3)+mu), R*sin((2*pi/3)+mu), 0]';
R4=[R*cos((4*pi/3)-mu), R*sin((4*pi/3)-mu), 0]';
R5=[R*cos((4*pi/3)+mu), R*sin((4*pi/3)+mu), 0]';
Rb=[R1 R2 R3 R4 R5 R6];
mu=25*pi/180;
rt1=[r*cos((pi/3)-mu), r*sin((pi/3)-mu), 0]';
rt2=[r*cos((pi/3)+mu), r*sin((pi/3)+mu), 0]';
rt3=[r*cos(pi-mu), r*sin(pi-mu), 0]';
rt4=[r*cos(pi+mu), r*sin(pi+mu), 0]';
rt5=[r*cos((5*pi/3)-mu), r*sin((5*pi/3)-mu), 0]';
rt6=[r*cos((5*pi/3)+mu), r*sin((5*pi/3)+mu), 0]';
rt=[rt1,rt2,rt3,rt4,rt5,rt6];
rotx=[1 0 0;0 cos(a) -sin(a);0 sin(a) cos(a)];
roty=[cos(b) 0 sin(b); 0 1 0;-sin(b) 0 cos(b)];
rotz=[cos(c) sin(c) 0; -sin(c) cos(c) 0; 0 0 1];
BTR=rotx*roty*rotz;
r=BTR*rt;
Rtp=[Rt Rt Rt Rt Rt Rt];
L=Rtp+r-Rb;
L1=norm(L(:,1));
L2=norm(L(:,2));
L3=norm(L(:,3));
L4=norm(L(:,4));
L5=norm(L(:,5));
L6=norm(L(:,6));
LL=[L1 L2 L3 L4 L5 L6]';
leg1x=[Rb(1,1),Rt(1)+r(1,1)];
leg1y=[Rb(2,1),Rt(2)+r(2,1)];
leg1z=[Rb(3,1),Rt(3)+r(3,1)];

leg2x=[Rb(1,2),Rt(1)+r(1,2)];
leg2y=[Rb(2,2),Rt(2)+r(2,2)];
leg2z=[Rb(3,2),Rt(3)+r(3,2)];

leg3x=[Rb(1,3),Rt(1)+r(1,3)];
leg3y=[Rb(2,3),Rt(2)+r(2,3)];
leg3z=[Rb(3,3),Rt(3)+r(3,3)];

leg4x=[Rb(1,4),Rt(1)+r(1,4)];
leg4y=[Rb(2,4),Rt(2)+r(2,4)];
leg4z=[Rb(3,4),Rt(3)+r(3,4)];

leg5x=[Rb(1,5),Rt(1)+r(1,5)];
leg5y=[Rb(2,5),Rt(2)+r(2,5)];
leg5z=[Rb(3,5),Rt(3)+r(3,5)];

leg6x=[Rb(1,6),Rt(1)+r(1,6)];
leg6y=[Rb(2,6),Rt(2)+r(2,6)];
leg6z=[Rb(3,6),Rt(3)+r(3,6)];

rho=(s^2)*ones(6,1);
dm=((d^2)*ones(6,1));
gamma=(rho-(LL.^2)-dm)';

X1=[cos(Be');sin(Be');0,0,0,0,0,0];
Y1=[0,0,0,0,0,0;0,0,0,0,0,0;1,1,1,1,1,1];
%(gamma-2*d*dot(X1,L))*(x^2)+(4*d*dot(Y1,L))*(x)+(2*d*dot(X1,L))+gamma

E=-2*d*dot(L,X1);
B=-2*d*dot(L,Y1);

x=(B+sqrt((B.^2)-(gamma.^2)+(E.^2)))./(gamma+E);

al=(2*atan(x))';
dal=al*180/pi
%crank vectors

cx=d.*cos(Be);
cy=d.*sin(Be);
cz=d.*sin(al);
cr=[cx';cy';cz'];
A=Rb+cr;

axis([-15 15 -15 15 -6 20]);

p1=line(leg1x,leg1y,leg1z, 'LineWidth',[0.5],'Color','m','LineStyle','--');
p2=line(leg2x,leg2y,leg2z, 'LineWidth',[0.5],'Color','r','LineStyle','--');
p3=line(leg3x,leg3y,leg3z, 'LineWidth',[0.5],'Color','r','LineStyle','--');
p4=line(leg4x,leg4y,leg4z, 'LineWidth',[0.5],'Color','k','LineStyle','--');
p5=line(leg5x,leg5y,leg5z, 'LineWidth',[0.5],'Color','k','LineStyle','--');
p6=line(leg6x,leg6y,leg6z, 'LineWidth',[0.5],'Color','m','LineStyle','--');
p7=line([Rt(1)+r(1,1),

Rt(1)+r(1,2)],[Rt(2)+r(2,1),Rt(2)+r(2,2)],[Rt(3)+r(3,1),Rt(3)+r(3,2)],
'LineWidth',[2],'Color','r');
p8=line([Rt(1)+r(1,2),
Rt(1)+r(1,3)],[Rt(2)+r(2,2),Rt(2)+r(2,3)],[Rt(3)+r(3,2),Rt(3)+r(3,3)],
'LineWidth',[2],'Color','r');
p9=line([Rt(1)+r(1,3),
Rt(1)+r(1,4)],[Rt(2)+r(2,3),Rt(2)+r(2,4)],[Rt(3)+r(3,3),Rt(3)+r(3,4)],
'LineWidth',[2],'Color','r');
p10=line([Rt(1)+r(1,4),
Rt(1)+r(1,5)],[Rt(2)+r(2,4),Rt(2)+r(2,5)],[Rt(3)+r(3,4),Rt(3)+r(3,5)],
'LineWidth',[2],'Color','r');
p11=line([Rt(1)+r(1,5),
Rt(1)+r(1,6)],[Rt(2)+r(2,5),Rt(2)+r(2,6)],[Rt(3)+r(3,5),Rt(3)+r(3,6)],
'LineWidth',[2],'Color','r');
p12=line([Rt(1)+r(1,6),
Rt(1)+r(1,1)],[Rt(2)+r(2,6),Rt(2)+r(2,1)],[Rt(3)+r(3,6),Rt(3)+r(3,1)],
'LineWidth',[2],'Color','r');
p13=line([Rb(1,1), Rb(1,2)],[Rb(2,1),Rb(2,2)],[Rb(3,1),Rb(3,2)],
'LineWidth',[2],'Color','y');
p14=line([Rb(1,2), Rb(1,3)],[Rb(2,2),Rb(2,3)],[Rb(3,2),Rb(3,3)],
'LineWidth',[2],'Color','y');
p15=line([Rb(1,3), Rb(1,4)],[Rb(2,3),Rb(2,4)],[Rb(3,3),Rb(3,4)],
'LineWidth',[2],'Color','y');
p16=line([Rb(1,4), Rb(1,5)],[Rb(2,4),Rb(2,5)],[Rb(3,4),Rb(3,5)],
'LineWidth',[2],'Color','y');
p17=line([Rb(1,5), Rb(1,6)],[Rb(2,5),Rb(2,6)],[Rb(3,5),Rb(3,6)],
'LineWidth',[2],'Color','y');
p18=line([Rb(1,6), Rb(1,1)],[Rb(2,6),Rb(2,1)],[Rb(3,6),Rb(3,1)],
'LineWidth',[2],'Color','y');
p19=line([Rb(1,1), A(1,1)],[Rb(2,1),A(2,1)],[Rb(3,1),A(3,1)],
'LineWidth',[2],'Color','b');
p20=line([Rb(1,2), A(1,2)],[Rb(2,2),A(2,2)],[Rb(3,2),A(3,2)],
'LineWidth',[2],'Color','b');
p21=line([Rb(1,3), A(1,3)],[Rb(2,3),A(2,3)],[Rb(3,3),A(3,3)],
'LineWidth',[2],'Color','b');
p22=line([Rb(1,4), A(1,4)],[Rb(2,4),A(2,4)],[Rb(3,4),A(3,4)],
'LineWidth',[2],'Color','b');
p23=line([Rb(1,5), A(1,5)],[Rb(2,5),A(2,5)],[Rb(3,5),A(3,5)],
'LineWidth',[2],'Color','b');
p24=line([Rb(1,6), A(1,6)],[Rb(2,6),A(2,6)],[Rb(3,6),A(3,6)],
'LineWidth',[2],'Color','b');
p25=line([A(1,1), Rt(1)+r(1,1)],[A(2,1),Rt(2)+r(2,1)],[A(3,1),Rt(3)+r(3,1)],
'LineWidth',[2],'Color','m');
p26=line([A(1,2), Rt(1)+r(1,2)],[A(2,2),Rt(2)+r(2,2)],[A(3,2),Rt(3)+r(3,2)],
'LineWidth',[2],'Color','m');
p27=line([A(1,3), Rt(1)+r(1,3)],[A(2,3),Rt(2)+r(2,3)],[A(3,3),Rt(3)+r(3,3)],
'LineWidth',[2],'Color','m');
p28=line([A(1,4), Rt(1)+r(1,4)],[A(2,4),Rt(2)+r(2,4)],[A(3,4),Rt(3)+r(3,4)],
'LineWidth',[2],'Color','m');

p29=line([A(1,5), Rt(1)+r(1,5)],[A(2,5),Rt(2)+r(2,5)],[A(3,5),Rt(3)+r(3,5)],
'LineWidth',[2],'Color','m');
p30=line([A(1,6), Rt(1)+r(1,6)],[A(2,6),Rt(2)+r(2,6)],[A(3,6),Rt(3)+r(3,6)],
'LineWidth',[2],'Color','m');
xlabel("x-axis cm")
ylabel("y-axis cm")
zlabel("z-axis cm")

drawnow

pause()

for i=0:1:7
    Rt=[0 0 10.4]'
    a=0*pi/180;
    b=0*pi/180;
    c=i*pi/180;
    R=10.620943523;
    r=6;
    %servoangle
    %cranklength
    d=5.9;
    %leglength
    s=12;
    %Beta
    Be=[118, 2, -122, 122, -2, -118 ]'.*pi/180;
    %Be=[0 0 0 0 0 0 ]'.*pi/180;
    mu=(41.54666139/2)*(pi/180);
    R1=[R*cos(mu), R*sin(mu), 0]';
    R6=[R*cos(-mu), R*sin(-mu), 0]';
    R2=[R*cos((2*pi/3)-mu), R*sin((2*pi/3)-mu), 0]';
    R3=[R*cos((2*pi/3)+mu), R*sin((2*pi/3)+mu), 0]';
    R4=[R*cos((4*pi/3)-mu), R*sin((4*pi/3)-mu), 0]';
    R5=[R*cos((4*pi/3)+mu), R*sin((4*pi/3)+mu), 0]';
    Rb=[R1 R2 R3 R4 R5 R6];
    mu=25*pi/180;
    rt1=[r*cos((pi/3)-mu), r*sin((pi/3)-mu), 0]';
    rt2=[r*cos((pi/3)+mu), r*sin((pi/3)+mu), 0]';
    rt3=[r*cos(pi-mu), r*sin(pi-mu), 0]';
    rt4=[r*cos(pi+mu), r*sin(pi+mu), 0]';
    rt5=[r*cos((5*pi/3)-mu), r*sin((5*pi/3)-mu), 0]';
    rt6=[r*cos((5*pi/3)+mu), r*sin((5*pi/3)+mu), 0]';
    rt=[rt1,rt2,rt3,rt4,rt5,rt6];
    rotx=[1 0 0;0 cos(a) -sin(a);0 sin(a) cos(a)];
    roty=[cos(b) 0 sin(b); 0 1 0;-sin(b) 0 cos(b)];
    rotz=[cos(c) sin(c) 0; -sin(c) cos(c) 0; 0 0 1];
    BTR=rotx*roty*rotz;
    r=BTR*rt;
    Rtp=[Rt Rt Rt Rt Rt Rt];
    L=Rtp+r-Rb;
    %L1=L(:,1);
    %L2=L(:,2);
    %L3=L(:,3);
    %L4=L(:,4);
    %L5=L(:,5);
    %L6=L(:,6);
    %length1=norm(L1)
    %length2=norm(L2)
    %length3=norm(L3)
    %length4=norm(L4)
    %length5=norm(L5)
    %length6=norm(L6)
    L1=norm(L(:,1));
    L2=norm(L(:,2));
    L3=norm(L(:,3));
    L4=norm(L(:,4));
    L5=norm(L(:,5));
    L6=norm(L(:,6));
    LL=[L1 L2 L3 L4 L5 L6]';
    leg1x=[Rb(1,1),Rt(1)+r(1,1)];
    leg1y=[Rb(2,1),Rt(2)+r(2,1)];
    leg1z=[Rb(3,1),Rt(3)+r(3,1)];
    leg2x=[Rb(1,2),Rt(1)+r(1,2)];
    leg2y=[Rb(2,2),Rt(2)+r(2,2)];
    leg2z=[Rb(3,2),Rt(3)+r(3,2)];
    leg3x=[Rb(1,3),Rt(1)+r(1,3)];
    leg3y=[Rb(2,3),Rt(2)+r(2,3)];
    leg3z=[Rb(3,3),Rt(3)+r(3,3)];
    leg4x=[Rb(1,4),Rt(1)+r(1,4)];
    leg4y=[Rb(2,4),Rt(2)+r(2,4)];
    leg4z=[Rb(3,4),Rt(3)+r(3,4)];
    leg5x=[Rb(1,5),Rt(1)+r(1,5)];
    leg5y=[Rb(2,5),Rt(2)+r(2,5)];
    leg5z=[Rb(3,5),Rt(3)+r(3,5)];
    leg6x=[Rb(1,6),Rt(1)+r(1,6)];
    leg6y=[Rb(2,6),Rt(2)+r(2,6)];
    leg6z=[Rb(3,6),Rt(3)+r(3,6)];
    rho=(s^2)*ones(6,1);
    dm=((d^2)*ones(6,1));
    gamma=(rho-(LL.^2)-dm)';
    X1=[cos(Be');sin(Be');0,0,0,0,0,0];
    Y1=[0,0,0,0,0,0;0,0,0,0,0,0;1,1,1,1,1,1];
    %(gamma-2*d*dot(X1,L))*(x^2)+(4*d*dot(Y1,L))*(x)+(2*d*dot(X1,L))+gamma
    E=-2*d*dot(L,X1);
    B=-2*d*dot(L,Y1);
    x=(B+sqrt((B.^2)-(gamma.^2)+(E.^2)))./(gamma+E);
    al=(2*atan(x))';
    dal=al*180/pi

    %crank vectors
    cx=d.*cos(Be);
    cy=d.*sin(Be);
    cz=d.*sin(al);
    cr=[cx';cy';cz'];
    A=Rb+cr;
    set(p1,'X', leg1x, 'Y',leg1y,'Z',leg1z)
    set(p2,'X', leg2x, 'Y',leg2y,'Z',leg2z)
    set(p3,'X', leg3x, 'Y',leg3y,'Z',leg3z)
    set(p4,'X', leg4x, 'Y',leg4y,'Z',leg4z)
    set(p5,'X', leg5x, 'Y',leg5y,'Z',leg5z)
    set(p6,'X', leg6x, 'Y',leg6y,'Z',leg6z)
    set(p7,'X', [Rt(1)+r(1,1), Rt(1)+r(1,2)],
'Y',[Rt(2)+r(2,1),Rt(2)+r(2,2)],'Z',[Rt(3)+r(3,1),Rt(3)+r(3,2)])
    set(p8,'X', [Rt(1)+r(1,2), Rt(1)+r(1,3)],
'Y',[Rt(2)+r(2,2),Rt(2)+r(2,3)],'Z',[Rt(3)+r(3,2),Rt(3)+r(3,3)])
    set(p9,'X', [Rt(1)+r(1,3), Rt(1)+r(1,4)],
'Y',[Rt(2)+r(2,3),Rt(2)+r(2,4)],'Z',[Rt(3)+r(3,3),Rt(3)+r(3,4)])
    set(p10,'X', [Rt(1)+r(1,4), Rt(1)+r(1,5)],
'Y',[Rt(2)+r(2,4),Rt(2)+r(2,5)],'Z',[Rt(3)+r(3,4),Rt(3)+r(3,5)])
    set(p11,'X', [Rt(1)+r(1,5), Rt(1)+r(1,6)],
'Y',[Rt(2)+r(2,5),Rt(2)+r(2,6)],'Z',[Rt(3)+r(3,5),Rt(3)+r(3,6)])
    set(p12,'X', [Rt(1)+r(1,6), Rt(1)+r(1,1)],
'Y',[Rt(2)+r(2,6),Rt(2)+r(2,1)],'Z',[Rt(3)+r(3,6),Rt(3)+r(3,1)])
    set(p13,'X', [Rb(1,1), Rb(1,2)], 'Y',[Rb(2,1),Rb(2,2)],'Z',[Rb(3,1),Rb(3,2)])
    set(p14,'X', [Rb(1,2), Rb(1,3)], 'Y',[Rb(2,2),Rb(2,3)],'Z',[Rb(3,2),Rb(3,3)])
    set(p15,'X', [Rb(1,3), Rb(1,4)], 'Y',[Rb(2,3),Rb(2,4)],'Z',[Rb(3,3),Rb(3,4)])
    set(p16,'X', [Rb(1,4), Rb(1,5)], 'Y',[Rb(2,4),Rb(2,5)],'Z',[Rb(3,4),Rb(3,5)])
    set(p17,'X', [Rb(1,5), Rb(1,6)], 'Y',[Rb(2,5),Rb(2,6)],'Z',[Rb(3,5),Rb(3,6)])
    set(p18,'X', [Rb(1,6), Rb(1,1)], 'Y',[Rb(2,6),Rb(2,1)],'Z',[Rb(3,6),Rb(3,1)])
    set(p19,'X', [Rb(1,1), A(1,1)], 'Y',[Rb(2,1),A(2,1)],'Z',[Rb(3,1),A(3,1)])
    set(p20,'X', [Rb(1,2), A(1,2)], 'Y',[Rb(2,2),A(2,2)],'Z',[Rb(3,2),A(3,2)])
    set(p21,'X', [Rb(1,3), A(1,3)], 'Y',[Rb(2,3),A(2,3)],'Z',[Rb(3,3),A(3,3)])
    set(p22,'X', [Rb(1,4), A(1,4)], 'Y',[Rb(2,4),A(2,4)],'Z',[Rb(3,4),A(3,4)])
    set(p23,'X', [Rb(1,5), A(1,5)], 'Y',[Rb(2,5),A(2,5)],'Z',[Rb(3,5),A(3,5)])
    set(p24,'X', [Rb(1,6), A(1,6)], 'Y',[Rb(2,6),A(2,6)],'Z',[Rb(3,6),A(3,6)])
    set(p25,'X', [A(1,1), Rt(1)+r(1,1)], 'Y',[A(2,1),Rt(2)+r(2,1)],'Z',[A(3,1),Rt(3)+r(3,1)])
    set(p26,'X', [A(1,2), Rt(1)+r(1,2)], 'Y',[A(2,2),Rt(2)+r(2,2)],'Z',[A(3,2),Rt(3)+r(3,2)])
    set(p27,'X', [A(1,3), Rt(1)+r(1,3)], 'Y',[A(2,3),Rt(2)+r(2,3)],'Z',[A(3,3),Rt(3)+r(3,3)])
    set(p28,'X', [A(1,4), Rt(1)+r(1,4)], 'Y',[A(2,4),Rt(2)+r(2,4)],'Z',[A(3,4),Rt(3)+r(3,4)])
    set(p29,'X', [A(1,5), Rt(1)+r(1,5)], 'Y',[A(2,5),Rt(2)+r(2,5)],'Z',[A(3,5),Rt(3)+r(3,5)])
    set(p30,'X', [A(1,6), Rt(1)+r(1,6)], 'Y',[A(2,6),Rt(2)+r(2,6)],'Z',[A(3,6),Rt(3)+r(3,6)])
    drawnow
    pause(.1)
end
