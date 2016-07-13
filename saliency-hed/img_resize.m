function new = img_resize(old,newsize)

if isscalar(newsize)
	newsize = [ newsize newsize ];
end

% TODO using only nearest, could be bad for high frequency masks

[h w c] = size(old);

y = round(linspace(1,h,newsize(1)));
x = round(linspace(1,w,newsize(2)));

new = old(y,x,:);
