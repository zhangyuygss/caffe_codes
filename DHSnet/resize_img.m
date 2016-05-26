%Add images and masks for training, images are 
%converted from mask10
%images are converted into 224x224 to feed the net
%GT are converted into 28x28 56x56 112x112 224x224
clear;
cd /home/zhangyu/data/;

%training data below
imglist = dir('mask10/images/');
gtlist  = dir('mask10/GT/');
imgpath = 'DHS-data/img/';
mask28path = 'DHS-data/mask28/';
mask56path = 'DHS-data/mask56/';
mask112path = 'DHS-data/mask112/';
mask224path = 'DHS-data/mask224/';
for idx = 3:length(imglist)
	img = imread(strcat('mask10/images/', imglist(idx).name));
	img224 = imresize(img,[224,224]);
	imwrite(img224, strcat(imgpath, imglist(idx).name(1:end-4), '.png'));
end
disp(['idx_img:', num2str(idx)]);

for idx = 3:length(gtlist)
	mask = imread(strcat('mask10/GT/', gtlist(idx).name));
	mask28 = imresize(mask,[28,28]);
	mask56 = imresize(mask,[56,56]);
	mask112 = imresize(mask,[112,112]);
	mask224 = imresize(mask,[224,224]);
	imwrite(mask28, strcat(mask28path, gtlist(idx).name(1:end-4), '.png'));
	imwrite(mask56, strcat(mask56path, gtlist(idx).name(1:end-4), '.png'));
	imwrite(mask112, strcat(mask112path, gtlist(idx).name(1:end-4), '.png'));
	imwrite(mask224, strcat(mask224path, gtlist(idx).name(1:end-4), '.png'));
end
disp(['idx_gt:', num2str(idx)]);

%test data below
test_imglist = dir('bsd/images/');
test_gtlist = dir('bsd/GT/');
test_imgpath = 'DHS-data/test/img/';
test_mask28path = 'DHS-data/test/mask28/';
test_mask56path = 'DHS-data/test/mask56/';
test_mask112path = 'DHS-data/test/mask112/';
test_mask224path = 'DHS-data/test/mask224/';
for idx = 3:length(test_imglist)
	img = imread(strcat('bsd/images/', test_imglist(idx).name));
	img224 = imresize(img,[224,224]);
	imwrite(img224, strcat(test_imgpath, test_imglist(idx).name(1:end-4), '.jpg'));
end
disp(['idx_test_img:', num2str(idx)]);

for idx = 3:length(test_gtlist)
	mask = imread(strcat('bsd/GT/', test_gtlist(idx).name));
	mask28 = imresize(mask,[28,28]);
	mask56 = imresize(mask,[56,56]);
	mask112 = imresize(mask,[112,112]);
	mask224 = imresize(mask,[224,224]);
	imwrite(mask28, strcat(test_mask28path, test_gtlist(idx).name(1:end-4), '.jpg'));
	imwrite(mask56, strcat(test_mask56path, test_gtlist(idx).name(1:end-4), '.jpg'));
	imwrite(mask112, strcat(test_mask112path, test_gtlist(idx).name(1:end-4), '.jpg'));
	imwrite(mask224, strcat(test_mask224path, test_gtlist(idx).name(1:end-4), '.jpg'));
end
disp(['idx_test_gt:', num2str(idx)]);

