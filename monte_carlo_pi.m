nmax = 10000;
x = rand(nmax,1);
y = rand(nmax,1);
x1=x;
y1=y;
r = sqrt(x1.^2+y1.^2) ;
% get logicals 
inside = r<=1 ;
outside = r>1 ;
% plot 
plot(x1(inside),y1(inside),'g.');
hold on
plot(x1(outside),y1(outside),'b.');
% get pi value 
thepi = 4*sum(inside)/nmax ;  
fprintf('%8.4f\n',thepi)