prt = %f
exec('Raizes_MetodosAbertos.sci',-1)
function [rts,delta]=BaskaraFormula(ps)
    a = coeff(ps);
    [a0, a1] = (a(1)/a(3), a(2)/a(3))
    delta=a1^2-4*a0;
    S1 = sqrt(delta)/2
    k=[1;2]
    rts= -a1/2 + S1*exp(%i*2*%pi*k/2)
endfunction

function [rts,delta]=CardanoFormula(ps)
   a=coeff(ps);
   [a0, a1, a2] = (a(1)/a(4), a(2)/a(4), a(3)/a(4))
   Q=(3*a1-a2^2)/9
   R=(9*a2*a1-27*a0-2*a2^3)/54
   delta=Q^3+R^2
   S1=(R+sqrt(delta))^(1/3)
   if (Q==0)  then  S2=0;
   else       S2=-Q/S1    end 
   k=[1;2;3]  
   rts=-a2/3+S1*exp(%i*2*%pi*k/3)+S2*exp(-%i*2*%pi*k/3)
endfunction

function [ps_out, resto, b]=fatorar_p1(ps,p_div)
    a=coeff(ps) 
    c=coeff(p_div)
    n=length(a)
    b(n)=a(n);  
    for k=n-1:-1:1
       b(k)=a(k )-c(1)*b(k+1);
    end    
    resto = b(1)
    ps_out=poly(b(2:n),'s','coeff')   
endfunction

function [ps_out, resto, b]=fatorar_p2(ps,p_div)
    a=coeff(ps) 
    c=coeff(p_div)
    n=length(a)
    b(n)=a(n);
    b(n-1)=a(n-1)-c(2)*b(n);
    for k=n-2:-1:1
        b(k)=a(k)-b(k+1)*c(2)-b(k+2)*c(1);
    end     
    resto = b(1)+b(2)*(s+c(2))
    ps_out=poly(b(3:n),'s','coeff')
endfunction   
 
 function [r1,r2,delta]=baskara(ps)
    a = coeff(ps);
    delta=a(2)^2-4*a(3)*a(1);
    r1=(-a(2) + sqrt(delta))/(2*a(3))
    r2=(-a(2) - sqrt(delta))/(2*a(3))
endfunction
 
function rts=muller_iterativo(ps,prt)  
    n=length(coeff(ps)) // polinônio ordem n-1
    while n>3  // repita enquanto ordem do polinômio for maior que 2 
          raiz=NewtonRaphson_pol(ps,0.1+%i*0.1,%f);
          rts(n-1)=clean(raiz,1e-8)
          if(abs(imag(rts(n-1))) < 1e-8 ) then
               divisor =  s-rts(n-1);
               if (prt) disp([ps, divisor, [rts(n-1)]]) end
               ps = fatorar_p1(ps, divisor)   // ps=pdiv(ps,divisor)
               n=n-1;   // diminua em 1 a ordem do polinômio
          else  // se a raiz for complexa elimine também o conjugado
              rts(n-2)=conj(rts(n-1))
              r=real(rts(n-1)),
              i=imag(rts(n-1))
              divisor = (s^2-2*r*s+r^2+i^2)
              if (prt) disp([ps, divisor, [rts(n-1) rts(n-2)]]) end
              ps = fatorar_p2(ps, divisor)  //  ps=pdiv(ps,divisor)
              n=n-2;   // diminua em 2 a ordem do polinômio
          end        
    end;
    if(n==3)   // último polinômio de ordem 1 ou 2  
        [rts(n-1),rts(n-2),delta]=baskara(ps);  
        if (prt) disp([ps, [rts(n-1) rts(n-2)],  1]) end
    else 
        a=coeff(ps) 
        rts(n-1)=-a(1)/a(2)
        if (prt)  disp([ps, [rts(n-1)]]) end
    end;
    [g,k]=gsort(real(rts),'g','i')
    rts = clean(rts(k),1e-8)
endfunction

function [ps2_out,pdiv]=encontrar_divisor_quadratico(p_in)
    u=[0.1;0.1];  // inicialização ps2_out= u(2) + u(1)*s +s^2 
    for (k=1:500)
       ps2_out=u(2)+u(1)*s + s^2 
       [pdiv, Rb, b] = fatorar_p2(p_in,ps2_out) 
       pb_in=poly(b,'s','coeff')
       [pc   , Rc, c] = fatorar_p2(pb_in,ps2_out)  
       du(1) =  ( b(1)*c(4)-c(3)*b(2) ) / (c(2)*c(4)-c(3)^2);
       du(2) =  ( c(2)*b(2)-b(1)*c(3) ) / (c(2)*c(4)-c(3)^2);
       if (norm(du)<1e-16) break end
       u=u+du
    end
endfunction

function rts=bairstow_zeros(ps,prt)    
    n=length(coeff(ps))
    p_in=ps
    while n>3 //repita enquanto ordem do polinômio > 2 
          [ps2_out,p_div]=encontrar_divisor_quadratico(p_in)
          [rts(n-1),rts(n-2),delta]=baskara(ps2_out);  
          if (prt)
              disp(p_in)  
              disp(ps2_out)
              disp(rts(n-2:n-1)')  
              printf("\n")
          end
          p_in=p_div
          n=n-2;   // diminua em 2 a ordem do polinômio
    end;
    if (prt)  disp(p_in) end
    if(n==3)  // última equação ordem 2
        [rts(n-1),rts(n-2),delta]=baskara(p_in);
        if (prt) disp(rts(n-2:n-1)') end
    else     // última equação ordem 1
         a=coeff(p_in) //linear
         rts(n-1)=-a(1)/a(2)
         if (prt) disp(rts(n-1)) end
    end;
    [g,k]=gsort(real(rts),'g','i')
    rts = clean(rts(k),1e-8)
endfunction
 
function b=fatorar_p1_coeff(a,u)
    n=length(a)   // fator=s+uZ
    b(n)=a(n);  
    for k=n-1:-1:1
       b(k)=a(k)-u*b(k+1);
    end       
endfunction

function b=fatorar_p2_coeff(a,u,v)
    n=length(a)   // fator=s^2+u*s+v
    b(n)=a(n);
    b(n-1)=a(n-1)-u*b(n);
    for k=n-2:-1:1
        b(k)=a(k)-b(k+1)*u-b(k+2)*v;
    end     
endfunction

function [p_div,p_out]=encontrar_divisor_quadratico_coeff(p_in)
    a=coeff(p_in)
    n=length(a)
    u=0.1; //  fator=s^2 +u*s +v
    v=0.1; //  chute inicial u=v=0.1
    erro=1
    while (erro > 1e-8)
         // b=[a]/[v,u,1]  resto=[b1  b2] // quociente=b(3:n)  
         b=fatorar_p2_coeff(a,u,v)    
         // c=[b]/[v,u,1]   derivadas parciais c(2),c(3) e c(4)   
         c=fatorar_p2_coeff(b,u,v) 
         A= [c(2),c(3) ; c(3),c(4)]
         y= [b(1) ; b(2)]
         
         if(norm(y)<1e-12) break end
         // dx incrementos para [u,v]
         dx=EliminacaoGauss(A,y,%f) 
         u = u + dx(1)
         v = v + dx(2)
         erro = norm(dx)
    end
    p_div=poly([clean(v,1e-10),clean(u,1e-10),1],'s','coeff')
    p_out=poly(clean(b(3:n),1e-10),'s','coeff')
 endfunction

function [p2,ordem]=FatoraTermosIrredutiveis(ps)   
     // utilizada no programa de frações parciais/ilaplace_fga
    n=length(coeff(ps))
    n_pol=1
    p(n_pol,1)=ps
    p(n_pol,2)=0;
    n_pol=n_pol+1
    p_in=ps
    while n>3  // repita enquanto ordem do polinômio for maior que 2 
          [p_div,p_out]=encontrar_divisor_quadratico_coeff(p_in)
          [rts(n-1),rts(n-2),delta]=baskara(p_div);  
          if (delta<0) then
              p(n_pol,1)=real((s-rts(n-1))*(s-rts(n-2)))
              p(n_pol,2)=-2;
              n_pol=n_pol+1
          else
              p(n_pol,1)=real((s-rts(n-1)))
              p(n_pol,2)=1;
              n_pol=n_pol+1
              p(n_pol,1)=real((s-rts(n-2)))
              p(n_pol,2)=1;
              n_pol=n_pol+1
          end
          a=coeff(p_out)
          p_in=p_out
          n=n-2;   // diminua em 2 a ordem do polinômio
    end;
    if(n==3)  //solução da última equação  
        [rts(n-1),rts(n-2),delta]=baskara(p_in);  //quadrática
         if (delta<0) then
             p(n_pol,1)=real((s-rts(n-1))*(s-rts(n-2)))
             p(n_pol,2)=-2;
        else
             p(n_pol,1)=real((s-rts(n-1)))
             p(n_pol,2)=1;
             n_pol=n_pol+1
             p(n_pol,1)=real((s-rts(n-2)))
             p(n_pol,2)=1;
        end
    else  
         a=coeff(p_in) //linear
         rts(n-1)=-a(1)/a(2)
         p(n_pol,1)=real((s-rts(n-1)))
         p(n_pol,2)=1;
    end;
    
    for(i=2:n_pol)   // se a fase for pequena, trate como real
       if (p(i,2)==-2)
            r=roots(p(i,1))
            if( atan( abs(imag(r(1))) / abs(real(r(1)))) < 1e-4 ) then
                p(i,1)=(s-sign(real(r(1)))*abs(r(1)))
                p(i,2)=1
                n_pol=n_pol+1
                p(n_pol,1)=(s-sign(real(r(1)))*abs(r(1)))
                p(n_pol,2)=1
            end
        end
     end
          
    for(i=2:n_pol) // raizes reais parecidas são tratatas com multiplas
        for(j=i+1:n_pol)
             if ( p(i,2)<>-2 & p(j,2)<>-2) then
                 r1=roots(p(i,1));
                 r2=roots(p(j,1));
                 if( abs(r1(1)-r2(1))<1e-4) then
                    r = (real(r1(1))+real(r2(1)))/2
                    p(min(i,j),1)=(s-r);
                    p(min(i,j),2)=p(i,2)+p(j,2)
                    p(max(i,j),1)=1;
                    p(max(i,j),2)=0
                 end  
             end
        end
    end
    k=1
    for(i=2:n_pol) // reorganiza o array de saída retirando os eliminados
        if (p(i,2)<>0) then
            p2(k)=p(i,1)
            ordem(k)=p(i,2)
            k=k+1
        end
    end
endfunction

