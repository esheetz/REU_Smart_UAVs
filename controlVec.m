% compute the control vector
% inputs:
%   H4point, a 4x2 matrix
% outputs:
%   dirV, a normalized direction vector

function dirV = controlVec(H4point)
    
    %% convert homography
    Hmatrix = convertHomography(H4point);

    %% get feature points
    [pcs,prs] = featurePoints(H4point);
    
    % separate into individual points
    % homogenous coordinates (add third dimension, z=1)
    pc1 = [pcs(1,:) 1];
    pc2 = [pcs(2,:) 1];
    pc3 = [pcs(3,:) 1];
    pc4 = [pcs(4,:) 1];
    
    pr1 = [prs(1,:) 1];
    pr2 = [prs(2,:) 1];
    pr3 = [prs(3,:) 1];
    pr4 = [prs(4,:) 1];
    
    %% compute centers of gravity
    % each COG is a 1x3 vector
    pcCOG = (1/4).*(pc1 + pc2 + pc3 + pc4);
    prCOG = (1/4).*(pr1 + pr2 + pr3 + pr4);
    % transpose so each vector is a 3x1 vector
    pcCOG = pcCOG';
    prCOG = prCOG';
    
    %% compute direction vector
    v = Hmatrix * pcCOG;      % 3x1
    v = prCOG' * v;           % 1x1
    v = v/(prCOG' * prCOG);   % 1x1
    v = v * prCOG;            % 3x1
    v = v - pcCOG;            % 3x1
    
    % normalize
    len = norm(v);
    dirV = (1/len)*v;
    
end