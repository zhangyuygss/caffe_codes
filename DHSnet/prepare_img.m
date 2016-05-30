%data augmentation
function prepare_img
clear,clc
allDataset={'BSD','DUT-O','ECSSD','MSRA10K','PASCAL1500','SED'};
%allDataset={'ECSSD'};

imgSize=224;
maskSize={28,56,112,224};

savePathRoot='../img_mask/all/';

%data agmentation methods
methods={{'hflip'},{'crop'},{'rotate'}};%crop with zoom-out
paras={{[1,-1]},{{'whole','up','down','left','right','middle'}},{[0]}};
cropFrac=[0.2];
%imgAgmNum=12;
pad=1;

for datasetIdx=1:length(allDataset)
    datasetName=allDataset{datasetIdx};
    disp(datasetName);
    
    datasetInfo=getDatasetInfo(datasetName);
    imgPath=datasetInfo.imgPath;
    maskPath=datasetInfo.maskPath;
    imgFiles=datasetInfo.imgFiles;
    %maskFiles=datasetInfo.maskFiles;
    imgNum=datasetInfo.imgNum;
    
    savePath=[savePathRoot datasetName];
    if exist(savePath,'dir')~=7
        mkdir(savePath); 
    end
    
    savePathImg=[savePath '/' 'img'];
    if exist(savePathImg,'dir')~=7
        mkdir(savePathImg); 
    end
    
    for sizeIdx=1:length(maskSize)
        savePathMask{sizeIdx}=[savePath '/' 'mask' num2str(maskSize{sizeIdx})];
        if exist(savePathMask{sizeIdx},'dir')~=7
            mkdir(savePathMask{sizeIdx}); 
        end
    end
    
    for imgIdx=1:imgNum
        %disp(imgIdx);
        imgAgmIdx=0;
        
        img=imread([imgPath '\' imgFiles(imgIdx).name]);
        img_s=imresize(im2double(img),[imgSize,imgSize]);
        [imgName,ext]=strtok(imgFiles(imgIdx).name,'.');
        mask=imread([maskPath '\' imgName '.png']);
        mask=double(mask)/255;
        for sizeIdx=1:length(maskSize)
            mask_s{sizeIdx}=imresize(mask,[maskSize{sizeIdx},maskSize{sizeIdx}]);
        end
        %imgTmp=[];
        %maskTmp=[];
        for i=1:length(methods{1})
            if strcmp(methods{1}{i},'hflip')
                thisParas1=paras{1}{i};
                for ii=1:length(thisParas1)
                    if thisParas1(ii)==1
                        imgTmp1=img_s;
                        maskTmp1=mask_s;
                    elseif thisParas1(ii)==-1
                        imgTmp1=img_s(:,end:-1:1,:);
                        for sizeIdx=1:length(maskSize)
                            maskTmp1{sizeIdx}=mask_s{sizeIdx}(:,end:-1:1,:);
                        end
                    end
                    for j=1:length(methods{2})
                        if strcmp(methods{2}{j},'crop')
                            thisParas2=paras{2}{j};
                            for jj=1:length(thisParas2)
                                for jjj=1:length(cropFrac)
                                    imgTmp2=imgCrop(imgTmp1,thisParas2{jj},cropFrac(jjj),pad,'img');
                                    for sizeIdx=1:length(maskSize)
                                        maskTmp2{sizeIdx}=imgCrop(maskTmp1{sizeIdx},thisParas2{jj},cropFrac(jjj),pad,'mask');
                                    end
                                    for k=1:length(imgTmp2)
                                        imgTmp=imgTmp2{k};
                                        imgAgmIdx=imgAgmIdx+1;
                                        saveNameImg=[datasetName '_' imgName '-' num2str(imgAgmIdx) ext];
                                        saveNameMask=[datasetName '_' imgName '-' num2str(imgAgmIdx) '.png'];
                                        imwrite(imgTmp,[savePathImg '/' saveNameImg]);
                                        for sizeIdx=1:length(maskSize)
                                            maskTmp=double(im2bw(maskTmp2{sizeIdx}{k},0.5));
                                            imwrite(maskTmp,[savePathMask{sizeIdx} '/' saveNameMask]);
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
end

function imgC=imgCrop(img,manner,cropFrac,pad,flag)
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

function imgR=imgRotate(img,ang)
%siz1=size(img,1);
%siz2=size(img,2);
imgR=imrotate(img,ang,'bilinear','crop');
end