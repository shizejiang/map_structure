function [ x0,y0,eEllipCoeff,CurL0 ] = ReverseGaussianProjectionStep1( lat_center,lon_center )

L_Reference = 120;
CurL0 = ConvertDms2Rad(L_Reference);

lat_center = DDD2DMS(lat_center);
lon_center = DDD2DMS(lon_center);

eEllipCoeff.a   = 6378137;
eEllipCoeff.A1  = 111132.9525494;
eEllipCoeff.A2  = -16038.50840;
eEllipCoeff.A3  = 16.83260;
eEllipCoeff.A4  = -0.02198;
eEllipCoeff.A5  = 0.00003;

eEllipCoeff.e2  = 0.0066943799013;
eEllipCoeff.e12 = 0.00673949674227;

[x0,y0] = fgConvertBl2xy(lat_center,lon_center,eEllipCoeff,CurL0);


end

