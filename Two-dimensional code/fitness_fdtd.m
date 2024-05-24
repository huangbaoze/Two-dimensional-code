function f=fitness_fdtd(x)
global h;
global S_gd;
Matrix=[];
for i=1:16
a=dec2bin(x(i),16);
b=boolean(a-'0');
binary=double(b);
Matrix=[Matrix binary];
end
Matrix1=reshape(Matrix,16,16);
Matrix1'
[groupDelay,groupDD,MAmp]=Conversion(Matrix1',h);
f=abs(groupDelay-S_gd);
end

