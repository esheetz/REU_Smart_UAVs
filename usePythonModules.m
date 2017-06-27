% script to call user-defined Python modules

% help MATLAB find Python
%pyversion D:\Anaconda3\python.exe

% add current folder to Python search path
if count(py.sys.path,'') == 0
    insert(py.sys.path,int32(0),'');
end

% to call function, specify Python, file name, function name
% for example: pnts = py.features.feature_points(img1,img2)