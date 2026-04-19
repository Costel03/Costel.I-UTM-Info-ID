% ============================================================
% EXERCISE 1 - Matrix Operations
% ============================================================

% a. Build matrix A (4x2) with random elements in (0, 10)
A = rand(4, 2) * 10
disp('A = 4x2 random matrix in (0,10)');

% b. Build B (2x4) with all even elements, multiply A*B -> C
B = [2 4 6 8; 10 12 14 16]
C = A * B
disp('C = A * B');

% c. Inverse of C
inv_C = inv(C)
disp('inv_C = inverse of C');

% d. M = all elements of B divided by 2
M = B / 2
disp('M = B divided by 2');

% e. Concatenate M with itself vertically to get 4x4 matrix V
V = [M; M]
disp('V = M concatenated with itself (4x4)');

% f. Extract the 2x2 matrix from the middle of V (rows 2-3, cols 2-3)
W = V(2:3, 2:3)
disp('W = 2x2 submatrix from the middle of V');

% g. Apply sin(x) to each element of W
W_sin = sin(W)
disp('W_sin = sin applied element-wise to W');

% h. Transpose of W
W_T = W'
disp('W_T = transpose of W');

% i. W * W
W_sq = W * W
disp('W_sq = W * W');
