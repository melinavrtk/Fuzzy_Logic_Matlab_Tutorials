clc; clear;

% Define initial fuzzy sets
% A on universe X, B on universe Y, C on universe Z
muAx = [0.9 0.8 0.7 0.7];
muBy = [1 0.6 0.8];
muCz = [0.1 0.1 0.2];

% Observed (new) inputs A' and B'
A_prime = [0 0 1 0];
B_prime = [0 1 0];

% =========================================================
% Step 1: Compute Fuzzy Relation R(y,z) = mu_B(y) -> mu_C(z)
% Using Reichenbach Implication: a -> b = 1 - a + a*b
% =========================================================
R = zeros(length(muBy), length(muCz));
for i = 1:length(muBy)
    for j = 1:length(muCz)
        R(i,j) = 1 - muBy(i) + muBy(i) * muCz(j);
    end
end
disp('Relation R(y,z):');
disp(R);

% =========================================================
% Step 2: Compute C'(z) = B'(y) ∘ R(y,z)
% Using Max-Product Composition
% =========================================================
c_prime_temp = zeros(length(B_prime), size(R,2));
for i = 1:length(B_prime)
    for j = 1:size(R,2)
        c_prime_temp(i,j) = B_prime(i) * R(i,j);
    end
end
c_prime = max(c_prime_temp); % Max over the rows
disp('Inferred set C''(z):');
disp(c_prime);

% =========================================================
% Step 3: Compute Fuzzy Relation R'(x,z) = mu_A(x) -> mu_C'(z)
% Using Reichenbach Implication again
% =========================================================
R_prime = zeros(length(muAx), length(c_prime));
for i = 1:length(muAx)
    for j = 1:length(c_prime)
        R_prime(i,j) = 1 - muAx(i) + muAx(i) * c_prime(j);
    end
end
disp('Relation R''(x,z):');
disp(R_prime);

% =========================================================
% Step 4: Compute final output C''(z) = A'(x) ∘ R'(x,z)
% Using Max-Product Composition
% =========================================================

% Method A: Using nested loops
c_double_prime_temp = zeros(length(A_prime), size(R_prime,2));
for i = 1:length(A_prime)
    for j = 1:size(R_prime,2)
        c_double_prime_temp(i,j) = A_prime(i) * R_prime(i,j);
    end
end
c_double_prime = max(c_double_prime_temp);
disp('Final inferred set C''''(z) (using nested loops):');
disp(c_double_prime);

% Method B: Vectorized / Single loop method (More efficient in MATLAB)
c_vectorized_temp = zeros(length(A_prime), size(R_prime,2));
for i = 1:size(R_prime,2)
    c_vectorized_temp(:,i) = (A_prime') .* R_prime(:,i);
end
c_final = max(c_vectorized_temp);
disp('Final inferred set C''''(z) (using vectorization):');
disp(c_final);
