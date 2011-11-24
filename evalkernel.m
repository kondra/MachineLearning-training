function rate=evalkernel
%функция оценивает работу различных ядер
%результатом является таблица с оценками качества
mu_ = 0;
sigma_ = 1;
p = @(x) (normpdf(x, mu_, sigma_));
rate=zeros(10,11);

for i=1:10
    X = normrnd(mu_, sigma_, 1000, 1);
    m = size(X, 1);
    hopt = 1.06*(m^(-1/5))*std(X);

    g = nonparametric(X, hopt, 'e', 1);
    J=@(x) (p(x)-g(x)).^2;
    rate(1,i) = 1/m*sqrt(sum(J(X')));
    rate(1,11) = rate(1,11) + rate(1,i);

    g = nonparametric(X, hopt, 'k', 1);
    J=@(x) (p(x)-g(x)).^2;
    rate(2,i) = 1/m*sqrt(sum(J(X')));
    rate(2,11) = rate(2,11) + rate(2,i);

    g = nonparametric(X, hopt, 't', 1);
    J=@(x) (p(x)-g(x)).^2;
    rate(3,i) = 1/m*sqrt(sum(J(X')));
    rate(3,11) = rate(3,11) + rate(3,i);

    g = nonparametric(X, hopt, 'g', 1);
    J=@(x) (p(x)-g(x)).^2;
    rate(4,i) = 1/m*sqrt(sum(J(X')));
    rate(4,11) = rate(4,11) + rate(4,i);

    g = nonparametric(X, hopt, 'p', 1);
    J=@(x) (p(x)-g(x)).^2;
    rate(5,i) = 1/m*sqrt(sum(J(X')));
    rate(5,11) = rate(5,11) + rate(5,i);
end
rate(:,11)=rate(:,11)./10;
end
