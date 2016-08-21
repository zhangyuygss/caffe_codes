clear;
save_path = '/home/zhangyu/data/hed-sal/performance';
datadir = '/home/zhangyu/data/database/';
datasets={'DUT-O'};%,'bsd','ECSSD','MSRA10K'
salMapRootDir='/home/zhangyu/data/hed-sal/saliency-map/';
allModel={'hed_iter_5000','hed_iter_10000','hed_iter_15000','hed_iter_20000',...
          'hed_iter_25000','hed_iter_30000','hed_iter_35000','hed_iter_40000',...
          'hed_iter_45000','hed_iter_50000'};
          ext='.jpg';
perfWrite={'AUC','AP','Pre1','TPR1','Fm'};
for datasetIdx=1:length(datasets)
    results=[];
    datasetName=datasets{datasetIdx};
    disp(datasetName);
    mkdir('/home/zhangyu/data/hed-sal/performance/',datasetName);
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


%plot performance
clear;
load('DUT-O_results.mat');
auc = zeros(1,19);
ap = auc;
f = auc;
pre = auc;
tpr = auc;
for i = 1:19
    auc(i) = results(i).Performance.AUC;
    ap(i) = results(i).Performance.AP;
    pre(i) = results(i).Performance.Pre1;
    tpr(i) = results(i).Performance.TPR1;
    f(i) = results(i).Performance.Fm;
end

load('/home/zhangyu/data/vggnet/unsupervised_performance/DUT-O/DUT-O_results.mat');
auc1 = zeros(1,9);
ap1 = auc1;
f1 = auc1;
pre1 = auc1;
tpr1 = auc1;
for i = 1:9
    auc1(i) = results(i).Performance.AUC;
    ap1(i) = results(i).Performance.AP;
    pre1(i) = results(i).Performance.Pre1;
    tpr1(i) = results(i).Performance.TPR1;
    f1(i) = results(i).Performance.Fm;
end

load('/home/zhangyu/data/vggnet/performance/DUT-O/DUT-O_results.mat');
auc2 = zeros(1,19);
ap2 = auc2;
f2 = auc2;
pre2 = auc2;
tpr2 = auc2;
for i = 1:9
    auc2(i) = results(i).Performance.AUC;
    ap2(i) = results(i).Performance.AP;
    pre2(i) = results(i).Performance.Pre1;
    tpr2(i) = results(i).Performance.TPR1;
    f2(i) = results(i).Performance.Fm;
end

i = 5000:5000:95000;
i1 = 5000:5000:45000;
plot(i,auc,'r',i,ap,'b',i,pre,'g',i,tpr,'y',i,f,'c',...
    i1,auc1,'r-',i1,ap1,'b-',i1,pre1,'g-',i1,tpr1,'y-',i1,f1,'c-',...
    i,auc2,'r*',i,ap2,'b*',i,pre2,'g*',i,tpr2,'y*',i,f2,'c*');
title('DUT-O Performance');
xlabel('Iteration');
ylabel('Performance');
legend('AUC','AP','Pre','TPR','Fmeasure','AUC1','AP1','Pre1',...
    'TPR1','Fmeasure1','AUC2','AP2','Pre2','TPR2','Fmeasure2');