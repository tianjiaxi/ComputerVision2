cloud = readPcd('data/0000000000.pcd');
cloud2 = zeros(1,4);

counter = 1;
for i = 1:length(cloud)
   if cloud(i,3) < 2 && cloud(i,3) > 0.5
       cloud2(counter,:) = cloud(i,:);
       counter = counter + 1;
   end
end
