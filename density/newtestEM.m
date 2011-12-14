function [M S W l] = newtestEM

    %параметры модельных данных
    n = 1000;
    p1 = 1/4;
    p2 = 1/4;
    p3 = 1/2;
    mu1 = 1;
    mu2 = 4;
    mu3 = -1;
    sigma1 = 1;
    sigma2 = 3;
    sigma3 = 2;
    
    %f_ = @(x, mu, sigma) (1/(sqrt(2*pi)*sigma))*exp(-(x-mu).^2./(2*sigma^2));
    x1 = normrnd(mu1, sigma1, n, 1);
    x2 = normrnd(mu2, sigma2, n, 1);
    x3 = normrnd(mu3, sigma3, 2*n, 1);
    %S = binornd(1, p, n, 1);
    %l = logical(S);
    %x1 = X1(l);
    %x2 = X2(~l);
    X = [x1; x2; x3];
    %p_=rand;
    tic
    %[M S W] = EM(X,2,[0,7],[2,3],[3/5, 2/5],0.001);
    %[M S W] = SEM(X,2,[1+rand,2+rand],[5+rand,2+rand],[p_, 1-p_],0.01);
    [W M S l] = EMk(X,3,0.001);%[0,7],[2,3],[3/5, 2/5],0.001);
    toc
    
    clf;
    F = @(x) (p1 * normpdf(x, mu1, sigma1) + p2*normpdf(x,mu2,sigma2) + p3*normpdf(x,mu3,sigma3));
    h = ezplot(F,[-20,20]);%, [min(mu1,mu2)-3*max(sigma1,sigma2),max(mu1,mu2)+3*max(sigma1,sigma2)]);
    F1 = @(x) (W(1) * normpdf(x, M(1), S(1)) + W(2)*normpdf(x,M(2),S(2)) + W(3)*normpdf(x,M(3),S(3)));
    set(h, 'Color', 'red');
    hold on;
    h = ezplot(F1,[-20,20]);%, [min(M(1),M(2))-3*max(S(1),S(2)),max(M(1),M(2))+3*max(S(1),S(2))]);
    set(h, 'Color', 'blue');
    scatter(x1,zeros(length(x1),1),'+');
    scatter(x2,zeros(length(x2),1),'x','red');
    scatter(x3,zeros(length(x3),1),'o','blue');
    legend('true','estimate','first','second');
end