function rate = testParzen(t, m, dim)
    clf;
    switch t
        case {'norm'}
            switch dim
                case {1}
                    mu_ = 0;
                    sigma_ = 1.5;
                    X = normrnd(mu_, sigma_, m, 1);
                    m = size(X, 1);
                    h = 1.06*(m^(-1/5))*std(X);
                    g = nonparametric(X, h, 'g', 1);
                    clf;
                    ezplot(g, [mu_-3*sigma_, mu_+3*sigma_]);
                    hold on;
                    p = @(x) (normpdf(x, mu_, sigma_));
                    hg=ezplot(p, [mu_-3*sigma_, mu_+3*sigma_]);
                    hold on;
                    scatter(X, zeros(m,1), '+');
                    J=@(x) (p(x)-g(x)).^2;
                    rate = 1/m*sqrt(sum(J(X)));
                case {2}
                    mu = [1 -1];
                    sigma = [0.9 0.4; 0.4 0.3];
                    X = mvnrnd(mu, sigma, m);
                    h = 0.3;
                    g = nonparametric(X, h, 'g', 2);
                    p = @(x, y)(mvnpdf([x y], mu, sigma));
                    J = @(x, y)((p(x,y) - g(x,y)));
                    figure(1);
                    clf;
                    ezsurf(J);
                    ezcontourf(J);
                    hold on;
                    scatter(X(:,1), X(:,2), 'black', '.');
                    [X1, X2] = meshgrid(-100:.5:100, -100:.5:100);
                    J1 = @(x, y)((p(x,y) - g(x,y)).^2);
                    figure(2);
                    clf;
                    %ezsurf(J1);
                    ezcontourf(J1);
                    hold on;
                    scatter(X(:,1), X(:,2), 'black', '.');
                    Z=J1(X1(:),X2(:));
                    rate = 1/m*sqrt(sum(Z));
            end
        case {'exp'}
            mu = 1;
            h = 0.3;
            X = exprnd(mu, m, 1);
            g = nonparametric(X, h, 'e', 1);
            clf;
            ezplot(g, [-10, 10]);
            hold on;
            p = @(x)(exppdf(x, mu));
            hg=ezplot(p, [0, 5]);
            hold on;
            scatter(X, zeros(m,1), '+');
            J=@(x) (p(x)-g(x)).^2;
            rate = 1/m*sqrt(sum(J(X)));
    end
    set(hg, 'Color', 'red');
end