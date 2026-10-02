clc; clear; close all;

% =========================================================
% Theoretical Background: Generalized Modus Ponens (GMP) & CRI
% =========================================================
% Fuzzy inference implements the Compositional Rule of Inference (CRI) 
% and produces an aggregated fuzzy set that is subsequently defuzzified.
% 
% Rule form: IF x is A THEN y is B
% This fuzzy rule generates a fuzzy relation R(x,y) (acting as a trained model).
% 
% Given a new observation: x is A'
% We need to infer the new output: y is B'
% 
% Formula: B' = A' ∘ R (where ∘ denotes max-min composition)
% Mathematically: mu_B'(y) = sup_x {mu_A'(x) * mu_R(x,y)} (where * is a T-norm)
% Note: 'sup' (supremum) is equivalent to 'max' for discrete/continuous functions.
%
% Geometrically: A' undergoes cylindrical extension into the Cartesian product 
% space of X and Y, intersecting with the relation R.

% =========================================================
% Part 1: Define Discrete Fuzzy Sets
% =========================================================
% Universe X: [1, 5], Universe Y: [-2, 2]
A = [0, 0.1, 0.4, 0.8, 1];       % Premise (Rule Input)
B = [0, 0.6, 1,   0.6, 0];       % Consequent (Rule Output)
Anew = [0, 0.2, 0.3, 1, 0.1];    % New Observation A'

% =========================================================
% Part 2: Generate Fuzzy Relation R(x,y)
% =========================================================
% Using Mamdani Implication (MIN operator)
r = zeros(length(A), length(B));
for i = 1:length(A)
    for j = 1:length(B)
        r(i,j) = min(A(i), B(j));
    end
end

% Visualize the Fuzzy Relation Matrix R(x,y) in 3D
figure;
bar3(r);
title('Fuzzy Relation Matrix R(x,y) (Mamdani Implication)');
xlabel('Universe Y (B)');
ylabel('Universe X (A)');
zlabel('Membership Degree');
colormap('parula');

% =========================================================
% Part 3: Max-Min Composition (B' = A' ∘ R)
% =========================================================
% Compute the intersection (MIN) of the cylindrical extension of A' with R
Bnew_temp = zeros(length(Anew), size(r,2));
for i = 1:length(Anew)
    for j = 1:size(r,2)
        % Transposing Anew to match dimensions
        Bnew_temp(i,j) = min(Anew(i), r(i,j));
    end
end

% Compute the projection (MAX / Supremum) onto Universe Y
Bnew = max(Bnew_temp);

% Display results in the Command Window
disp('--- Generalized Modus Ponens (GMP) ---');
disp('Relation Matrix R(x,y):');
disp(r);
disp('New Observation A'':');
disp(Anew);
disp('Inferred Output B'':');
disp(Bnew);
