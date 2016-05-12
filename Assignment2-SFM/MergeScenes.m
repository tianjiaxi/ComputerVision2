function MergeScenes()
run('vlfeat-0.9.20/toolbox/vl_setup')
mode = 3;
folder = 'House';
directory = strcat(pwd, '\',folder,'\*.png');
contents = dir(directory);
f1= [];
PointView = [];
InliersMatches = [];
matchfound = 0;
for iterations = 1:numel(contents)-1
   
    
    image1 = contents(iterations).name;
    image2 = contents(iterations+1).name;
    
    im1 = im2single(imread(fullfile('House', image1))) ;
    im2 = im2single(imread(fullfile('House', image2))) ;
    
    if isempty(f1)
        [f1,D1] = vl_sift(im1);
       
    end
    [f2,D2] = vl_sift(im2);
    [matches, scores] = vl_ubcmatch(D1,D2) ;
    
    xy1 = f1(1:2, matches(1, :))';
    xy2 = f2(1:2, matches(2, :))';

    if mode == 2 || mode == 3
        x1 = xy1(:, 1);
        y1 = xy1(:, 2);
        x2 = xy2(:,1);
        y2 = xy2(:,2);
        mx1 = mean(x1);
        my1 = mean(y1);

        d1 = mean(sqrt(((x1 - mx1).^2) + ((y1 - my1).^2)));

        T1 = [sqrt(2)/d1, 0,          -mx1 * sqrt(2)/d1;
             0,          sqrt(2)/d1, -my1 * sqrt(2)/d1;
             0,          0,          1];
         
        xy1 = T1 * [xy1, ones(length(xy1), 1)]';
        xy1 = xy1';
        
        mx2 = mean(x2);
        my2 = mean(y2);

        d2 = mean(sqrt(((x2 - mx2).^2) + ((y2 - my2).^2)));

        T2 = [sqrt(2)/d2, 0,          -mx2 * sqrt(2)/d2;
             0,           sqrt(2)/d2, -my2 * sqrt(2)/d2;
             0,           0,          1];
         
        xy2 = T2 * [xy2,ones(length(xy2), 1)]';
        xy2 = xy2';
    end
    
    x1 = xy1(:, 1);
    y1 = xy1(:, 2);
    x2 = xy2(:,1);
    y2 = xy2(:,2);
    
%     A = [x1.*x2, x1.*y2, x1, y1.*x2, y1.*y2, y1, x2, y2, ones(size(x1))];
%     
%     [U,D,V] = svd(A); %performing SVD on A
%     
%     [M,I] = min(max(D)); %finding the smallest singular value
%     
%     F = reshape(V(:,I),[3,3]);
%     
%     [Uf, Df, Vf] = svd(F); %performing SVD on F
%     
%     [M,I] = min(max(Df)); %finding the smallest singular value
%     
%     Dfp = Df;
%     Dfp(I,I) = 0; %ensuring the rank is 2    
%     
%     F = Uf*Dfp*Vf';
    if mode == 1 || mode == 2
        [F] = FundamentalMatrix(x1,y1,x2,y2);
    end
    if mode == 3
        [F,inliers] = RANSAC(x1, y1, x2, y2);
    end
    if mode == 2 || mode == 3
        F = denormalizeF(F, T1, T2); 
    end
    
    
    
    %PlotImages(matches, im1, im2, f1, f2, inliers)
    
    %PlotEpipolarLines(im1, im2, F, Epipole)
    
    %look up all the inliers
    %for l = 1:length(inliers)
    %   NewInliersMatches(:,l) = matches(:, inliers(:,l));
    %end
    NewInliersMatches = matches(:, inliers);
    
    %first iteration is just filling the whole thing with ones
    if iterations == 1
        PointView  = ones(size(NewInliersMatches));
        InliersMatches = NewInliersMatches;
        CoordinateX = zeros(size(NewInliersMatches));        
        CoordinateY = zeros(size(NewInliersMatches));
        for m = 1:length(CoordinateX(:,1))
            for n = 1:length(CoordinateY(1,:))
                if m == 1
                    CoordinateX(m,n) = f1(1, InliersMatches(m,n));
                    CoordinateY(m,n) = f1(2, InliersMatches(m,n));
                else
                    CoordinateX(m,n) = f2(1, InliersMatches(m,n));
                    CoordinateY(m,n) = f2(2, InliersMatches(m,n));
                end
            end
        end
    else
    %create new rows to append for new frame
    NewPointView = zeros(1,size(PointView, 2));
    InliersMatches2 = zeros(1, size(InliersMatches, 2));
    NewCoordinateX = zeros(1,size(CoordinateX, 2));
    NewCoordinateY = zeros(1,size(CoordinateY, 2));
    
    for j = 1:length(NewInliersMatches(1,:))
        for k = 1:length(InliersMatches(1,:))
            if NewInliersMatches(1,j) == InliersMatches(end,k)
                %append 1 if match was found
                NewPointView(1, k) = 1;
                %append indexes if match was found
                InliersMatches2(1,k) = NewInliersMatches(2,j);
                
                %look the index found in newinliersmatches up in D2 and
                %place the x and y coordinates in the coordinate matrices
                NewCoordinateX(1,k) = f2(1, NewInliersMatches(2,j));
                NewCoordinateY(1,k) = f2(2, NewInliersMatches(2,j));
                matchfound = 1;
                break
            end
        end
        if matchfound == 0
                %append new column to already existing pointviewmatrix
                emptycolumnPointView = zeros(iterations, 1);
                %sizePV = size(PointView)
                emptycolumnPointView(end, 1) = 1;
                PointView = horzcat(PointView, emptycolumnPointView);
                
                %append new column to already existing indexmatrix
                emptycolumnInliersMatches = zeros(iterations, 1);
                emptycolumnInliersMatches(end, 1) = NewInliersMatches(1,j);
                InliersMatches = horzcat(InliersMatches, emptycolumnInliersMatches);
                
                %append columns to index and pointview for new frame
                NewPointView(1, end+1) = 1;
                InliersMatches2(1, end+1) = NewInliersMatches(2,j);
                
                %append new columns to CoordinateX matrixes 
                emptycolumnCoordinateX = zeros(iterations, 1);
                emptycolumnCoordinateX(end, 1) = f1(1, NewInliersMatches(1,j));
                CoordinateX = horzcat(CoordinateX, emptycolumnCoordinateX);
                
                %append new columns to CoordinateY matrixes 
                emptycolumnCoordinateY = zeros(iterations, 1);
                emptycolumnCoordinateY(end, 1) = f1(2, NewInliersMatches(1,j));
                CoordinateY = horzcat(CoordinateY, emptycolumnCoordinateY);
                
                NewCoordinateX(1, end+1) = f2(1, InliersMatches2(1,end));
                NewCoordinateY(1, end+1) = f2(2, InliersMatches2(1,end));
        end  
        matchfound = 0;
    end
    
    InliersMatches = vertcat(InliersMatches, InliersMatches2);
    PointView = vertcat(PointView, NewPointView);
    
    CoordinateX = vertcat(CoordinateX, NewCoordinateX);
    CoordinateY = vertcat(CoordinateY, NewCoordinateY);
    end
    
    f1=f2;
    D1=D2;
    
end
minIM  = min(InliersMatches);
minPV  = min(PointView);
counterIM = 0;
counterPV = 0;
for i = 1: length(minIM)
    if max(minIM(1,i)) > 0
        counterIM = counterIM+1;
    end  
    if max(minPV(1,i)) > 0
        counterPV = counterPV+1;
    end  
end
    counterIM
    counterPV
    spy(PointView)
    %recombine CoordinateX and CoordinateY to D
    D = reshape([CoordinateX(:) CoordinateY(:)]',2*size(CoordinateX,1), []);
    StructureFromMotion(D);
end