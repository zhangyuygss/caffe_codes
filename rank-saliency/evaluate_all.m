clear;
cd /home/zhangyu/data/vggnet/performance;
datadir = '/home/zhangyu/data/database/';
datasets={'ECSSD','MSRA10K','DUT-O'};
salMapRootDir='/home/zhangyu/data/vggnet/saliencymap/';
allModel={'Iter__iter_5000','Iter__iter_10000','Iter__iter_15000','Iter__iter_20000',...
		'Iter__iter_25000','Iter__iter_30000','Iter__iter_35000','Iter__iter_40000',...
		'Iter__iter_45000','Iter__iter_50000','Iter__iter_55000','Iter__iter_60000',...
		'Iter__iter_65000','Iter__iter_70000','Iter__iter_75000','Iter__iter_80000',...
		'Iter__iter_85000','Iter__iter_90000','Iter__iter_95000','Iter__iter_100000'};
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