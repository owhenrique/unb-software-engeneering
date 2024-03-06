prt=%f
//exec('Raizes_MetodosIntervalares.sci',-1)
function x1=NewtonRaphson(f,df,x0,tol,prt)
    erro = 1;
    if (prt) 
        if(imag(x0)<>0)   printf ( '%i\t%.10f+%.10fi\t%.1e\n',1,real(x0),imag(x0),erro) 
        else              printf ( '%i\t%.10f\t%.1e\n',1,x0,erro)  end
    end
    for (k=2:500)
       f0=f(x0)
       df0=df(x0)
       if (f0==0) x1=x0; 
       else       x1 = x0 - f0/df0   end
       if (x1<>0) erro =abs((x1-x0)/x1) end
       if (prt) 
           if(imag(x1)<>0)   printf ('%i\t%.10f+%.10fi\t%.1e\n',k,real(x1),imag(x1),erro) 
            else             printf ( '%i\t%.10f\t%.1e\n',k,x0,erro)   end
       end
       if  erro<tol  break   end
       x0=x1
    end
endfunction

function x1=NewtonRaphson_p(f,df,x0,tol,p,prt)
    erro = 1;
    if (prt) 
        if(imag(x0)<>0)   printf ( '%i\t%.10f+%.10fi\t%.1e\n',1,real(x0),imag(x0),erro) 
        else              printf ( '%i\t%.10f\t%.1e\n',1,x0,erro)  end
    end
    for (k=2:50)
       f0=f(x0)
       df0=df(x0)
       if (f0==0) x1=x0; 
       else       x1 = x0 - p*f0/df0   end
       if(x1<>0)  erro =abs((x1-x0)/x1)  end
       if (prt) 
           if(imag(x1)<>0)   printf ('%i\t%.10f+%.10fi\t%.1e\n',k,real(x1),imag(x1),erro) 
            else             printf ( '%i\t%.10f\t%.1e\n',k,x0,erro)   end
       end
       if  erro<tol  break   end
       x0=x1
    end
endfunction

function x1=NewtonRaphson_pol(ps,x0,prt)
   erro = 1;
    if (prt) 
        if(imag(x0)<>0)   printf ( '%i\t%.10f+%.10fi\t%.1e\n',1,real(x0),imag(x0),erro) 
        else              printf ( '%i\t%.10f\t%.1e\n',1,x0,erro)  end
    end
   for (k=2:500)
      f0=horner(ps,x0)
      df0=horner(derivat_fga(ps),x0)
      if (f0==0) x1=x0; 
      else       x1=x0-f0/df0   end
      if (x1<>0) erro =abs((x1-x0)/x1) end
       if (prt) 
           if(imag(x1)<>0)   printf ('%i\t%.10f+%.10fi\t%.1e\n',k,real(x1),imag(x1),erro) 
            else             printf ( '%i\t%.10f\t%.1e\n',k,x0,erro)   end
       end
      if  erro<1e-16  break   end
      x0=x1
   end
   x1=clean(x1,1e-10)
endfunction

function dps=derivat_fga(ps)
    a = coeff(ps)
    N=length(a)
    b= a(2:N).*[1:N-1]
    dps=poly(b,"s","coeff" )
endfunction

function dps=derivat_fga2(ps)
    a = coeff(ps)
    exp0=0:length(a)-1
    exp1=[0,0:length(a)-2]
    dps=sum(a.*exp0 .* s.^exp1) 
endfunction

function x1=Secante(f,x1,x2,tol,prt)
    erro = 1;
    if (prt) 
        printf ( '%i\t%.10f\t%.1e\n',1,x1,erro)
        printf ( '%i\t%.10f\t%.1e\n',1,x2,erro) 
    end
    for(k=2:500)
        x0=x1;
        x1=x2;    
        f0=f(x0)
        f1=f(x1)
        df_x1 = (f1-f0)/(x1-x0);
        x2 = x1 - f(x1)/df_x1;
        if(x2<>0) erro =abs((x2-x1)/x2)  end
        if (prt) 
            printf ( '%i\t%.10f\t%.1e\n',k,x2,erro) 
        end
        if  erro<tol  break  end
    end
endfunction

function x1=SecanteModificado(f,x0,tol,prt)
    erro = 1;
    dx=1e-8;
    if (prt) 
        if(imag(x0)<>0)   printf ( '%i\t%.10f+%.10fi\t%.1e\n',1,real(x0),imag(x0),erro) 
        else              printf ( '%i\t%.10f\t%.1e\n',1,x0,erro)  end
    end
    for (k=2:500)
       f0=f(x0)
       f1=f(x0+dx)
       df0=(f1-f0) /dx  // Secante Modificado
       x1 = x0 - f0/df0
       if(x1<>0)  erro =abs((x1-x0)/x1)  end
       if (prt) 
           if(imag(x1)<>0)   printf ('%i\t%.10f+%.10fi\t%.1e\n',k,real(x1),imag(x1),erro) 
            else             printf ( '%i\t%.10f\t%.1e\n',k,x0,erro)   end
       end
       if  erro<tol  break end
       x0=x1
    end
endfunction

function x1=SecanteModificado_pol(ps,x0)
    dx=1e-8;
    for (k=1:500)
       y0=horner(ps,x0)
       y1=horner(ps,x0+dx)
       dy0=(y1-y0) /dx  // Secante Modificado
       x1 = x0 - y0/dy0
       if  (abs(xr-x0)<1e-16) break end
       x0=x1
    end
endfunction

function x1=PontoFixo_n(f,x0,N,prt)
    deff ('y=g(x)','y=f(x)+x')   
    erro = 1;
    if (prt) 
        printf ( '%i\t%.10f\t%.1e\n',0,x0,erro) 
    end
    for (k=1:N)
        x1 = g(x0);
        if(x1<>0)   erro =abs((x1-x0)/x1)  end
        if (prt) 
            printf ( '%i\t%.10f\t%.1e\n',k,x1,erro)
        end
       // if  erro<tol break  end
        x0=x1
    end
endfunction


function x1=PontoFixo(f,x0,tol,prt)
    deff ('y=g(x)','y=f(x)+x')   
    erro = 1;
    if (prt) 
        printf ( '%i\t%.10f\t%.1e\n',0,x0,erro) 
    end
    for (k=1:500)
        x1 = g(x0);
        if(x1<>0)   erro =abs((x1-x0)/x1)  end
        if (prt) 
            printf ( '%i\t%.10f\t%.1e\n',k,x1,erro)
        end
        if  erro<tol break  end
        x0=x1
    end
endfunction


function x1=PontoFixo_pol(ps,x0,tol,prt)
    deff ('y=g(x)','y=horner(ps,x)+x')   
    erro = 1;
    if (prt) 
        printf ( '%i\t%.10f\t%.1e\n',0,x0,erro) 
    end
    for (k=1:500)
        x1 = g(x0);
        if(x1<>0)   erro =abs((x1-x0)/x1)  end
        if (prt) 
            printf ( '%i\t%.10f\t%.1e\n',k,x1,erro)
        end
        if  erro<tol break  end
        x0=x1
    end
endfunction
