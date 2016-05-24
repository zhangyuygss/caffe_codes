imgList = dir('images/');
for idx = 3:length(imgList)
    img = imread(strcat('images/',imgList(idx).name));
    img = imresize(img,[56 56]);
    imwrite(img,strcat('mask/',imgList(idx).name(1:end-8),'.png'))
    disp(idx)
end