gesture_recog
=============

A gesture recognition application for controlling VLC media player

The project aims at controlling vlc media player by using dynamic hand gestures as input.
Various functions of Vlc linked with gestures are play/pause,stop,increase volume,decrease volume and changing aspect ratio(crop).

Source code content:
___________________
commandg/                                    -source code for command generator(c++)
commandg.exe                                 -command generator executable 
gestureRecognitionApplication.m              -main  m file (matlab)
normalise.m                                  -supporting file[1]
computeSkinProbability.m                     -supporting file[1]
Skinmodel.bin                                -binary data set for skin detection[1]
README.txt                                   -This file

PreRequisite:
_____________
->VLC media player must be installed in default folder.
->optimum amount of light must be in room.
->Bright source of light must not be infront of webcam.

Running the application:
________________________
1.Install matlab.
2.Open matlab and browse to project folder directory.
3.Open gestureRecognitionApplication.m and debug the m file.

SOftware requirements:
____________________

->Matlab and Vlc media player must be installed in system.
->operating system(Windows XP or above).

Hardware Requirements:
______________________
Minimum requirements

•  Processor: Intel Celeron or above
•	RAM:256 Mb
•	Hard disk:6 Gb or Higher
•	Monitor: Standard VGA Monitor  
•	Webcam with minimum 10 fps.

Refences:
[1]  C. Ó. Conaire, N. E. O'Connor and A. F. Smeaton, “Detector adaptation by maximizing agreement between independent data sources,” IEEE Computer Society Conference on Computer Vision and Pattern Recognition, pp. 1-6, June 2007.



