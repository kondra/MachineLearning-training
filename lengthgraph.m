function lengthgraph
    cnt = 100;
    x = 50:50:1000;
    r1 = zeros(1,size(x,2));
    r2 = zeros(1,size(x,2));
    k=1;
    for i=x
        ra1=0;
        ra2=0;
        for j=1:cnt
           [t1 t2] = parametric2test(1,i,0);
           ra1=ra1+t1;
           ra2=ra2+t2;
        end
        r1(1,k)=ra1/cnt;
        r2(1,k)=ra2/cnt;
        k=k+1;
    end
    %clf;
    h=plot(x,r1);
    set(h,'color','red');
    hold on;
    %plot(x,r2);
    %legend('l2','uniform');
    %hold off;
end
        