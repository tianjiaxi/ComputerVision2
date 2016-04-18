function cloud2 = cleanData(cloud)
    cloud2 = zeros(1, 3);
    counter = 1;
    for i = 1:length(cloud)
       if cloud(i,3) < 2
           cloud2(counter,:) = cloud(i,:);
           counter = counter + 1;
       end
    end
end