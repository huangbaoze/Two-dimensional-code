function [y] = bigdec2bin(x,n)
e=round(eval(log2(x)));
ind=mod(sym(2)^e,x);
if ind==0
    y=num2str([zeros(1,n-e) 1,zeros(1,e)]);
elseif ind==1
    y=num2str([zeros(1,n-e) double(mod(floor(x*sym(2).^(1-e:0)),2))]);
else
    y=num2str([zeros(1,n-e) double(mod(floor(x*sym(2).^(-e:0)),2))]);
end
end