function auc=roc(Y,A)
l=length(Y);
[A,I] = sort(A,'ascend');
Y=Y(I);
X1=cumsum(Y)/length(Y==1);
X2=cumsum(~Y)/length(Y==0);
clf;
plot([0,X1],[0,X2]);
auc=trapz([0 X1], [0 X2]);
