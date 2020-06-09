close all;
clear all;

load "../matrixes/apache2.mat"

%A = Problem.A;
%tic
%R = chol(A, "lower")
%toc

A = Problem.A;
sizeA = size(A,1);
dA = decomposition(A,'chol','lower');
xe = ones(1,size);
b = xe*A;
x = b/dA;