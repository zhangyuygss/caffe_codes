%% para_get: get parameters of a saliency map to measure it
%% implementation of article Comparing Salient Object Detection Results without Ground Truth
function [paras] = para_get(img,saliency)
	rowsize = size(saliency,1);
	colsize = size(saliency,2);
	% saliency coverage
	cover = zeros(1,10);
	for i = 1:length(cover)
		threshold = i*0.1*256;
		saltmp = saliency > threshold;
		cover(i) = sum(sum(saltmp))/(rowsize*colsize);
	end
	%penalty
	penalty = 0;
	if (cover(3)<0.07)
		penalty = 0.07-cover(3);
	elseif (cover(3)>0.32)
		penalty = cover(3)-0.32;
	end

	% saliency compactness
	pval = [0.25 0.5 0.75];
	compact = zeros(1,length(pval));
	region_num = zeros(1,length(pval));
	saltmp = saliency(:);
	saltmp = unique(sort(saltmp));
	for i = 1:length(pval)
		threshold = saltmp(round(pval(i)*length(saltmp)));
		binaried = saliency>threshold;
		regions = regionprops(binaried,'basic');
		region_num(i) = length(regions);
		tmp = sort([regions.Area],'descend');
		maxregion_area = tmp(1);
		maxregion_idx = find([regions.Area]==maxregion_area);
		boundingbox = regions(maxregion_idx).BoundingBox;
		salregion = saliency(round(boundingbox(2))+1:round(boundingbox(2))+boundingbox(4)-1,...
			round(boundingbox(1))+1:round(boundingbox(1))+boundingbox(3)-1);
		compact(i) = mean(salregion(:))/256;
	end
	%compact penalty
	com_penalty = 0;
	if (compact(3)<0.7)
		com_penalty = 0.7- compact(3);
	end
	%regions penalty
	region_penalty = sum(region_num)/30;

	% saliency value histogram
	salvalue = zeros(1,20);
	for i = 1:length(salvalue)
		threshold = (i)*0.05*256;
		saltmp = saliency < threshold & saliency >=threshold-0.05*256;
		salvalue(i) = sum(sum(saltmp))/(rowsize*colsize);
	end
	peakvals = salvalue(1)+salvalue(2)+salvalue(19)+salvalue(20)+salvalue(18)+...
				salvalue(17)+salvalue(3);
	value_penalty = 1 - peakvals;

	% color separation
	colour = zeros(1,3);
	colorbin = 16;
	for i = 1:3
		for j = 1:colorbin
			hstmp = img(:,:,i)<=j*16 & img(:,:,i)>j*16-16;
			hstmp = uint8(hstmp);
			hstmp = hstmp.*saliency;
			hs = sum(sum(hstmp))/sum(sum(saliency));

			saliency1 = 256- saliency;
			hgtmp = img(:,:,i)<=j*16 & img(:,:,i)>j*16-16;
            hgtmp = uint8(hgtmp);
			hgtmp = hgtmp.*saliency1;
			hg = sum(sum(hgtmp))/sum(sum(saliency1));
			colour(i) = colour(i) + min(hs,hg); 
		end
	end
	colour = colour/colorbin;
	colour_penalty = sum(colour);

	% segmentation quality

	
	sorce = 5- penalty- com_penalty- region_penalty- value_penalty- colour_penalty;

   
	paras = [penalty com_penalty region_penalty value_penalty colour_penalty sorce];
end