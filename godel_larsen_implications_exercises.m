clc; clear; close all;

% =========================================================
% Exercise 1: Godel Implication & Max-Product Composition
% =========================================================
disp('--- Exercise 1: Godel Implication ---');
muA = [0.2, 0.7, 1, 0.7, 0.2];
muB = [0, 0.5, 0.8, 1, 0.5];
muAnew = [0.1, 0.7, 0.3, 0.2, 0];

% Step 1: Compute Fuzzy Relation R'(x,y) = mu_A(x) -> mu_B(y) 
% Using Godel Implication: IF a <= b THEN 1, ELSE b
r_godel = zeros(length(muA), length(muB));
for i = 1:length(muA)
    for j = 1:length(muB)
        if muA(i) <= muB(j)
            r_godel(i,j) = 1;
        else
            r_godel(i,j) = muB(j);
        end
    end
end
disp('Relation Matrix R (Godel):');
disp(r_godel);

% Step 2: B'(y) = mu_A'(x) o R'(x,y) using Max-Product Composition
muBnew_temp = zeros(length(muAnew), size(r_godel,2));
for i = 1:length(muAnew)
    for j = 1:size(r_godel,2)
        muBnew_temp(i,j) = muAnew(i) * r_godel(i,j);
    end
end
muBnew = max(muBnew_temp);
disp('Inferred Output B'' (Max-Product):');
disp(muBnew);

% =========================================================
% Exercise 2: Continuous Rule Firing (Mamdani vs Larsen)
% =========================================================
% Rule: IF x is A THEN y is B
x = linspace(0, 10, 1000);
y = linspace(0, 100, 1000);

A = trimf(x, [3, 5, 6]);
B = trimf(y, [10, 20, 30]);
Anew = trimf(x, [2, 4, 7]); % New observation A'

figure('Name', 'Rule Firing: Mamdani vs Larsen');

% Subplot 1: Input Space & Firing Strength
subplot(2,1,1);
plot(x, A, 'k', 'LineWidth', 2); hold on;
plot(x, Anew, 'b--', 'LineWidth', 2);

% Dynamically calculate firing strength w1 (Max of Intersection)
intersection_A_Anew = min(A, Anew);
w1 = max(intersection_A_Anew); 

plot(x, intersection_A_Anew, 'r', 'LineWidth', 2);
title(sprintf('Input Space: Firing Strength w_1 = %.3f', w1));
legend('Set A', 'New Input A''', 'Intersection (Min)');
grid on;

% Subplot 2: Output Space Implication
subplot(2,1,2);
plot(y, B, 'k', 'LineWidth', 2); hold on;

% Mamdani Implication (Clipping via MIN)
B_mamdani = min(w1, B);
plot(y, B_mamdani, 'r', 'LineWidth', 2);

% Larsen Implication (Scaling via PRODUCT)
B_larsen = w1 .* B;
plot(y, B_larsen, 'g--', 'LineWidth', 2);

title('Output Space: Mamdani (Clipped) vs Larsen (Scaled) Implication');
legend('Original Set B', 'Mamdani Implication', 'Larsen Implication');
grid on; axis([0 100 0 1.1]);

% =========================================================
% Exercise 3: Aggregation of Multiple Rules
% =========================================================
x_out = linspace(0, 10, 1000);

b1 = trimf(x_out, [2, 4, 6]);
b2 = trimf(x_out, [4, 6, 8]);

% Given firing strengths for Rule 1 and Rule 2
w1_ex3 = 0.75;
w2_ex3 = 0.25; 

figure('Name', 'Aggregation of Multiple Rules');
plot(x_out, b1, 'k--', 'LineWidth', 1.5); hold on;
plot(x_out, b2, 'k--', 'LineWidth', 1.5);

% Implication step (Clipping)
b1_dash = min(w1_ex3, b1);
b2_dash = min(w2_ex3, b2);

plot(x_out, b1_dash, 'r', 'LineWidth', 2); 
plot(x_out, b2_dash, 'm', 'LineWidth', 2); 

% Aggregation step (MAX)
c_aggregated = max(b1_dash, b2_dash);
plot(x_out, c_aggregated, 'b', 'LineWidth', 4);

title('Aggregation of Rules (Mamdani)');
legend('Original b1', 'Original b2', 'Clipped b1 (w=0.75)', 'Clipped b2 (w=0.25)', 'Aggregated Output C');
grid on; axis([0 10 0 1.1]);
