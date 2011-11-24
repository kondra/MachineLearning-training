function [M S W l rate time] = testEM2(g)
%функция производит тестирование и оценку качества ЕМ алгоритма на
%двумерных данных
%Если g == 1 происходит построение графиков

%параметры модельных данных
n = 1000;
p = 1/3;
mu1 = [0 0];
mu2 = [4 5];
sigma1 = [1 0; 0 0.9];
sigma2 = [1 0; 0 1.5];

%генерация данных
X1 = mvnrnd(mu1, sigma1, n);
X2 = mvnrnd(mu2, sigma2, n);
S = binornd(1, p, n, 1);
l = logical(S);
x1 = X1(l,:);
x2 = X2(~l,:);
X = [x1; x2];

%запуск алгоритма
tic
[W M S l] = EMk(X,2,0.0001, [0 0; 4 4]);
time=toc;

%истинная функция распределения
F = @(x,y) (p * mvnpdf([x y], mu1, sigma1) + (1-p)*mvnpdf([x y],mu2,sigma2));
%результат работы алгоритма
F1 = @(x,y) (W(1) * mvnpdf([x y], M(1,:), S(1:2,:)) + W(2)*mvnpdf([x y],M(2,:),S(3:4,:)));

%построение графиков
if g == 1
    figure(1);clf;
    ezsurf(F,[-10 10],[-10 10]);
    legend('true');

    figure(2);clf
    ezsurf(F1,[-10 20],[-10 20]);
    legend('estimate');

    figure(3);clf;
    scatter(x1(:,1),x1(:,2),'+','green');
    hold on;
    scatter(x2(:,1),x2(:,2),'x','red');
end

%оценка качества
J = @(x,y) (F(x,y)-F1(x,y)).^2;
rate = sqrt(sum(J(X(:,1),X(:,2))))/length(X);

end