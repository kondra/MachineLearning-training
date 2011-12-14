function AUC=testkNN(X1,X2,mk)
%вычисляет значение AUC для kNN классификатора
%X1-обучение
%X2-контроль
%mk-число ближайших соседей
AUC=zeros(mk,1);
for k=3:mk
    [~, A, ~]=newproc(X1,X2,k,0);
    AUC(k,1)=A;
end