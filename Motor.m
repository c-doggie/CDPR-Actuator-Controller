function x_dot = Motor(t, x, load, tau)

r = 1.75/100; %radius of shaft load
I_r = 10*10^-3; %inertia of rotor
I_g = 7.44*10^-3; %inertia of gearbox
k_t = 0.67; %torque constant
N = 6; %gear ratio of motor

%Current states
theta = x(1);
theta_dot = x(2);

%Controller Params
%load
%load = 2*sin(t); %kg
%torque
%tau = 1; %nm

%Motor EOM
theta_dotdot = (tau+load*r + k_t*theta_dot) / (I_r + I_g/N);
%theta_dotdot = (tau+load*r+k_t*theta_dot) / (I_r + I_g/N);

x_dot = [theta_dot; theta_dotdot];

end
