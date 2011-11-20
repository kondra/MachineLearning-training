function [mu_, sigma_] = parametric(X)
    mu_ = mean(X);
    sigma_ = std(X, 1);
end