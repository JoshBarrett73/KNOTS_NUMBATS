%Function to find the writhe, link matrix and number of components in a
%given knot, PD
function [writhe,linkMatrix,numComponents] = analyseDiagram(PD)
N = size(PD, 1);
%Code to handle the unknot:
if N == 0
    writhe = 0;
    numComponents = 1;
    linkMatrix = 0;
else
    %Similarly to countLoops, the following code is to set up a 2x2N matrix
    %of edges each edge is adjacent to. Code is the same with states
    %omitted.
    straightAdj = zeros(2*N, 2); 
    knownNext = zeros(2*N, 1); %Any known next edges as we trace the planar diagram. 
    for k = 1:N %Each k is a crossing
        a = PD(k,1); b = PD(k,2); c = PD(k,3); d = PD(k,4);
        knownNext(a) = c; %This comes from knowing it is the understrand
        pairs = [a c; b d]; %undirected from here so cant make changes to knownNext
        for r = 1:2
            u = pairs(r,1); %u is one edge of the two connected edges stored in pairs
            v = pairs(r,2);
            % to store that u is adjacent to v:
            if straightAdj(u, 1) == 0 %If the first slot for an adjacent edge to u is free
                straightAdj(u, 1) = v;
            else
                straightAdj(u, 2) = v;
            end
            % to store that v is adjacent to u:
            if straightAdj(v, 1) == 0 %If the first slot for an adjacent edge to v is free
                straightAdj(v, 1) = u;
            else
                straightAdj(v, 2) = u;
            end
        end
    end


    %Again, very similarly to countLoops, we now walk every closed loop in
    %straightAdj, while tracking the next edge as we go.
    compID = zeros(2*N,1); %Replaces our visited in countLoops, 0 means 
    % unvisited, once visited, it is replaced by the esge number (what Im calling component ID)
    nextEdge = zeros(2*N,1); %Stores the confirmed forward neighbor of 
    % every edge once its loop orientation is known.
    numComponents = 0;

    % Pass 1: Start only on edges with a known forward direction (a -> c)
    for startEdge = 1:2*N
        if compID(startEdge) == 0 && knownNext(startEdge) ~= 0
            numComponents = numComponents + 1;
            compID(startEdge) = numComponents;

            prevEdge = startEdge;
            currEdge = knownNext(startEdge);

            while currEdge ~= startEdge
                compID(currEdge) = numComponents;
                nextEdge(prevEdge) = currEdge;

                if straightAdj(currEdge, 1) == prevEdge
                    prevEdge = currEdge;
                    currEdge = straightAdj(currEdge, 2);
                else
                    prevEdge = currEdge;
                    currEdge = straightAdj(currEdge, 1);
                end
            end
            nextEdge(prevEdge) = startEdge; % Close the loop back to startEdge
        end
    end

    % Pass 2: Catch any component that never passed under a crossing
    for startEdge = 1:2*N
        if compID(startEdge) == 0
            numComponents = numComponents + 1;
            compID(startEdge) = numComponents;

            prevEdge = startEdge;
            currEdge = straightAdj(startEdge, 1);

            while currEdge ~= startEdge
                compID(currEdge) = numComponents;
                nextEdge(prevEdge) = currEdge;

                if straightAdj(currEdge, 1) == prevEdge
                    prevEdge = currEdge;
                    currEdge = straightAdj(currEdge, 2);
                else
                    prevEdge = currEdge;
                    currEdge = straightAdj(currEdge, 1);
                end
            end
            nextEdge(prevEdge) = startEdge;
        end
    end

    % At this point, we have the next edge in the knot for any given edge
    % in the knot.

    %To find the writhe at a given crossing, we use the right-hand rule. If
    %you are at the crossing with a behind and c infront of you, if the
    %overstrand enters from your left (nextEdge(d) = b) the crossing sign
    %is +1.
    crossingSigns = zeros(N,1);
    writhe = 0;
    linkMatrix = zeros(numComponents,numComponents);
    for k = 1:N %Each k is a crossing
        a = PD(k,1); b = PD(k,2); c = PD(k,3); d = PD(k,4);
        if nextEdge(d) == b
            crossingSigns(k) = 1;
        else
            crossingSigns(k) = -1;
        end
        writhe = crossingSigns(k) + writhe;
        %Through each iteration we also create the link matrix.
        c1 = compID(a); %understrand
        c2 = compID(b); %overstrand
        if c1 ~= c2
            linkMatrix(c1, c2) = linkMatrix(c1, c2) + crossingSigns(k);
            linkMatrix(c2, c1) = linkMatrix(c2, c1) + crossingSigns(k);
        end
    end
    linkMatrix = linkMatrix.*(1/2);
end
end