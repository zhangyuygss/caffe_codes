%% para_get: get parameters of a saliency map to measure it
%% implementation of article Comparing Salient Object Detection Results without Ground Truth
function [paras] = para_get(img,saliency)
	rowsize = size(saliency,1);
	colsize = size(saliency,2);
	% saliency coverage
	cover = zeros(1,10);
	for i = 1:length(cover)
		threshold = i*0.1;
		saltmp = saliency > threshold;
		cover(i) = sum(sum(saltmp))/(rowsize*colsize);
	end

	% saliency compactness
	pval = [0.25 0.5 0.75];
	compact = zeros(1,length(pval));		
	saltmp = saliency(:);
	saltmp = sort(saltmp);
	for i = 1:length(pval)
		threshold = saltmp(round(pval(i)*rowsize*colsize));
		binaried = saliency>threshold;
		regions = regionprops(binaried,'basic');
		maxregion_area = sort([regions.Area],'descend')(1);
		maxregion_idx = find([regions.Area]==maxregion_area);
		boundingbox = regions(maxregion_idx).BoundingBox;
		salregion = saliency(floor(boundingbox(2)):floor(boundingbox(2))+boundingbox(4)-1,...
			floor(boundingbox(1)):floor(boundingbox(1))+boundingbox(3)-1);
		compact(i) = mean(salregion(:))/256;
	end

	% saliency value histogram
	salvalue = zeros(1,20);
	for i = i:length(salvalue)
		threshold = (i-1)*0.05;
		saltmp = saliency < threshold & saliency >=threshold-0.05;
		salvalue(i) = sum(sum(saltmp))/(rowsize*colsize);
	end

	% color separation
	colour = zeros(1:3);
	colorbin = 16;
	for i = 1:3
		for j = 1:colorbin
			hstmp = img(:,:,i)<=j*16 & img(:,:,i)>j*16-16;
			hstmp = hstmp.*saliency;
			hs = sum(sum(hstmp))/sum(sum(saliency));

			saliency1 = 1- saliency;
			hgtmp = img(:,:,i)<=j*16 & img(:,:,i)>j*16-16;
			hgtmp = hgtmp.*saliency1;
			hg = sum(sum(hgtmp))/sum(sum(saliency1));
			colour(i) = colour(i) + min(hs,hg); 
		end
	end
	colour = colour/colorbin;

	% segmentation quality
	


	paras = [cover compact salvalue colour];
end