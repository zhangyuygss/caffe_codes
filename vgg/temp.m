cd /home/zhangyu/data/vggnet/

gtlist = dir('GT224/');
for idx=  3:length(gtlist)
	gttmp = imread(strcat('GT224/',gtlist(idx).name));
	gt2 = imresize(gttmp,[56,56]);
	imwrite(gt2,strcat('GT/',gtlist(idx).name));
end