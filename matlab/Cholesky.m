close all;
clear all;
clc;
%%

fileName = 'ex15.mat';
%fileName = 'shallow_water1.mat';
%fileName = 'apache2.mat';
%fileName = 'Flan_1565.mat';

path = '../matrices/';
load(sprintf(strcat(path,'%s'), fileName));

%% chol%{

A = Problem.A;
sizeA = size(A,1);
xe1 = ones(1,sizeA);
b1 = xe1*A;
tic
R = chol(A);
x1 = b1/R;
toc
%}

%% decomposition
A = Problem.A;
sizeA = size(A,1);
xe = ones(1,sizeA);
tic
dA = decomposition(A,'chol','lower');
b = xe*A;
x = b/dA;
toc

%% function
%profile on;
%profile('-memory','on');
%setpref('profiler','showJitLines',1);

A = Problem.A;
sizeA = size(A,1);
xe = ones(1,sizeA);
b = xe*A;

tic
x = solveSystemChol(A, b);
toc
f = @() solveSystemChol(A, b);
t = timeit(f);
erel = norm(x-xe) / norm(xe);

%%
 A = Problem.A;
    sizeA = size(A,1);
    xe = ones(1,sizeA);
    b = xe*A;

try
    x = solveSystemChol(A, b);
catch exception
   res = ["outMem" "outMem" "outMem" "outMem"];
end

%%
f = @() solveSystemChol(A, b);
t = timeit(f);
erel = norm(x-xe) / norm(xe);
out = ["Name" "Size" "Time" "Error"];
res = [name sizeA t erel];
out = [out; res];
writematrix(out, "output.csv", 'Delimiter', 'semi');

%% csv 
name = convertCharsToStrings(Problem.name);
out = ["Name" "Size" "Time" "Error"];
res = [name sizeA t erel];
out = [out; name sizeA t erel];
writematrix(out, "output.csv", 'Delimiter', 'semi');

%%
clear Problem path fileName;



