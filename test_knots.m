clear; clc;
% A script to test functions
PD_unknot = [];
PD_trefoil = [1 5 2 4; 3 1 4 6; 5 3 6 2];
PD_figure_eight = [4 2 5 1; 8 6 1 5; 6 3 7 4; 2 7 3 8];
PD_pos_hopf_link = [1 4 2 3; 3 2 4 1];

state_unknot = []; 
loops_unkot = countLoops(PD_unknot, state_unknot);
fprintf('Unknot - closed loops in all-A state: %d (expected: 1)\n', loops_unkot);

state_trefoil = [0, 0, 0]; 
loops_trefoil = countLoops(PD_trefoil, state_trefoil);
fprintf('Trefoil - closed loops in all-A state: %d (expected: 2)\n', loops_trefoil);

state_fig8 = [0, 0, 0, 0];
loops_fig8 = countLoops(PD_figure_eight, state_fig8);
fprintf('Figure-eight - closed loops in all-A state: %d (expected: 3)\n', loops_fig8);

state_hopf = [0, 0];
loops_hopf = countLoops(PD_pos_hopf_link, state_hopf);
fprintf('Hopf link - closed loops in all-A state: %d (expected: 2)\n', loops_hopf);

fprintf('--- Testing analyseDiagram ---\n');

[w_unknot, link_unknot, comp_unknot] = analyseDiagram(PD_unknot);
fprintf('Unknot       -> writhe: %d (exp: 0), components: %d (exp: 1), linkMatrix: %s (exp: 0)\n', ...
    w_unknot, comp_unknot, mat2str(link_unknot));

[w_trefoil, link_trefoil, comp_trefoil] = analyseDiagram(PD_trefoil);
fprintf('Trefoil      -> writhe: %d (exp: 3), components: %d (exp: 1), linkMatrix: %s (exp: 0)\n', ...
    w_trefoil, comp_trefoil, mat2str(link_trefoil));

[w_fig8, link_fig8, comp_fig8] = analyseDiagram(PD_figure_eight);
fprintf('Figure-eight -> writhe: %d (exp: 0), components: %d (exp: 1), linkMatrix: %s (exp: 0)\n', ...
    w_fig8, comp_fig8, mat2str(link_fig8));

[w_hopf, link_hopf, comp_hopf] = analyseDiagram(PD_pos_hopf_link);
fprintf('Hopf link    -> writhe: %d (exp: 2), components: %d (exp: 2), linkMatrix: %s (exp: [0 1;1 0])\n', ...
    w_hopf, comp_hopf, mat2str(link_hopf));