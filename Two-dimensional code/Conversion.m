function [groupDelay,groupDD,MAmp]=Conversion(Matrix,h)
global Matrixnumber;
global kk;
Matrixnumber=Matrixnumber+1;
kk=kk+1;
um=1e-6;
code=strcat(...
               'addstructuregroup;','set("name","group");','set("z",0);');                 
appevalscript(h,code);
appputvar(h,'um',um);
for i=1:16
    for j=1:16
       if Matrix(i,j)==1
           y=21.75-(i-1)*2.9;
           x=-21.75+(j-1)*2.9;
           size=2.9;           
           appputvar(h,'i',i);
           appputvar(h,'j',j);
           code=strcat('switchtolayout;',...           
               'addrect;','set("name","Si"+num2str(i)+"_"+num2str(j));', 'set("material","Si (Silicon) - Palik");',...
               'set("x",',num2str(x*um,16),');',...
               'set("y",',num2str(y*um,16),');',...
               'set("x span",',num2str(size*um,16),');',...
               'set("y span",',num2str(size*um,16),');',...
               'set("z min",0);',...
               'set("z max",29*um);',...
               'set("first axis","z");',...
               'addtogroup("group");');                         
            appevalscript(h,code);
       end             
    end
end
appevalscript(h,'run;');

code=strcat('select("trans_box");',...
    'runanalysis;',...
    'aa=getdata("trans_box","omega");',...
    'bb=getdata("trans_box","P_linear_rad");',...
    't_RCP=getdata("trans_box","t_RCP");',...
    'mAmp=getdata("trans_box","mt_AMP");',...
    'Phase=getdata("trans_box","phaseExrad");');
    appevalscript(h,code);
    omega=appgetvar(h,'aa');
    P_linear_rad=appgetvar(h,'bb');  %线性拟合后的相位
    Amp=appgetvar(h,'t_RCP');
    MAmp=appgetvar(h,'mAmp');  %平均振幅透射率
    Phase=appgetvar(h,'Phase');   %相位
    PhaseC = Phase(19);%%%设计波长对应的相位
%判断线性度
[fitresult, gof] = createFit(omega-omega(19), P_linear_rad);
groupDD=fitresult.p8;%二次项系数；泰勒级数展开二次项前有1/2的系数
groupDelay=fitresult.p9;
rmse=gof.rmse;

filename0=strcat('E:\huangbaoze\matlab\Two-dimensional code\Matrix\Matrix',num2str(Matrixnumber),'.xlsx');
xlswrite(filename0,Matrix,'A1');
%写入表格
Matrixnumber_period_GD_GDD_rmse_MAmp = [Matrixnumber,46.4,groupDelay,groupDD,rmse,MAmp];
filename1 ='Matrixnumber_period_GD_GDD_rmse_MAmp.xlsx';
xlRange = strcat('A',num2str(kk));%EXCEL 里面从A列kk行开始存储

xlswrite(filename1,Matrixnumber_period_GD_GDD_rmse_MAmp,1,xlRange);

xlswrite(filename1,P_linear_rad',2,xlRange);

xlswrite(filename1,Amp',3,xlRange);

xlswrite(filename1,Phase',4,xlRange);

code=strcat('switchtolayout;','groupscope("group");','delete("group");');%都行
%code=strcat('switchtolayout;','select("group");','delete("group");');
appevalscript(h,code);

end