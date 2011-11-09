function [M, S, W] = EM(X, k, M, S, W, delta)
    m = size(X, 1);
    g = zeros(m, k);
    g0 = zeros(m, k);
    phi = @(x,mu,sigma) (1/(sqrt(2*pi)*sigma)*exp(-(x-mu)^2/(2*sigma^2)));
    while 1
        %E
        for i = 1:m
            for j = 1:k
                g0(i,j) = g(i,j);
                msum = 0;
                for s = 1:k
                    msum = msum + W(s)*phi(X(i),M(s),S(s));
                end
                g(i,j) = (W(j)*phi(X(i),M(j),S(j)))/msum;
            end
        end
        %M
        %M0 = M;
        for j = 1:k
            W(j) = (1/m)*sum(g(:,j));
            M(j) = (1/(m*W(j)))*sum(g(:,j).*X);
            S(j) = sqrt((1/(m*W(j)))*sum(g(:,j).*(X-M(j)).^2));
        end
        if max(max(abs(g-g0))) < delta
            break;
        end
    end
end