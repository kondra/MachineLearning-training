function rate = testParzen(t, m, dim)
    %clf;
    switch t
        case {'norm'}
            switch dim
                case {1}
                    mu_ = 0;
                    sigma_ = 10;
                    X = normrnd(mu_, sigma_, m, 1);
                    m = size(X, 1);
                    p = @(x) (normpdf(x, mu_, sigma_));
                    
                    hopt = 1.06*(m^(-1/5))*std(X);
                    %H=0.01:0.05:3;
                    H=hopt
                    cnt=length(H);
                    rate=zeros(cnt,1);
                    k=1;
                    for h=H
                        g = nonparametric(X, h, 'g', 1);
                        J=@(x) (p(x)-g(x)).^2;
                        rate(k) = 1/m*sqrt(sum(J(X')));
                        k=k+1;
                    end
                    %clf;
                    %plot(H,rate);
                    %hold on;
                    %plot(repmat(hopt,cnt+1,1),[0;rate],'red');
                    
                    clf;
                    ezplot(g, [mu_-3*sigma_, mu_+3*sigma_]);
                    hold on;
                    p = @(x) (normpdf(x, mu_, sigma_));
                    hg=ezplot(p, [mu_-3*sigma_, mu_+3*sigma_]);
                    hold on;
                    scatter(X, zeros(m,1), '+');
                    set(hg, 'Color', 'red');
                case {2}
                    mu = [1 -1];
                    sigma = [0.9 0.4; 0.4 0.3];
                    X = mvnrnd(mu, sigma, m);
                    h1 = 1.06*(m^(-1/5))*std(X(:,1));
                    h2 = 1.06*(m^(-1/5))*std(X(:,2));
                    g = nonparametric(X, h1, 'g', 2, h2);
                    p = @(x, y)(mvnpdf([x y], mu, sigma));
                    J = @(x, y)((p(x,y) - g(x,y)));
                    figure(3);
                    clf;
                    ezsurf(g);
                    figure(4);
                    clf;
                    ezsurf(p);
                    figure(1);
                    clf;
                    ezsurf(J);
                    %ezcontour(J);
                    %hold on;
                    %scatter(X(:,1), X(:,2), 'black', '+');
                    J1 = @(x, y)((p(x,y) - g(x',y')').^2);
                    %figure(2);
                    %clf;
                    %ezsurf(J1);
                    %ezcontour(J1);
                    %hold on;
                    %scatter(X(:,1), X(:,2), 'black', '+');
                    Z=J1(X(:,1),X(:,2));
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
            rate = 1/m*sqrt(sum(J(X')));
            set(hg, 'Color', 'red');
    end
end