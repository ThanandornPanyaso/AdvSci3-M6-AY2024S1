% MATLAB code to apply the Acceptance-Rejection method for a Normal distribution

% Define the target distribution (normal distribution parameters)
mu = 0;  % mean
sigma = 0.4;  % standard deviation
f = @(x) normpdf(x, mu, sigma);  % target PDF

% Define the proposal distribution (uniform distribution parameters)
a = -5;  % lower bound
b = 5;   % upper bound
g =  @(x) exp(-(x^2));  % proposal PDF
C = 1;  % constant such that f(x) <= C * g(x)

% Number of samples
N = 1000;

% Arrays to store accepted and rejected samples
accepted_samples = [];
rejected_samples = [];

% Acceptance-Rejection sampling
while length(accepted_samples) < N
    % Step 1: Draw X from proposal distribution g(X)
    x_candidate = a + (b - a) * rand();
    
    % Step 2: Generate U ~ U(0,1), independent of X
    u = rand();
    
    % Step 3: Acceptance criterion
    if u <= f(x_candidate) / (C * g(x_candidate))
        accepted_samples = [accepted_samples; x_candidate, u];
    else
        rejected_samples = [rejected_samples; x_candidate, u];
    end
end

% Plot the results
figure;
hold on;
% Plot the target distribution
fplot(f, 'k', 'LineWidth', 2);
% Plot the accepted samples
plot(accepted_samples(:,1), accepted_samples(:,2), 'bo');
% Plot the rejected samples
plot(rejected_samples(:,1), rejected_samples(:,2), 'rx');
legend('target', 'accept', 'reject');
xlabel('x');
ylabel('u');
title('Acceptance-Rejection Method for Normal Distribution');
hold off;
length(rejected_samples)+length(accepted_samples)