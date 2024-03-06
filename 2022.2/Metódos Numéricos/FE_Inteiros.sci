prt = %f
function b=dec2binario1(a,n) 
  p= 2^(n-1:-1:0)
  r=int(a./p)
  b = modulo(r,2) 
  if((a>(2^n)-1)|(a<0)) b=[] end
endfunction

function a=binario2dec1(b) 
    p= 2^(length(b)-1:-1:0);
    a= b*p';  
endfunction

function s=b2s(b)
    s="["
    for i=1:length(b)  s=s+string(b(i)) end
    s=s+"]"
endfunction

function b=dec2binario2(a,n) 
  b=dec2binario1(abs(a),n-1)
  if (a>=0) then   b=[0 b] // acrescentar o bit de sinal
  else             b=[1 b]  end
  if(  a<(-2^(n-1)-1) |  a>(2^(n-1)-1)  ) b=[] end
endfunction

function a=binario2dec2(b)
   sinal=b(1)
   a= (-1)^sinal*binario2dec1(b(2:length(b)));  
endfunction

function [b1,b2]=Compatibiliza_Tamanhos(b1,b2)
    n1=length(b1)
    n2=length(b2)
    if (n1>n2) then //length(b1)<>length(b2)
        b2=[ones(1:n1-n2)*b2(1) b2]
    elseif (n2>n1)
        b1=[ones(1:n2-n1)*b1(1) b1]
    end
endfunction
 
function b3=SomaBinaria(b1,b2,prt)
    [b1,b2]=Compatibiliza_Tamanhos(b1,b2)
    n=length(b1)
    v1=0
    for(k=n:-1:1)
       b3(1,k)=b1(k)+b2(k)+v1
       v1=0
       if b3(k)==2 then
           b3(k)=0
           v1=1
       elseif b3(k)==3 then
           b3(k)=1
           v1=1   
       end
    end
    if (prt) then
         printf("  %s\n+ %s\n= %s \n", b2s(b1),b2s(b2),b2s(b3))
    end     
endfunction  

function b=comple2(b)
      b=bitcmp(b,1)   // inverter bits
      b=SomaBinaria(b,[0 1],%f)  // somar 1    
endfunction
 
function b=dec2binario3(a,n) 
  b=dec2binario1(abs(a),n)
  if(a<0) then  b=comple2(b)  end
  if(  a<(-2^(n-1)) |  a>(2^(n-1)-1)  ) then b=[] end
endfunction 

function a=binario2dec3(b)
  sinal = b(1)
  if(sinal) then  b=comple2(b) end
  a= (-1)^sinal * binario2dec1(b) ;
endfunction 
