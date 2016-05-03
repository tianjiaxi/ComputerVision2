function SFM
    run('vlfeat-0.9.20/toolbox/vl_setup')
    
    im1 = im2single(imread(fullfile('House', 'frame00000001.png'))) ;
    im2 = im2single(imread(fullfile('House', 'frame00000002.png'))) ;
    
    [f1,d1] = vl_sift(im1);
    [f2,d2] = vl_sift(im2);
    
    [matches, scores] = vl_ubcmatch(d1,d2) ;
    
end