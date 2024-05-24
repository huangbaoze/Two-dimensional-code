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
global Matrixnumber;
global kk;
global S_gd;
load('E:\huangbaoze\matlab\Two-dimensional code\coefficient_matrix.mat','coefficient_matrix');
S_gd=coefficient_matrix(4,250);
kk=0;
Matrixnumber=0;
Matrix0=randsample([0 1],256,true,[0.5 0.5]);
Matrix=reshape(Matrix0,16,16)
[groupDelay,groupDD,Amp17]=Conversion(Matrix1',h);


