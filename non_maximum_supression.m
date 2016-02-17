function [ suppressed_image ] = non_maximum_suppression( magnitude_image, angle_image)
    [ rows, columns ] = size(magnitude_image);
    suppressed_image = zeros(rows, columns);
    for i = 2  : rows - 1
        for j = 2 : columns - 1  
            if (angle_image(i, j) == 0)
                    if (magnitude_image(i, j) < magnitude_image(i - 1, j ) || magnitude_image(i, j) < magnitude_image(i + 1, j))
                        magnitude_image(i, j) = 0;
                    end
            end
            if (angle_image(i, j) == 1)
                if (magnitude_image(i, j) < magnitude_image(i - 1, j - 1) || magnitude_image(i, j) < magnitude_image(i + 1, j + 1))
                    magnitude_image(i, j) = 0;
                end
            end
            if (angle_image(i, j) == 2)
                if (magnitude_image(i, j) < magnitude_image(i, j - 1) || magnitude_image(i, j) < magnitude_image(i + 1 , j - 1))
                    magnitude_image(i, j) = 0;
                end
            end
            if (angle_image(i, j) == 3)
                if (magnitude_image(i, j) < magnitude_image(i - 1, j + 1) || magnitude_image(i, j) < magnitude_image(i + 1, j - 1))
                    magnitude_image(i, j) = 0;
                end
            end
        end
    end
    suppressed_image = magnitude_image;

end

