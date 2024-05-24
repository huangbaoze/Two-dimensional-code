%-------------huangbaoze--------------------
%-------------设置FDTD接口--------------------
clc,clear,close 
path(path,'D:\Program Files\Lumerical\FDTD\api\matlab');
sim_file_path=('E:\huangbaoze\matlab\Two-dimensional code'); % update this path to user's folder
sim_file_name=('Two-dimensional code.fsp');
global h;
h=appopen('fdtd');
%Pass the path variables to FDTD
appputvar(h,'sim_file_path',sim_file_path);
appputvar(h,'sim_file_name',sim_file_name);
code=strcat('cd(sim_file_path);',...
    'load(sim_file_name);');
appevalscript(h,code);
%-------------设置基本参数--------------------
Matrix=xlsread('Matrix\Matrix1016.xlsx',1);
Conversion(Matrix1',h);