function f = nonparametric(X, h, ker, dim, h2)
    m = size(X, 1);
    switch ker
        case {'e'}
            %ядро епанечникова
            K = @(z) (3/4)*((1-z.^2)).*(abs(z)<=1);
        case {'g'}
            %гауссовcкое ядро
            K = @(z) (exp((-z.^2)./2)./sqrt(2*pi));
        case {'k'}
            %квартическое ядро
            K = @(z) (15/16)*((1-z.^2).^2).*(abs(z)<=1);
        case {'t'}
            %треугольное
            K = @(z) (1-abs(z)).*(abs(z)<=1);
        case {'p'}
            %прямоугольное
            K = @(z) 1/z*(abs(z)<=1);
    end
    switch dim
        case {1}
            f=@(x) ((1/(m*h)).*sum(K((repmat(X,1,size(x',1))-repmat(x,size(X,1),1))./h)));
        case {2}
            f=@(x,y) ((1/(m*h*h2)).*sum(K((repmat(X(:,1),1,size(x',1))-repmat(x,size(X(:,1),1),1))./h).*K((repmat(X(:,2),1,size(y',1))-repmat(y,size(X(:,2),1),1))./h2)));
    end
end