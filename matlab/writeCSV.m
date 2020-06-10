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
            profile clear;
            profile('-memory','on');
            setpref('profiler','showJitLines',1);
            
            x = solveSystemChol(A, b);
            %f = @() solveSystemChol(A, b);
            %t = timeit(f);
            erel = norm(x-xe) / norm(xe);
            
            profilerInfo = profile('info');
            
            functionNames = {profilerInfo.FunctionTable.FunctionName};
            functionRow = find(strcmp(functionNames(:), 'solveSystemChol'));

            t = profilerInfo.FunctionTable(functionRow).TotalTime; 
            mem = profilerInfo.FunctionTable(functionRow).TotalMemAllocated; 
            
            name = convertCharsToStrings(Problem.name);
            res = [name sizeA t mem erel];
        catch exception
            name = convertCharsToStrings(Problem.name);
            res = [name sizeA "outOfMem" "outOfMem" "outOfMem"];
        end
        csvOut = [csvOut; res];
    end
    clearvars -except csvOut
    writematrix(csvOut, "outputMatlab.csv", 'Delimiter', 'semi');
        
    profile viewer;
    
end

