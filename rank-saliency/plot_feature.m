clear;
load('original_on_bsd.mat');
features = {'coverage','compact','regionnum','salvalue','colour'};
sorted_gt = sort(gtresults,'descend');
for idx = 1:5
	penalty = unsuper_feature(:,idx);
	resort_penal = zeros(length(penalty),1);
	for i = 1:length(sorted_gt)
		location = find(gtresults==sorted_gt(i));
		resort_penal(i) = penalty(location);
	end
	x = 1:300;
	plot(x,sorted_gt,x,resort_penal);
	title(features(idx));
    figure;
end

% coverage = unsuper_feature(:,1);
% compact = unsuper_feature(:,2);
% regionnum = unsuper_feature(:,3);
% salvalue = unsuper_feature(:,4);
% colour = unsuper_feature(:,5);

