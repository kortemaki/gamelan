function beats = beattrack_viterbi( localscore, period, alpha )
% <localscore> is the onset strength envelope
% <period> is the target tempo period 
% <alpha> is weight applied to transition cost

backlink = -ones(1,length(localscore));
cumscore = localscore;

prange = round(-2 * period):-round(period/2);
txcost = (-alpha * abs((log(prange/-period)).^2));

for i = max(-prange + 1):length(localscore)
    timerange = i+prange;
    scorecands = txcost + cumscore(timerange);
    [vv,xx] = max(scorecands);
    % Add on local score
    cumscore(i) = vv + localscore(i);
    % Store backtrace
    backlink(i) = timerange(xx);
end

% Start backtrace from best cumulated score
[vv,beats] = max(cumscore);
% .. then find all its predecessors
while backlink(beats(1)) > 0
    beats = [backlink(beats(1)),beats];
end

plot(cumscore);

end

