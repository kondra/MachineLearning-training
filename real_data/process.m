function [y AUC]=process(X1,X2,k)
    Y=kNN(X2(:,2:10),X1(:,2:10),k);
    [m ~] = size(X2);
    y = zeros(m, 1);
    for i = 1:m
        y(i,1)=round(sum(X1(Y(i,:),1))/k);
    end
    [X11 Y11 T11 AUC] = perfcurve(X2(:,1),y,1);
    clf;
    plot(X11,Y11);
    %Y=zeros(length(X2),1);
    %for i = 1:length(X2)
    %Y(i,1)=kNN2(X1,X2(i,:),k,s);    
    %   if mod(i,1000)==0
    %      i
    %   end
    %end
end