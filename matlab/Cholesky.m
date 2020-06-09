close all;
clear all;

fileName = 'ex15.mat';
%fileName = 'shallow_water1.mat';
%fileName = 'apache2.mat';

path = 'C:\\Users\\lisac\\OneDrive - Universita degli Studi di Milano-Bicocca\\Magistrale\\Appunti magistrale\\2° semestre\\Metodi del calcolo scientifico\\Progetti\\Progetto1\\Matrix\\';
load(sprintf(strcat(path,'%s'), fileName));

A = Problem.A;
tic
R = chol(A);
toc

R2 = decomposition(A, 'chol', 'lower');

clear Problem path fileName;

