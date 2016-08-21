%plot performance
clear;
load('/home/zhangyu/data/hed-sal/dhs/performance/ECSSD/ECSSD_results.mat');
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

load('/home/zhangyu/data/hed-sal/dhs/performance/ECSSD/ECSSD_results.mat');
auc1 = zeros(1,19);
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

// load('/home/zhangyu/data/hed-sal/dhs/performance/ECSSD/ECSSD_results.mat');
// auc2 = zeros(1,19);
// ap2 = auc2;
// f2 = auc2;
// pre2 = auc2;
// tpr2 = auc2;
// for i = 1:9
//     auc2(i) = results(i).Performance.AUC;
//     ap2(i) = results(i).Performance.AP;
//     pre2(i) = results(i).Performance.Pre1;
//     tpr2(i) = results(i).Performance.TPR1;
//     f2(i) = results(i).Performance.Fm;
// end

i = 5000:5000:95000;
i1 = 5000:5000:45000;
plot(i,auc,'r',i,ap,'b',i,pre,'g',i,tpr,'y',i,f,'c',...
    i1,auc1,'r--',i1,ap1,'b--',i1,pre1,'g--',i1,tpr1,'y--',i1,f1,'c--',...
    i,auc2,'r*-',i,ap2,'b*-',i,pre2,'g*-',i,tpr2,'y*-',i,f2,'c*-');
title('DUT-O Performance');
xlabel('Iteration');
ylabel('Performance');
legend('AUC','AP','Pre','TPR','Fmeasure','AUC1','AP1','Pre1',...
    'TPR1','Fmeasure1','AUC2','AP2','Pre2','TPR2','Fmeasure2');
