#!/bin/bash

if [ $# -eq 0]; then
	echo "No arguments provided"
	exit 1
fi

input=$1

clang++ -Xclang -ast-print -fsyntax-only $input >prog.cpp
clang++ -Xclang -ast-dump=json prog.cpp >prog.json
