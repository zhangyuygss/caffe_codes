% clear;
% maskdir = '/home/zhangyu/data/hed-sal/GT/';
% mask28dir = '/home/zhangyu/data/hed-sal/mask28/';
% mask224dir = '/home/zhangyu/data/hed-sal/mask224/';
% mask112dir = '/home/zhangyu/data/hed-sal/mask112/';

% masklist = dir([maskdir '*.jpg']);
% for i = 1:length(masklist)
% 	mask = imread(masklist(i).name);
% 	mask28 = imresize(mask,[28,28]);
% 	mask112 = imresize(mask,[112,112]);
% 	mask224 = imresize(mask,[224,224]);
% 	imwrite(mask28,[mask28dir masklist(i).name]);
% 	imwrite(mask112,[mask112dir masklist(i).name]);
% 	imwrite(mask224,[mask224dir masklist(i).name]);
% end

% %list
% clear;
% cd '/home/zhangyu/data/hed-sal/';
% %training list below
% mask28path = 'mask28/';
% mask112path = 'mask112/';
% mask224path = 'mask224/';
% msk28txt = 'dhs_msk28_list.txt';
% msk112txt = 'dhs_msk112_list.txt';
% msk224txt = 'dhs_msk224_list.txt';

% fid = fopen(msk28txt, 'w+');
% img_namelist = dir([mask28path '*.jpg']);
% for k = 1:length(img_namelist)
% 	image_name = [img_namelist(k).name, ' ', '0',];
% 	fprintf(fid, '%s\r\n', image_name);
% end
% fclose(fid);

% fid = fopen(msk112txt, 'w+');
% img_namelist = dir([mask112path '*.jpg']);
% for k = 1:length(img_namelist)
% 	image_name = [img_namelist(k).name, ' ', '0',];
% 	fprintf(fid, '%s\r\n', image_name);
% end
% fclose(fid);

% fid = fopen(msk224txt, 'w+');
% img_namelist = dir([mask224path '*.jpg']);
% for k = 1:length(img_namelist)
% 	image_name = [img_namelist(k).name, ' ', '0',];
% 	fprintf(fid, '%s\r\n', image_name);
% end
% fclose(fid);
