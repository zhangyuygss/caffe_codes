#!/usr/bin/env sh
# Create the lmdb inputs
echo "Creating levelbd..."
TOOLS=/home/zhangyu/caffe-master/.build_release/tools/

GLOG_logtostderr=1

$TOOLS/convert_imageset.bin	-backend="leveldb" /home/zhangyu/data/DHS-data/img/ 	/home/zhangyu/data/DHS-data/dhs_img_list.txt  	 /home/zhangyu/data/DHS-data/levelbd/train_img_levelbd
$TOOLS/convert_imageset.bin   -gray=true  -backend="leveldb"  /home/zhangyu/data/DHS-data/mask28/  /home/zhangyu/data/DHS-data/dhs_msk28_list.txt   /home/zhangyu/data/DHS-data/levelbd/train_mask28_levelbd
$TOOLS/convert_imageset.bin   -gray=true -backend="leveldb"  /home/zhangyu/data/DHS-data/mask56/  /home/zhangyu/data/DHS-data/dhs_msk56_list.txt   /home/zhangyu/data/DHS-data/levelbd/train_mask56_levelbd
$TOOLS/convert_imageset.bin   -gray=true -backend="leveldb"  /home/zhangyu/data/DHS-data/mask112/ /home/zhangyu/data/DHS-data/dhs_msk112_list.txt  /home/zhangyu/data/DHS-data/levelbd/train_mask112_levelbd
$TOOLS/convert_imageset.bin   -gray=true -backend="leveldb"  /home/zhangyu/data/DHS-data/mask224/ /home/zhangyu/data/DHS-data/dhs_msk224_list.txt  /home/zhangyu/data/DHS-data/levelbd/train_mask224_levelbd

# $TOOLS/convert_imageset.bin	-backend="leveldb"	   /home/zhangyu/data/DHS-data/test/img/ 	/home/zhangyu/data/DHS-data/test_img_list.txt  	 /home/zhangyu/data/DHS-data/levelbd/test_img_levelbd
# $TOOLS/convert_imageset.bin   -gray=true -backend="leveldb"  /home/zhangyu/data/DHS-data/test/mask28/  /home/zhangyu/data/DHS-data/test_msk28_list.txt   /home/zhangyu/data/DHS-data/levelbd/test_mask28_levelbd
# $TOOLS/convert_imageset.bin   -gray=true  -backend="leveldb" /home/zhangyu/data/DHS-data/test/mask56/  /home/zhangyu/data/DHS-data/test_msk56_list.txt   /home/zhangyu/data/DHS-data/levelbd/test_mask56_levelbd
# $TOOLS/convert_imageset.bin   -gray=true  -backend="leveldb" /home/zhangyu/data/DHS-data/test/mask112/ /home/zhangyu/data/DHS-data/test_msk112_list.txt  /home/zhangyu/data/DHS-data/levelbd/test_mask112_levelbd
# $TOOLS/convert_imageset.bin   -gray=true  -backend="leveldb" /home/zhangyu/data/DHS-data/test/mask224/ /home/zhangyu/data/DHS-data/test_msk224_list.txt  /home/zhangyu/data/DHS-data/levelbd/test_mask224_levelbd

echo "Done."