clear all
clc

csvOut = {"Name", "Size", "Time", "MemoryUsage", "Error"};
path = '../matrices/';
file = "shallow_water1.mat";
    load(sprintf(strcat(path,'%s'), file));
    disp(strcat("run ", Problem.name));
    A = Problem.A;
    sizeA = size(A,1);
    xe = ones(1,sizeA);
    b = xe*A;

    profile off;
    profile clear;
    profile on;

    x = solveSystemChol(A, b);
    
    profile off;
    
    erel = norm(x-xe) / norm(xe);

    profilerInfo = profile('info');

    %t = profilerInfo.FunctionTable; %Profiler Time
            
    functionNames = {profilerInfo.FunctionTable.FunctionName};
    functionRow = find(strcmp(functionNames(:), 'solveSystemChol'));

    t = profilerInfo.FunctionTable(functionRow).TotalTime; 
    mem = "N/A";%profilerInfo.FunctionTable(functionRow).TotalMemAllocated; 

    name = Problem.name;
    res = {name, num2str(sizeA), num2str(t), num2str(mem), num2str(erel)};
    
    csvOut = [csvOut ; res];
%clearvars -except csvOut

cellToCSV(getNewFileName("outputOctaveTest", 0), csvOut);




