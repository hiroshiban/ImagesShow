function cleanpport
% Sets most pins of the parallel port to zero
%
parport = digitalio('parallel','LPT1');
addline(parport,0:7,'out');
parport

putvalue(parport.Line(1:8),0)

delete(parport);