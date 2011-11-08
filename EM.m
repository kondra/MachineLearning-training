function [M, S] = EM(X, k, M, S, W, delta)
    m = size(X, 1);
    g = zeros(m, k);
    g0 = zeros(m, k);
    phi = @(x,mu,sigma) (1/((2*pi)^(1/2)*sigma)*exp(-(x-mu)^2/(2*sigma^2)));
    while 1
        %E
        for i = 1:m
            for j = 1:k
                g0(i,j) = g(i,j);
                sum = 0;
                for s = 1:k
                    sum = sum + W(s)*phi(X(i),M(s),S(s));
                end
                g(i,j) = (W(j)*phi(X(i),M(j),S(j)))/sum;
            end
        end
        %M
        M0 = M;
        for j = 1:k
            W(j) = (1/m)*sum(g(:,j));
            M(j) = (1/(m*W(j)))*sum(g(:,j).*X);
            S(j) = (1/(m*W(j)))*sum(g(:,j).*(x-M0).^2);
        end
        if max(max(abs(g-g0))) < delta
            break;
        end
    end
end