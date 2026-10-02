clc; clear; close all;

% Define the universe of discourse U
U = linspace(60, 93, 1000);

% Uniform partition of U into 5 centers
set = linspace(60, 93, 5);

% For a 50% overlap, the membership functions must intersect at exactly 0.5.
% The distance between the centers of each function is set(i+1) - set(i)
b = set(2) - set(1);

% Gaussian function formula: gaussmf(x; c, sigma) = exp(-((x-c)^2) / 2*sigma^2)
% At the intersection point x - c = b/2, the membership is 0.5.
% Solving for sigma: sigma = b / sqrt(2*log(2))
s = b / sqrt(2 * log(2));

% Store all membership functions in matrix K
K = zeros(length(set), length(U));
for i = 1:length(set)
    K(i,:) = gaussmf(U, [s, set(i)]);
end

% Plot the original fuzzy sets
figure;
plot(U, K, 'b', 'LineWidth', 1.5); hold on;
title('Fuzzy Partition of Universe U (Gaussian Functions)');
xlabel('Universe U'); ylabel('Membership Degree');

% ---------------------------------------------------------
% 1. Yager Complement for K1 (1st membership function) with w=1
% ---------------------------------------------------------
yager = @(x,w) (1 - x.^w).^(1/w); 
Y = yager(K(1,:), 1);

figure;
plot(U, K(1,:), 'r', 'LineWidth', 1.5); hold on;
plot(U, Y, 'b', 'LineWidth', 1.5);
title('Original Function and its Yager Complement (w=1)');
legend('Original Gaussian (K1)', 'Yager Complement');

% ---------------------------------------------------------
% 2. Standard Union (Max Operator) between functions 2 and 3
% ---------------------------------------------------------
% Note: Bounded sum is min(1, x+y). Here we use the standard Max union.
A = max(K(2,:), K(3,:)); 

figure;
plot(U, K(2,:), 'b', U, K(3,:), 'b', 'LineWidth', 1.2); hold on; 
plot(U, A, 'r', 'LineWidth', 2);
title('Standard Union (Max) of Functions 2 and 3');
legend('Function 2', 'Function 3', 'Union (Max)');

% ---------------------------------------------------------
% 3. Drastic Sum (T-conorm / S-norm) between functions 2 and 3
% ---------------------------------------------------------
% The Drastic Sum is defined as:
% x OR y = x (if y=0), y (if x=0), 1 (otherwise)

% Method A: Direct loop calculation
B_loop = zeros(1, size(K,2));
for j = 1:size(K,2)
    if K(2,j) == 0
        B_loop(j) = K(3,j);
    elseif K(3,j) == 0
        B_loop(j) = K(2,j);
    else
        B_loop(j) = 1;
    end
end

% Method B: Using local function da2 (best practice for dynamic inputs)
B_func = da2(K(2,:), K(3,:));

figure;
plot(U, K(2,:), 'b', U, K(3,:), 'b', 'LineWidth', 1.2); hold on; 
plot(U, B_func, 'r', 'LineWidth', 2);
title('Drastic Sum of Functions 2 and 3');
legend('Function 2', 'Function 3', 'Drastic Sum');
% Note: Since neither function 2 nor 3 reaches absolute 0 in the shared 
% region for a Gaussian curve, their Drastic Sum is mostly the line y=1.

% ---------------------------------------------------------
% 4. Standard Intersection (Min Operator) between functions 2 and 3
% ---------------------------------------------------------
C = min(K(2,:), K(3,:)); 

figure;
plot(U, K(2,:), 'b', U, K(3,:), 'b', 'LineWidth', 1.2); hold on; 
plot(U, C, 'r', 'LineWidth', 2);
title('Standard Intersection (Min) of Functions 2 and 3');
legend('Function 2', 'Function 3', 'Intersection (Min)');


% =========================================================
% LOCAL FUNCTIONS
% =========================================================

function B = da(A)
    % Drastic Sum taking a matrix A and operating on rows 2 and 3
    B = zeros(1, size(A,2));
    for j = 1:size(A,2)
        if A(2,j) == 0
            B(j) = A(3,j);
        elseif A(3,j) == 0
            B(j) = A(2,j);
        else
            B(j) = 1;
        end
    end
end

function B = da2(x, y)
    % Drastic Sum taking two specific arrays x and y (Preferred Method)
    B = zeros(1, length(x));
    for j = 1:length(x)
        if x(j) == 0
            B(j) = y(j);
        elseif y(j) == 0
            B(j) = x(j);
        else
            B(j) = 1;
        end
    end
end
