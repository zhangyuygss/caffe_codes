%rank saliency maps from auc
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
	gtresults(i) = score_get(sm,GT,100);
    if ~mod(i,100)
        disp([i]);
    end
end
save('mrsa10k.mat');

%prepare training data,30% of current saliency maps
img_savepath = '/home/zhangyu/data/hed-sal/selected-data/images/';
mask_savepath = '/home/zhangyu/data/hed-sal/selected-data/GT/';
maxIterations=3;
load('mrsa10k.mat');
sm_sorted = sort(gtresults,'descend');
for i = 50:round(length(sallist)*0.3)
    if ~mod(i,100)
        disp([i]);
    end
	idx = find(gtresults == sm_sorted(i));
	im = imread([imgdir sallist(idx).name]);
	sm = imread([saldir sallist(idx).name]);
    sm = double(sm)/255;
    threshold = graythresh(sm);
    sm = st_segment(im,sm,threshold,maxIterations);
	imwrite(im,[img_savepath sallist(idx).name]);
	imwrite(sm,[mask_savepath sallist(idx).name]);
end