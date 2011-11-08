function [mu_, sigma_] = parametricff(filename)
    X = load(filename, '-ascii');
    [mu_, sigma_] = parametric(X);
end