function [mu_, sigma_] = parametric(X)
%одномерный ММП
%X-выборка
mu_ = mean(X);
sigma_ = std(X);
end
