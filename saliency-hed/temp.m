clear;
imgdir = '/home/zhangyu/data/hed-sal/selected-data/images/';
gtdir = '/home/zhangyu/data/vggnet/unsupervised/MSRA10K/SO_global_iter_5000/';
gtsavepath = '/home/zhangyu/data/hed-sal/selected-data/mask224/';
imglist = dir([imgdir '*.jpg']);
for i = i:length(imglist)
	im = imread([gtdir imglist(i).name]);
	im = imresize(im,[224,224]);
	imwrite(im,[gtsavepath imglist(i).name]);
end
