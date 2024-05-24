%-------------huangbaoze--------------------
%-------------设置FDTD接口--------------------
clc,clear,close 
path(path,'D:\Program Files\Lumerical\FDTD\api\matlab');
sim_file_path=('E:\huangbaoze\matlab\Two-dimensional code\DBS'); % update this path to user's folder
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
load('E:\huangbaoze\matlab\Two-dimensional code\coefficient_matrix.mat','coefficient_matrix');
S_gd=coefficient_matrix(4,250);
kk=0;
Matrixnumber=0;
Matrix0=randsample([0 1],256,true,[0.5 0.5]);
Matrix=reshape(Matrix0,16,16)
[groupDelay,groupDD,Amp17]=Conversion_DBS(Matrix,h);
GD=groupDelay;
%GDD=groupDD;
%AMP=Amp17;
for n=1:200
flag=mod(n,2);
    for i=1:16
          for j=1:16
             if flag==1
                 x=i;
                 y=j;
             else
                 x=j;
                 y=i;
             end
             tmp=Matrix(x,y);
             Matrix(x,y)=1-tmp;
             [gd,gdd,amp]=Conversion_DBS(Matrix,h);
              if gd<=GD
                 Matrix(x,y)=tmp;
             else
                 GD=gd;                   
             end
          end
     end
end



