% ============================================================
% EXERCISE 2 - Vector and Matrix Indexing
% ============================================================

% j. Select elements from vector v
v = [1 2 3 4 5 6 7 8]

% Positions 2 to 6
sel_2to6 = v(2:6)
disp('Elements at positions 2-6');

% Positions 1, 4, 7
sel_1_4_7 = v([1, 4, 7])
disp('Elements at positions 1, 4, 7');

% k. Build a 6x6 random matrix A
A = rand(6, 6)
disp('A = 6x6 random matrix');

% i. Select row 1
row1 = A(1, :)
disp('Row 1 of A');

% ii. Select column 2
col2 = A(:, 2)
disp('Column 2 of A');

% iii. Select rows 1-3 and columns 3-5
sub1 = A(1:3, 3:5)
disp('Rows 1-3, Columns 3-5');

% iv. Select rows 1 and 3, columns 3-5
sub2 = A([1, 3], 3:5)
disp('Rows 1 and 3, Columns 3-5');
