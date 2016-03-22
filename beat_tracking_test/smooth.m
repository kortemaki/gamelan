function [ output ] = smooth( input, sigma ,win)
% SMOOTH a curve;
% Use Gaussian Kernel Density Estimation

len = length(input);
output = zeros(1, len);

for i = 1: len
    range = max(1, i - win) : min(len, i + win);
    output(1, i) = sum(input(range) .* exp(-((range - i)./sigma).^2))/sum(exp(-((range - i)./sigma).^2));
end

