function y = quickSortFileSize(x)
    n=length(x);

    if n<2
        y = x;
        return;
    end

    x1 = [];
    x2 = [];

    for i = 1:n-1
        fileSizei = x(i).bytes;
        fileSizen = x(n).bytes;
        
        if fileSizei<fileSizen
            x1 = [x1 x(i)];
        else
            x2 = [x2 x(i)];
        end
    end

    y = [quickSortFileSize(x1) x(n) quickSortFileSize(x2)];

end