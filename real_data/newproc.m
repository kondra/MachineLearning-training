function [Y AUC] = newproc(X1, X2, k, f, metric)
%Классификация и вычисление качества
%X1 - обучающая выборка
%X2 - контрольная выборка
%k - число ближайших соседей
%f - флаг, нужно ли рисовать график ROC-кривой
%metric - выбор метрики

%по умолчанию l2-метрика
if nargin < 5
    metric = 'euclidean';
end
tic;
%вектора ответов
Y1 = X1(:,1);
Y2 = X2(:,1);
%ветора объектов
X1 = X1(:,2:10);
X2 = X2(:,2:10);
%поиск k-ближайших соседей
[IDX, ~] = knnsearch(X1,X2,'k',k,'distance',metric);
[m, ~] = size(X2);
%вектор ответов
Y = zeros(m, 1);
%классификация
for i = 1:m
    s=sum(Y1(IDX(i,:),1));
    Y(i,1) = mean(s)>=0.5;
end
%ROC-кривая
[X11, Y11, ~, AUC] = perfcurve(Y2,Y,1);
fprintf('%d\n',AUC);
if f==1
    plot(X11,Y11);
end
toc
end