clc;
%variables
theta0 = 0;   %Initial angle
theta_dot0 = 0;  %Initial angular velocity
dt = 0.001;      %Integration time step
T = 50;         %Simulation time

time = 0:dt:T;

%Using MATLAB ode45's Runge-Kutta integration:
x0 = [theta0; theta_dot0];
[time2,x2] = ode45(@Motor,[0 T],x0);
time2 = time2';
x2 = x2';       %States must be a column vector

%Plotting solutions
plot(time2,x2(1,:))
grid on
legend('Runge-Kutte (ode45)')
xlabel('Time [s]')
ylabel('Motor angle \theta [rad]')
