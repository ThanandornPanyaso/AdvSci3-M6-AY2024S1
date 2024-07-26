% Number of steps
n = 1000;

% Initialize position
x = zeros(1, n+1);
y = zeros(1, n+1);

% Perform random walk
for i = 2:n+1
    direction = randi(4); % 1: right, 2: up, 3: left, 4: down
    switch direction
        case 1
            x(i) = x(i-1) + 1;
            y(i) = y(i-1);
        case 2
            x(i) = x(i-1);
            y(i) = y(i-1) + 1;
        case 3
            x(i) = x(i-1) - 1;
            y(i) = y(i-1);
        case 4
            x(i) = x(i-1);
            y(i) = y(i-1) - 1;
    end
end

% Plot trajectory
figure;
plot(x, y, 'b-', 'LineWidth', 1);
hold on;
plot(0, 0, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r'); % Mark original position
xlabel('X');
ylabel('Y');
title('2D Random Walk: 1 Walker, 1000 Steps');
grid on;
axis equal;
