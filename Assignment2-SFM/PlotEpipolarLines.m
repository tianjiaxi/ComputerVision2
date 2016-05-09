function PlotEpipolarLines(im1, im2, F)
figure();
imshow(cat(2, im1, im2)) ;
EpipoleL = null(F)

[X, Y] = ginput(1)

hold on ;
plot(X,Y,'go');
plot(EpipoleL(1), EpipoleL(2), 'ro');
hl = line([X ; EpipoleL(1)], [Y ; EpipoleL(2)]) ;
set(hl,'linewidth', 0.5, 'color', 'b') ;

EpipoleR = null(F')
size(F)
size(im1, 2)

p1 = [X; Y; 1];
XYR = F*p1
plot(XYR(1)+ size(im1, 2),XYR(2),'go');
plot(EpipoleR(1) + size(im1, 2), EpipoleR(2), 'ro');
hr = line([XYR(1)+ size(im1, 2) ; EpipoleR(1) + size(im1, 2);], [XYR(2) ; EpipoleR(2)]) ;
set(hr,'linewidth', 0.5, 'color', 'g') ;


[m n] = size(im1);

left_P = [left_x; left_y; 1];
right_P = F*left_P;
right_epipolar_x = 1:2*m;

% Using the eqn of line: ax+by+c=0; y = (-c-ax)/b
right_epipolar_y = (-right_P(3)-right_P(1)*right_epipolar_x)/right_P(2);

figure(2); hold on; plot(right_epipolar_x, right_epipolar_y, 'r');
end
