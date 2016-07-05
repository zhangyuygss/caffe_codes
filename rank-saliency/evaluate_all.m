clear;
cd /home/zhangyu/data/vggnet/performance_sele65/;
datadir = '/home/zhangyu/data/database/';
datasets={'ECSSD','DUT-O','bsd'};%,'MSRA10K',
salMapRootDir='/home/zhangyu/data/vggnet/select65/';
allModel={'unsupervise_iter_5000','unsupervise_iter_10000','unsupervise_iter_15000','unsupervise_iter_20000',...
        'unsupervise_iter_25000','unsupervise_iter_30000','unsupervise_iter_35000','unsupervise_iter_40000',...
        'unsupervise_iter_45000','unsupervise_iter_50000','unsupervise_iter_55000','unsupervise_iter_60000',...
        'unsupervise_iter_65000','unsupervise_iter_70000','unsupervise_iter_75000','unsupervise_iter_80000',...
		'unsupervise_iter_85000','unsupervise_iter_90000','unsupervise_iter_95000','unsupervise_iter_100000'};
ext='.jpg';
perfWrite={'AUC','AP','Pre1','TPR1','Fm'};
for datasetIdx=1:length(datasets)
    results=[];
    datasetName=datasets{datasetIdx};
    disp(datasetName);
    mkdir(datasetName);
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
    save([datasetName '/' datasetName  '_results.mat'],'results');

 %   plotFigure(datasetName,allModel,results);
    fid=fopen([datasetName '/' datasetName '_results.txt'],'w+');
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