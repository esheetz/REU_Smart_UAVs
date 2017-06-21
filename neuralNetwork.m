% homography estimation using neural network
% inputs:
%   filler input
% outputs:
%   nnOut, an 8x1 vector of the neural network output
%       [[ deltaX1 ]
%        [ deltaY1 ]
%        [ deltaX2 ]
%        [ deltaY2 ]
%        [ deltaX3 ]
%        [ deltaY3 ]
%        [ deltaX4 ]
%        [ deltaY4 ]]

function nnOut = neuralNetwork(~)

    %% define global variables
    global currCam
    global currSnap
    
    %% run images through neural network

end