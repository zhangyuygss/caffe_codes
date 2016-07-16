#!/usr/bin/env sh
# Create the lmdb inputs
echo "Creating leveldb..."
TOOLS=/home/zhangyu/caffe-master/.build_release/tools/

GLOG_logtostderr=1

$TOOLS/convert_imageset.bin	-backend="leveldb" /home/zhangyu/data/hed-sal/img/ 	/home/zhangyu/data/hed-sal/hed_img_list.txt  	 /home/zhangyu/data/hed-sal/leveldb/train_img_leveldb
$TOOLS/convert_imageset.bin   -gray=true  -backend="leveldb"  /home/zhangyu/data/hed-sal/GT/  /home/zhangyu/data/hed-sal/hed_mask_list.txt   /home/zhangyu/data/hed-sal/leveldb/train_mask_leveldb
# $TOOLS/convert_imageset.bin	-backend="leveldb" /home/zhangyu/data/vggnet/test_img/ 	/home/zhangyu/data/vggnet/vgg_img_list_test.txt  	 /home/zhangyu/data/vggnet/leveldb/test_img_leveldb
# $TOOLS/convert_imageset.bin   -gray=true  -backend="leveldb"  /home/zhangyu/data/vggnet/test_GT/  /home/zhangyu/data/vggnet/vgg_mask_list_test.txt   /home/zhangyu/data/vggnet/leveldb/test_mask_leveldb


echo "Done."