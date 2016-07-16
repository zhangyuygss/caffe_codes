#!/usr/bin/env sh
# Create the lmdb inputs
echo "Creating leveldb..."
TOOLS=/home/zhangyu/caffe-master/.build_release/tools/

GLOG_logtostderr=1

# $TOOLS/convert_imageset.bin	-backend="leveldb" /home/zhangyu/data/DHS-data/img/ 	/home/zhangyu/data/DHS-data/dhs_img_list.txt  	 /home/zhangyu/data/DHS-data/leveldb/train_img_leveldb
$TOOLS/convert_imageset.bin   -gray=true  -backend="leveldb"  /home/zhangyu/data/hed-sal/mask28/  /home/zhangyu/data/hed-sal/dhs_msk28_list.txt   /home/zhangyu/data/hed-sal/leveldb/train_mask28_leveldb
# $TOOLS/convert_imageset.bin   -gray=true -backend="leveldb"  /home/zhangyu/data/DHS-data/mask56/  /home/zhangyu/data/DHS-data/dhs_msk56_list.txt   /home/zhangyu/data/DHS-data/leveldb/train_mask56_leveldb
$TOOLS/convert_imageset.bin   -gray=true -backend="leveldb"  /home/zhangyu/data/hed-sal/mask112/ /home/zhangyu/data/hed-sal/dhs_msk112_list.txt  /home/zhangyu/data/hed-sal/leveldb/train_mask112_leveldb
$TOOLS/convert_imageset.bin   -gray=true -backend="leveldb"  /home/zhangyu/data/hed-sal/mask224/ /home/zhangyu/data/hed-sal/dhs_msk224_list.txt  /home/zhangyu/data/hed-sal/leveldb/train_mask224_leveldb

# $TOOLS/convert_imageset.bin	-backend="leveldb"	   /home/zhangyu/data/DHS-data/test/img/ 	/home/zhangyu/data/DHS-data/test_img_list.txt  	 /home/zhangyu/data/DHS-data/leveldb/test_img_leveldb
# $TOOLS/convert_imageset.bin   -gray=true -backend="leveldb"  /home/zhangyu/data/DHS-data/test/mask28/  /home/zhangyu/data/DHS-data/test_msk28_list.txt   /home/zhangyu/data/DHS-data/leveldb/test_mask28_leveldb
# $TOOLS/convert_imageset.bin   -gray=true  -backend="leveldb" /home/zhangyu/data/DHS-data/test/mask56/  /home/zhangyu/data/DHS-data/test_msk56_list.txt   /home/zhangyu/data/DHS-data/leveldb/test_mask56_leveldb
# $TOOLS/convert_imageset.bin   -gray=true  -backend="leveldb" /home/zhangyu/data/DHS-data/test/mask112/ /home/zhangyu/data/DHS-data/test_msk112_list.txt  /home/zhangyu/data/DHS-data/leveldb/test_mask112_leveldb
# $TOOLS/convert_imageset.bin   -gray=true  -backend="leveldb" /home/zhangyu/data/DHS-data/test/mask224/ /home/zhangyu/data/DHS-data/test_msk224_list.txt  /home/zhangyu/data/DHS-data/leveldb/test_mask224_leveldb

echo "Done."