[I0,map]=imread('lines','bmp');
colormap(map);
I0=double(I0); %increasing of calculation precision
[row col deep]=size(I0); %acquisition of the input image size

%gray-level image creation
IG0=I0;
%conversion to grayscale
IG0(:,:,1)=(I0(:,:,1)+I0(:,:,2)+I0(:,:,3))/3;
IG0(:,:,2)=IG0(:,:,1);
IG0(:,:,3)=IG0(:,:,1);

%Accumulator
max_ro=floor(sqrt(row*row+col*col));
max_alfa=180;
A=zeros(max_ro,max_alfa);

%Hough transform for straight lines
for x=1:col
    for y=1:row
        if IG0(row-y+1,x,1)==0
            for ro=1:max_ro
                for alfa=1:max_alfa
                    alf=pi*alfa/180.0;
                    if ro==round(x.*cos(alf)+y.*sin(alf))
                        A(max_ro-ro+1,alfa)=A(max_ro-ro+1,alfa)+1;
                    end;    
                end;
            end;
        end; %if
    end;
end;    


IA=double(zeros(max_ro,max_alfa,3));
IA(:,:,1)=A;
minIA=min(min(IA(:,:,1)));
maxIA=max(max(IA(:,:,1)));
IA(:,:,1)=255*(IA(:,:,1)-minIA)/(maxIA-minIA);
IA(:,:,2)=IA(:,:,1);
IA(:,:,3)=IA(:,:,1);

% OUTPUT FIGURES

%input grayscale image
IG0=uint8(IG0);
figure(1);
image(IG0);
title('INPUT IMAGE');

%Accumulator
IA=uint8(IA);
figure(2);
image(IA);
title('ACCUMULATOR');

%Accumulator - 3D
figure(3);
surf(A);
title('ACCUMULATOR - 3D');