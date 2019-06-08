function [ROI, BW] = fingerroi(I, cropSize)

%   Finger ROI extraction and resizing
%
%   Input:
%   - I: Image
%   - cropSize: crop size in x direction one half at left one half at right
%               before ROI extraction
%
%   Output:
%   - ROI: Region of interest
%   
%   Author:
%   - Alessandro Fornasier (alessandrofo@edu.aau.at)

    [R, C] = size(I);
    
    %Crop the image
    I = I(:,(cropSize):end-(cropSize));

    %Adapting thresholding and morphological operation for ROI extraction
    T = adaptthresh(I, 0.35, 'Statistic', 'gaussian');
    BW = bwconvhull(imopen(imbinarize(I,T), strel('line', ceil(12.5*R/100), 90)));
    
    MinX = inf;
    MaxX = 0;
    MaxY = 0;

    for j = 1:R
        idx = find(BW(j,:));
        if min(idx) < MinX
            MinX = min(idx);
        end
        if max(idx) > MaxX
            MaxX = max(idx);
        end
    end

    for j = 1:C-2*cropSize
        idx = find(BW(:,j));
        if max(idx) > MaxY
            MaxY = max(idx);
        end
    end

    ROI = I(1:MaxY,MinX:MaxX);
    BW = BW(1:MaxY,MinX:MaxX);
  

end

