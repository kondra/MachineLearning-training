function [rate rate2] = parametric2test(mode, m, gr)
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
            if gr==1
                %figure(1);
                %clf;
                %ezsurf(J);
                %ezcontour(J);
                %hold on;
                %scatter(X(:,1), X(:,2), 'black', '+');
            end
            %[X1, X2] = meshgrid(-100:.5:100, -100:.5:100);
            J1 = @(x, y)((p(x,y) - pe(x,y)).^2);
            if gr==1
                figure(2);
                clf;
                ezsurf(J1);
                legend('l2');
                %ezcontour(J1);
                %hold on;
                %scatter(X(:,1), X(:,2), 'black', '+');
                figure(1);
                clf;
                ezsurf(pe);
                legend('estimate');
                figure(3);
                clf;
                ezsurf(p);
                legend('true');
            end
            Z=J1(X(:,1),X(:,2));
            rate = 1/m*sqrt(sum(Z));
            Z=J(X(:,1),X(:,2));
            rate2 = 1/m*(sum(abs(Z)));
        case {1}
            mu = 2;
            sigma = 0.5;
            X = normrnd(mu, sigma, m, 1);
            tic
            [mu_, sigma_] = parametric(X);
            toc
            pe = @(x)(normpdf(x,mu_,sigma_));
            p = @(x)(normpdf(x,mu,sigma));
            if gr==1
                figure(1);
                clf;
                h = ezplot(p);
                hold on;
                set(h, 'Color', 'red');
                ezplot(pe);
                scatter(X, zeros(m, 1), '+');
            end
            J=@(x) (pe(x)-p(x)).^2;
            J1=@(x) abs(pe(x)-p(x));
            rate = 1/m*sqrt(sum(J(X)));
            rate2 = 1/m*sum(J1(X));
    end
end