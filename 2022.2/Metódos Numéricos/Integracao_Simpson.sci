prt = %t
plt = %t
// deff ('y=f(x)' , 'y=x*sin(x)')
exec('Polinomio_Interpolacao.sci',-1)
function I=Simpson_13_tab(x,y,prt,plt)
   n=length(x)
   h=x(2)-x(1); //espaçamento
   w=ones(1:n);
   w(2:2:n-1)=4;
   w(3:2:n-1)=2
   S=y*w'
   I=(h/3)*S
   
   if (prt) 
       printf("[x y w y*w]")
       disp([x' y' w' (y.*w)'])
    //   printf("h=%f\nsoma(y*w)=%f\nI=(%f)/3*(%f)\n",h,S,h,S)
       printf("Integal por Simpson 1/3 %4d pontos = %f\n",n,I)
   end
   if (plt)
       for i=1:2:n-2   
         ps=PolinomioVandermonde(x(i:i+2),y(i:i+2))
         N=1000
         xi=linspace(x(i),x(i+2),N);
         yi=horner(ps,xi)
         xfpoly([xi(1) xi xi(N)],[0 yi 0],modulo(i/2+5,25)+8)
      // plot2d(xi,yi,modulo(i/2,7)+2)
       end
       scatter(x,y)
       xgrid()
       xtitle("Integral por Simpson 1/3 "+string(n)+" pontos="+string(I))
   end
endfunction
    
    
function I=Simpson_13(f,a,b,n,prt,plt) 
   h=(b-a)/(n-1); //espaçamento
   x=a:h:a+(n-1)*h;
   y=feval(x,f)
   I=Simpson_13_tab(x,y,prt,plt)
    if (prt)
        I2=intg(a,b,f);
        printf("integral exata = %f\n",I2)
        erro=abs((I2-I)/I2)*100
        printf("erro=%f%%\n",erro) 
    end
    if(plt)
        t=linspace(a,b,1000)
        plot(t,feval(t,f),'bk','LineWidth',3)
    end
endfunction    
    
function I=Test_Simpson_13(f,a,b)
   I2=intg(a,b,f);
   printf("integral exata = %f\n",I2)
   k=0
   //for (n=[3,5,9,15,21,31,41,51,61])
   for (n=[3,5,7,9,11,13,15,21,51])
     k=k+1 
     subplot(3,3,k)
     t=linspace(a,b,100)
     plot(t,feval(t,f),'--r')
     I=Simpson_13(f,a,b,n,%f,%t)
     erro=abs((I2-I)/I2)*100
     printf("%4d pontos = %f  erro=%.4f%%\n",n,I,erro)
     xtitle(string(n)+" pontos="+string(I))
   end
endfunction

function I=Simpson_38_tab(x,y,prt,plt)
   n=length(x)
   h=x(2)-x(1); //espaçamento
   w=ones(1:n);
   w(2:3:n-1)=3;
   w(3:3:n-1)=3
   w(4:3:n-1)=2
   S=y*w'
   I=(3*h/8)*S
   
   if (prt)
       printf("[x y w y*w]")
       disp([x' y' w' (y.*w)'])
       printf("h=%f\nsoma(y*w)=%f\nI=3*(%f)/8*(%f)\n",h,S,h,S)
       printf("Integal por Simpson 3/8 %4d pontos = %f\n",n,I)
   end
   if (plt)
       for i=1:3:n-3   
         ps=PolinomioVandermonde(x(i:i+3),y(i:i+3))
         N=1000
         xi=linspace(x(i),x(i+3),N);
         yi=horner(ps,xi)
         xfpoly([xi(1) xi xi(N)],[0 yi 0],modulo(i/3+13,25)+8)
         // plot2d(xi,yi,modulo(i/3+3,7)+1)
       end
       scatter(x,y) 
       xgrid()
       xtitle("Integral por Simpson 3/8 "+string(n)+" pontos="+string(I))
   end
endfunction

function I=Simpson_38(f,a,b,n,prt,plt)
    h=(b-a)/(n-1); // integral de f no intervalo [a,b]
    x=a:h:a+(n-1)*h;
    y=feval(x,f)
    I=Simpson_38_tab(x,y,prt,plt)
    
    if (prt)
        I2=intg(a,b,f);
        printf("integral exata = %f\n",I2)
        erro=abs((I2-I)/I2)*100
        printf("erro=%f%%\n",erro) 
    end
    if(plt)
        t=linspace(a,b,1000)
        plot(t,feval(t,f),'bk','LineWidth',3)
    end
endfunction

function I=Test_Simpson_38(f,a,b)
  I2=intg(a,b,f);
  printf("integral exata = %f\n",I2)
  k=0
  for (n=[4,7,10,13,16,19,22,25,28]) //n número de pontos
     k=k+1 
     subplot(3,3,k)
     t=linspace(a,b,100)
     plot(t,feval(t,f),'--r')
     I=Simpson_38(f,a,b,n,%f,%t)
     erro=abs((I2-I)/I2)*100
     printf("%4d pontos = %f  erro=%.3f%%\n",n,I,erro)
     xtitle(string(n)+" pontos="+string(I))
   end 
endfunction  

function I=Simpson_tab(x,y,prt,plt)
  n=length(x)
  if modulo(n,2)==1
    I=Simpson_13_tab(x,y,prt,plt)
  elseif   modulo(n,3)==1 then
    I=Simpson_38_tab(x,y,prt,plt)
  else
    h=x(2)-x(1); //espaçamento
    Ia=Simpson_13_tab(x(1:n-3),y(1:n-3),prt,plt) 
    Ib=Simpson_38_tab(x(n-3:n),y(n-3:n),prt,plt)// Simpson3/8 no final
    I=Ia+Ib
    if(prt)
        printf("\nSimpson 1/3 + 3/8 com %d pontos = %f\n",n,I)
        xtitle("Simpson 1/3+3/8 "+string(n)+" pontos="+string(I))
    end
  end
endfunction 

function I=Simpson(f,a,b,n,prt,plt)
    h=(b-a)/(n-1); // integral de f no intervalo [a,b]
    x=a:h:a+(n-1)*h;
    y=feval(x,f)
    I=Simpson_tab(x,y,prt,plt)
    if (prt)
        I2=intg(a,b,f);
        printf("integral exata = %f\n",I2)
        erro=abs((I2-I)/I2)*100
        printf("erro=%f%%\n",erro) 
    end
    if(plt)
        t=linspace(a,b,1000)
        plot(t,feval(t,f),'bk','LineWidth',3)
    end
endfunction  

  
function I=Test_Simpson(f,a,b)
  I2=intg(a,b,f);
  printf("integral exata = %f\n",I2)
  k=0
  for (n=[3,4,5,6,7,8,10,12,14]) //n número de pontos
     k=k+1 
     subplot(3,3,k)
     t=linspace(a,b,100)
     plot(t,feval(t,f),'--r')
     I=Simpson(f,a,b,n,%f,%t)
     erro=abs((I2-I)/I2)*100
     printf("%4d pontos = %f  erro=%.3f%%\n",n,I,erro)
     xtitle(string(n)+" pontos="+string(I))
   end 
endfunction  
