function classplot(X,i,j)
hold off;
clf;
y=X(:,1);
%scatter(X(y==0,i), 1:size(X(y==0,i),1), 'blue', 'o');
scatter(X(y==0,i), X(y==0,j), 'blue', 'o');
hold on;
%scatter(X(y==1,i), 1:size(X(y==1,i),1), 'red', '+');
scatter(X(y==1,i), X(y==1,j), 'red', '+');
