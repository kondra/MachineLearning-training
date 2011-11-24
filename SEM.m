function [W, M, S, count] = SEM(X, k, delta)
%Стохастический EM алгоритм
%функция вычисляет веса, вектор математических ожиданий и ковариационные
%матрицы. Выходной  параметр l - количество итераций. X - выборка, k - число
%компонент в смеси, delta - параметр критерия останова.
m = size(X, 1);
g = zeros(m, k);
y = zeros(m, k);
count = 0; %число итераций

%начальное приближение
W(1:k,1)=1/k;
M=zeros(k,1);
for j=1:k
    M(j,1) = min(X) + (j-1)/k*(max(X)-min(X)) + rand;
end
S = ones(k,1);

W=W';
S=S';
M=M';

while 1
    count = count+1;
    %E-шаг (expectation):
    g0 = g;
    for i = 1:m
        for j = 1:k
            g(i,j) = (W(j)*normpdf(X(i),M(j),S(j)))/sum(W.*normpdf(X(i), M, S));
        end
    end
    %S-шаг(стохастическое моделирование):
    K = nan(k, m);
    num=ones(k,1);
    for i = 1:m
        y(i,:)=mnrnd(1,g(i,:));
        for j = 1:k
            if y(i,j)==1
                K(j,num(j))=X(i);
                num(j)=num(j)+1;
            end
        end
    end
    %M-шаг (maximization):
    %пересчет весов
    W = (1/m).*sum(g);
    %пересчет матожиданий и дисперсий
    for j = 1:k
        M(j) = (1/num(j))*sum(K(j,~isnan(K(j,:))));
        S(j) = sqrt((1/num(j))*sum((K(j,~isnan(K(j,:)))-M(j)).^2));
    end
    if max(max(abs(g-g0))) < delta || count > 100
        break;
    end
end
end
