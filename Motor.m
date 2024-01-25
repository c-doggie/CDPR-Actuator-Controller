function x_dot = Motor(t, x)
r = 1.75/100; %m measured on shaft
I_r = 7.44*10^-3; %kg*m^2 | from datasheet--reflected inertia

%Current states
theta = x(1);
theta_dot = x(2);

%Controller Params
%load
load = 2; %kg
%Tau
tau = 1;


%Motor EOM
theta_dotdot = (r/I_r)*load + (1/I_r)*tau;

x_dot = [theta_dot; theta_dotdot];

end