cloud = readPcd('data/0000000000.pcd');
cloud2 = zeros(size(cloud));

zcounter = 0;
counter = 1;
for i = 1:length(cloud)
   if cloud(i,3) < 2 && cloud(i,3) > 0.5
       cloud2(counter,:) = cloud(i,:);
       counter = counter + 1;
   end
   if cloud(i,3)  0
      zcounter = zcounter + 1 ;
   end
end

zcounter
max(cloud2)
min(cloud2)
mean(cloud2)
scatter3(cloud2(:,1),cloud2(:,2), cloud2(:,3))