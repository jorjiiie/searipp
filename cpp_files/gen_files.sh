#!/bin/bash

input=$1

clang++ -Xclang -ast-print -fsyntax-only $input >prog.cpp
clang++ -Xclang -ast-dump=json prog.cpp >prog.json
