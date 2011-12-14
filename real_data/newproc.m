function [Y AUC] = newproc(X1, X2, k, f, metric)
    if nargin < 5
        metric = 'euclidean';
    end
    tic;
    Y1 = X1(:,1);
    Y2 = X2(:,1);
    X1 = X1(:,2:10);
    X2 = X2(:,2:10);
    [IDX, ~] = knnsearch(X1,X2,'k',k,'distance',metric);
    [m, ~] = size(X2);
    Y = zeros(m, 1);
    for i = 1:m
        s=sum(Y1(IDX(i,:),1));
        Y(i,1) = mean(s)>=0.5;
    end
    [X11, Y11, ~, AUC] = perfcurve(Y2,Y,1);
    fprintf('%d\n',AUC);
    if f==1
        plot(X11,Y11);
    end
    toc
end