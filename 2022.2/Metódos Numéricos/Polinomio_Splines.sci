prt = %f
exec('AL_EliminacaoGauss.sci',-1)
 function [ps,A,b]=SplineLinear(x,y) 
     s=poly(0,'s');
     N=length(x)-1 // # de intervalos 
     b   =   zeros(2*N,1);
     A   =   zeros(2*N,2*N);
     index=1; //x(index),y(index)
     col=1;  // A(lin,col)
     for lin=1:2:2*N-1 //2N equações: funções passam por (xi,yi))
        A(lin:lin+1,col:col+1)= [[x(index)   1];
                                 [x(index+1) 1]]  
        b(lin:lin+1)=  [y(index);
                        y(index+1)] ;
        index=index+1;
        col=col+2;
     end
     coef=tridiagonal(diag(A,-1),diag(A),diag(A,1),b)
     for (i=1:N)
        ps(i) = poly([coef(2*i),coef(2*i-1)],"s","coeff")
     end
 endfunction
 
 function [ps,A,b]=SplineQuadratica(x,y) 
     s=poly(0,'s');
     N=length(x)-1  // # de intervalos 
     b   =   zeros(3*N,1);
     A   =   zeros(3*N,3*N);
     index=1; //x(index),y(index)
     col=1; // A(lin,col)
     A(1,1)=1; // 1a equação a1=0 
     for lin=2:2:2*N   //2N equações: funções passam por (xi,yi))
        A(lin:lin+1,col:col+2)= [[x(index)^2   x(index)   1];
                                 [x(index+1)^2 x(index+1) 1]]  
        b(lin:lin+1)=  [y(index);
                        y(index+1)] ;
        index=index+1;
        col=col+3;
     end
     col=1;
     index=2;
     for lin=2*N+2:3*N //N-1 equações-1a derivadas pontos internos
        A(lin,col:col+5)=   [2*x(index) 1 0 -2*x(index) -1 0];
        index=index+1;
        col=col+3;
     end
     coef=EliminacaoGaussJordan(A,b)
     for (i=1:N)
        ps(i) = poly([coef(3*i),coef(3*i-1),coef(3*i-2)],"s","coeff")
     end
 endfunction
 
 
 function [ps,A,b]=SplineCubica(x,y) 
     s=poly(0,'s');
     N=length(x)-1  // # de intervalos 
     b   =   zeros(4*N,1);
     A   =   zeros(4*N,4*N);
     index=1; //x(index),y(index)
     col=1;
     for lin=1:2:2*N-1    //2N equações: funções passam por (xi,yi))
        A(lin:lin+1,col:col+3)= [[x(index)^3   x(index)^2   x(index)   1];
                                 [x(index+1)^3 x(index+1)^2 x(index+1) 1]]  
        b(lin:lin+1)=  [y(index);
                        y(index+1)] ;
        index=index+1;
        col=col+4;
     end
     col=1;
     index=2;
     for lin=2*N+1:3*N-1   // N-1 equações - 1a derivadas pontos internos 
        A(lin,col:col+7)=[3*x(index)^2  2*x(index) 1 0 -3*x(index)^2 -2*x(index) -1 0];
        index=index+1;
        col=col+4;
     end
     col=1;
     index=1;
     A(3*N,col:col+3)=   [6*x(index)   2  0 0]; //2a derivada ponto externo 
     index=index+1;
     for lin=3*N+1:4*N-1   // N-1 equações - 2a derivadas pontos internos 
        A(lin,col:col+7)=   [6*x(index)   2  0 0 -6*x(index) -2 0 0];
        index=index+1;
        col=col+4;
     end
     A(4*N,col:col+3)=   [6*x(index)   2  0 0];//2a derivada ponto externo 
     coef=EliminacaoGaussJordan(A,b)
     for (i=1:N)
         ps(i) = poly([coef(4*i),coef(4*i-1),coef(4*i-2),coef(4*i-3)],"s","coeff")
     end
 endfunction
 
  
 function Plot_Spline(x,y,tipo)
      if     (tipo==1) then
            [ps,A,b]=SplineLinear(x,y);
      elseif (tipo==2)  then 
             [ps,A,b]=SplineQuadratica(x,y);
      else   
             [ps,A,b]=SplineCubica(x,y); 
      end;
      printf("Matriz Aumentada [A|b]")
      disp([A b]) // coef = inv(A)*b
      disp(ps)
      N=length(ps)
      range=max(x)-min(x)
      for(i=1:N)
          t=linspace(x(i),x(i+1),50);
          plot2d(t,horner(ps(i),t),modulo(i,3)+1)
      end
      gca().data_bounds=[min(x)-range/10,min(y)-range/10;...
      max(x)+range/10,max(y)+range/10]
      scatter(x,y)
      xtitle("Interpolação Splines "+string(N)+" intervalos");   
 endfunction
 
  
function yp=InterSpline(xp,x,ps)
   for (i=1:length(xp))
      index=max(find(x<xp(i)))
      if(index==[] | index>length(ps)) then
          yp(i)=%nan
      else
          yp(i)=horner(ps(index),xp(i))
      end
   end  
endfunction
  
function [ps,a,b,c,d,dl,dp,du,r]=SplineNatural(x,y)
    s=poly(0,'s');
    N=length(x)-1 // # de intervalos
    h  =diff(x);
    dy =diff(y)./h;
    dl=h(2:N-1);
    dp=[2*(h(1:N-1)+h(2:N))];
    du=h(2:N-1);
    r=[3*(dy(2:N)-dy(1:N-1))];
    c = [0 tridiagonal(dl,dp,du,r) 0];
    a=y;
    for (i=1:N)
        b(i) = dy(i) - 1/3*h(i).*(2*c(i)+c(i+1));
        d(i) = (c(i+1)-c(i))./(3*h(i));
        ps(i,1) = poly([a(i),b(i),c(i),d(i)],"s","coeff")
    end
 endfunction

 function Plot_SplineNatural(x,y)
    [ps,a,b,c,d,dl,dp,du,r]=SplineNatural(x,y)
    N=length(x)-1 // # de intervalos
    printf("[x h y dy r]");
    disp([x',[diff(x) %nan]',y',[diff(y)./diff(x) %nan]',[%nan r %nan ]',[%nan dp %nan]' ]);
    printf("Sistema Tridiagonal [dl dp du | r = c]");
    disp([diag(dp)+diag(du,1)+diag(dl,-1) r' c(2:N)']);
    printf("Matriz de Soluções [a b c d]");
    disp([a(1:N)',b,c(1:N)',d])
    printf("Splines Cúbicas");
    disp(ps)
    for(i=1:N)
        t=linspace(x(i),x(i+1),500);
        plot2d(t,horner(ps(i),t-x(i)),modulo(i,3)+1)
    end
    scatter(x,y);
    xtitle("Interpolação Splines "+string(N)+" intervalos");   
 endfunction

 function ps=SplineClamped(x,y,dx0,dxn)
    //Entrada lista de pontos (x,y)
    //- dx0 = derivada no ponto x0
    //- dxn = derivada no ponot xn
     s=poly(0,'s');
     Ni=length(x)-1;
     dx=diff(x);
     dy=diff(y);
     df=dy./dx;
     e=dx(2:Ni-1);
     h=2*(dx(1:Ni-1)+dx(2:Ni));
     g=dx(2:Ni);
     r=6*diff(df);
     //derivada nos pontos extremos
      h(1)=h(1)-dx(1)/2;
      r(1)=r(1)-3*(df(1)-dx0);
      h(Ni-1)=h(Ni-1)-dx(Ni)/2;
      r(Ni-1)=r(Ni-1)-3*(dxn-df(Ni));
      for k=2:Ni-1
          temp=e(k-1)/h(k-1);
          h(k)=h(k)-temp*g(k-1);
          r(k)=r(k)-temp*r(k-1);
      end
      df2(Ni)=r(Ni-1)/h(Ni-1);
      for k=Ni-2:-1:1
          df2(k+1)=(r(k)-g(k)*df2(k+2))/h(k);
      end
      df2(1)=3*(df(1)-dx0)/dx(1)-df2(2)/2;
      df2(Ni+1)=3*(dxn-df(Ni))/dx(Ni)-df2(Ni)/2;
      for k=1:Ni
          a= y(k);
          b= df(k)-dx(k)*(2*df2(k)+df2(k+1))/6;
          c= df2(k)/2;
          d= (df2(k+1)-df2(k))/(6*dx(k));
          ps(k)=poly([a,b,c,d],'s','coeff')
          ps(k)=horner(ps(k),(s-x(k)))
          disp(ps)
      end
        //plotar resultados
      range=max(x)-min(x)
      wnd=gca()
      for(k=1:Ni)
          t=[x(k):range/100:x(k+1)];
          plot2d(t,horner(ps(k),t),modulo(k,5))
      end
      wnd.data_bounds=[min(x)-range/10,min(y)-range/10;max(x)+range/10,max(y)+range/10]
      scatter(x,y)
      xtitle("Interpolação Splines "+string(Ni)+" intervalos");     
 endfunction 


