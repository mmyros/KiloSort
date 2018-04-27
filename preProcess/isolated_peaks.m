function [row, col, mu] = isolated_peaks(S1, loc_range, long_range, Th)
% loc_range = [3  1];
% long_range = [30  6];
thr_noise= 11;
smin = my_min(S1, loc_range, [1 2]);
peaks = single( S1<smin+1e-3 & S1<Th ...
              & S1<thr_noise);
sum_peaks = my_sum(peaks, long_range, [1 2]);
peaks = peaks .* (sum_peaks<1.2).* S1;

peaks([1:20 end-40:end], :) = 0;

[row, col, mu] = find(peaks);
% if ~isempty(row)
%     disp(prctile(S1(:), .01))   
%     subplot(2,1,1)
%     hist(S1(:),100);
%     subplot(2,1,2)
%     semilogy(-20:.1:0,histc(S1(:),-20:.1:0));drawnow
% end