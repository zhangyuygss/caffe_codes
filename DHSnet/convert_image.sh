#!/usr/bin/env sh
# Create the lmdb inputs

TOOLS=/home/nianliu/Deeplearning_codes/caffe/caffe-master/.build_release/tools
	
GLOG_logtostderr=1
	
$TOOLS/convert_imageset     ../all/ train_img_list.txt  SO_train_img_lmdb
$TOOLS/convert_imageset   -gray=true   ../all/ train_mask28_list.txt  SO_train_mask28_lmdb
$TOOLS/convert_imageset   -gray=true   ../all/ train_mask56_list.txt  SO_train_mask56_lmdb
$TOOLS/convert_imageset   -gray=true   ../all/ train_mask112_list.txt  SO_train_mask112_lmdb
$TOOLS/convert_imageset   -gray=true   ../all/ train_mask224_list.txt  SO_train_mask224_lmdb

$TOOLS/convert_imageset     ../all/ vld_img_list.txt  SO_vld_img_lmdb
$TOOLS/convert_imageset   -gray=true   ../all/ vld_mask28_list.txt  SO_vld_mask28_lmdb
$TOOLS/convert_imageset   -gray=true   ../all/ vld_mask56_list.txt  SO_vld_mask56_lmdb
$TOOLS/convert_imageset   -gray=true   ../all/ vld_mask112_list.txt  SO_vld_mask112_lmdb
$TOOLS/convert_imageset   -gray=true   ../all/ vld_mask224_list.txt  SO_vld_mask224_lmdb

echo "Done."
