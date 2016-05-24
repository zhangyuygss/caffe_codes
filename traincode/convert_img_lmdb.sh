echo "Creating train rgb lmdb..."

GLOG_logtostderr=1 
/home/zhangyu/caffe-master/.build_release/tools/convert_imageset \
/home/zhangyu/data/images/ \
/home/zhangyu/data/train_image_list.txt \
/home/zhangyu/data/train_image_lmbd \
echo "Done~>_<"

