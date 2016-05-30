%evaluate all methods on all datasets
clear,clc

%salMapRootDir='E:\chenhao\saliency\test_results';
salMapRootDir='G:\NianLiu\CNN_for_SO-CVPR\img_mask\results';
% allDataset={'BSD','DUT-O-test','ECSSD','MSRA10K-test','PASCAL1500','SED','PASCAL-S'};
allDataset={'DUT-O-test','ECSSD','MSRA10K-test','PASCAL-S'};

%allModel={'DHS','CPMC-GBVS','DRFI','GBMR','GS','HDCT','HS','RC','wCtr','MCDL','MDF','LEGS'};
allModel={'DeconvNetSm'};

ext='.png';
perfWrite={'AUC','AP','Pre1','TPR1','Fm'};
for datasetIdx=1:length(allDataset)
%     results=cell(length(allModel),2);
    results=[];
    datasetName=allDataset{datasetIdx};
    disp(datasetName);
    mkdir(datasetName);
    
    datasetInfo=getSODatasetInfo(datasetName);
    maskPath=datasetInfo.maskPath;
    
    for modelIdx=1:length(allModel)
        modelName=allModel{modelIdx};
        disp(modelName);
%         results{modelIdx,1}=modelName;
        results(modelIdx).modelName=modelName;
        salMapDir=[salMapRootDir '\' datasetName '\' modelName];
        if exist(salMapDir,'dir')==7 && length(dir(salMapDir))>10
            Performance=evaluate_SO(maskPath,salMapDir,ext);
%             results{modelIdx,2}=Performance;
            results(modelIdx).Performance=Performance;
        else
%             results{modelIdx,2}=[];
            results(modelIdx).Performance=[];
        end
        
    end
    save([datasetName '\' datasetName  '_results.mat'],'results');
    plotFigure(datasetName,allModel,results);
    fid=fopen([datasetName '\' datasetName '_results.txt'],'w+');
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