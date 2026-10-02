clc; clear; close all;

% 50% overlap occurs when the membership values of two adjacent 
% functions sum to 1 at their intersection point.
% These types of partitions (forced 50% overlap) are called Ruspini partitions.
% In Ruspini partitions, there are fewer parameters to optimize 
% (e.g., only the center is optimized).

% Define the universe of discourse for the two variables
x = linspace(-10, 10, 100); % Universe 1 (e.g., VO2max)
y = linspace(0, 1, 100);    % Universe 2 (e.g., Training level)

% Define Gaussian membership functions (gaussmf(x, [sigma, center]))
% k1 calculates the membership degree of x, k2 for y
k1 = gaussmf(x, [2, 0]);
k2 = gaussmf(y, [0.1, 0.5]);

% Plot the individual membership functions
figure;
subplot(1, 2, 1);
plot(x, k1, 'b', 'linewidth', 3);
title('Input 1: VO2max');

subplot(1, 2, 2);
plot(y, k2, 'b', 'linewidth', 3);
title('Input 2: Training Level');

% Create a grid for 3D visualization
[xx, yy] = meshgrid(x, y);

% Initialize the fuzzy relation matrix
r = zeros(length(x), length(y));

% Calculate the fuzzy relation using the MIN T-norm
for i = 1:length(x)
    for j = 1:length(y)
        % r(i,j) represents the degree to which the pair (x,y) 
        % belongs to the fuzzy relation
        r(i, j) = min(k1(i), k2(j)); 
    end
end

% 3D Surface visualization of the fuzzy relation
figure;
surf(xx, yy, r);
title('3D Surface of the Fuzzy Relation (MIN T-norm)');
xlabel('VO2max');
ylabel('Training Level');
zlabel('Membership Degree');
% shading flat;  % Optional: removes grid lines from the surface
% colormap(spring); % Optional: changes the color palette
