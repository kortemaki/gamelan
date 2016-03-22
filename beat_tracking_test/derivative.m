function [ derivatives ] = derivative( input )

[row, col] = size(input);
derivatives = zeros(1, col);

for i = 2:col
    derivatives(i) = input(i) - input(i-1);
end


end

