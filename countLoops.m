%A function to couunt
function numLoops = countLoops(PD, state)
N = size(PD, 1);
% Each edge (1 to 2N) connects to two neighbor edges (one at crossing)
adj = zeros(2*N, 2); 

%Exception case for the unknot
if N == 0 
    numLoops = 1; 
    return; 
end

for k = 1:N %Each k is a crossing
    a = PD(k,1); b = PD(k,2); c = PD(k,3); d = PD(k,4);
    if state(k) == 0
        pairs = [a b; c d]; % A-smoothing
    else
        pairs = [a d; c b]; % A^-1-smoothing
    end
    for r = 1:2
        u = pairs(r,1); %u is one edge of the two connected edges stored in pairs
        v = pairs(r,2);
        % to store that u is adjacent to v:
        if adj(u, 1) == 0 %If the first slot for an adjacent edge to u is free
            adj(u, 1) = v;
        else
            adj(u, 2) = v;
        end
        % to store that v is adjacent to u:
        if adj(v, 1) == 0 %If the first slot for an adjacent edge to v is free
            adj(v, 1) = u;
        else
            adj(v, 2) = u;
        end
    end
end

numLoops = 0; %Initialise the number of loops in PD
visited = false(1, 2*N); %For each edge, we can track if it has been visited
for startEdge = 1:2*N
    if visited(startEdge) == false
        visited(startEdge) = true;
        numLoops = numLoops + 1;
        prevEdge = startEdge;
        currEdge = adj(startEdge,1);
        %while loop visits each edge in the loop startEdge is a part of
        while currEdge ~= startEdge
            visited(currEdge) = true;
            if adj(currEdge,1) == prevEdge
                prevEdge = currEdge;
                currEdge = adj(currEdge,2);
            else
                prevEdge = currEdge;
                currEdge = adj(currEdge,1);
            end
        end
    end
end
end