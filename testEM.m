function [M S W] = testEM
    n = 10000;
    p = 1/3;
    mu1 = 1;
    mu2 = 3;
    sigma1 = 1;
    sigma2 = 4;
    f_ = @(x, mu, sigma) (1/(sqrt(2*pi)*sigma))*exp(-(x-mu).^2./(2*sigma^2));
    X1 = normrnd(mu1, sigma1, n, 1);
    X2 = normrnd(mu2, sigma2, n, 1);
    S = binornd(1, p, n, 1);
    l = logical(S);
    x1 = X1(l);
    x2 = X2(~l);
    X = [x1; x2];
    [M S W] = EM(X,2,[0,1],[2,3],[3/5, 2/5],0.001);
    
    clf;
    F = @(x) (p * f_(x, mu1, sigma1) + (1-p)*f_(x,mu2,sigma2));
    h = ezplot(F, [min(mu1,mu2)-3*max(sigma1,sigma2),min(mu1,mu2)+3*max(sigma1,sigma2)]);
    F1 = @(x) (W(1) * f_(x, M(1), S(1)) + W(2)*f_(x,M(2),S(2)));
    set(h, 'Color', 'red');
    hold on;
    h = ezplot(F1, [min(M(1),M(2))-3*max(S(1),S(2)),min(M(1),M(2))+3*max(S(1),S(2))]);
    set(h, 'Color', 'blue');
end