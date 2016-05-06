function PlotEpipolarLines(im1, im2, F, Epipole)
figure();
imshow(cat(2, im1, im2)) ;
Epipole
[X, Y] = ginput(1);

hold on ;
h = line([X(1) ; Epipole(1)], [Y(1) ; Epipole(2)]) ;
set(h,'linewidth', 0.5, 'color', 'b') ;
end

