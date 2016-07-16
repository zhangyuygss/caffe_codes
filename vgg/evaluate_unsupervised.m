clear;
save_path = '/home/zhangyu/data/vggnet/unsupervised1_performance';
datadir = '/home/zhangyu/data/database/';
datasets={'DUT-O','bsd','ECSSD'};%'MSRA10K'
salMapRootDir='/home/zhangyu/data/vggnet/unsupervised/';
allModel={'vgg_iter_5000','vgg_iter_10000','vgg_iter_15000',...
        'vgg_iter_20000','vgg_iter_25000','vgg_iter_30000',...
        'vgg_iter_35000','vgg_iter_40000','vgg_iter_45000',...
        'vgg_iter_50000','vgg_iter_55000','vgg_iter_60000',...
        'vgg_iter_65000','vgg_iter_70000','vgg_iter_75000',...
        'vgg_iter_80000'};
ext='.jpg';
perfWrite={'AUC','AP','Pre1','TPR1','Fm'};
for datasetIdx=1:length(datasets)
    results=[];
    datasetName=datasets{datasetIdx};
    disp(datasetName);
    mkdir('/home/zhangyu/data/vggnet/unsupervised1_performance/',datasetName);
    maskPath=[datadir datasets{datasetIdx} '/GT/'];
    for modelIdx=1:length(allModel)
        modelName=allModel{modelIdx};
        disp(modelName);
        results(modelIdx).modelName=modelName;
        salMapDir=[salMapRootDir datasetName '/' modelName];
        if exist(salMapDir,'dir')==7 && length(dir(salMapDir))>10
            Performance=evaluate_SO(maskPath,salMapDir,ext);
            results(modelIdx).Performance=Performance;
        else
            results(modelIdx).Performance=[];
        end
        
    end
    save([save_path '/' datasetName '/' datasetName  '_results.mat'],'results');

 %   plotFigure(datasetName,allModel,results);
    fid=fopen([save_path '/' datasetName '/' datasetName '_results.txt'],'w+');
    for i= 1:length(perfWrite)
        for modelIdx=1:length(allModel)
            if ~isempty(results(modelIdx).Performance)
                eval(['fprintf(fid,''%.4f  '', results(modelIdx).Performance.' perfWrite{i} ');']);
            else
                fprintf(fid,'%.4f  ', 0);
            end
        end
        fprintf(fid,'\r\n');
    end
    fclose(fid);
    
end