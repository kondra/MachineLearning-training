function classplot2(X,i)
hold off;
clf;
scatter(X(:,i), 1:size(X(:,i),1), 'blue', 'o');
