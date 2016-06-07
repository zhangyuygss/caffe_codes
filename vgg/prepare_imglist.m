clear;
cd '/home/zhangyu/data/vggnet/';

imgpath = 'img/';
gtpath = 'GT/';
img_txt = 'vgg_img_list.txt';
mask_txt = 'vgg_mask_list.txt';

fid = fopen(img_txt, 'w+');
img_namelist = dir([imgpath '*.jpg']);
for k = 1:length(img_namelist)
	image_name = [img_namelist(k).name, '', '0',];
	fprintf(fid, '%s\r\n', image_name);
end
fclose(fid);

fid = fopen(mask_txt, 'w+');
img_namelist = dir([gtpath '*.jpg']);
for k = 1:length(img_namelist)
	image_name = [img_namelist(k).name, ' ', '0',];
	fprintf(fid, '%s\r\n', image_name);
end
fclose(fid);
