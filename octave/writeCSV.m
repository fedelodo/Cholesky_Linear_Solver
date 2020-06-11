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
            profile clear;
            profile('-memory','on');
            setpref('profiler','showJitLines',1);
            
            x = solveSystemChol(A, b);
            
            erel = norm(x-xe) / norm(xe);
            
            profilerInfo = profile('info');
            
            functionNames = {profilerInfo.FunctionTable.FunctionName};
            functionRow = find(strcmp(functionNames(:), 'solveSystemChol'));

            t = profilerInfo.FunctionTable(functionRow).TotalTime; 
            mem = profilerInfo.FunctionTable(functionRow).TotalMemAllocated; 
            
            res = {name, num2str(sizeA), num2str(t), num2str(mem), num2str(erel)};
        catch exception
            res = [name sizeA "N/A" "N/A" "N/A"];
        end_try_catch
        csvOut = [csvOut ; res];
    end
    clearvars -except csvOut

    cellToCSV("outputOctaveTest.csv", csvOut);
end

