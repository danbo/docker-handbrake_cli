#!/bin/bash

# assumption: full paths are provided
input=$1
output=$2

# assupmtion: x264 and aac are desired
# DVD= 20 +/- 1
# BD= 22 +/- 1
quality=23
preset=veryfast
level=4.1
audiobr=128

# assimption: film, constant framerate, strict-anamorphic
vparams="-e x264 --x264-preset $preset --h264-level $level -q $quality --x264-tune film --cfr --strict-anamorphic"
aparams="-E av_aac -B $audiobr"

# docker needs output to exist to map (?)
touch ${output}
touch ${output}.log

docker run --rm \
  -v ${input}:/tmp/${input}:ro \
  -v ${output}:/tmp/${output}:rw \
  -v ${output}.log:/tmp/${output}.log:rw \
  danbo/handbrake \
  /bin/bash -c "HandBrakeCLI $vparams $aparams -i \"/tmp/${input}\" -o \"/tmp/${output}\" 2>\"/tmp/${output}.log\""