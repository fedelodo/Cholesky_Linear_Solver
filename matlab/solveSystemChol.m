function x = solveSystemChol(A, b)
    R = decomposition(A,'chol','lower');
    x = b / R;
end

