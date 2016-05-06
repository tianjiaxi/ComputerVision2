for i =1:48
    frameno  = num2str(i);
    frameno2  = num2str(i+1);
    if size(frameno) == 1
        
      image = strcat('frame', '0000000',frameno, '.png');
      image2 = strcat('frame', '0000000',frameno2, '.png');
    else
      image = strcat('frame', '000000',frameno, '.png'); 
      image2 = strcat('frame', '000000',frameno2, '.png');
    end
    
    SFM(1, image, image2);
end