function output_image = draw_boundingbox (test_image,dets_output)
% draw the rectangle for detected objects
% Inputs:
%       test_image : the original image for test
%       dets_output : the detected results in the end
% Outputs:
%       output_image : the detected result show in the test image
% 
% 2012.09.11
% if size(dets_output,2)>4
%    dets_output(:,5)=mat2gray(dets_output(:,5));
% end

for i=1:size(dets_output,1)
    % scale = dets_output(i,5);
     class = dets_output(i,6);
    %class = 1;
    % score = dets_output(i,7);
    %%%��ͬ��ʹ�ò�ͬ��ɫ�ľ��ο��ע
    if class>10
        class=class-10;
    end
    if class==1
        test_image = box(test_image, dets_output, i, [255,0,0]);      % ��ɫ
    elseif class==2
        test_image = box(test_image, dets_output, i, [0,255,0]);      % ��ɫ
    elseif class==3
        test_image = box(test_image, dets_output, i, [0,0,255]);      % ��ɫ
    elseif class==4
        test_image = box(test_image, dets_output, i, [255,255,255]);  % ��ɫ
    elseif class==5
        test_image = box(test_image, dets_output, i, [0,255,255]);    % ӫ����
    elseif class==6
        test_image = box(test_image, dets_output, i, [128,128,128]);  % ��ɫ
    elseif class==7
        test_image = box(test_image, dets_output, i, [255,255,0]);    % ��ɫ
    elseif class==8
        test_image = box(test_image, dets_output, i, [255,0,255]);    % ��ɫ
    elseif class==9
        test_image = box(test_image, dets_output, i, [128,0,255]);    % ѩ��ɫ
    elseif class==10
        test_image = box(test_image, dets_output, i, [0,0,0]);        % ��ɫ
    else
        error('Wrong class lebal!!!');
    end
end
output_image =test_image;


end

function test_image = box(test_image, dets_output, i, color_value)
x1 = dets_output(i,1);
y1 = dets_output(i,2);
x2 = dets_output(i,3);
y2 = dets_output(i,4);


R = color_value(1);
G = color_value(2);
B = color_value(3);

% if size(dets_output,2)>4
%     R=R*dets_output(i,5);
%     G=G*dets_output(i,5);
%     B=B*dets_output(i,5);
% end
    

% ���Ƽ��Ŀ��
test_image(y1:y2,max(x1-1,1):max(x1-1,1),1)=R;
test_image(y1:y2,max(x2-1,1):max(x2-1,1),1)=R;
test_image(max(y1-1,1):max(y1-1,1),x1:x2,1)=R;
test_image(max(y2-1,1):max(y2-1,1),x1:x2,1)=R;
%%%%%%
test_image(y1:y2,max(x1-1,1):max(x1-1,1),2)=G;
test_image(y1:y2,max(x2-1,1):max(x2-1,1),2)=G;
test_image(max(y1-1,1):max(y1-1,1),x1:x2,2)=G;
test_image(max(y2-1,1):max(y2-1,1),x1:x2,2)=G;
%%%%%%
test_image(y1:y2,max(x1-1,1):max(x1-1,1),3)=B;
test_image(y1:y2,max(x2-1,1):max(x2-1,1),3)=B;
test_image(max(y1-1,1):max(y1-1,1),x1:x2,3)=B;
test_image(max(y2-1,1):max(y2-1,1),x1:x2,3)=B;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
test_image(y1:y2,x1:x1,1)=R;
test_image(y1:y2,x2:x2,1)=R;
test_image(y1:y1,x1:x2,1)=R;
test_image(y2:y2,x1:x2,1)=R;
%%%%%%
test_image(y1:y2,x1:x1,2)=G;
test_image(y1:y2,x2:x2,2)=G;
test_image(y1:y1,x1:x2,2)=G;
test_image(y2:y2,x1:x2,2)=G;
%%%%%%
test_image(y1:y2,x1:x1,3)=B;
test_image(y1:y2,x2:x2,3)=B;
test_image(y1:y1,x1:x2,3)=B;
test_image(y2:y2,x1:x2,3)=B;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
test_image(y1:y2,min(x1+1,size(test_image,2)):min(x1+1,size(test_image,2)),1)=R;
test_image(y1:y2,min(x2+1,size(test_image,2)):min(x2+1,size(test_image,2)),1)=R;
test_image(min(y1+1,size(test_image,1)):min(y1+1,size(test_image,1)),x1:x2,1)=R;
test_image(min(y2+1,size(test_image,1)):min(y2+1,size(test_image,1)),x1:x2,1)=R;
%%%%%%
test_image(y1:y2,min(x1+1,size(test_image,2)):min(x1+1,size(test_image,2)),2)=G;
test_image(y1:y2,min(x2+1,size(test_image,2)):min(x2+1,size(test_image,2)),2)=G;
test_image(min(y1+1,size(test_image,1)):min(y1+1,size(test_image,1)),x1:x2,2)=G;
test_image(min(y2+1,size(test_image,1)):min(y2+1,size(test_image,1)),x1:x2,2)=G;
%%%%%%
test_image(y1:y2,min(x1+1,size(test_image,2)):min(x1+1,size(test_image,2)),3)=B;
test_image(y1:y2,min(x2+1,size(test_image,2)):min(x2+1,size(test_image,2)),3)=B;
test_image(min(y1+1,size(test_image,1)):min(y1+1,size(test_image,1)),x1:x2,3)=B;
test_image(min(y2+1,size(test_image,1)):min(y2+1,size(test_image,1)),x1:x2,3)=B;

end