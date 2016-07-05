%get saliency maps from trained models 
addpath(genpath('/usr/local/caffe-master/matlab'))
caffe.reset_all();
caffe.set_mode_gpu();
gpu_id = 1;
caffe.set_device(gpu_id);
model_dir = '/home/zhangyu/data/vggnet/snap/select65/unsupervise/';
def_dir = '/home/zhangyu/codes/caffe_codes/vgg/';
phase = 'test'; % run with phase test (so that dropout isn't applied)
net_model = [def_dir 'SO_global_vgg_deploy.prototxt'];
datasets = {'bsd','DUT-O','ECSSD'};%,'MSRA10K'

%model loop should be outside the dataset loop, or GPU memory will be running out very soon
model_list = dir([model_dir '*.caffemodel']);
for i = 1:length(model_list)
    modelname = model_list(i).name;
    net_weights = [model_dir modelname];
    net = caffe.Net(net_model, net_weights, phase);
    for j = 1:length(datasets)
        imgdir = strcat('/home/zhangyu/data/database/',datasets{j},'/images/');
        tmpdir = ['/home/zhangyu/data/vggnet/select65/' datasets{j}];        %mkdir 2 arguments max
        mkdir(tmpdir,model_list(i).name(1:end-11));
        smdir = strcat('/home/zhangyu/data/vggnet/select65/',datasets{j},'/',model_list(i).name(1:end-11));
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