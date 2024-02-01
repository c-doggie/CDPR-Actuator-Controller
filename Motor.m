function x_dot = Motor(t, x, load, tau)
model_params

%Current states
theta = x(1);
theta_dot = x(2);

%Controller Params
%load
%load = 2*sin(t); %kg
%torque
%tau = 1; %nm

%Motor EOM
theta_dotdot = (tau + load*r - k_t*theta_dot) / (I_r + I_g/N);

x_dot = [theta_dot; theta_dotdot];

end
