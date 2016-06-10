% cd /home/zhangyu/data/;

% imgpath_save = 'vggnet/test_img/';
% gtpath_save = 'vggnet/test_GT/';
% imgdir = '/home/zhangyu/data/database/ECSSD/images/';
% gtdir = '/home/zhangyu/data/database/ECSSD/GT/';

% test_imglist = dir(imgdir);
% for idx = 3:length(test_imglist)
% 	testimg = imread(strcat(imgdir,test_imglist(idx).name));
% 	img = imresize(testimg,[224,224]);
% 	imwrite(img,strcat(imgpath_save,test_imglist(idx).name));
% end

% test_gtlist = dir(gtdir);
% for idx = 3:length(test_gtlist)
% 	testgt = imread(strcat(gtdir,test_gtlist(idx).name));
% 	gtt = imresize(testgt,[56,56]);
% 	imwrite(gtt,strcat(gtpath_save,test_gtlist(idx).name));
% end


clear;
cd '/home/zhangyu/data/vggnet/';

imgpath = 'test_img/';
gtpath = 'test_GT/';
img_txt = 'vgg_img_list_test.txt';
mask_txt = 'vgg_mask_list_test.txt';

fid = fopen(img_txt, 'w+');
img_namelist = dir([imgpath '*.jpg']);
for k = 1:length(img_namelist)
	image_name = [img_namelist(k).name, ' ', '0',];
	fprintf(fid, '%s\r\n', image_name);
end
fclose(fid);

fid = fopen(mask_txt, 'w+');
img_namelist = dir([gtpath '*.png']);
for k = 1:length(img_namelist)
	image_name = [img_namelist(k).name, ' ', '0',];
	fprintf(fid, '%s\r\n', image_name);
end
fclose(fid);
