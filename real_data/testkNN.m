function AUC=testkNN(X1,X2,mk)
AUC=zeros(mk,1);
for k=3:mk
    [Y A ~]=newproc(X1,X2,k,0);
    AUC(k,1)=A;
end