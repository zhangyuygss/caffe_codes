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
	
end