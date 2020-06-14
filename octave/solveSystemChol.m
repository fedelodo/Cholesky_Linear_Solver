function x = solveSystemChol(A, b)
    R = chol(A, 'lower');
    x = b / (R * R');
end

