function [M S W l rate time] = testEM(g,mode)
%функция производит тестирование и оценку качества ЕМ алгоритма
%Если g == 1 происходит построение графиков
%mode - выбор алгоритма. 'e' - обычный EM, 's' - стохастический

%параметры модельных данных
n = 1000;
p = 1/3;
mu1 = 1;
mu2 = 3;
sigma1 = 1;
sigma2 = 1;

%генерация выборки
X1 = normrnd(mu1, sigma1, n, 1);
X2 = normrnd(mu2, sigma2, n, 1);
S = binornd(1, p, n, 1);
l = logical(S);
x1 = X1(l);
x2 = X2(~l);
X = [x1; x2];

%запуск алгоритма
tic
if mode == 'e'
    [W M S l] = EMk(X,2,0.001);
elseif mode == 's'
    [W M S l] = SEM(X,2,0.001);
end
time=toc;

%истинная функция распределения
F = @(x) (p * normpdf(x, mu1, sigma1) + (1-p)*normpdf(x,mu2,sigma2));
%результат работы алгоритма
F1 = @(x) (W(1) * normpdf(x, M(1), S(1)) + W(2)*normpdf(x,M(2),S(2)));

%построение графиков
if g == 1
    clf;

    h = ezplot(F, [min(mu1,mu2)-3*max(sigma1,sigma2),max(mu1,mu2)+3*max(sigma1,sigma2)]);
    set(h, 'Color', 'red');

    hold on;

    h = ezplot(F1, [min(M(1),M(2))-3*max(S(1),S(2)),max(M(1),M(2))+3*max(S(1),S(2))]);
    set(h, 'Color', 'blue');

    scatter(x1,zeros(length(x1),1),'+');
    scatter(x2,zeros(length(x2),1),'x','red');

    legend('true','estimate','first','second');
end

%оценка качества
J = @(x) (F(x)-F1(x)).^2;
rate = sqrt(sum(J(X)))/length(X);

end