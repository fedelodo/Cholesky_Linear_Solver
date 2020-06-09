close all;
clear all;

%fileName = 'ex15.mat';
%fileName = 'shallow_water1.mat';
%fileName = 'apache2.mat';
%fileName = 'cfd2.mat';
fileName = 'StocF-1465';

path = '../matrixes/';
load(sprintf(strcat(path,'%s'), fileName));

A = Problem.A;
tic
dA = decomposition(A,'chol','lower');
%R = chol(A);
toc

sizeA = size(A,1);
xe = ones(1,sizeA);
b = xe*A;
x = b/dA;

xe = ones(sizeA,1);
b = A*xe;

x1 = R \ (R' \ b);



clear Problem path fileName;

