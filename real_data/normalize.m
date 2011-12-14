function X=normalize(X)
X=bsxfun(@minus,X,min(X));
X=bsxfun(@rdivide,X,max(X));