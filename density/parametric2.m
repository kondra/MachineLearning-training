function [mu, sigma] = parametric2(X)
%двумерный ММП
%X-выборка
[m ~] = size(X);
mu = mean(X);
repmu = repmat(mu, m, 1);
sigma = (1/(m-1))*((X-repmu)'*(X-repmu));
end
