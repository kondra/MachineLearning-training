function A=ktest(X, k)
n=5;
N=80000;
[M ~]=size(X);
s=0;
clf;
hold on;
for j=1:n
    IDX=randperm(M);
    [~, a] = newproc(X(IDX(1:N),:),X(IDX((N+1):end),:),k,1,'cityblock');
    s=s+a;
end
A=s/n;