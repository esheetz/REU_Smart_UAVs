% find feature points with relationship from H4point
% points from camera view orient origin (always the same)
% points from reference image determined to preserve relationship
% inputs:
%   H4point, a 4x2 matrix
%       [[ deltaX1 deltaY1 ]
%        [ deltaX2 deltaY2 ]
%        [ deltaX3 deltaY3 ]
%        [ deltaX4 deltaY4 ]]
% outputs:
%   prs, a 4x2 matrix of feature points in reference image
%   pcs, a 4x2 matrix of feature points in current camera view
%       [[ X1 Y1 ]
%        [ X2 Y2 ]
%        [ X3 Y3 ]
%        [ X4 Y4 ]]

function [prs,pcs] = featurePoints(H4point)

    % points from current camera view pc
    % these points orient around origin
    pr1 = [1 1];
    pr2 = [-1 1];
    pr3 = [-1 -1];
    pr4 = [1 -1];
    
    % points from reference snapshot pr
    % preserve relationship determined in H4point
    pc1 = pr1 + H4point(1,:);
    pc2 = pr2 + H4point(2,:);
    pc3 = pr3 + H4point(3,:);
    pc4 = pr4 + H4point(4,:);
    
    pcs = [pc1 ; pc2 ; pc3 ; pc4];
    prs = [pr1 ; pr2 ; pr3 ; pr4];

end