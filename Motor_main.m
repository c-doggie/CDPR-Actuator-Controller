clc;
%Initial Conditions
theta0 = 0;   %Initial angle
theta_dot0 = 0;  %Initial angular velocity
x0 = [theta0; theta_dot0];

%Simulation Parameters
T = 0.2;         %Simulation time
dt = 0.001;
%Square wave config
square_t = 0:dt:T;
square_x = square(square_t);

%Controller Params
tau_values = [1 2 3 4];
load_values = -5;

% Prepare the figure
figure;
hold on;
grid on;
colors = ['b', 'r', 'g', 'w']; % Define a set of colors

%Using MATLAB ode45's Runge-Kutta integration:
for i = 1:length(tau_values)

    [time, x] = ode45(@(t,x) Motor(t, x, load_values, tau_values(i)), [0 T], x0);
    % Plot original solution
    subplot(2, 1, 1); % Two rows, one column, first plot
    hold on;
    plot(time, x(:,1), colors(i));
    grid on;
    xlabel('Time [s]');
    ylabel('Shaft Velocity [rad/s]');
    title(['Shaft Velocity Responses for Different Tau Values (Load = ' num2str(load_values) 'kg)']);
    
    % Compute and plot derivative
    subplot(2, 1, 2); % Two rows, one column, second plot
    hold on;
    plot(time, x(:,2), colors(i));
    grid on;
    xlabel('Time [s]');
    ylabel('Shaft Acceleration [rad/s^2]');
    title('Shaft Acceleration');

end

% Add legends
subplot(2, 1, 1);
legend(arrayfun(@(tau) ['tau = ', num2str(tau)], tau_values, 'UniformOutput', false), 'Location', 'best');
subplot(2, 1, 2);
legend(arrayfun(@(tau) ['tau = ', num2str(tau)], tau_values, 'UniformOutput', false), 'Location', 'best');
sgtitle('$T+Fr = \ddot{\theta_1}(I_r+\frac{I_g}{N}) + k_t\dot{\theta}$','Interpreter','latex')

hold off;

