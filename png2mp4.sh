#!/bin/sh
# 
# Joseph B. Zambon
# jbzambon@ncsu.edu
#
# Utility script to combine ordered pngs into a mp4 animation
#
# 21 June 2011
# Updated: 27 August 2015
# Updated: 1 April 2019 (replaced deprecated avconv with ffmpeg

#desired framerate of movie (frames/sec)
r=5

#backup files for safekeeping
mkdir backup
cp *.png backup/
echo "Done Backing up"

iter=1
for f in *.png;
do
  echo "Processing $f file.."
  if [ $iter -eq 1 ]; then
    #desired image width, sanity check for even numbers
      w=`identify -format "%w" $f`
        if [ `expr $w % 2` -eq 1 ]; then
           w=`expr $w - 1`
        fi
    #desired image height, sanity check for even numbers
      h=`identify -format "%h" $f`
        if [ `expr $h % 2` -eq 1 ]; then
           h=`expr $h - 1`
        fi
  fi
  conf_file=`printf %03d $iter`
  echo $conf_file
  convert -background white -flatten -resize "$w"x"$h"\! -quality 100 $f `printf %03d $iter`.jpg
  convert `printf %03d $iter`.jpg \( ncsu_logo.jpg -resize 250x119^ \) -gravity northwest -geometry +50+5 -composite -quality 100 `printf %03d $iter`.jpg
  convert `printf %03d $iter`.jpg \( oomg_logo.jpg -resize 398x119^ \) -gravity northeast -geometry +50+5 -composite -quality 100 `printf %03d $iter`.jpg
  iter=`expr $iter + 1`
done

#avconv -r $r -i %03d.jpg -s $w"x"$h -b 20000000 temp.mp4
ffmpeg -r $r -f image2 -s $w"x"$h -i %03d.jpg -vcodec libx264 -crf 25  -pix_fmt yuv420p temp.mp4
