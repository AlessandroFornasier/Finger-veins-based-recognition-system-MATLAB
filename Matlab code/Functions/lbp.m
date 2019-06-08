function [LBPM] = lbp(I)

%   LBP Calculation
%
%   Input:
%   - I: Binary image
%
%   Output:
%   - LBPM: Matrix where each element is the 8 bit lbp code of the 3x3
%           block of the image
%
%   Author:
%   - Alessandro Fornasier (alessandrofo@edu.aau.at)

    [r,c] = size(I);
    LBPM = zeros(size(r-2,c-2));
    mask = [1 2 4;128 0 8;64 32 16];
    
    for j = 2:r-1
        for k = 2:c-1
            temp = I(j-1:j+1,k-1:k+1);
            temp = mask.*temp;
            LBPM(j-1,k-1) = sum(temp(:));
        end
    end

end

