# Caffe codes via training and using the model.
## Contents
+ DHSnet
+ traincode
+ use-caffemodel
+ vgg
+ rank-saliency

$$ L = \frac{1}{N} \sum_i \sum_{j\neq y_i} \left[ \max(0, f(x_i; W)_j - f(x_i; W)_{y_i} + \Delta) \right] + \lambda \sum_k\sum_l W_{k,l}^2 $$
