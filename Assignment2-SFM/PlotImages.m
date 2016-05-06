function PlotImages(matches, im1, im2, f1, f2, inliers)

if length(inliers) > 1
    sel = inliers;
else
    if inliers == 0
        sel = 1:length(matches);
    else
        perm = randperm(size(matches, 2));
        nMatches = inliers;
        sel = perm(1:nMatches);
    end
end

imshow(cat(2, im1, im2)) ;

figure(2) ; clf ;
imagesc(cat(2, im1, im2));


x1 = f1(1,matches(1,sel)) ;
x2 = f2(1,matches(2,sel)) + size(im1,2) ;
y1 = f1(2,matches(1,sel)) ;
y2 = f2(2,matches(2,sel)) ;

hold on ;
h = line([x1 ; x2], [y1 ; y2]) ;
set(h,'linewidth', 0.5, 'color', 'b') ;

vl_plotframe(f1(:,matches(1,sel))) ;
f2(1,:) = f2(1,:) + size(im1,2) ;
vl_plotframe(f2(:,matches(2,sel))) ;

x1 = f1(1,matches(1,sel)) ;
x2 = f2(1,matches(2,sel)) ;
y1 = f1(2,matches(1,sel)) ;
y2 = f2(2,matches(2,sel)) ;

hold on ;
h = line([x1 ; x2], [y1 ; y2]) ;
set(h,'linewidth', 1, 'color', 'r') ;

vl_plotframe(f1(:,matches(1,sel))) ;
vl_plotframe(f2(:,matches(2,sel))) ;
axis image off ;
end

