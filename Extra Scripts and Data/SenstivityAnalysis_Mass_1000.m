close all;
throttle_points = [0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.6,0.7,0.8,0.9,0.95];

x1 = [4,5,6,7,8.1,9.2,10.4,12,13,14,15,17,19,21,23,23];
x2 = [2,4.5,7,9.5,12,14.5,17,19.5,22,24.5,27,32.5,37,42,47,50];
    x3=[10,13,16,19,22,25,28,32,33,34,40,46,54,62,70,74];
    x4=[12,16.5,21,25.5,30,34.5,39,43.5,50,54,58,64,70,76,84,90];
x5 = [2,9,18,27,36,45,54,63,72,82,90,104,118,130,142,147];

data.TCU.upshift.veh_spd=...
[ max(5.312,min(40,[x1]));
max(7.34,min(55,[x2]));
max(11,min(83,[x3]));
max(16.412,min(123,[x4]));
max(22.7,min(170,[x5]));
max(31.54,min(236, [x5] + 50));
500,500,500,500,500,500,500,500,500,500,500,500,500,500,500,500;
500,500,500,500,500,500,500,500,500,500,500,500,500,500,500,500]';



data.TCU.downshift.veh_spd = ...
[ max(5.312,min(26,[x1]-dist));
max(7.34,min(38,[x2]-dist));
max(11,min(55,[x3]-dist));
max(16.412,min(80,[x4]-dist));
max(22.7,min(110,[x5]-dist));
max(31.54,min(160, [x5] + 50-dist));
500,500,500,500,500,500,500,500,500,500,500,500,500,500,500,500;
500,500,500,500,500,500,500,500,500,500,500,500,500,500,500,500]';

figure
hold on
grid minor

plot(data.TCU.upshift.veh_spd(:,1),throttle_points,'c-','Linewidth',2)
plot(data.TCU.upshift.veh_spd(:,2),throttle_points,'b-','Linewidth',2)
plot(data.TCU.upshift.veh_spd(:,3),throttle_points,'k-','Linewidth',2)
plot(data.TCU.upshift.veh_spd(:,4),throttle_points,'r-','Linewidth',2)
plot(data.TCU.upshift.veh_spd(:,5),throttle_points,'g-','Linewidth',2)
plot(data.TCU.upshift.veh_spd(:,6),throttle_points,'m-','Linewidth',2)

plot(data.TCU.downshift.veh_spd(:,1),throttle_points,'c--')
plot(data.TCU.downshift.veh_spd(:,2),throttle_points,'b--')
plot(data.TCU.downshift.veh_spd(:,3),throttle_points,'k--')
plot(data.TCU.downshift.veh_spd(:,4),throttle_points,'r--')
plot(data.TCU.downshift.veh_spd(:,5),throttle_points,'g--')
plot(data.TCU.downshift.veh_spd(:,6),throttle_points,'m--')

title('Gear ShiftMap Normal for 1000kg vehicle');
xlabel('Velocity [km/h]');
ylabel('Throttle')
axis([0 150 0 1])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%