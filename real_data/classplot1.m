function classplot1(X,i)
hold off;
clf;
y=X(:,1);
scatter(X(y==0,i), 1:size(X(y==0,i),1), 'blue', 'o');
hold on;
scatter(X(y==1,i), 1:size(X(y==1,i),1), 'red', '+');
