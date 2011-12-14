function classplot3(X,i,j,k)
hold off;
clf;
y=X(:,1);
scatter3(X(y==0,i), X(y==0,j), X(y==0,k), 'blue', 'o');
hold on;
scatter3(X(y==1,i), X(y==1,j), X(y==1,k), 'red', '+');
