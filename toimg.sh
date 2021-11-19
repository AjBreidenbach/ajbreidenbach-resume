#!/bin/bash
for input in "$@"
 do
   convert $input -resize 28x28 png:- | base64 -w 0 | xargs printf '<img width="14" height="14" src="data:image/jpeg;base64, %s">' > $(basename $input .svg).img
 done


