function [ distances ] = distance( S );

[row, col] = size(S);
distances = zeros(1, col);
k=1;

%--find peaks
for i = 2:col-1
    if S(i)>=S(i-1) && S(i)>=S(i+1)
        peaks_positions(k) = i;
        k = k+1;
    end
end


[rowp, colp] = size(peaks_positions);

for i = 1:colp-1
    for j = peaks_positions(1, i):peaks_positions(1, i+1)
        distances(1, j) = min(abs(j - peaks_positions(1, i)), abs(j - peaks_positions(1, i+1)));
        distances(1, j) = distances(1, j)/ (peaks_positions(1, i+1) - peaks_positions(1, i));
    end
end


for j = 1:peaks_positions(1, 1)
    distances(1, j) = abs(j - peaks_positions(1, 1));
    distances(1, j) = distances(1, j)/ (2*(peaks_positions(1, 1) - 1));
end

for j = peaks_positions(1, colp):col
    distances(1, j) = abs(j - peaks_positions(1, colp));
    distances(1, j) = distances(1, j)/ (2*(col - peaks_positions(1, colp)));
end

end
