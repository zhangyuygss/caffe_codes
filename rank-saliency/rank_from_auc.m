clear;
saldir = '/home/zhangyu/data/vggnet/unsupervised/MSRA10K/SO_global_iter_5000/';
gtdir = '/home/zhangyu/data/database/MSRA10K/GT/';
imgdir = '/home/zhangyu/data/database/MSRA10K/images/';

sallist = dir([saldir '*.jpg']);
gtresults = zeros(1,length(sallist));
for i = 1:length(sallist)
	sm = imread([saldir sallist(i).name]);
	img = imread([imgdir sallist(i).name]);
	GT = imread([gtdir sallist(i).name(1:end-4) '.png']);
	gtresults(i) = auc_get(sm,GT,100);
    if ~mod(i,100)
        disp([i]);
    end
end
save('mrsa10k.mat');

sm_sorted = sort(gtresults,'descend');
for i = 1:round(length(sallist)*0.8)
	find()