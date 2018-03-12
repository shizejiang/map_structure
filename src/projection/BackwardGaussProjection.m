function [ coor_global ] = BackwardGaussProjection( center_lat, center_lon, heading,coor_x,coor_y )

[center_x,center_y] = backward_projection_step1_mex(center_lat,center_lon);

[coor_global(1),coor_global(2)]=backward_projection_step2_mex(center_x,center_y,heading,coor_x,coor_y);

end

