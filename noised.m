function noised
    m=700;
    n=500;
    x=0:10:n;
    k=1;
    cnt = 100;
    rate=zeros(length(x));
    for i=x
        r = 0;
        for j=1:cnt
            dzeta=exprnd(1,i,1);
            X1=normrnd(2,1,m,1);
            X=[dzeta;X1];
            [mu,sigma]=parametric2(X);
            pe = @(x)(normpdf(x,mu,sigma));
            p = @(x)(normpdf(x,2,1));

            %clf;
            %h = ezplot(p);
            %hold on;
            %set(h, 'Color', 'red');
            %ezplot(pe);
            %scatter(X1, zeros(m, 1), '+');
            %scatter(dzeta, zeros(i, 1), 'x', 'red');
            %legend('true', 'estimate','ideal','noise');

            mm=m+i;
            J=@(x) (pe(x)-p(x)).^2;
            r = r + 1/mm*sqrt(sum(J(X)));
        end
        rate(k)=r/cnt;
        k=k+1;
    end
    plot(x,rate);
end