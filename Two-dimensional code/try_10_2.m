clear
A=[1 2 3 7; 4 5 6 8 ; 7 8 9 9];
B=(boolean(dec2bin(A,8)-'0'));
[row_b,col_b]=size(B);
[row_a,col_a]=size(A);

for i=1:row_a
    x=0;
    for j=1:col_a
     BB(i,(j-1)*col_b+1:col_b*j)=B(i+x*row_a,:);
     x=x+1;
    end    
end