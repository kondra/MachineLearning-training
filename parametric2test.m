function rate = parametric2test(mode, m)
    switch mode
        case {2}
            mu = [1 -1];
            sigma = [0.9 0.4; 0.4 0.3];
            X = mvnrnd(mu, sigma, m);
            tic
            [mu_, sigma_] = parametric2(X);
            toc
            p = @(x, y)(mvnpdf([x y], mu, sigma));
            pe = @(x, y)(mvnpdf([x y], mu_, sigma_));
            J = @(x, y)((p(x,y) - pe(x,y)));
            figure(1);
            clf;
            %ezsurf(J);
            ezcontourf(J);
            hold on;
            scatter(X(:,1), X(:,2), 'black', '.');
            [X1, X2] = meshgrid(-100:.5:100, -100:.5:100);
            J1 = @(x, y)((p(x,y) - pe(x,y)).^2);
            figure(2);
            clf;
            %ezsurf(J1);
            ezcontourf(J1);
            hold on;
            scatter(X(:,1), X(:,2), 'black', '.');
            Z=J1(X1(:),X2(:));
            rate = 1/m*sqrt(sum(Z));
        case {1}
            mu = 2;
            sigma = 0.5;
            X = normrnd(mu, sigma, m, 1);
            tic
            [mu_, sigma_] = parametric(X);
            toc
            pe = @(x)(normpdf(x,mu_,sigma_));
            p = @(x)(normpdf(x,mu,sigma));
            figure(1);
            clf;
            h = ezplot(p);
            hold on;
            set(h, 'Color', 'red');
            ezplot(pe);
            scatter(X, zeros(m, 1), '+');
            J=@(x) (pe(x)-p(x)).^2;
            rate = 1/m*sqrt(sum(J(X)));
    end
end