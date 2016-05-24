clear;
smapdir = dir(['/home/zhangyu/codes/use-caffemodel/smap/mask10/SO*']);
gtdir = '/home/zhangyu/data/mask10/GT/';
model_rate = zeros(1,9);
for i = 1:9
	total_erroe_rate =0 ;
	smdir = strcat('/home/zhangyu/codes/use-caffemodel/smap/mask10/',smapdir(i).name,'/');
	disp(['comparing model ' num2str(i) 'of 9']);
	smaplist = dir([smdir '*.png']);
	gtlist = dir([gtdir '*.png']);
	for j = 1:length(smaplist)
		im_smap = imread([smdir smaplist(j).name]);
		im_gt = imread([gtdir  gtlist(j).name]);
		% if size(im_smap,1)~=size(im_gt,1)
		% 	errornum = errornum +1;
		% end
        im_gt = logical(im_gt);
		imerror = im_smap - im_gt;
		imerror = imerror.^2;
		error_rate = sum(imerror(:))/(size(im_smap,1)*size(im_smap,2));
		total_erroe_rate = total_erroe_rate + error_rate;
	end	
	model_rate(i)  = total_erroe_rate/length(smaplist);
	disp(['model ' smapdir(i).name 'error rate:' num2str(model_rate(i))]);
end
	
