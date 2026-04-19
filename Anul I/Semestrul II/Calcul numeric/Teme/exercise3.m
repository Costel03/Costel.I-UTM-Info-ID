% ============================================================
% EXERCISE - Plotting (MATLAB/Octave II)
% ============================================================

% -----------------------------------------------------------
% 1. Plot f(x) = x^2 with labels, legend, title
% -----------------------------------------------------------
figure(1);
x = -10:0.1:10;
y = x.^2;

plot(x, y, 'b-', 'LineWidth', 2);
xlabel('x');
ylabel('f(x)');
title('Graph of f(x) = x^2');
legend('f(x) = x^2');
grid on;

% -----------------------------------------------------------
% 2. Plot f(x)=tan(x) and g(x)=cot(x) on the same graph
%    x in [0, 2*pi], clipping large values for readability
% -----------------------------------------------------------
figure(2);
x = 0:0.01:2*pi;

f = tan(x);
g = cot(x);

% Clip values to [-10, 10] so asymptotes don't dominate the plot
f(abs(f) > 10) = NaN;
g(abs(g) > 10) = NaN;

plot(x, f, 'b-', 'LineWidth', 2);
hold on;
plot(x, g, 'r--', 'LineWidth', 2);
hold off;

xlabel('x');
ylabel('y');
title('Graphs of f(x) = tan(x) and g(x) = cot(x)');
legend('f(x) = tan(x)', 'g(x) = cot(x)');
xlim([0, 2*pi]);
ylim([-10, 10]);
grid on;

% -----------------------------------------------------------
% 3. Plot the set of points: (-1,2.5), (0,3), (-2,5), (2,4), (-1,6)
% -----------------------------------------------------------
figure(3);
px = [-1,  0, -2,  2, -1];
py = [2.5, 3,  5,  4,  6];

plot(px, py, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
xlabel('x');
ylabel('y');
title('Set of Points');
legend('Points');
grid on;
