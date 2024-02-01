clc;
model_params

% Prepare the figure
figure;
colors = ['b', 'r', 'g', 'm'];

% Plot the square wave before the loop
subplot(2, 1, 1);
plot(square_t, square_wave(square_t,0.5,sq_period), '.-','HandleVisibility','off'); % Plot the square wave
%hold on;

% Using MATLAB ode45's Runge-Kutta integration:
for i = 1:length(tau_values)
    
    [time, x] = ode45(@(t,x) Motor(t, x, square_wave(t,sq_amplitude,sq_period), tau_values(i)), [0 T], x0);

    x = x./(2*pi); %convert to radians

    % Plot original solution
    subplot(3, 1, 1);
    hold on;
    plot(time, x(:,1), colors(i));
    grid on;
    xlabel('Time [s]');
    ylabel('Shaft Position [rad]');
    title(['Shaft Position Responses for Different Tau Values (Load = ' num2str(sq_amplitude) '*square(' num2str(sq_period) '*t) kg)']);
    
    % Compute and plot derivative
    subplot(3, 1, 2); % Two rows, one column, second plot
    hold on;
    plot(time, x(:,2), colors(i));
    grid on;
    xlabel('Time [s]');
    ylabel('Shaft Velocity [rad/s]');
    title('Shaft Velocity');


    % Compute and plot acceleration
    dt2 = diff(time);
    dx2 = diff(x(:,2));
    accel = dx2 ./ dt2;
    time_derivative = time(1:end-1) + dt2/2; % Time vector for derivative

    subplot(3,1,3);
    hold on;
    plot(time_derivative, accel, colors(i));
    grid on;
    xlabel('Time [s]');
    ylabel('Shaft Acceleration [rad/s^2]');
    title('Shaft Acceleration Response');
    

end

% Add legends for the response curves only
subplot(3, 1, 1);
legend(arrayfun(@(tau) ['tau = ', num2str(tau)], tau_values, 'UniformOutput', false), 'Location', 'best');
subplot(3, 1, 2);
legend(arrayfun(@(tau) ['tau = ', num2str(tau)], tau_values, 'UniformOutput', false), 'Location', 'best');
subplot(3,1,3);
legend(arrayfun(@(tau) ['tau = ', num2str(tau)], tau_values, 'UniformOutput', false), 'Location', 'best');
sgtitle('$T+Fr = \ddot{\theta_1}(I_r+\frac{I_g}{N}) + k_t\dot{\theta}$','Interpreter','latex')

hold off;

% Square wave config
function square_out = square_wave(t, amplitude, period)
    square_out = amplitude*square(period*t);
end
