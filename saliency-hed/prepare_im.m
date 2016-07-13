function prepare_im
clear;
cd /home/zhangyu/data/;
database = {'bsd','MSRA10K'};
imgsiz = 224;
masksiz = 56;
imgpath_save = 'hed-sal/img/';
maskpath_save = 'hed-sal/GT/';
% methods={'hflip','crop','rotate'};%crop with zoom-out
paras={{[1,-1]},{{'whole','up','down','left','right','middle'}},{[0]}};
cropFrac=0.2;
pad=1;
imgnum =0;

for i = 1:length(database)
	imgpath = strcat('database/',database{i},'/images/');
	maskpath = strcat('database/',database{i},'/GT/');
	imglist = dir(imgpath);
	masklist = dir(maskpath);
	for idx = 3:length(imglist)
		img = imread(strcat(imgpath,imglist(idx).name));
		mask = imread(strcat(maskpath,masklist(idx).name));
		img224 = imresize(img,[imgsiz,imgsiz]);
		mask56 = imresize(mask,[masksiz,masksiz]);
		imwrite(img224,strcat(imgpath_save,imglist(idx).name(1:end-4),'224.jpg'));
		imwrite(mask56,strcat(maskpath_save,masklist(idx).name(1:end-4),'224.jpg'));
		hflip_ornot = paras{1}{1};
		for h = 1:length(hflip_ornot)
			if hflip_ornot(h)==1
				imgstep1 = img224;
				maskstep1 = mask56;
			elseif hflip_ornot(h)==-1
				imgstep1 = img224(:,end:-1:1,:);
				maskstep1 = mask56(:,end:-1:1,:);
			end
			crop_method = paras{2}{1};
			for c = 1:length(crop_method)
				imgstep2 = imgcrop(imgstep1,crop_method{c},cropFrac,pad,'img');
				maskstep2 = imgcrop(maskstep1,crop_method{c},cropFrac,pad,'mask');
				for t = 1:length(imgstep2)
					imgtmp = imgstep2{t};
					imgnum = imgnum +1;
					masktmp = maskstep2{t};
					imwrite(imgtmp,strcat(imgpath_save,database{i},'_',imglist(idx).name(1:end-4),'_',num2str(imgnum),'.jpg'));
					imwrite(masktmp,strcat(maskpath_save,database{i},'_',masklist(idx).name(1:end-4),'_',num2str(imgnum),'.jpg'));
				end
			end
		end
	end
end
end

function imgC=imgcrop(img,manner,cropFrac,pad,flag)
siz1=size(img,1);
siz2=size(img,2);
switch flag
    case 'img'
        padPixel(1,1,:) = [123.68, 116.779, 103.939]./255;
    case 'mask'
        padPixel=0;
end
padImg=repmat(padPixel,[siz1,siz1,1]);

switch manner
    case 'whole'
        idx1=round(0.5*cropFrac*siz1):round((1-0.5*cropFrac)*siz1);
        idx2=round(0.5*cropFrac*siz2):round((1-0.5*cropFrac)*siz2);
    case 'up'
        idx1=1:round((1-cropFrac)*siz1);
        idx2=1:siz2;
    case 'down'
        idx1=round(cropFrac*siz1):siz1;
        idx2=1:siz2;
    case 'left'
        idx2=1:round((1-cropFrac)*siz2);
        idx1=1:siz1;
    case 'right'
        idx2=round(cropFrac*siz2):siz2;
        idx1=1:siz1;
    case 'middle'
        idx1=round(0.5*cropFrac*siz1):round((1-0.5*cropFrac)*siz1);
        idx2=round(0.5*cropFrac*siz2):round((1-0.5*cropFrac)*siz2);
    otherwise
        disp('Invalid crop manner!');
        return
end
switch manner
    case 'whole'
        imgC{1}=img;
    otherwise
        imgC{1}=imresize(img(idx1,idx2,:),[siz1,siz2]);
end
if pad
    switch manner
        case 'whole'
            padImg(idx1,idx2,:)=imresize(img,[numel(idx1),numel(idx1)]);
        otherwise
            padImg(idx1,idx2,:)=img(idx1,idx2,:);
    end
    imgC{2}=padImg;
end
end