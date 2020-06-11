function x = solveSystemChol(A, b)
    dA = chol(A,'lower');
    x = b/dA;
end

