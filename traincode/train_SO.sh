set ff=unix
#!/bin/sh
GLOG_logtostderr=1 /home/zhangyu/caffe-master/.build_release/tools/caffe.bin train -solver SO_global_vgg_solver.prototxt -weights VGG_ILSVRC_16_layers.caffemodel
