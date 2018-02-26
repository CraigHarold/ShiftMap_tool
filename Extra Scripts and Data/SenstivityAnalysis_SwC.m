Switching_cost = [0:10:100];
Number_shifts = [59, 26,18,12,11,11,11,7,4,4,4];
Fuel_consumption = [8.121,8.360,8.550,8.624,8.734,8.734,8.734,9.237,9.213,9.213,9.213];

figure;
grid minor
title('Sensitivity Analysis for Switching Cost')
yyaxis left
plot(Switching_cost,Number_shifts,'LineWidth',1.4);
axis([0 100 0 70])
xlabel('Switching Cost [% of average fuel consumption]')
ylabel('Number of Up-shifts [-]')


yyaxis right
plot(Switching_cost,Fuel_consumption,'LineWidth',1.4);
axis([0 100 7 10])
ylabel('Fuel Consumption [litre/100km]')