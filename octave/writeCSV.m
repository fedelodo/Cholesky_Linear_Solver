function writeCSV()
    csvOut = {"Name", "Size", "Time", "MemoryUsage", "Error"};
    path = '../matrices/';
    files = dir(strcat(path,'*.mat'));
    for i=1:length(files)
        load(sprintf(strcat(path,'%s'), files(i).name));
        disp(strcat("run ", Problem.name));
        A = Problem.A;
        sizeA = size(A,1);
        xe = ones(1,sizeA);
        b = xe*A;
        
        name = Problem.name;
        
        try
            profile off;
            profile clear;
            profile on;
            
            x = solveSystemChol(A, b);
            
            profile off;
            
            erel = norm(x-xe) / norm(xe);
            
            profilerInfo = profile('info');
            
            functionNames = {profilerInfo.FunctionTable.FunctionName};
            functionRow = find(strcmp(functionNames(:), 'solveSystemChol'));

            t = profilerInfo.FunctionTable(functionRow).TotalTime; 
            mem = "N/A";%profilerInfo.FunctionTable(functionRow).TotalMemAllocated; 
            
            
            res = {name, num2str(sizeA), num2str(t), num2str(mem), num2str(erel)};
        catch exception
            disp(exception.message);
            res = {name, sizeA, "N/A", "N/A", "N/A"};
        end_try_catch
        csvOut = [csvOut ; res];
    end
    clearvars -except csvOut

    cellToCSV(getNewFileName("outputOctave", 0), csvOut);
end

