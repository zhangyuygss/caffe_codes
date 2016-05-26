clear;
cd '/home/zhangyu/data/DHS-data/';
%training list below
imgpath = 'img/';
mask28path = 'mask28/';
mask56path = 'mask56/';
mask112path = 'mask112/';
mask224path = 'mask224/';
img_txt = 'dhs_img_list.txt';
msk28txt = 'dhs_msk28_list.txt';
msk56txt = 'dhs_msk56_list.txt';
msk112txt = 'dhs_msk112_list.txt';
msk224txt = 'dhs_msk224_list.txt';

fid = fopen(img_txt, 'w+');
img_namelist = dir([imgpath '*.png']);
for k = 1:length(img_namelist)
	image_name = [img_namelist(k).name, ' ', '0',];
	fprintf(fid, '%s\r\n', image_name);
end
fclose(fid);

fid = fopen(msk28txt, 'w+');
img_namelist = dir([mask28path '*.png']);
for k = 1:length(img_namelist)
	image_name = [img_namelist(k).name, ' ', '0',];
	fprintf(fid, '%s\r\n', image_name);
end
fclose(fid);

fid = fopen(msk56txt, 'w+');
img_namelist = dir([mask56path '*.png']);
for k = 1:length(img_namelist)
	image_name = [img_namelist(k).name, ' ', '0',];
	fprintf(fid, '%s\r\n', image_name);
end
fclose(fid);

fid = fopen(msk112txt, 'w+');
img_namelist = dir([mask112path '*.png']);
for k = 1:length(img_namelist)
	image_name = [img_namelist(k).name, ' ', '0',];
	fprintf(fid, '%s\r\n', image_name);
end
fclose(fid);

fid = fopen(msk224txt, 'w+');
img_namelist = dir([mask224path '*.png']);
for k = 1:length(img_namelist)
	image_name = [img_namelist(k).name, ' ', '0',];
	fprintf(fid, '%s\r\n', image_name);
end
fclose(fid);

%test list below
test_imgpath = 'test/img/';
test_mask28path = 'test/mask28/';
test_mask56path = 'test/mask56/';
test_mask112path = 'test/mask112/';
test_mask224path = 'test/mask224/';
test_img_txt = 'test_img_list.txt';
test_msk28txt = 'test_msk28_list.txt';
test_msk56txt = 'test_msk56_list.txt';
test_msk112txt = 'test_msk112_list.txt';
test_msk224txt = 'test_msk224_list.txt';

fid = fopen(test_img_txt, 'w+');
img_namelist = dir([test_imgpath '*.jpg']);
for k = 1:length(img_namelist)
	image_name = [img_namelist(k).name, ' ', '0',];
	fprintf(fid, '%s\r\n', image_name);
end
fclose(fid);

fid = fopen(test_msk28txt, 'w+');
img_namelist = dir([test_mask28path '*.jpg']);
for k = 1:length(img_namelist)
	image_name = [img_namelist(k).name, ' ', '0',];
	fprintf(fid, '%s\r\n', image_name);
end
fclose(fid);

fid = fopen(test_msk56txt, 'w+');
img_namelist = dir([test_mask56path '*.jpg']);
for k = 1:length(img_namelist)
	image_name = [img_namelist(k).name, ' ', '0',];
	fprintf(fid, '%s\r\n', image_name);
end
fclose(fid);

fid = fopen(test_msk112txt, 'w+');
img_namelist = dir([test_mask112path '*.jpg']);
for k = 1:length(img_namelist)
	image_name = [img_namelist(k).name, ' ', '0',];
	fprintf(fid, '%s\r\n', image_name);
end
fclose(fid);

fid = fopen(test_msk224txt, 'w+');
img_namelist = dir([test_mask224path '*.jpg']);
for k = 1:length(img_namelist)
	image_name = [img_namelist(k).name, ' ', '0',];
	fprintf(fid, '%s\r\n', image_name);
end
fclose(fid);

clear;