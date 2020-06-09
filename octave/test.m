close all;
clear all;

load "../matrixes/apache2.mat"

A = Problem.A;
tic
R = chol(A, "lower")
toc