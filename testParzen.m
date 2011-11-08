function testParzen(t)
    clf;
    switch t
        case {'norm'}
            mu_ = 0;
            sigma_ = 1;
            X = normrnd(mu_, sigma_, 1000, 1);
            n = size(X, 1);
            h = 1.06*(n^(-1/5))*std(X);
            nonparametric(X, h);
            hold on;
            f = @(x) (1/(sqrt(2*pi)*sigma_))*exp(-(x-mu_).^2./(2*sigma_^2));
            h=ezplot(f, [mu_-3*sigma_, mu_+3*sigma_]);
        case {'exp'}
            mu = 1;
            X = exprnd(mu, 1000, 1);
            nonparametric(X, 0.3);
            hold on;
            f = @(x) (mu*exp(-mu*x));
            h=ezplot(f, [0, 5]);
    end
    set(h, 'Color', 'red');
end