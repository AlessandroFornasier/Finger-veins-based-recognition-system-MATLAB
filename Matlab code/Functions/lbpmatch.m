function [match] = lbpmatch(I1,I2)

%   LBP Calculation
%
%   Input:
%   - I1,I2: Binary image
%
%   Output:
%   - match: Binary value, 1 if 2 image matches 0 otherwise
%
%   Author:
%   - Alessandro Fornasier (alessandrofo@edu.aau.at)

    if size(I1) == size(I2)
        [r,c] = size(I1);
        match = zeros(r,c);
        for j = 1:1:r
            for k = 1:1:c
                match(j,k) = sum(xor(de2bi(I1(j,k),8,'left-msb')',de2bi(I2(j,k),8,'left-msb')') == 1);
            end
        end
        match = sum(match(:));
    end
end

