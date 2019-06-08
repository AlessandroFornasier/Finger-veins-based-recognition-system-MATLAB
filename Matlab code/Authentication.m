%% Authentication Model Making

close all;
clear all;
clc;

tic;

N = 1;  %Person id
M = 6;  %Number of image per person
P = 3;  %Number of person in database
R = 6;  %Number of model per person

pathname = strcat('Acquisition\',int2str(N),'\');
preprocessing(pathname, M)

toc;

%% Authentication

tic;

T = 20500;
flag = 0;

minmatch = inf;

for j = 1:1:M
    %Image read
    I = imbinarize(imread(strcat(pathname,'M0',int2str(j),'.jpg')));
    %LBP calculation
    LBP = lbp(I);
    %LBP Matching with every model
    for k = 1:1:P
        if flag == 1
            break;
        end
        for r = 1:1:R
            MI = imbinarize(imread(strcat('Model\',int2str(k),'\','M0',int2str(r),'.jpg')));
            MLBP = lbp(MI);
            match = lbpmatch(LBP,MLBP);
%             if match < minmatch
%                 minmatch = match;
%             end
            if match < T
                flag = 1;
                acqI = j;
                mod = k;
                modI = r;
                break;
            end
        end
    end
end

fprintf('----------Matching result----------\n');
if flag == 1
    fprintf('-\tMatch value: %d\n',match);
    fprintf('-\tPerson ID: %d\n',N);
    fprintf('-\tAcquisition image used: %d\n',acqI);
    fprintf('-\tMatched model: %d\n',mod);
    fprintf('-\tModel image used: %d\n',modI);
    figure; imshowpair(imread(strcat(pathname,'0',int2str(acqI),'.jpg')),imread(strcat(pathname,'M0',int2str(acqI),'.jpg')),'montage');
    figure; imshowpair(imread(strcat('Model\',int2str(mod),'\','0',int2str(modI),'.jpg')),imread(strcat('Model\',int2str(mod),'\','M0',int2str(modI),'.jpg')),'montage');
else
    fprintf('-\tNo matching')
end

toc;