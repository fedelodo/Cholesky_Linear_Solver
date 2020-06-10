function writeCSV()
    csvOut = ["Name" "Size" "Time" "MemoryUsage" "Error"];
    path = '../matrices/';
    files = dir(strcat(path,'*.mat'));
    for i=1:length(files)
        load(sprintf(strcat(path,'%s'), files(i).name));
        disp(strcat("run ", Problem.name));
        A = Problem.A;
        sizeA = size(A,1);
        xe = ones(1,sizeA);
        b = xe*A;
        
        try
            %tic
            x = solveSystemChol(A, b);
            %toc
            f = @() solveSystemChol(A, b);
            t = timeit(f);
            erel = norm(x-xe) / norm(xe);

            name = convertCharsToStrings(Problem.name);
            res = [name sizeA t "null" erel];
        catch exception
            name = convertCharsToStrings(Problem.name);
            res = [name sizeA "outOfMem" "outOfMem" "outOfMem"];
        end
        csvOut = [csvOut; res];
    end
    clearvars -except csvOut
    writematrix(csvOut, "outputMatlab.csv", 'Delimiter', 'semi');
    
end

