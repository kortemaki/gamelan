function [ mel,mr ] = frq2mel( frq )
% converts a vector of frequencies to mel scale
% m=ln(1+f/700)*1000/ln(1+1000/700)
persistent k
if isempty(k)
    k=1000/log(1+1000/700);
end
af=abs(frq);
mel=sign(frq).*log(1+af/700)*k;
mr=(700+af)/k;
if ~nargout
    plot(frq,mel,'-x');
    xlabel(['Frequency(' xticksi 'Hz)']);
    ylabel(['Frequency(' yticksi 'Mel)']);
end

end

