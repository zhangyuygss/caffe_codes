#!/usr/bin/env sh
# Create the lmdb inputs
echo "Creating leveldb..."
TOOLS=/home/zhangyu/caffe-master/.build_release/tools/

GLOG_logtostderr=1

$TOOLS/convert_imageset.bin	-backend="leveldb" /home/zhangyu/data/vggnet/img/ 	/home/zhangyu/data/vggnet/vgg_img_list.txt  	 /home/zhangyu/data/vggnet/leveldb/train_img_leveldb
$TOOLS/convert_imageset.bin   -gray=true  -backend="leveldb"  /home/zhangyu/data/vggnet/GT/  /home/zhangyu/data/vggnet/vgg_mask_list.txt   /home/zhangyu/data/vggnet/leveldb/train_mask_leveldb


echo "Done."