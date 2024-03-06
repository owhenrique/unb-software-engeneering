prt = %t
plt = %t

function ps1=polyint_fga(ps)
    a = coeff(ps)
    N=length(a)
    ps1=poly([0 a./[1:N]],"s","coeff")
endfunction

function I=Integral_pol(f,a,b,n,prt,plt)
    x=linspace(a,b,n)
    y=feval(x,f)
    pv=PolinomioVandermonde(x,y)
    pv_i = polyint_fga(pv);
    I = horner(pv_i,x(n))-horner(pv_i,x(1))
    if (prt)
         printf("Polinônio ajustado p(x)=")
         disp(pv)
         printf("Integral analítica P(x)")
         disp(pv_i)
         printf("Integral Definida=P(%f)-P(%f)=%f\n",x(n),x(1),I);
    end
    if(plt)
        N=1000
        xi=linspace(x(1),x(n),N)
        yi=horner(pv,xi)
        plot(xi,yi,'bk')
        xfpoly([xi(1) xi xi(N)],[0 yi 0],7)
        scatter(x,y)
        str=sprintf("Integral Polinômio %4d pontos = %lf\n",n,I)
        xtitle(str)
        legend("polinomio ajustado","Integral Aproximada","pontos de controle",4)
    end
endfunction

exec('Polinomio_Interpolacao.sci',-1)
nc_w=[
[1,     0,      0,     0,      0,      0,      0,      0,      0,     0,      0    ], 
[1,     1,      0,     0,      0,      0,      0,      0,      0,     0,      0    ],
[1,     4,      1,     0,      0,      0,      0,      0,      0,     0,      0    ], 
[1,     3,      3,     1,      0,      0,      0,      0,      0,     0,      0    ], 
[7,     32,     12,    32,     7,      0,      0,      0,      0,     0,      0    ],
[19,    75,     50,    50,     75,     19,     0,      0,      0,     0,      0    ],
[41,    216,    27,    272,    27,     216,    41,     0,      0,     0,      0    ], 
[751,   3577,   1323,  2989,   2989,   1323,   3577,   751,    0,     0,      0    ],  
[989,   5888,  -928,   10496, -4540,   10496, -928,    5888,   989,   0,      0    ],
[2857,  15741,  1080,  19344,  5778,   5778,   19344,  1080,   15741, 2857,   0    ]]

nc_a_num=[1,1,1,3, 2,  5,  1,    7,    4,    9,      5]
nc_a_den=[1,2,3,8,45,288,140,17280,14175,89600, 299376]

function [num,den,w] = nc_coeff(N)
   n = 0:N-1;
   for(k=1:N)
     A(k,:)=(n.^(k-1))
   end
   if (N==1) b=1
   else      b(n+1)=(N-1)^(n+1)./(n+1); end
   wf = EliminacaoGauss(A,b',%f)
   for i=1:N    w1(i,:)=dec2frac(wf(i),1e-10,%f)  end
   for i=1:N
     w1(i,1)=int(w1(i,1)*max(w1(:,2))/w1(i,2))
     num=gcd(w1(:,1))
     w(i)=int(w1(i,1))/num
     den=max(w1(:,2))
   end
end

function [num,den,w] = nc_tabela(Nc)
    w = zeros(Nc,Nc)
    for (N=1:Nc)
        [num(1,N),den(1,N),w(N,1:N)] = nc_coeff(N)
    end
endfunction

function I=NewtonCotes_tab(x,y,prt,plt)
    n=length(x)
    h=x(2)-x(1); //espaçamento
    w=nc_w(n,1:n)
    alpha=nc_a_num(n)/nc_a_den(n)
    I=h*alpha*(y*w')
    str=sprintf("Newton-Cotes %4d pontos   = %f\n",n,I)
    if(prt)
        printf("[x y w y*w]")
        disp([x' y' w' y'.*w'])
        printf("I=h * alpha * (y*w'')\n")
        printf("I=(%.2f)*(%d/%d)*(%.2f)=%f\n",h,nc_a_num(n),nc_a_den(n),y*w',I)
        printf("%s\n",str)
     end
     if(plt)
        xtitle(str)
        t=linspace(x(1),x(n),200)
        scatter(x,y)
        pv=PolinomioVandermonde(x,y)
        plot(t,horner(pv,t),'r')
        legend("pontos de controle","polinômio",4)
     end
endfunction

function I=NewtonCotes_tab2(x,y,prt,plt)
    n=length(x)
    h=x(2)-x(1); //espaçamento
    [num,den,w] = nc_coeff(n)
    alpha = num/den
    I=h*alpha*(y*w)
    str=sprintf("Newton-Cotes %4d pontos   = %f\n",n,I)
    if(prt)
        printf("[x y w y*w]")
        disp([x' y' w y'.*w])
        printf("I=h * alpha * (y*w'')\n")
        printf("I=(%.2f)*(%d/%d)*(%.2f)=%f\n",h,num,den,y*w,I)
        printf("%s\n",str)
     end
     if(plt)
        xtitle(str)
        t=linspace(x(1),x(n),200)
        scatter(x,y)
        pv=PolinomioVandermonde(x,y)
        plot(t,horner(pv,t),'r')
        legend("pontos de controle","polinômio",4)
     end
endfunction

function I=NewtonCotes_f(f,a,b,n,prt,plt)
    x=linspace(a,b,n)
    y=feval(x,f)
    I=NewtonCotes_tab2(x,y,prt,plt)
    I_exata=intg(a,b,f)
    erro = abs(I-I_exata)/I_exata*100;
    str=sprintf("Newton-Cotes %4d pontos = %lf erro=%.3f%%\n",n,I,erro)
    if (prt)
         printf("Integral Exata=%f erro=%.3f%%\n",I_exata,erro)
    end
    if (plt) then
       xtitle(str)
       t=linspace(a,b,200)
       plot(t,f,'--b')  
       legend("pontos de controle","função","polinômio",4)
    end
endfunction   

function Test_NewtonCotes(f,a,b)
  I_exata=intg(a,b,f)
  printf("Integral Exata = %f\n",I_exata)
  n=[3,4,5,6,7,8,9,10,20]
  for (k=1:9)
    subplot(3,3,k)
    I=NewtonCotes_f(f,a,b,n(k),%t,%t)
    erro = abs(I-I_exata)/I_exata*100;
  end
endfunction

nca_coeff=[
[ 0,  1,  1,    0,    0,   0,   0,  0,  0];
[ 0,  2, -1,    2,    0,   0,   0,  0,  0];
[ 0, 11,  1,    1,   11,   0,   0,  0,  0];
[ 0, 11, -14,  26,  -14,  11,   0,  0,  0];
[ 0,611,-453, 562,  562,-453, 611,  0,  0];
[ 0,460,-954,2196,-2459,2196,-954,  460,0]];

nca_alpha=[3/2,4/3,5/24,6/20,7/1440,8/945];

function I=NewtonCotesAberto_tab(f,a,b,n,prt,plt)
    h=(b-a)/(n+2-1),
    x=a+h:h:a+n*h
    y=feval(x,f)
    w=nca_coeff(n-1,2:n+1)
    alpha=nca_alpha(n-1)
    I=h*alpha*(y*w')
    I_exata=intg(a,b,f);
    erro = abs(I-I_exata)/I_exata*100;
    str=sprintf("Newton-Cotes Aberto %4d(+2) pontos = %f erro=%.3e%%\n",n,I,erro)
    if (prt)
        printf("[x y w y*w]")
        disp([[a x b]' [f(a) y f(b)]' [0 w 0]' [0; y'.*w'; 0] ])
        printf("I=h * alpha * (y*w'')\n")
        frac = dec2frac(alpha,1e-16,%f);
        printf("I=(%.2f) * (%d/%d) * (%.2f) = %f\n",h,frac(1),frac(2),y*w',I)
        printf("%s\n",str)
    end
    if (plt)
        scatter(x,y)
        t=linspace(a+h,b-h,200)
        plot(t,feval(t,f),'--b') 
        pv=PolinomioVandermonde(x,y)
        t=linspace(a,b,200)
        plot(t,horner(pv,t),'r')
        legend("pontos controle","função","polinômio",4)
        xtitle(str)
    end
endfunction

function I=NewtonCotesAberto(f,a,b,n,prt,plt)
    h=(b-a)/(n+2-1),
    x=a+h:h:a+n*h
    y=feval(x,f)
    pv=PolinomioVandermonde(x,y)
    pv_i = polyint_fga(pv);
    I = horner(pv_i,b)-horner(pv_i,a)
    I_exata=intg(a,b,f)
    erro = abs(I-I_exata)/I_exata*100;
    str=sprintf("Newton-Cotes Aberto %4d(+2) pontos = %f erro=%.3e%%\n",n,I,erro)
    if (prt)
        printf("%s\npv=%s",str,string(pv));
    end
    if(plt)
        scatter(x,y)
        t=linspace(a+h,b-h,200)
        plot(t,f,'--b')  
        t=linspace(a,b,200)
        plot(t,horner(pv,t),'r')
        legend("pontos controle","função","polinômio",4)
        xtitle(str)
    end
endfunction


