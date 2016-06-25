clear;
saldir_1 = '/home/zhangyu/temp/unsupervised/';
saldir_2 = '/home/zhangyu/temp/supervised/';
gtdir = '/home/zhangyu/temp/bsd/GT/';
imgdir = '/home/zhangyu/temp/bsd/images/';
supervisedtxt = 'supervised.txt';
unsupervisedtxt = 'unsupervised.txt';

sallist = dir([saldir_1 '*.jpg']);
fid = fopen(unsupervisedtxt,'w+');
for i = 1:length(sallist)
	sm = imread([saldir_1 sallist(i).name]);
	img = imread([imgdir sallist(i).name]);
	GT = imread([gtdir sallist(i).name(1:end-4) '.png']);
	para = para_get(img,sm);
	gtresults = QXL_ROC(sm,GT,100);
	fprintf(fid, '%s: ', sallist(i).name(1:end-4));
	fprintf(fid, '%8.4f', para);
	fprintf(fid, '%8.4f', gtresults);
	fprintf(fid, '\r\n');
end

sallist = dir([saldir_2 '*.jpg']);
fid = fopen(supervisedtxt,'w+');
for i = 1:length(sallist)
	sm = imread([saldir_2 sallist(i).name]);
	img = imread([imgdir sallist(i).name]);
	GT = imread([gtdir sallist(i).name(1:end-4) '.png']);
	para = para_get(img,sm);
	gtresults = QXL_ROC(sm,GT,100);
	fprintf(fid, '%s: ', sallist(i).name(1:end-4));
	fprintf(fid, '%8.4f', para);
	fprintf(fid, '%8.4f', gtresults);
	fprintf(fid, '\r\n');
end