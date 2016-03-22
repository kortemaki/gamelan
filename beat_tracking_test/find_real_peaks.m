function [ P ] = find_real_peaks(S)

%--this function is to find peaks which is higher than the peak previous to
%it

[row, col] = size(S);
k = 0;

%--find peaks
for i = 2:col-1
    if S(i)>=S(i-1) && S(i)>=S(i+1)
        k = k + 1;
        peaks_positions(k) = i;
    end
end


m = 0;

for j = 2:k
    if S(peaks_positions(j)) >= S(peaks_positions(j - 1))
        m = m + 1;
        real_peaks_positions(m) = peaks_positions(j);
        R(peaks_positions(j)) = 5;
    end
end

P = S;

for k = 2: length(real_peaks_positions)
    window = round((real_peaks_positions(k) - real_peaks_positions(k - 1)) / 7);
    range = (real_peaks_positions(k) - 6 * window) : (real_peaks_positions(k) - window);
    sigma = floor(window / 2);
    win = length(range);
    P(1, range) = smooth(S(1, range), sigma, win);
end

end