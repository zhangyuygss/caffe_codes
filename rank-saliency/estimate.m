clear;
saldir_1 = '/home/zhangyu/temp/unsupervised/';
saldir_2 = '/home/zhangyu/temp/supervised/';
gtdir = '/home/zhangyu/temp/bsd/GT/';
imgdir = '/home/zhangyu/temp/bsd/images/';
supervisedtxt = 'supervised.txt';
unsupervisedtxt = 'unsupervised.txt';

sallist = dir([saldir_1 '*.jpg']);
fid = fopen(unsupervisedtxt,'w+');
gtresults = zeros(length(sallist),1);
score = zeros(length(sallist),1);
unsuper_feature = zeros(length(sallist),6);
for i = 1:length(sallist)
	if ~mod(i,50)
		disp(i);
	end
	sm = imread([saldir_1 sallist(i).name]);
	img = imread([imgdir sallist(i).name]);
	GT = imread([gtdir sallist(i).name(1:end-4) '.png']);
	para1 = para_get(img,sm);
	unsuper_feature(i,:) = para1;
	tmp = auc_get(sm,GT,100);
    gtresults(i) = tmp;
	score(i) = para1(6);
	fprintf(fid, '%s: ', sallist(i).name(1:end-4));
	fprintf(fid, '%8.4f', para1);
	fprintf(fid, '%8.4f', gtresults(i));
	fprintf(fid, '\r\n');
end


sallist = dir([saldir_2 '*.jpg']);
gtresults1 = zeros(length(sallist),1);
score1 = zeros(length(sallist),1);
super_feature = zeros(length(sallist),6);
fid = fopen(supervisedtxt,'w+');
for i = 1:length(sallist)
	if ~mod(i,50)
		disp(i);
	end
	sm = imread([saldir_2 sallist(i).name]);
	img = imread([imgdir sallist(i).name]);
	GT = imread([gtdir sallist(i).name(1:end-4) '.png']);
	para2 = para_get(img,sm);
	super_feature(i,:) = para2;
	tmp = auc_get(sm,GT,100);
    gtresults(i) = tmp;
	score1(i) = para2(6);
	fprintf(fid, '%s: ', sallist(i).name(1:end-4));
	fprintf(fid, '%8.4f', para2);
	fprintf(fid, '%8.4f', gtresults(i));
	fprintf(fid, '\r\n');
end

save('original_on_bsd.mat');