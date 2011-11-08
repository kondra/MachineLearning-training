function nonparametric(X)
    [m n] = size(X);
    h = 5;
    K = @(z) (exp((-z.^2)/2)./sqrt(2*pi));
end
    
function y = f(X, x)
    %y = 