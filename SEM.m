function [M, S, W] = SEM(X, k, M, S, W, delta)
    m = size(X, 1);
    g = zeros(m, k);
    y = zeros(m, k);
    count = 0;
    %phi = @(x,mu,sigma) (1/(sqrt(2*pi)*sigma)*exp(-(x-mu)^2/(2*sigma^2)));
    while 1
        count = count+1;
        %E
        g0 = g;
        for i = 1:m
            for j = 1:k
                g(i,j) = (W(j)*normpdf(X(i),M(j),S(j)))/sum(W.*normpdf(X(i), M, S));
            end
        end
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
        %=mnrnd(1,g);
        %X1=repmat(X,1,k);
        %K=X1(logical(y))';
        %num=sum(K)';
        %M
        %M0 = M;
        W = (1/m).*sum(g);
        %M = (1./(m*W)).*sum(g.*X);
        %S = sqrt((1./(m*W))).*sum(g.*(X-M).^2);
        for j = 1:k
            %num(j)
            %K(j,~isnan(K(j,:)))
            M(j) = (1/num(j))*sum(K(j,~isnan(K(j,:))));
            S(j) = sqrt((1/num(j))*sum((K(j,~isnan(K(j,:)))-M(j)).^2));
        end
        if max(max(abs(g-g0))) < delta
            break;
        end
    end
    count
end
