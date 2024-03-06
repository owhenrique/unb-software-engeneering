prt = %f

function x1=Bissecao_abs(f,a,b,tol,prt) //erro absoluto
    if (f(a)*f(b)>0) then
       printf("não há raiz no intervalo [%f,%f]]\n",a,b)
       x1=[]
       return
    end
    if (prt) 
        printf ('i \ta\t\t\tx1\t\t\tb\t\t\terro\n') 
    end
    for (k=1:200)   
        erro=abs(b-a)
        x1=(a+b)/2     // Bisseção
        if (prt) 
            printf ("%d\t%.10f(%2d)\t%.10f(%2d)\t%.10f(%2d)\t%.1e\n",...
            k,a,sign(f(a)),x1,sign(f(x1)),b,sign(f(b)),erro) 
        end
        if  ( (erro<tol) | (f(x1)==0) )  break  end
        if     f(x1)*f(a)<0  b=x1
        else   a=x1          end   
    end
endfunction

function x1=Bissecao_n(f,a,b,tol,prt) //número de iterações
    if (f(a)*f(b)>0) then
       printf("não há raiz no intervalo [%f,%f]]\n",a,b)
       x1=[]
       return
    end
    n=ceil(log2((b-a)/tol))+1
    if (prt) 
        printf("Previsão de %d iterações\n",n) 
        printf ('i \ta\t\t\tx1\t\t\tb\t\t\terro\n')
    end
    for (k=1:n)
        x1=(a+b)/2    // Bisseção
        if (prt) 
            printf ("%d\t%.10f(%2d)\t%.10f(%2d)\t%.10f(%2d)\t%.1e\n",...
            k,a,sign(f(a)),x1,sign(f(x1)),b,sign(f(b)),abs(b-a)) 
        end
        if  ( f(x1)==0 )  break  end
        if     f(x1)*f(a)<0  b=x1
        else   a=x1          end   
    end
endfunction

function x1=Bissecao(f,a,b,tol,prt) //erro relativo
    if (f(a)*f(b)>0) then
       printf("não há raiz no intervalo [%f,%f]]\n",a,b)
       x1=[]
       return
    end
    if (prt) 
        printf ('i \ta\t\t\tx1\t\t\tb\t\t\terro\n') 
    end
    x1=a;
    erro=  1;
    for (k=1:200)
        x0=x1
        x1=(a+b)/2     // Bisseção
        if(x1<>0)  erro =abs((x1-x0)/x1)  end
        if (prt) 
            printf ( '%i\t%.10f(%2d)\t%.10f(%2d)\t%.10f(%2d)\t%.1e\n',k,...
            a,sign(f(a)),x1,sign(f(x1)),b,sign(f(b)),erro) 
        end
        if  ( (erro<tol) | (f(x1)==0) )  break  end
        if     f(x1)*f(a)<0  b=x1
        else   a=x1          end   
    end
endfunction

function x1=FalsaPosicao(f,a,b,tol,prt)
    if (f(a)*f(b)>0) then
       printf("não há raiz no intervalo [%f,%f]]\n",a,b)
       x1=[]
       return
    end
    if (prt) 
        printf ('i \ta\t\t\tx1\t\t\tb\t\t\terro\n')
    end
    x1=a;
    erro=  1;
    for (k=1:500)
        x0=x1
        x1=(a*f(b)-b*f(a))/(f(b)-f(a)) //Falsa Posição (Bisseção x1=(a+b)/2)
        if(x1<>0)  erro =abs((x1-x0)/x1)  end
        if (prt) 
            printf ( '%i\t%.10f(%2d)\t%.10f(%2d)\t%.10f(%2d)\t%.1e\n',...
            k,a,sign(f(a)),x1,sign(f(x1)),b,sign(f(b)),erro) 
        end
        if  ( (erro<tol) | (f(x1)==0) )  break  end
        if     f(x1)*f(a)<0  b=x1
        else   a=x1          end 
    end
endfunction

function x1=FalsaPosicaoModificado(f,a,b,tol,prt)
    if (f(a)*f(b)>0) then
       printf("não há raiz no intervalo [%f,%f]]\n",a,b)
       x1=[]
       return
    end
    if (prt) 
        printf ('i \ta\t\t\tx1\t\t\tb\t\t\terro\n') 
    end
    x1=a; 
    fa = f(a);
    fb = f(b); 
    na=0; 
    nb=0; 
    for(k=1:500)
        x0=x1;
        x1=(a*fb-b*fa)/(fb-fa) // falsa posição modificado
        fx1 = f(x1)
        if(x1<>0)  erro =abs((x1-x0)/x1)  end
        if (prt) 
            printf ( '%i\t%.10f(%2d)\t%.10f(%2d)\t%.10f(%2d)\t%.1e\n',...
            k,a,sign(f(a)),x1,sign(f(x1)),b,sign(f(b)),erro) 
        end
        if  ( (erro<tol) | (f(x1)==0) )  break  end
        if fx1*fa < 0 then
            b=x1
            fb = fx1;
            nb=0;
            na=na+1
            if (na>=2)  fa = fa/2;  end
        else
            a=x1;
            fa = fx1;
            na=0;
            nb=nb+1
            if (nb>=2)  fb = fb/2;   end;
        end
    end
endfunction

function testMultissecao(f,a,b)
    for(i=3:700)
        for(j=1:60)
             tic();Multissecao(f,a,b,i,%f);x1(j)=toc();
        end
        y1(i)=median(x1)
        tic();Bissecao(f,a,b,i,%f);y0(i)=toc();
    end;
    disp(median(y0))
    plot(y1)
endfunction

//N=500
function xr=Multissecao(f,a,b,N,prt)
  if (f(a)*f(b)>0) then
     printf("não há raiz no intervalo [%f,%f]]\n",a,b)
     x1=[]
     return
  end
  for (k=1:100)
     x=linspace(a,b,N)
     [f_min,index]=min(abs(feval(x,f)))
     erro=(x(2)-x(1))/2
     if (prt)
        printf ('%i\t%.10f(%2d)\t%.10f(%2d)\t%.10f(%2d)\t%.1e\n',...
        k,a,sign(f(x(1))),x(index),sign(f_min),b,sign(f(x(N))),erro)
     end
     if(erro<=%eps)|(abs(f_min)==0) break; end;
     a=x(index)-erro
     b=x(index)+erro
  end
  xr=x(index)
endfunction
