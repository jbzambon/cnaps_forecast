# cnaps_forecast
Create CNAPS forecast animations by definining start time and forecast hours

Tested from a fresh conda installation on an AWS instance...
```
ubuntu@ip-172-31-90-200:~$ mkdir cnaps
ubuntu@ip-172-31-90-200:~$ cd cnaps/
ubuntu@ip-172-31-90-200:~/cnaps$ git clone https://github.com/jbzambon/cnaps_forecast.git .
..... cloning stuff .....
ubuntu@ip-172-31-90-200:~/cnaps$ conda env create -f environment.yml
..... installing stuff .....
ubuntu@ip-172-31-90-200:~/cnaps$ conda activate hr72_panel6
(hr72_panel6) ubuntu@ip-172-31-90-200:~/cnaps$ python hr72_6panel.py 
Input start date in YYYYMMDDHH format
2019040100
Input number of hours to plot
72
..... pythoning stuff .....
```
Now you should have several (25) png images prefixed "cnaps_XX" where XX are the individual frames.

To create an animation, you need to install ImageMagick and avconv...
```
(hr72_panel6) ubuntu@ip-172-31-90-200:~/cnaps$ sudo apt install imagemagick-6.q16 
Do you want to continue? [Y/n] Y
..... installing stuff .....
(hr72_panel6) ubuntu@ip-172-31-90-200:~/cnaps$ sudo apt-get install ffmpeg
Do you want to continue? [Y/n] Y
..... installing stuff .....
```

Run png2mp4.sh script to backup original pngs, convert png to jpg, add logos, and create a mp4.

(hr72_panel6) ubuntu@ip-172-31-90-200:~/cnaps$ ./png2mp4.sh 
..... scripting .....

MP4 is called temp.mp4, download it to wherever you want to watch it.
```
scp -i .ssh/aws.pem ubuntu@X.X.X.X:/home/ubuntu/cnaps/temp.mp4 .
```
