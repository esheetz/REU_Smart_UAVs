% computes the initial normalized direction vector for return journey
% inputs:
%   posnX, matrix of sample times and x position (pixels)
%   posnY, matrix of sample times and y position (pixels)
%   posnZ, matrix of sample times and z position (pixels)
% outputs:
%   dirV, normalized 3x1 direction vector for return journey

function dirV = turnAround_path(posnX,posnY,posnZ)

    posn_final = [posnX(end,2) posnY(end,2) posnZ(end,2)];
    posn_prev = [posnX(end-1,2) posnY(end-1,2) posnZ(end-1,2)];
    
    vec = posn_prev - posn_final;
    
    len = norm(vec);
    dirV = (1/len)*vec;

end