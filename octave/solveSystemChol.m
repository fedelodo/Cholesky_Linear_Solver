function x = solveSystemChol(A, b)
    R = chol(A, 'lower');
    x = b / (R * R');
    %x = dA / (dA' \ b);
    %x = b / dA;
end

