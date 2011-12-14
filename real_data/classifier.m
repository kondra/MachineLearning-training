function Y = classifier(X1, X2, k)
    tic
    [m ~] = size(X2);
    I = kNN(X1(:,2:10), X2(:,2:10), k);
    Y = zeros(m,1);
    for i = 1:m
        Y(i,1) = round(sum(X1(I(i,:), 1))/k);
    end
    toc
end
