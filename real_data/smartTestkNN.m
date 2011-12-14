function A=smartTestkNN(X, f)
n=3;
maxk=20;
A=zeros(maxk,1);
i=1;
N=80000;
[M ~]=size(X);
for k=1:maxk
    s=0;
    fprintf('k=%d\n',k);
    for j=1:n
        IDX=randperm(M);
        [~, a] = newproc(X(IDX(1:N),:),X(IDX((N+1):end),:),k,0,'chebychev');
        s=s+a;
    end
    A(i,1)=s/n;
    fprintf('average AUC=%d\n\n',A(i,1));
    i=i+1;
end
if f==1
    plot(1:length(A),A);
    xlabel('k');
    ylabel('AUC');
end