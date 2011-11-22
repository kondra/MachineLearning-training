function [M S W] = testEM2

    %параметры модельных данных
    n = 1000;
    p = 1/5;
    mu1 = [1 2];
    mu2 = [4 5];
    sigma1 = [1 0; 0 .9];
    sigma2 = [3 0.2; 0.6 2.5];
    
    %f_ = @(x, mu, sigma) (1/(sqrt(2*pi)*sigma))*exp(-(x-mu).^2./(2*sigma^2));
    X1 = mvnrnd(mu1, sigma1, n);
    X2 = mvnrnd(mu2, sigma2, n);
    S = binornd(1, p, n, 1);
    l = logical(S);
    x1 = X1(l);
    x2 = X2(~l);
    X = [x1; x2];
    p_=rand;
    tic
    %[M S W] = EM(X,2,[0,7],[2,3],[3/5, 2/5],0.001);
    [M S W] = SEM2(X,2,[1+rand,2+rand;3+rand,1+rand],[5+rand,2+rand],[p_, 1-p_],0.01);
    toc
    
    clf;
    figure 1;
    F = @(x) (p * mvnpdf(x, mu1, sigma1) + (1-p)*mvnpdf(x,mu2,sigma2));
    h = ezsurf(F);%, [min(mu1,mu2)-3*max(sigma1,sigma2),max(mu1,mu2)+3*max(sigma1,sigma2)]);
    figure 2;
    F1 = @(x) (W(1) * mvnpdf(x, M(1), S(1)) + W(2)*mvnpdf(x,M(2),S(2)));
    set(h, 'Color', 'red');
    hold on;
    h = ezsurf(F1);%, [min(M(1),M(2))-3*max(S(1),S(2)),max(M(1),M(2))+3*max(S(1),S(2))]);
    set(h, 'Color', 'blue');
    scatter(x1(:,1),x1(:,2),'+');
    scatter(x2(:,1),x2(:,2),'x','red');
    legend('estimate','true','first','second');
end