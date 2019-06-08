function preprocessing(pathname,N)

%   Preprocessing tasks
%
%   Input:
%   - filename: path of the image
%   - N: number of taken images for model making
%   
%   Author:
%   - Alessandro Fornasier (alessandrofo@edu.aau.at)

    for j = 1:N
        
        %Image read
        I = im2double(imread(strcat(pathname,'0',int2str(j),'.jpg')));

        %ROI Extraction and size reduction
        [ROI,BW] = fingerroi(I,60);

        %Image enanchement
        ROI = (ROI-min(ROI(:)))/(max(ROI(:))-min(ROI(:))).*BW;

        %Thresholding
        TROI = bwmorph(imclose(niblack(ROI, [1 29], -0.15),strel('rectangle',[3 7])),'clean');

        %Resize
        [r,c] = size(TROI);
        r = floor(10*r/100);
        c = floor(15*c/100);
        TROI = imresize(TROI(r:end-r,c:end-c), [200 50]);
        
        %Save
        imwrite(TROI,strcat('C:\Users\4l3fo\Google Drive\MyUni\Projects\Matlab\Veins\project\',pathname,'M0',int2str(j),'.jpg'),'jpg')
        
    end
    
end

