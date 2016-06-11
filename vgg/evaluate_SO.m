function Performance = evaluate_SO(maskPath,salMapDir,ext)
    NT=100; %有多少级灰度阈值

    sms=dir([salMapDir '/*' ext]);
    imgNum=length(sms);
    
    TPR=zeros(imgNum,NT);
    FPR=TPR;
    Pre=TPR;
    allFm=TPR;
%     AUC=zeros(imgNum,1);
%     AP=AUC;
    TPR1=zeros(imgNum,1);
    Pre1=TPR1;
    Fm=TPR1;
    
    wTPR=TPR1;
    wPre=TPR1;
    wFm=TPR1;
    
    %parfor i=1:imgNum
    for i=1:imgNum
        %disp(i/imgNum)
        sm=mat2gray(imread([salMapDir '/' sms(i).name]));
        gt=imread([maskPath  sms(i).name(1:end-4) '.png']);
        [TPR(i,:), FPR(i,:), Pre(i,:), ~, ~, allFm(i,:)] = QXL_ROC( sm, gt, NT );
        [TPR1(i,:), Pre1(i,:), Fm(i,:)] = Fmeasure( sm, gt );
        
        [wFm(i,:),wPre(i,:),wTPR(i,:),]= WFb(sm,logical(gt));
    end
    
    Performance.TPR=mean(TPR,1);
    Performance.FPR=mean(FPR,1);
    Performance.Pre=mean(Pre,1);

    Performance.AUC = -trapz([1,Performance.FPR,0], [1,Performance.TPR,0]);
    Performance.AP = -trapz([1,Performance.TPR,0], [0,Performance.Pre,1]);
    
    Performance.allFm=mean(allFm,1);

    Performance.Pre1=mean(Pre1);
    Performance.TPR1=mean(TPR1);
    Performance.Fm=mean(Fm);
    
    Performance.wPre=mean(wPre);
    Performance.wTPR=mean(wTPR);
    Performance.wFm=mean(wFm);
