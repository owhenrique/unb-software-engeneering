function y1=derivada1_scilab(f,x)
     J = numderivative(f,x)
     y1=diag(J)
endfunction

function y1=derivada1_adiantada(y,h)
     N=length(y)
     n=1:N-1
     y1(n)=(y(n+1)-y(n))/h
     y1(N)=y1(N-1)
endfunction

function y1=derivada1_atrasada(y,h)
     N=length(y)
     n=2:N
     y1(n)=(y(n)-y(n-1))/h;
     y1(1)=y1(2)
endfunction

function y1=derivada1_centrada(y,h)
     N=length(y)
     y1(1)=(y(2)-y(1))/h
     n=2:N-1
     y1(n)=(y(n+1)-y(n-1))/(2*h);
     y1(N)=(y(N)-y(N-1))/h
endfunction

function plot_derivada1(f,a,b,h)
    N=ceil((b-a)/h + 1)
    x=linspace(a,b,N)
    y=feval(x,f)
    y1_fw=derivada1_adiantada(y,h);
    y1_bk=derivada1_atrasada(y,h);
    y1_sci=derivada1_scilab(f,x);
   subplot(211)  
    plot(x,y)
    scatter(x,y)
    legend("f(x)",2);
   subplot(212)
    str=sprintf("h=%.2f",h)
    xtitle(str)
    plot(x,y1_fw,'b')
    plot(x,y1_sci,'bk')
    plot(x,y1_bk,'r')
    legend("f ''(x) adiantada","f ''(x) scilab",...
    "f ''(x) atrasada",2)  
endfunction

function plot_derivada1c(f,a,b,h)
    x=[a:h:b]
    N=size(x)
    y=feval(x,f)
    y1=derivada1_centrada(y,h)
    str=sprintf("h=%.2f",h)
    xtitle(str)
    plot(x,y1,'r')
    legend("f ''(x) centrada",2)  
endfunction


function plot_derivada1_centrada(f,a,b,h)
    x=[a:h:b]
    N=size(x)
   subplot(211)  
    y=feval(x,f)
    plot(x,y)
    scatter(x,y)
    legend("f(x)",2);
   subplot(212)
    y1=derivada1_centrada(y,h)
    y1_sci=derivada1_scilab(f,x);
    str=sprintf("h=%.2f",h)
    xtitle(str)
    plot(x,y1,'r')
    plot(x,y1_sci,'bk')
    legend("f ''(x) centrada","f ''(x) scilab",2)  
endfunction

function y2=derivada2_centrada_2(y,h)
     y1=derivada1_centrada(y,h)
     y2=derivada1_centrada(y1,h)
endfunction


function y2=derivada2_centrada(y,h)
     N=length(y)
     n=2:N-1
     y2(n)=(y(n+1)-2*y(n)+y(n-1))/(h^2);
     y2(1)=y2(2);
     y2(N)=y2(N-1);
endfunction

function plot_derivada2_centrada(f,a,b,h)
    x=[a:h:b]
    N=size(x)
   subplot(211)  
    y=feval(x,f)
    plot(x,y)
    scatter(x,y)
    legend("f(x)",2);
   subplot(212)
    y2=derivada2_centrada_2(y,h);
    str=sprintf("h=%.2f",h)
    xtitle(str)
    plot(x,y2,'r') 
    legend("f ''''(x) centrada",3)  
endfunction

function ps1=derivat_fga(ps)
    a = coeff(ps)
    N=length(a)
    ps1=(a(2:N).*[1:N-1])*(s^[0:N-2])'
endfunction

function ps1=polyint_fga(ps)
    a = coeff(ps)
    N=length(a)
    ps1=(a./[1:N])*(s^[1:N])'
endfunction

function Test_Derivada_pol(f,a,b,n)
    xi=linspace(a,b,n)
    yi=feval(xi,f)  
    if n<=10 ordem =n-1; else ordem = 9 end
    if (n<=10) then
       printf("Vandermonde ordem %d",ordem)
       ps=PolinomioVandermonde(xi,yi)
    else
       printf("Mínimos Quadrados ordem 9")
       ps=PolinomioMQ(xi,yi,9)
    end
   subplot(211)
    x=linspace(a,b,1000)
    plot(x,feval(x,f))
    plot(x,horner(ps,x),'r')
    plot2d(xi,yi,-2) 
    legend("f(x)","Polinômio","Pontos de Controle",2)
   subplot(212)
    ps1 = derivat(ps)
    plot(x,horner(ps1,x),'r')
    legend("1a derivada",2)
    xtitle("Derivada do Polinômio de ordem "+string(ordem))
endfunction



