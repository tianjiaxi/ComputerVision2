function PlotEpipolarLines(im1, im2, F)
figure();
imshow(cat(2, im1, im2)) ;
EpipoleL = null(F)

[X, Y] = ginput(1)

hold on ;
plot(X,Y,'go');
plot(EpipoleL(1), EpipoleL(2), 'ro');
h = line([X ; EpipoleL(1)], [Y ; EpipoleL(2)]) ;
set(h,'linewidth', 0.5, 'color', 'b') ;

EpipoleR = null(F')
size(F)
size(im1, 1)
XYR = F * [X; Y; 1]
plot(XYR(1)+ size(im1, 2),XYR(2),'go');
plot(EpipoleR(1) + size(im1, 2), EpipoleR(2), 'ro');
h = line([XYR(1)+ size(im1, 2) ; EpipoleR(1) + size(im1, 2);], [XYR(2) ; EpipoleR(2)]) ;
set(h,'linewidth', 0.5, 'color', 'b') ;
end

