function x1=raizQuadrada(x1,a)
    for n=1:500
        x0=x1
        x1 = (x0 +a/x0)/2
        disp([x0 x1])
        erro = abs((x1-x0)/x1)
        if (erro<1e-18) break; end; 
    end
    printf("raiz de %d após %i iterações = %f",a,n,x1)
endfunction

function y = dado_k_lados(k,N)
    y=int(modulo(1000*rand(1:N),k)+1);
endfunction

function taylor_expx(x,N)
    y=1;
    printf("n \t  erro \t\t aprox.\n")
    for(n=1:N)
        y = y + 1/factorial(n)*x^n
        erro =  abs(y-exp(1))/exp(1)
        printf("%i \t  %.2e \t %.8f\n",n,erro,y)
        if (erro<1e-7) break end
    end
    printf("%d iteração erro %.2e neper~=%.8f\n",n,erro,y)
endfunction

function taylor_lnx(x,N)
    y=0;
    printf("n \t  erro \t\t aprox.\n")
    for(n=1:N)
        y = y +(-1)^(n+1) * 1/n*x^n
        erro =  abs(y-log(1+x))/abs(log(1+x))
        printf("%i \t  %.2e \t %.8f\n",n,erro,y)
        if (erro<1e-4) break end
    end
    printf("%d iteração erro %.2e log(%f)~=%.8f\n",n,erro,1+x,y)
endfunction


function y=erf_fga(x)
    t=1./(1+0.5*abs(x))
    y = sign(x).*(1-t.*exp(-x.^2-1.26551223+1.00002368*t+0.37409196*t.^2+0.09678418*t.^3-0.18628806*t^4...
              +0.27886807*t.^5-1.13520398*t^6+1.48851587*t.^7-0.82215223*t^8+0.17087277*t.^9))
endfunction

function PI=CálculoPI(n)
    a1 = sqrt(2)
    b1=0
    PI=2+sqrt(2)
    for (i=1:n)
        disp(PI)
        a2=(sqrt(a1)+1/sqrt(a1))/2
        b2=((1+b1)*sqrt(a1))/(a1+b1)
        PI=(1+a2)*PI*b2/(1+b2)
        a1=a2
        b1=b2
    end
    disp([i+1,PI])
endfunction

function  v=randperm(n,k)
    v_inter = grand(1, "prm", (1:n))
    v = v_inter(1:k)
end

erro_frac = 1e-16
prt=%f
function x_frac=dec2frac(x, erro_frac,prt)
  iri(1)=floor(x)
  resto(1)=x-iri(1)
  num(1)=iri(1)
  den(1)=1
  x_frac=[num(1),den(1)]
  if(prt)
    printf("%d/%d \t e=%0.e\n",x_frac(1),x_frac(2),abs(x-x_frac(1)/x_frac(2)))
  end
  if resto(1)<>0 then
    iri(2)=floor(1.0/resto(1))
    resto(2)=1.0/resto(1)-iri(2)
    num(2)=iri(2)*num(1)+1
    den(2)=iri(2)*den(1)
    x_frac=[num(2),den(2)]
    if(prt)
        printf("%d/%d \t e=%0.e\n",x_frac(1),x_frac(2),abs(x-x_frac(1)/x_frac(2)))
    end
    if ( (resto(2)<>0) & (abs(x-num(2)/den(2)) > erro_frac ) )then
      for n=3:25
         iri(n)=floor(1.0/resto(n-1))
         resto(n)=1.0/resto(n-1)-iri(n)
         num(n)=iri(n)*num(n-1)+num(n-2)
         den(n)=iri(n)*den(n-1)+den(n-2)
         x_frac=[num(n),den(n)]
         if(prt)
            printf("%d/%d \t e=%0.e\n",x_frac(1),x_frac(2),abs(x-x_frac(1)/x_frac(2)))
        end 
        if (resto(n)==0)|(abs(x-num(n)/den(n)) < erro_frac)
            break;
        end
      end
    end
  end
endfunction

pi="3.141592653589793238462643383279502884197"
e ="2.718281828459045235360287471352662497757"
function dec2frac_dd(x_str,n)
  x=str2dd(x_str)
  xf=getHi(x);
  iri_old=dd(floor(xf));
  resto_old=x-iri_old;
  num_old=iri_old;
  den_old=1;
  if resto_old<>0 then
    temp = getHi(1.0/resto_old);  
    iri=dd(floor(temp));
    resto=1.0/resto_old-iri;
    num=iri*num_old+1;
    den=iri*den_old;
    if resto<>0 then
      for i=1:100
         temp = getHi(1.0/resto) ; 
         iri_new=dd(floor(temp));
         resto_new=1.0/resto-iri_new;
         num_new=iri_new*num+num_old;
         den_new=iri_new*den+den_old;
         delta = x-num_new/den_new;
         if (resto_new==0)|(log10(getHi(den))>n | delta==0)
             break;
         end
         printf("%d -> %.0lf / %.0lf (%.1e)\n\n",i,getHi(num),getHi(den),getHi(delta))
         num_old=num
         den_old=den
         iri_old=iri
         resto_old=resto
         num=num_new
         den=den_new
         iri=iri_new
         resto=resto_new
      end
    end,
  end
  disp(num_new/den_new)
endfunction

