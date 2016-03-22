clc;
clear all;
close all;

[d, sr] = wavread('samples/sample_1min.wav');

d = d(:, 1);
time = length(d) / sr;

%--stft
wlen = floor(sr * 0.01);
hop = floor(0.5 * wlen);
nfft = 512;
fs = sr;

d_frequency = stft(d, wlen, hop, nfft, fs);
V = abs(d_frequency);

figure; %--the result of stft
imagesc(V);

components = 20;
[W, H, err] = nmf_alg(V, components, 'alg', @nmf_kl, 'niter', 100, 'verb', 2);

figure; %--the result of NMF
subplot(1, 2, 1);imagesc(W); 
subplot(1, 2, 2);imagesc(H);

%--display every components (gaussion kernel density estimation)

figure;

for i = 1:components
    
    subplot(components, 1, i);
    plot(H(i, :));
    
end

%--smooth every components (gaussion kernel density estimation) and
%normalize them

figure;
sigma = 30;
window = 200;
S = H; 
maximums = zeros(1, components);

for i = 1:components
    
    subplot(components, 1, i);
    H(i, :) = H(i, :) .^2;
    %S(i,:) = H(i,:);
    S(i, :) = smooth(H(i, :), sigma, window);
    maximums(1, i) = max(S(i,:));
    S(i, :) = S(i, :) / maximums(1, i);
    plot(S(i, :));
    
end

%--flatten S

figure;

S = sum(S, 1);
plot(S);

%--S is the onset strength envelope

P = find_real_peaks(S);
%--find peaks which is higher than the peak previous to it

%--derivative distances

derivatives = derivative(S);
distances = distance_behind(derivatives);

beta = 3.5;

score = P - beta * distances;

[period,xcr,D,onsetenv,sgsrate] = tempo(d,sr,120,3.0,P);


%--period is the global tempo estimate;

figure;

alpha = 5;
beats = beattrack_viterbi(score, 2 * period(2), alpha);

len = length(S);
t = time/len:time/len:time;

plot(S);
xlabel('time/s');
hold on;


m = max(S);

for i = 1:length(beats)
    beattrack(beats(i)) = m;
end

plot(beattrack, '-r');

hold off;






