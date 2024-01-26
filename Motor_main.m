clc;
%Initial Conditions
theta0 = 0;   %Initial angle
theta_dot0 = 0;  %Initial angular velocity
x0 = [theta0; theta_dot0];

%Simulation Parameters
T = 20;         %Simulation time
dt = 0.005;
%Square wave config
square_t = 0:dt:20;
square_x = square(square_t);

%Controller Params
tau_values = [1 2 3 4];
load_values = -100;

% Prepare the figure
figure;
hold on;
grid on;
colors = ['b', 'r', 'g', 'w']; % Define a set of colors

%Using MATLAB ode45's Runge-Kutta integration:
for i = 1:length(tau_values)
    tau = tau_values(i);
    [time, x] = ode45(@(t,x) Motor(t, x, load_values, tau), [0 T], x0);
    x = x./(2*pi*60); %convert rad to rps
    
    % Plot original solution
    subplot(2, 1, 1); % Two rows, one column, first plot
    hold on;
    plot(time, x(:,1), colors(i));
    grid on;
    xlabel('Time [s]');
    ylabel('Shaft angle \theta [rotations]');
    title(['Shaft Angle Responses for Different tau Values (Load = ' num2str(load_values) 'kg)']);
    
    % Compute and plot derivative
    dt = diff(time); % Differences in time
    dx = diff(x(:,1)); % Differences in solution
    derivative = dx ./ dt;
    time_derivative = time(1:end-1) + dt/2; % Time vector for derivative

    subplot(2, 1, 2); % Two rows, one column, second plot
    hold on;
    plot(time_derivative, derivative, colors(i));
    grid on;
    xlabel('Time [s]');
    ylabel('Shaft Velocity [rpm]');
    title('Shaft Velocity');
end

% Add legends
subplot(2, 1, 1);
legend(arrayfun(@(tau) ['tau = ', num2str(tau)], tau_values, 'UniformOutput', false), 'Location', 'best');
subplot(2, 1, 2);
legend(arrayfun(@(tau) ['tau = ', num2str(tau)], tau_values, 'UniformOutput', false), 'Location', 'best');

hold off;
