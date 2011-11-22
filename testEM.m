function [M S W] = testEM

    %параметры модельных данных
    n = 2000;
    p = 1/5;
    mu1 = 1;
    mu2 = 4;
    sigma1 = 1;
    sigma2 = 1;
    
    %f_ = @(x, mu, sigma) (1/(sqrt(2*pi)*sigma))*exp(-(x-mu).^2./(2*sigma^2));
    X1 = normrnd(mu1, sigma1, n, 1);
    X2 = normrnd(mu2, sigma2, n, 1);
    S = binornd(1, p, n, 1);
    l = logical(S);
    x1 = X1(l);
    x2 = X2(~l);
    X = [x1; x2];
    p_=rand;
    tic
    %[M S W] = EM(X,2,[0,7],[2,3],[3/5, 2/5],0.001);
    [M S W] = SEM(X,2,[1+rand,2+rand],[5+rand,2+rand],[p_, 1-p_],0.01);
    toc
    
    clf;
    F = @(x) (p * normpdf(x, mu1, sigma1) + (1-p)*normpdf(x,mu2,sigma2));
    h = ezplot(F, [min(mu1,mu2)-3*max(sigma1,sigma2),max(mu1,mu2)+3*max(sigma1,sigma2)]);
    F1 = @(x) (W(1) * normpdf(x, M(1), S(1)) + W(2)*normpdf(x,M(2),S(2)));
    set(h, 'Color', 'red');
    hold on;
    h = ezplot(F1, [min(M(1),M(2))-3*max(S(1),S(2)),max(M(1),M(2))+3*max(S(1),S(2))]);
    set(h, 'Color', 'blue');
    scatter(x1,zeros(length(x1),1),'+');
    scatter(x2,zeros(length(x2),1),'x','red');
    legend('estimate','true','first','second');
end