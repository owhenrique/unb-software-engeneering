prt = %t
plt = %t
exec('Polinomio_Interpolacao.sci',-1)
exec('AL_EliminacaoGauss.sci',-1)
function I=Trapezios_tab(x,y,prt,plt)
   n=length(x)   //função tabular (xi,yi)
   h=x(2)-x(1); //espaçamento
   w=ones(1:n);
   w(2:n-1)=2;
   S=y*w';
   I=(h/2)*S
   
   if (prt)
       printf("[x y w y*w]")
       disp([x' y' w' (y.*w)'])
       printf("h=%f\nsoma(y*w)=%f\nI=(%f)/2*(%f)\n",h,S,h,S)
       printf("Integal por Trapézios %4d pontos = %f\n",n,I)
    end
    if (plt)   
       for i=1:n-1   
         ps=PolinomioVandermonde(x(i:i+1),y(i:i+1))
         N=1000
         xi=linspace(x(i),x(i+1),N);
         yi=horner(ps,xi)
         xfpoly([xi(1) xi xi(N)],[0 yi 0],modulo(i+5,25)+8)
       //  plot2d(xi,yi,modulo(i+5,25)+8)
       end
       scatter(x,y) 
       xgrid()
       xtitle("Integral por Trapézios "+string(n)+" pontos="+string(I))
   end
endfunction

function I=Trapezios(f,a,b,n,prt,plt)
    h=(b-a)/(n-1); // integral de f no intervalo [a,b]
    x=a:h:a+(n-1)*h;
    y=feval(x,f)
    I=Trapezios_tab(x,y,prt,plt)
    
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

function Test_Trapezios(f,a,b)
  I2=intg(a,b,f);
  printf("integral exata = %f\n",I2)
  k=0
  for (n=[2,3,4,5,7,9,15,20,50]) //n número de pontos
     k=k+1 
     subplot(3,3,k)
     t=linspace(a,b,100)
     plot(t,feval(t,f),'--r')
     I=Trapezios(f,a,b,n,%f,%t)
     erro=abs((I2-I)/I2)*100
     printf("%4d pontos = %f  erro=%.3f%%\n",n,I,erro)
     xtitle(string(n)+" pontos="+string(I))
   end
endfunction
