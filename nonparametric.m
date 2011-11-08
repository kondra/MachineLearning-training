function nonparametric(X, h)
    m = size(X, 1);
    K = @(z) (exp((-z.^2)/2)./sqrt(2*pi));
    f = @(x) ((1/(m*h)).*sum(K((x-X)./h)));
    clf;
    ezplot(f, [-10, 10]);
end