echo "Creating train lmdb..."
GLOG_logtostderr=1
/home/zhangyu/caffe-master/.build_release/tools/convert_imageset \
--gray \
/home/zhangyu/data/mask/ \
/home/zhangyu/data/train_mask_list.txt \
/home/zhangyu/data/train_mask_lmbd \
echo "Done!^_^"






