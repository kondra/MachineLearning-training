function parzenff(filename)
    X = load(filename, '-ascii');
    nonparametric(X, 2);
end