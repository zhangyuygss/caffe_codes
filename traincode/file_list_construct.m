clear;
clc;
maskpath = 'mask/';
txtpath = 'train_mask_list.txt';
fid=fopen(txtpath,'w+');
fclose(fid);
fid = fopen(txtpath,'w');
mask_name = dir([maskpath '*.png']);
for j = 1:length(mask_name)
   file_name =[ mask_name(j).name,' ', '0'];
   fprintf(fid, '%s\r\n', file_name);
end
fclose(fid);
clear;
imgpath = 'images/';
txtimagepath = 'train_image_list.txt';
fid1 = fopen(txtimagepath, 'w+');

image_name = dir([imgpath, '*.jpg']);
for j = 1:length(image_name)
    file_name = [image_name(j).name, ' ', '0'];
    fprintf(fid1, '%s\r\n', file_name);
end
fclose(fid1);