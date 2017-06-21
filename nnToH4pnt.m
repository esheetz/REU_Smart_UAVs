% converts neural network output (8x1) to H4point (4x2)
% inputs:
%   nnOut, an 8x1 vector of the neural network output
%       [[ deltaX1 ]
%        [ deltaY1 ]
%        [ deltaX2 ]
%        [ deltaY2 ]
%        [ deltaX3 ]
%        [ deltaY3 ]
%        [ deltaX4 ]
%        [ deltaY4 ]]
% outputs:
%   H4point, a 4x2 matrix
%       [[ deltaX1 deltaY1 ]
%        [ deltaX2 deltaY2 ]
%        [ deltaX3 deltaY3 ]
%        [ deltaX4 deltaY4 ]]

function H4point = nnToH4pnt(nnOut)

    % initialize H4point
    H4point = zeros(4,2);
    
    % set values
    H4point(1,:) = nnOut(1:2)';
    H4point(2,:) = nnOut(3:4)';
    H4point(3,:) = nnOut(5:6)';
    H4point(4,:) = nnOut(7:8)';

end