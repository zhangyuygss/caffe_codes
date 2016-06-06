function prepare_img
clear;
cd /home/zhangyu/data/;
database = {'bsd','MSAR10K'};
imgsiz = 224;
masksiz = 224;
imgpath_save = 'vggnet/imgs/';
maskpath_save = 'vggnet/GT';
% methods={'hflip','crop','rotate'};%crop with zoom-out
paras={{[1,-1]},{{'whole','up','down','left','right','middle'}},{[0]}};
cropFrac=0.2;
pad=1;

for i = 1:length(database)
	imgpath = strcat('database/',database(i),'/images/');
	maskpath = strcat('database/',database(i),'/GT/');
	imglist = dir(imgpath);
	masklist = dir(maskpath);
	for idx = 3:length(imglist)
		img = imread(strcat(imgpath,imglist(idx).name));
		mask = imread(strcat(maskpath,masklist(idx).name));
		img224 = imresize(img,[imgsiz,imgsiz]);
		mask224 = imresize(mask,[imgsiz,imgsiz]);
		imwrite(img224,strcat(imgpath_save,imglist(idx).name(1:end-4),'224.jpg'));
		imwrite(mask224,strcat(maskpath_save,masklist(idx).name(1:end-4),'224.jpg'));
		hflip_ornot = paras{1}{1};
		for h = 1:length(hflip_ornot)
			if hflip_ornot(h)==1
				imgstep1 = img224;
				maskstep1 = mask224;
			elseif hflip_ornot(h)==-1
				imgstep1 = img224(:,end:-1:1,:);
				maskstep1 = mask224(:,end:-1:1,:);
			end
			crop_method = paras{2}{1};
			for c = 1:length(crop_method)
				imgstep2 = imgcrop(imgstep1,crop_method)
		end
	end
end