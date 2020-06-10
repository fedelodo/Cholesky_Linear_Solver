close all;
clear all;

fileName = 'ex15.mat';
%fileName = 'shallow_water1.mat';
%fileName = 'apache2.mat';

path = 'C:\\Users\\lisac\\OneDrive - Universita degli Studi di Milano-Bicocca\\Magistrale\\Appunti magistrale\\2° semestre\\Metodi del calcolo scientifico\\Progetti\\Progetto1\\Matrix\\';
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
A = Problem.A;
sizeA = size(A,1);
xe = ones(1,sizeA);
b = xe*A;

profile on;
              profile('-memory','on');
              setpref('profiler','showJitLines',1);
tic
x = solveSystemChol(A, b);
toc
f = @() solveSystemChol(A, b);
t = timeit(f)
erel = norm(x-xe) / norm(xe);

%reportLine = {'Matrix': f, 'Size': size, 'MemoryUsage': mem_usage, 'Time': fntime, 'RelativeError': erel}
%%
clear Problem path fileName;

