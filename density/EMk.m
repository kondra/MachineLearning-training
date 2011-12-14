function [W,M,Sigma,l] = EMk(X,k,delta,M)
%EM-алгоритм
%функция вычисляет веса, вектор математических ожиданий и ковариационные
%матрицы. Выходной  параметр l - количество итераций. X - выборка, k - число
%компонент в смеси, delta - параметр критерия останова.

[m,n] = size(X);

g = [ones(m, 1) zeros(m, k-1)];

l=0; %число итераций

%начальное приближение
W(1:k,1)=1/k;
if nargin<4
    M=zeros(k,n);
    for j=1:k
        M(j,:) = min(X) + (j-1)/k*(max(X)-min(X)) + rand;
    end
end
Sigma = repmat(eye(n),k,1);

while 1
    %E-шаг (expectation):
    g0=g;
    for i = 1:m
        for j = 1:k
            g(i,j) = W(j)*mvnpdf(X(i,:),M(j,:),Sigma((j-1)*n+1:j*n,:));
            S = 0;
            for s = 1:k
                S = S + W(s)*mvnpdf(X(i,:), M(s,:), Sigma((s-1)*n+1:s*n,:));
            end
            g(i,j) = g(i,j)/S;
        end
    end

    %M-шаг (maximization):

    %пересчет весов
    W = sum(g)/m;
    %обновление векторов математических ожиданий
    for j = 1:k
        M(j,:) = (g(:,j)'*X)/m/W(j);
    end
    %обновление ковариационных матриц
    for j = 1:k
        S = zeros([n,n]);
        for i =1:m
            S = S + g(i,j)*(X(i,:)-M(j,:))'*(X(i,:)-M(j,:));
        end
        Sigma((j-1)*n+1:j*n,:) = S/m/W(j);
    end

    l=l+1;
    if max(max(abs(g-g0))) < delta || l > 100
        break
    end
end
end
