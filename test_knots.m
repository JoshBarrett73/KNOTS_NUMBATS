clear; clc;
% A script to test functions
PD_trefoil = [1 5 2 4; 3 1 4 6; 5 3 6 2];
PD_figure_eight = [4 2 5 1; 8 6 1 5; 6 3 7 4; 2 7 3 8];
PD_pos_hopf_link = [1 4 2 3; 3 2 4 1];

state_trefoil = [0, 0, 0]; 
loops_trefoil = countLoops(PD_trefoil, state_trefoil);
fprintf('Trefoil - closed loops in all-A state: %d (expected: 2)\n', loops_trefoil);

state_fig8 = [0, 0, 0, 0];
loops_fig8 = countLoops(PD_figure_eight, state_fig8);
fprintf('Figure-eight - closed loops in all-A state: %d (expected: 3)\n', loops_fig8);

state_hopf = [0, 0];
loops_hopf = countLoops(PD_pos_hopf_link, state_hopf);
fprintf('Hopf link - closed loops in all-A state: %d (expected: 2)\n', loops_hopf);