function [ coor_lat,coor_lon ] = ReverseGaussianProjectionStep2( x0,y0,Heading,tran_x,tran_y,eEllipCoeff,CurL0 )


Convx = tran_x * cos(Heading) + tran_y*sin(Heading);
Convy = tran_x * -sin(Heading)+ tran_y*cos(Heading);


x = Convy + x0;
y = Convx + y0;

y = y - 500000;
B0 = x / eEllipCoeff.A1;


%%do while
preB0 = B0;
B0 = B0 * pi / 180.0;
B0 = (x - (eEllipCoeff.A2 * sin(2 * B0) + eEllipCoeff.A3 * sin(4 * B0) + eEllipCoeff.A4 * sin(6 * B0) + eEllipCoeff.A5 * sin(8 * B0))) / eEllipCoeff.A1;
deta = abs(B0 - preB0);

while(deta > 0.000000001)
    preB0 = B0;
    B0 = B0 * pi / 180.0;
    B0 = (x - (eEllipCoeff.A2 * sin(2 * B0) + eEllipCoeff.A3 * sin(4 * B0) + eEllipCoeff.A4 * sin(6 * B0) + eEllipCoeff.A5 * sin(8 * B0))) / eEllipCoeff.A1;
    deta = abs(B0 - preB0);
end

B0 = B0 * pi / 180.0;
B = ConvertRad2Dms(B0);
sinB = sin(B0);
cosB = cos(B0);
t = tan(B0);
t2 = t * t;
N = eEllipCoeff.a / sqrt(1 - eEllipCoeff.e2 * sinB * sinB);
eta2 = cosB * cosB * eEllipCoeff.e2 / (1 - eEllipCoeff.e2);
V = sqrt(1 + eta2);
yN = y / N;
B = B0 - (yN * yN - (5 + 3 * t2 + eta2 - 9 * eta2 * t2) * yN * yN * yN * yN / 12.0 + (61 + 90 * t2 + 45 * t2 * t2) * yN * yN * yN * yN * yN * yN / 360.0)* V * V * t / 2;
L = CurL0 + (yN - (1 + 2 * t2 + eta2) * yN * yN * yN / 6.0 + (5 + 28 * t2 + 24 * t2 * t2 + 6 * eta2 + 8 * eta2 * t2) * yN * yN * yN * yN * yN / 120.0) / cosB;
B = ConvertRad2Dms(B);
L = ConvertRad2Dms(L);
B = DMS2DDD(B);
L = DMS2DDD(L);
coor_lat = B;
coor_lon = L;



end

