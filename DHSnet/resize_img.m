%Add images and masks for training, images are 
%converted from mask10
%images are converted into 224x224 to feed the net
%GT are converted into 28x28 56x56 128x128 224x224
clear('all');
imglist = dir('/home/zhangyu/data/mask10/images/');
gtlist = dir('/home/zhangyu/data/mask10/GT/');
imgpath = '/'
