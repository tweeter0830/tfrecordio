#!/bin/bash

OLD_MODULE=tensorflow/core/example
NEW_MODULE=tfrecordio/example
SRC_DIR=protos/$NEW_MODULE
MID_DIR=/tmp/
DEST_DIR=.

mkdir -p $SRC_DIR
mkdir -p $NEW_MODULE
touch tfrecordio/__init__.py
touch $NEW_MODULE/__init__.py

curl -o $SRC_DIR/feature.proto https://raw.githubusercontent.com/tensorflow/tensorflow/master/tensorflow/core/example/feature.proto
curl -o $SRC_DIR/example.proto https://raw.githubusercontent.com/tensorflow/tensorflow/master/tensorflow/core/example/example.proto

find $SRC_DIR -type f -print0 | xargs -0 sed -i "" "s#$OLD_MODULE#$NEW_MODULE#g"

protoc -I=protos --python_out=$DEST_DIR $SRC_DIR/feature.proto
protoc -I=protos --python_out=$DEST_DIR $SRC_DIR/example.proto

#cp $MID_DIR/tensorflow/core/example/*.py $DEST_DIR
