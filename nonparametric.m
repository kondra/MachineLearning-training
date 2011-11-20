function f = nonparametric(X, h, ker, dim)
    m = size(X, 1);
    switch ker
        case {'e'}
            %ядро епанечникова
            K = @(z) (3/4)*((1-z.^2)).*(abs(z)<1);
        case {'g'}
            %гауссовcкое ядро
            K = @(z) (exp((-z.^2)./2)./sqrt(2*pi));
        case {'k'}
            %квартическое ядро
            K = @(z) (15/16)*((1-z.^2).^2).*(abs(z)<1);
    end
    switch dim
        case {1}
            f = @(x) ((1/(m*h)).*sum(K((x-X)./h)));
        case {2}
            f = @(x, y) ((1/(m*h*h)).*sum(K((x-X)./h).*K((y-X)./h)));
    end
end