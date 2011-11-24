function rate = testParzen(t, m, dim)
%функция тестирования метода парзеновского окна
%t-тип распределения
%m-длина выборки
%dim-размерность
switch t
    case {'norm'}
        switch dim
            case {1}
                %генерация данных
                mu_ = 0;
                sigma_ = 10;
                X = normrnd(mu_, sigma_, m, 1);
                m = size(X, 1);
                p = @(x) (normpdf(x, mu_, sigma_));
                
                %ширина окна
                hopt = 1.06*(m^(-1/5))*std(X);
                %H=0.01:0.05:3;
                H=hopt;
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
                
                %графики
                clf;
                ezplot(g, [mu_-3*sigma_, mu_+3*sigma_]);
                hold on;
                p = @(x) (normpdf(x, mu_, sigma_));
                hg=ezplot(p, [mu_-3*sigma_, mu_+3*sigma_]);
                hold on;
                scatter(X, zeros(m,1), '+');
                set(hg, 'Color', 'red');
            case {2}
                %генерация данных
                mu = [1 -1];
                sigma = [0.9 0.4; 0.4 0.3];
                X = mvnrnd(mu, sigma, m);

                %ширина окна
                h1 = 1.06*(m^(-1/5))*std(X(:,1));
                h2 = 1.06*(m^(-1/5))*std(X(:,2));
                %тестирование
                g = nonparametric(X, h1, 'g', 2, h2);
                p = @(x, y)(mvnpdf([x y], mu, sigma));
                %J = @(x, y)((p(x,y) - g(x,y)));
                %графики
                figure(1);
                clf;
                ezsurf(g);
                figure(2);
                clf;
                ezsurf(p);
                %figure(1);
                %clf;
                %ezsurf(J);
                %ezcontour(J);
                %hold on;
                %scatter(X(:,1), X(:,2), 'black', '+');
                J1 = @(x, y)((p(x,y) - g(x',y')').^2);
                figure(3);
                clf;
                ezsurf(J1);
                %ezcontour(J1);
                %hold on;
                %scatter(X(:,1), X(:,2), 'black', '+');
                Z=J1(X(:,1),X(:,2));
                rate = 1/m*sqrt(sum(Z));
        end
end
end
