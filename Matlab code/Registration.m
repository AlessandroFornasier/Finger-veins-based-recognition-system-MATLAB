%% Registration Model Making

close all;
clear all;
clc;

tic;

N = 3;  %Number of person
M = 6;  %Number of image per person

for j = 1:N
    pathname = strcat('Model\',int2str(j),'\');
    preprocessing(pathname, M)
end

toc;