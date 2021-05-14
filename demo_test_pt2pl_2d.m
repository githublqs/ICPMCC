clc;
clear;
close all;
ptCloud_src = pcread('e:/src.ply');
Location_src=ptCloud_src.Location;
Location_src_2d=[Location_src(:,1),Location_src(:,2)];
ptCloud_dst = pcread('e:/dst.ply');
Location_dst=ptCloud_dst.Location;
Location_dst_2d=[Location_dst(:,1),Location_dst(:,2)];
Normal_dst=ptCloud_dst.Normal;
Normal_dst_2d=[Normal_dst(:,1),Normal_dst(:,2)];
ICPPlot(Location_src_2d,Location_dst_2d);
axis equal;
axis off;
title('ICP_MCC_pt2pl 2d initial state');

Dim=2;
R = eye(Dim);
t=[0;0];
[R4, t4, TCorr4, MSE4, TData4] = ICP_MCC_pt2pl_test_2d(Location_src_2d,Location_dst_2d ,R,t,Normal_dst_2d);

Rt=[[R4;[0,0]],[t4;1]];

dlmwrite('e:/Rt.csv', Rt, 'precision', 8); 
RtTransform=Rt*[Location_src_2d,ones(size(Location_src_2d,1),1)]';
RtTransform=RtTransform';
RtTransform=RtTransform(:,[1,2]);
ICPPlot(RtTransform,Location_dst_2d);
axis equal;
axis off;
title('ICPMCC p2l 2d Rt result');
