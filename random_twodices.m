clearvars;
% Number of simulations
numSteps = 100;

% Simulate rolling two dice
rolls = randi(6, numSteps, 2);
sums = sum(rolls, 2);

% Calculate the histogram of the sums
[counts, edges] = histcounts(sums, [1.5:1:12.5], 'Normalization', 'probability');

% Calculate the exact and hand probabilities
exact_prob = [1,2,3,4,5,6,5,4,3,2,1];
exact_prob = exact_prob / 36;
hand_prob =  [1,2,8,11,17,13,12,13,12,8,3];
hand_prob = hand_prob / 100;
% Plot the histogram
figure;
hold on;
histogram('BinEdges', edges, 'BinCounts', counts, 'Normalization', 'probability', 'FaceColor', 'r', 'FaceAlpha', 0.5);

% Overlay the exact probabilities
x = 2:12;
plot(x, exact_prob, 'LineWidth', 2);
plot(x, hand_prob, 'LineWidth', 2);
% Overlay the sim probabilities
plot(x, counts, 'LineWidth', 2);
% Label the axes
xlabel('the sum of rolling two dices');
ylabel('Probability');

% Add legend
legend('Hist', 'Exact', 'Hand','Sim');

% Add title
title('Total number of steps = 100');

hold off;

