clc,clear
figure(1);
hold on;
lb = 1; ub = 2;
ezplot('sin(10*pi*X)/X',[lb,ub]);
xlabel('自变量/X')
ylabel('因变量/Y')
Nind = 40;
Max_gen = 20;
Preci = 20;
GGAP = 0.95;
px = 0.7;
pm = 0.01;
trace = zeros(2,Max_gen);
FieldD = [Preci;lb;ub;1;0;1;1];
Chrom = crtbp(Nind,Preci);
gen = 0;
X = bs2rv(Chrom,FieldD);
Objv = sin(10 * pi * X)./X;
while gen < Max_gen
    Fitnv = ranking(Objv);
    Selch = select('sus',Chrom,Fitnv,GGAP);
    Selch = recombin('xovsp',Selch,px);
    Selch = mut(Selch,pm);
    X = bs2rv(Selch,FieldD);
    Objvsel = sin(10 * pi * X)./X;
    [Chrom,Objv] = reins(Chrom,Selch,1,1,Objv,Objvsel);
    X = bs2rv(Chrom,FieldD);
    gen = gen + 1;
    [Y,I] = min(Objv);
    trace(1,gen) = X(I);
    trace(2,gen) = Y;
end
plot(trace(1,:),trace(2,:),'bo');
grid on;
plot(X,Objv,'b*');
figure(2);
plot(1:Max_gen,trace(2,:));
grid on;
xlabel('遗传代数')
ylabel('解的变化')
title('进化过程')
BestY = trace(2,end);
BestX = trace(1,end);
fprintf(['最优解：\nX = ',num2str(BestX),'\nY = ',num2str(BestY),'\n'])
