% convert from 4 point homography parameterization to matrix homography
% inputs:
%   H4point, a 4x2 matrix
%       [[ deltaX1 deltaY1 ]
%        [ deltaX2 deltaY2 ]
%        [ deltaX3 deltaY3 ]
%        [ deltaX4 deltaY4 ]]
% outputs:
%   Hmatrix, a 3x3 matrix
%       [[ h11 h12 h13 ]
%        [ h21 h22 h23 ]
%        [ h31 h32 h33 ]]

function Hmatrix = convertHomography(H4point)

    %% get feature points
    [pcs,prs] = featurePoints(H4point);
    
    % separate into individual points
    pc1 = pcs(1,:);
    pc2 = pcs(2,:);
    pc3 = pcs(3,:);
    pc4 = pcs(4,:);
    
    pr1 = prs(1,:);
    pr2 = prs(2,:);
    pr3 = prs(3,:);
    pr4 = prs(4,:);
    
    %% convert
    % initialize A and b for matrix equation A*h = b
    A = [pc1(1) pc1(2) 1 0 0 0 -pc1(1)*pr1(1) -pc1(2)*pr1(1) -pr1(1);
         0 0 0 pc1(1) pc1(2) 1 -pc1(1)*pr1(2) -pc1(2)*pr1(2) -pr1(2);
         pc2(1) pc2(2) 1 0 0 0 -pc2(1)*pr2(1) -pc2(2)*pr2(1) -pr2(1);
         0 0 0 pc2(1) pc2(2) 1 -pc2(1)*pr2(2) -pc2(2)*pr2(2) -pr2(2);
         pc3(1) pc3(2) 1 0 0 0 -pc3(1)*pr3(1) -pc3(2)*pr3(1) -pr3(1);
         0 0 0 pc3(1) pc3(2) 1 -pc3(1)*pr3(2) -pc3(2)*pr3(2) -pr3(2);
         pc4(1) pc4(2) 1 0 0 0 -pc4(1)*pr4(1) -pc4(2)*pr4(1) -pr4(1);
         0 0 0 pc4(1) pc4(2) 1 -pc4(1)*pr4(2) -pc4(2)*pr4(2) -pr4(2)];
     
    % b = zeros(8,1);
    
    % solve
    % h is 9x1 matrix containing elements of Hmatrix
    h = null(A); % returns nonzero vector that satisfies A*x = b
    
    % rearrange elements of h to form Hmatrix
    Hmatrix = [h(1:3)';
               h(4:6)';
               h(7:9)'];

end