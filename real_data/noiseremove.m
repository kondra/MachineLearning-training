function X=noiseremove(X)
X(X(:,3)>20000,:)=[];
X(X(:,4)>9 & X(:,4)<99,:)=[];
X(X(:,5)>9 & X(:,5)<99,:)=[];
X(X(:,6)>35,:)=[];
X(X(:,7)>6 & X(:,7)<99,:)=[];
X(X(:,8)>6,:)=[];
X(X(:,9)>10,:)=[];
X(X(:,10)>0.9,:)=[];