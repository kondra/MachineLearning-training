function [W M S]=dataprocess
%функция запускает ЕМ алгоритм на реальных данных
data=load('data.txt');

%ЕМ или Парзен
[W M S ~] = EMk(data,2,0.001);
F = @(x,y) (W(1) * mvnpdf([x y], M(1,:), S(1:2,:)) + W(2)*mvnpdf([x y],M(2,:),S(3:4,:)));

%F=nonparametric(data,1,'g',2,2);

%построение графиков
figure(1);
clf;
ezsurf(F,[0 6], [35 100]);

figure(2);
clf;
ezcontourf(F,[0 6], [35 100]);

%отображение данных
%figure(3);
%clf;
%scatter(data(:,1), data(:,2), '+', 'green');
