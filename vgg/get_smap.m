cd /home/zhangyu/data/vggnet/saliencymap/;
addpath(genpath('/usr/local/caffe-master/matlab'))
caffe.reset_all();
caffe.set_mode_gpu();
gpu_id = 1;
caffe.set_device(gpu_id);
model_dir = '/home/zhangyu/data/vggnet/snap/';
def_dir = '/home/zhangyu/codes/caffe-codes/vgg/';
phase = 'test'; % run with phase test (so that dropout isn't applied)
net_model = [def_dir 'SO_global_vgg_deploy.prototxt'];
datasets = {'bsd','DUT-O','ECSSD','MSRA10K'};

for i = 1:length(datasets)
    imgdir = strcat('/home/zhangyu/data/',datasets{i},'/images/');
    model_list = dir('../snap/*.caffemodel');
    for j = 1:length(model_list)
        mkdir(datasets{i},model_list(j).name(1:end-11));
        smdir = strcat(datasets{i},model_list(j).name(1:end-11));
        modelname = model_list(j).name;
        net_weights = ['../snap/' modelname];
        net = caffe.Net(net_model, net_weights, phase);
        disp(['Get saliency map: ' datasets{i} model_list(j).name]);
        imglist = dir([imgdir '/*.jpg']);
        for idx = 1:length(imglist)\
            img = imread(['imgdir/' imglist(idx).name]);
            im = prepare_img(img);
            sm = predict_sm(net,im,size(img,1),size(img,2));
            sm = sm>0.3;
            if ~mod(idx,100)
                disp([num2str(idx) '/' num2str(length(imglist))]);
            end
            imwrite(sm,[smdir '/' imglist(idx).name]);
        end
    end
end
caffe.reset_all();

