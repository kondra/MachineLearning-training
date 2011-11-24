function [iter, rate, time] = collectEMstats
%функция проводит серию экспериментов, оценивается ЕМ алгоритм
%Результат работы - таблицы количества итераций, оценки, времени

n=5;%количество экспериментов
iter=zeros(2,n);
rate=zeros(2,n);
time=zeros(2,n);
for i=1:n
    [~, ~, ~, l, r, t] = testEM(0,'e');%обычный ЕМ
    iter(1,i)=l;
    rate(1,i)=r;
    time(1,i)=t;
    
    [~, ~, ~, l, r, t] = testEM(0,'s');%стохастический
    iter(2,i)=l;
    rate(2,i)=r;
    time(2,i)=t;
end