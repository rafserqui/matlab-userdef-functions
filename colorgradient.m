function [cmap] = colorgradient(c1,c2,mixN)
    % This function fades from c1 to c2 linearly interpolating
    % c1, c2 are two RGB vectors
    % mixN are the steps in which to linearly interpolate
    
    cmap = zeros(mixN,3);
    for x = 1:mixN
        ps = x/mixN;
        cmap(x,:) = (1-ps).*c1 + ps.*c2;
    end
end