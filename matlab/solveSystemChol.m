function x = solveSystemChol(A, b)
    dA = decomposition(A,'chol','lower');
    x = b/dA;
end

