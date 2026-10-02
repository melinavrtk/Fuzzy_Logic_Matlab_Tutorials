clc; clear; close all;

% =========================================================
% Part 1: Define Fuzzy Sets (Input/Output Universe)
% =========================================================
x = linspace(0, 12, 100); % Universe of discourse

% Define Triangular Membership Functions
a1 = trimf(x, [1, 3, 5]);
a2 = trimf(x, [2, 6, 9]);
a3 = trimf(x, [3, 5, 10]);

% Group into a matrix and plot the initial fuzzy sets
K = [a1; a2; a3];
figure;
plot(x, K, 'b', 'LineWidth', 2);
title('Input Fuzzy Sets (A1, A2, A3)');
xlabel('Universe of Discourse');
ylabel('Membership Degree');
legend('A1', 'A2', 'A3');
grid on;

% Note: To find the membership degree of a specific crisp input x*, 
% we evaluate the membership function at that exact point.
% e.g., ind = find(x == 4.5);

% =========================================================
% Part 2: Mamdani Inference & Defuzzification
% =========================================================
% Assume b1, b2, b3 are the fuzzy sets for the output variable y
b1 = trimf(x, [1, 3, 5]);
b2 = trimf(x, [2, 6, 9]);
b3 = trimf(x, [3, 5, 10]);

% Assume firing strengths (degrees of fulfillment) for a specific crisp input x*
% i.e., w_i = mu_Ai(x*)
w1 = 0.7; 
w2 = 0.3; 
w3 = 0.8;

% Rule Base:
% Rule 1: IF x is A1 THEN y is B2
% Rule 2: IF x is A2 THEN y is B3
% Rule 3: IF x is A3 THEN y is B1

figure;
hold on;

% Implication step: Truncate output sets using the MIN operator (Mamdani implication)
b2_dash = min(w1, b2); % From Rule 1
b3_dash = min(w2, b3); % From Rule 2
b1_dash = min(w3, b1); % From Rule 3

% Plot individual truncated sets
plot(x, b2_dash, 'r', 'LineWidth', 2);
plot(x, b3_dash, 'm', 'LineWidth', 2);
plot(x, b1_dash, 'k', 'LineWidth', 2);

% Aggregation step: Combine all truncated sets using the MAX operator
C_aggregated = max(b1_dash, max(b2_dash, b3_dash));

% Plot the final aggregated fuzzy set
plot(x, C_aggregated, 'y', 'LineWidth', 5);
title('Rule Implication & Aggregation');
xlabel('Output Universe (y)');
ylabel('Membership Degree');
legend('Truncated B2 (Rule 1)', 'Truncated B3 (Rule 2)', 'Truncated B1 (Rule 3)', 'Aggregated Output (C)');
grid on;

% Defuzzification step: Extract a crisp output value using the Centroid method
y_crisp = defuzz(x, C_aggregated, 'centroid');
fprintf('Defuzzified crisp output value (Centroid method): %.4f\n', y_crisp);
