function [mu_, sigma_] = parametric(X, mu, sigma)
    mu_ = mean(X);
    sigma_ = std(X, 1);
    
    clf;
    
    f = @(x) (1/(sqrt(2*pi)*sigma_))*exp(-(x-mu_).^2./(2*sigma_^2));
    ezplot(f, [-10 10]);
    
    if nargin == 3
        f_ = @(x) (1/(sqrt(2*pi)*sigma))*exp(-(x-mu).^2./(2*sigma^2));
        hold on;
        h = ezplot(f_, [-10, 10]);
        set(h, 'Color', 'red');
        hold off;
    end
end