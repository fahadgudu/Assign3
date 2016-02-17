function [x, y, confidence, scale, orientation] = get_interest_points(image, feature_width)
clc;

k = 0.05;
Threshold = 0.1;
sigma = 1;

sHalf  = sqrt(-log(0.1)*2*sigma.^2);
sHalf = 2 * round(sHalf) + 1;
[xx, yy] = meshgrid(-sHalf:1:sHalf);

[derivative_x, derivative_y] = gradient((1/2*pi*sigma) * exp(-(xx .^ 2 + yy .^ 2) / (2 * sigma ^ 2)));
Gxy = (1/2*pi*sigma) * exp(-(xx .^ 2 + yy .^ 2) / (2 * sigma ^ 2));

[ numOfRows, numOfColumns, nPlane] = size(image);
Ix = conv2(derivative_x, image);
Iy = conv2(derivative_y, image);

size(Ix)

Ix2 = Ix .^ 2;
Iy2 = Iy .^ 2;
Ixy = Ix .* Iy;

Sx2 = conv2(Gxy, Ix2);
Sy2 = conv2(Gxy, Iy2);
Sxy = conv2(Gxy, Ixy);

im = zeros(numOfRows, numOfColumns);
for x=1:numOfRows,
   for y=1:numOfColumns,
       x,y
       H = [Sx2(x, y) Sxy(x, y); Sxy(x, y) Sy2(x, y)];
       R =  ((Sx2(x, y) * Sy2(x,y) - Sxy(x,y)* Sxy(x,y)) - (k * (Sx2(x,y) + Sy2(x,y)) ^ 2));
       
       if (R > Threshold)
          im(x, y) = R; 
       end
   end
end
output= im > imdilate(im, [1 1 1; 1 0 1; 1 1 1]);
figure, imshow(output);
[ROWS,COLUMNS] = ndgrid(1:size(output,1),1:size(output,2));
x = ROWS(:);
y = COLUMNS(:);

end

