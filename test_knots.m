clear; clc;

% Right-handed trefoil shown on Planar Diagram (PD)
% [a, b, c, d] lists the four incident edges in counter-clockwise order starting from the incoming under-strand a
PD_trefoil = [1 5 2 4;
    3 1 4 6;
    5 3 6 2];

% State vector: 0 = A-smoothing, 1 = A^-1-smoothing
state = [0, 0, 0]; 
loops = countLoops(PD_trefoil, state);
fprintf('Closed loops in all-A state: %d (expected: 2)\n', loops);