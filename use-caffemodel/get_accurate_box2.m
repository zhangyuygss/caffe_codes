function [accBoxes,accFtr,v_GT] = get_accurate_box2(PosBoxes,image_ids,v_GT,iter,image_classes)
cd('get_accurate_box\')
%
%generate fc6 features using caffe
%
addpath(genpath('H:\mcc\caffe-master\matlab'))
caffe.reset_all();
caffe.set_mode_gpu();
gpu_id = 0;
caffe.set_device(gpu_id);
%caffe.set_mode_cpu();
net_model = '../../data/deploy.prototxt';
net_weights = '../../data/finetune_voc_2007_trainval_iter_70k';
phase = 'test';
net = caffe.Net(net_model,net_weights,phase);
%
VOCPath = 'H:\zhaolong\CVPR_rebuttal\JPEGImages\';
load('../../mat/crop.mat')
%
accBoxes = cell(size(image_ids,1),1);
accFtr = cell(size(image_ids,1),1);
t=load('sizeOfImg.mat');
sizeOfImg = t.sizeOfImg;
disp('Writing tmp imgs')
doReWrite = 1;
addFtr = 1;
drawImg = 0;
smDir = 'tmpSm2';
imgDir = 'tmpImgs2';
type = '_RCC.png';
if doReWrite
    %     if exist('tmpImgs6','dir')
    %         rmdir('tmpImgs6','s')
    %     end
    %     if exist('tmpSm6','dir')
    %         rmdir('tmpSm6','s')
    %     end
    %     mkdir('tmpImgs6')
    %     mkdir('tmpSm6')
    for i = 1:size(PosBoxes,1)
        imgName = image_ids{i,1};
        img = imread(strcat(VOCPath,imgName));
        siz = sizeOfImg(i,:);
        for j = 1:size(PosBoxes{i,1},1)
            box = PosBoxes{i,1}(j,:);
            box2(1) = max(1,box(1)-round(0.08*siz(2)));
            box2(2) = max(1,box(2)-round(0.08*siz(1)));
            box2(3) = min(siz(2),box(3)+round(0.08*siz(2)));
            box2(4) = min(siz(1),box(4)+round(0.08*siz(1)));
            tmpImg = img(box2(2):box2(4),box2(1):box2(3),:);
            imwrite(tmpImg,strcat(imgDir,'\',imgName(1:6),'_',num2str(j),'.jpg'))
        end
    end
    disp('Get Saliency Map')
    system(['H:\zhaolong\IJCAI2016\RC\RC\program\Bin\AttCut.exe ',imgDir,'\*.jpg ',smDir,' 25'])
end
mkdir(strcat('origin_',num2str(iter),'\'))
mkdir(strcat('show_',num2str(iter),'\'))
for i = 1:5011
    tic
    imgName = image_ids{i,1};
    disp(['Get accurate box: ' num2str(i)])
    img = imread(strcat(VOCPath,imgName));
    for j = 1:size(PosBoxes{i,1},1)
        box2 = [];
        box3 = [];
        tmpSm = imread(strcat(smDir,'/',imgName(1:6),'_',num2str(j),type));
        tmpSm =double(tmpSm)/255;
        box = PosBoxes{i,1}(j,:);
        [box4,flag,v_GT{i,1}(j,1)] = get_new_box(tmpSm,v_GT{i,1}(j,1));
        if flag ~= 0
            siz = sizeOfImg(i,:);
            box2(1) = max(1,box(1)-round(0.08*siz(2)));
            box2(2) = max(1,box(2)-round(0.08*siz(1)));
            box2(3) = min(siz(2),box(3)+round(0.08*siz(2)));
            box2(4) = min(siz(1),box(4)+round(0.08*siz(1)));
            box3(1)=box4(1)+box2(1)-1;
            box3(2)=box4(2)+box2(2)-1;
            box3(3)=box4(3)+box2(1)-1;
            box3(4)=box4(4)+box2(2)-1;
            accBoxes{i,1} = cat(1,accBoxes{i,1},box3);
        else
            accBoxes{i,1} = cat(1,accBoxes{i,1},box);
        end
        if addFtr == 1
            tmpclass = image_classes{i,1};
            if length(tmpclass) == 1
                disp('Easy Image!!!')
                continue
            end
            bbox = accBoxes{i,1}(j,:);
            im = single(img(:,:,[3 2 1]));
            crop = rcnn_im_crop(im, bbox, crop_mode, crop_size, ...
                crop_padding, image_mean);
            ims(:,:,:,1) = permute(crop, [2 1 3]);
            output = net.forward({ims});
            ftr = permute(output{1},[2 1 3]);
            accFtr{i,1} = cat(1,accFtr{i,1},ftr);
        end
    end
    %
    if drawImg
        out = draw_boundingbox(img,[PosBoxes{i,1} ones(size(PosBoxes{i,1},1),2)]);
        imwrite(out,strcat('origin_',num2str(iter),'\',imgName))
        out = draw_boundingbox(img,[accBoxes{i,1} ones(size(accBoxes{i,1},1),2)]);
        imwrite(out,strcat('show_',num2str(iter),'\',imgName))
    end
    toc
end
caffe.reset_all();
cd('..')
function [box3,flag,v]=get_new_box(binarySm,v)
[L,num] = bwlabel(binarySm,8);
flag = 1;
if num==0
    flag = 0;
    v = 0;
    box3 = [];
    return
end
regions  = regionprops(L, 'basic');
threshold=0;
for i=1:num
    if regions(i,1).Area>threshold
        box=regions(i).BoundingBox;
        box3=[round(box(1)),round(box(2)),floor(box(1)+box(3)),floor(box(2)+box(4))];
        threshold=regions(i,1).Area;
    end
end
if threshold < 1000
    v = 0;
    flag = 0;
end