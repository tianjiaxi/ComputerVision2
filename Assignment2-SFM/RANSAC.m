function bestInliers = imageStitching( path1, path2 )

run('vlfeat-0.9.20/toolbox/vl_setup')
%I = vl_impattern('left.jpg') ;
%image(I) ;
ima = rgb2gray(imread(path1));
Ia = single(ima) ;
imb = rgb2gray(imread(path2));
Ib = single(imb) ;

[fa, da] = vl_sift(Ia) ;
[fb, db] = vl_sift(Ib) ;
[matches, scores] = vl_ubcmatch(da, db, 3);

iterations = 20;
bestInliers = 0;
bestTransformation = 0;

for i = 1:iterations
    perm = randperm(size(matches, 2));
    nMatches = 3;
    sel = perm(1:nMatches);
    A = zeros(2*nMatches, 6);
    b = zeros(2*nMatches, 1);
    i = 1;
    for matchno = sel
        match = matches(:, matchno);
        xb = fa(1,matches(1,matchno));
        xa = fb(1,matches(2,matchno));
        yb = fa(2,matches(1,matchno));
        ya = fb(2,matches(2,matchno));
        A(i, :) = [xa, ya, 0, 0, 1, 0];
        A(i+1, :) = [0, 0, xa, ya, 0, 1];
        b(i, :) = xb;
        b(i+1, :) = yb;
        i = i + 2;
    end

    transformation = pinv(A)*b;

    transformations = zeros(size(matches,2), 2);
    inliers = 0 ;
    for i = 1:size(matches,2)    
        xb = fa(1,matches(1,i));
        xa = fb(1,matches(2,i));
        yb = fa(2,matches(1,i));
        ya = fb(2,matches(2,i));
        A = [xa, ya, 0,  0,  1, 0 ;
             0 , 0 , xa, ya, 0, 1 ];
        trans = A*transformation;
        xt = trans(1);
        yt = trans(2);

        dist = sqrt((xt - xb)^2 + (yt - yb)^2);
        if dist <= 10
            inliers = inliers + 1;
        end

    %     plot(xa,ya,'r.','MarkerSize',20)
    %     plot(xt + size(Ia, 2),yt,'b.','MarkerSize',20)
    %     h = line([xa ; xt + size(Ia, 2)], [ya ; yt]) ;
    %     set(h,'linewidth', 0.5, 'color', 'y') ;
    end
    if inliers > bestInliers
        bestSel = sel;
        bestInliers = inliers;
        bestTransformation = transformation;
    end
end

end

