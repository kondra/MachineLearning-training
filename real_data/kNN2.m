function y = kNN2(X, x, k,metric)
%Поиск ближайшего соседа
%X - выборка
%x - классифицируемый объект
%k - количество ближайших соседей
%metric - выбор метрики
switch metric
    case {'euclidean'}
        dist = @(x,y) sqrt(sum((x-y).^2));
    case {'cityblock'}
        dist = @(x,y) sum(abs(x-y));
    case {'chebychev'}
        dist = @(x,y) max(abs(x-y));
end
%матрица расстояний
D = dist(X(:,2:10)',repmat(x(2:10), length(X), 1)');
%сортировка
[~, I] = sort(D, 'ascend');
%выбор k ближайших и классификация
Y=X(I,1);
y = mean(Y(1:k,1))>0.5;