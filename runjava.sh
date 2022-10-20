#!/usr/bin/env bash

echo 'file_name : ' $1

target=$1

# $target is to read it.

# file_name=${target##*/}

file_path=${target%.java}

echo $file_path

# echo $file_name

# exec_name=${file_name%.java}

# echo $exec_name

javac $target && java $file_path
