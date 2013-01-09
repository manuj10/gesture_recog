vlc_path = 'C:\Program Files\VideoLAN\VLC\vlc.exe';
[filename, pathname] = uigetfile( ...
{  '*.*',  'All Files (*.*)'}, ...
   'Pick a video fileto play', ...
   'F:\');
dos(['"' vlc_path '" "' sprintf('%s%s',pathname,filename) '" &']);


obj=videoinput('winvideo',1);
set(obj, 'SelectedSourceName', 'input1');
set(obj,'ReturnedColorSpace','rgb');
src_obj = getselectedsource(obj);
get(src_obj);
triggerconfig(obj, 'Manual');
set(obj,'FramesPerTrigger',30);
set(obj,'TriggerRepeat',10);
start(obj);
pause(5);
trigger(obj);
thresh = 25; 
while(1)
i=1;
beep;
while(i)<=30
 pause(0.01);
 trigger(obj);
 source(:,:,:,i)=getsnapshot(obj);
 image(source(:,:,:,i));
 i=i+1;
end
bg = source(:,:,:,1);         % read in 1st frame as background frame
bg_bw = double(rgb2gray(bg));     % convert background to greyscale

% ----------------------- set frame size variables -----------------------
fr_size = size(bg);             
width = fr_size(2);
height = fr_size(1);
fg = zeros(height, width);
dox=0;
doy=0;
area=0;

% --------------------- process frames -----------------------------------

for i = 2:30

    fr = source(:,:,:,i);
    im = double(fr);
    skinprob = computeSkinProbability(im);
    im2(:,:,1) = (skinprob>0)*255;


n=im2(:,:,1);
    fr_bw = rgb2gray(fr);       % convert frame to grayscale
    
    fr_diff = abs(double(fr_bw) - double(bg_bw));  % cast operands as double to avoid negative overflow

    for j=1:width                 % if fr_diff > thresh pixel in foreground
         for k=1:height

             if ((fr_diff(k,j) > thresh))
                 fg(k,j) = fr_bw(k,j);
             else
                 fg(k,j) = 0;
             end
              if (fr_bw(k,j) > bg_bw(k,j))          
                 bg_bw(k,j) = bg_bw(k,j) + 1;           
             elseif (fr_bw(k,j) < bg_bw(k,j))
                 bg_bw(k,j) = bg_bw(k,j) - 1;     
             end

         end    
    end
      
     fc=im2uint8(n&fg);
    
xc=0;
yc=0;
c(i)=0;
noy(i)=0;
nox(i)=0;
for j=1:length(fc(:,1))
    for l=1:length(fc(1,:))
        if(fc(j,l)==255)
            yc=yc+j;
            xc=xc+l;
            c(i)=c(i)+1;
        end
    end
end
x(i)=xc/c(i);
y(i)=yc/c(i);
if(i>=3)
if(~(isnan(c(i))&&isnan(c(i-1))))
    if(c(i)>c(i-1)||(c(i)>c(i-2)))
        area=area+1;
    else
        area=area-1;
    end
end
end

if(~(isnan(x(i))||isnan(y(i))))
for j=1:length(fc(:,1))
    if(fc(j,floor(x(i))+1)==255)
        noy(i)=noy(i)+1;
    end
end
for j=1:length(fc(1,:))
    if(fc(floor(y(i)),j)==255)
        nox(i)=nox(i)+1;
    end
end
if(~(isnan(x(i-1))||isnan(y(i-1))))
    if(x(i)>x(i-1))
        dox=dox+1;
    else
        dox=dox-1;
    end
    if(y(i)<y(i-1))
        doy=doy+1;
    else
        doy=doy-1;
    end
end
        
end
nx=0;
ny=0;
nx=nx+nox(i);
ny=ny+noy(i);
     
end
nx=nx/i;
ny=ny/i;
xstart=0;
xend=0;
ystart=0;
yend=0;
command=0;
k=1;
j=2;
while(k~=4&&j~=30)
    if(~(isnan(x(j))||isnan(x(i-j))||isnan(y(j))||isnan(y(i-j))))
    xstart=xstart+x(j);
    xend=xend+x(i-j);
    ystart=ystart+y(j);
    yend=yend+y(i-j);
    k=k+1;
    end
    j=j+1;
end
xstart=xstart/k-1;
xend=xend/k-1;
ystart=ystart/k-1;
yend=yend/k-1;
if((abs(xend-xstart)>(width/5))||(abs(yend-ystart)>(height/5)))  %decision tree
    if((dox>0)&&(abs(dox)>abs(doy)))  %play/pause
       !commandg 1            
    elseif((dox<0)&&(abs(dox)>abs(doy)))  % stop 
        !commandg 2             
    elseif((doy>0)&&(abs(doy)>abs(dox)))  %increase vol
        !commandg 3  
    elseif((doy<0)&&(abs(doy)>abs(dox)))   %decrease vol
        !commandg 4          
    end
elseif(abs(area)>15)
    !commandg 5
                   
end
   
end

delete(obj);


