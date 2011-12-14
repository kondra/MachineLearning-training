function y = kNN2(X, x, k)
    dist = @(x,y) sqrt(sum((x-y).^2));
    D = dist(X(:,2:10)',repmat(x(2:10), length(X), 1)');
    [D I] = sort(D, 'ascend');
    Y=X(I,1);
    y = round(sum(Y(1:k,1)/k);