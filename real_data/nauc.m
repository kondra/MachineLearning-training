function A=nauc(X)
m=100;
A=zeros(size(1:10:m,1),1);
k=1;
[M, ~]=size(X);
for i = 10:10:m
    IDX=randperm(M);
    [~, a] = newproc(X(IDX((i+1):end),:),X(IDX(1:i),:),8,0);
    A(k,1)=a;
    k=k+1;
end