global randLCGseed
data=clock()
randLCGseed=1e10*data(6)^data(5);
function x=randLCG()
  global randLCGseed
  randLCGseed = uint32(1664525)*randLCGseed+uint32(1013904223);
  x = double(randLCGseed)/4294967296.0;
endfunction

global randMWCs1 randMWCs2
data=clock()
randMWCs1 = uint32(data(6));
data=clock()
randMWCs2 = uint32(data(6)*data(5));
function x=randMWC()
   global randMWCs1 randMWCs2
   s = uint32(2^16);
   randMWCs1 = 36969*modulo(randMWCs1,s)+randMWCs1/s;
   randMWCs2 = 18000*modulo(randMWCs2,s)+randMWCs2/s;
   x = double(randMWCs1*s+randMWCs2)/4294967296.0;
endfunction
