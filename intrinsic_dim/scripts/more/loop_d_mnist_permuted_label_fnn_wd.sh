#!/bin/bash

# Copyright (c) 2018 Uber Technologies, Inc.
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

for depth in {1,2,3,4,5}
do
	for width in {50,100,200,400}
	do
		for dim in {0,1000,10000,20000,30000,40000,50000,60000,70000,80000,90000,100000,110000,120000,130000,140000,150000,160000,170000,180000,190000,200000,210000,220000,230000,240000,250000,260000,270000,280000,290000,300000}
		do
			if [ "$dim" = 0 ]; then
				echo dir_"$dim"_"$depth"_"$width"
				CUDA_VISIBLE_DEVICES=`nextcuda --delay 10` resman -r fnn_mnist_t500_pl_"$dim"_"$depth"_"$width" -- ./train.py /data/mnist/h5/train_shuffled_labels_0.h5 /data/mnist/h5/test_shuffled_labels_0.h5 -E 500 --vsize $dim --opt 'adam' --lr 0.0001 --l2 0.0001 --arch mnistfc_dir --depth $depth --width $width &
			else	
				echo lrb_"$dim"_"$depth"_"$width"
				CUDA_VISIBLE_DEVICES=`nextcuda --delay 10` resman -r fnn_mnist_t500_pl_"$dim"_"$depth"_"$width" -- ./train.py /data/mnist/h5/train_shuffled_labels_0.h5 /data/mnist/h5/test_shuffled_labels_0.h5 -E 500 --vsize $dim --opt 'adam' --lr 0.0001 --l2 0.0001 --arch mnistfc --depth $depth --width $width --fastfoodproj&
			fi
		done
	done
done			

