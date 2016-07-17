%get saliency maps from trained models 
addpath(genpath('/usr/local/caffe-master/matlab'))

datasets = {'ECSSD','bsd','DUT-O'};%,,'MSRA10K'

%model loop should be outside the dataset loop, or GPU memory will be running out soon
model_list = dir('/home/zhangyu/data/hed-sal/dhs/snap/*.caffemodel');
for i = 1:length(model_list)
    caffe.reset_all();
    caffe.set_mode_gpu();
    gpu_id = 1;
    caffe.set_device(gpu_id);
    model_dir = '/home/zhangyu/data/hed-sal/dhs/snap/';
    def_dir = '/home/zhangyu/codes/caffe_codes/DHSnet/';
    phase = 'test'; % run with phase test (so that dropout isn't applied)
    net_model = [def_dir 'SO_RCL_deploy.prototxt'];
    modelname = model_list(i).name;
    net_weights = [model_dir modelname];
    net = caffe.Net(net_model, net_weights, phase);
    for j = 2:length(datasets)
        imgdir = strcat('/home/zhangyu/data/database/',datasets{j},'/images/');
        tmpdir = ['/home/zhangyu/data/hed-sal/dhs/' datasets{j}];        %mkdir 2 arguments max
        mkdir(tmpdir,model_list(i).name(1:end-11));
        smdir = strcat('/home/zhangyu/data/hed-sal/dhs/',datasets{j},'/',model_list(i).name(1:end-11));
        disp(['Get saliency map: ' datasets{j} ' ' model_list(i).name]);
        imglist = dir([imgdir '*.jpg']);
        for idx = 1:length(imglist)
            img = imread([imgdir imglist(idx).name]);
            im = prepare_img(img);
            sm = predict_sm(net,im,size(img,1),size(img,2));
            %sm = sm>0.3;
            if ~mod(idx,100)
                disp([num2str(idx) '/' num2str(length(imglist))]);
            end
            imwrite(sm,[smdir '/' imglist(idx).name]);
        end
    end
end
caffe.reset_all();