function exemplo_truncamento(x,N)
    exp_trunc=0
    for n=0:N
        exp_trunc=exp_trunc+x.^n/factorial(n)
        erro_rel(n+1) = abs((exp_trunc-exp(x))/exp(x))
        printf("%2d\t%.17f\t%.0e\n",n+1,exp_trunc,erro_rel(n+1))
    end
    plot(log10(erro_rel))
    printf("Valor exato\t%.17f\n",exp(x))
endfunction


// pi50 = 3.14159265358979323846264338327950288419716939937510
function exemplo_truncamento2(N)
    pi50 = 3.14159265358979323846264338327950288419716939937510
    deff ('y=f(x,y)' , 'y=sin(x)' )
    a=2
    b=4
    printf (' i\t     x1\t\t\t\terro\n')
    x1=a;
    for (n=1:N)
        erro(n) = abs((x1-pi50)/pi50)
        x1=(a+b)/2     // Bisseção
        printf ("%2d\t     %.21f\t%.0e\n",n,x1,erro(n))
        if f(x1)*f(a) < 0 then
             b=x1
        else
             a=x1
        end
    end
    plot((1:N)',log10(erro(1:N)))
    format("v",25)
    disp("PI scilab   = "+string(%pi))
    disp("PI 50 casas = 3.14159265358979323846264338327950288419716939937510")
endfunction


function tabela=tabela_floating_point(n,m)
    Bias = 2^(n-1)-1
    E=zeros(1:n)
    tabela(1,1) = %nan
    for (col=2:2^n+1)
        tabela(1,col) = binario2dec1(E)-Bias 
        E=SomaBinaria(E,[zeros(1:n-1) 1],%f)
    end
    M=zeros(1:m-1)
    for (lin=2:2^(m-1)+1)
        tabela(lin,1) = binario2dec4([1 M],1,m-1)
        M=SomaBinaria(M,[zeros(1:m-2) 1],%f)
    end 
        
    E=zeros(1:n)    
    for (col=2:2^n+1) 
        M=zeros(1:m-1)
        for(lin=2:2^(m-1)+1)
            e=[0 E M]
            tabela(lin,col) = float2dec(e,n,m)
            M=SomaBinaria(M,[zeros(1:m-2) 1],%f)
        end
        E=SomaBinaria(E,[zeros(1:n-1) 1],%f)
    end
endfunction


function grafico_floating_point(n,m)
    max_x = float2dec([0 ones(1:n+m-1) ],n,m) 
    k=0
    for x=linspace(-1.5*max_x,1.5*max_x,2000)
        k=k+1;
        a_in(k) = x
        e=dec2float(a_in(k),n,m);
        a_out(k)=float2dec(e,n,m)
    end
    w=gca()
    plot(a_in,a_out)
    w.data_bounds=[min(a_in),1.1*min(a_out);max(a_in),1.1*max(a_out)]
endfunction

function exemplo_arredondamento1(x)
  printf("Condicionamento: substituir iterações  por multiplicação\n")
  lista_n=[11, 8, 8]
  lista_m=[53,24,16]
  lista_itr  =[10^2,10^3,10^4,10^5,10^6]
  lista_delta=10^-2./lista_itr
  for(i=1:length(lista_itr))
    itr=lista_itr(i)
    delta = lista_delta(i)
    printf("Somar %d vezes o número %f ao número %f\n",itr,delta,x)
    for (k=1:length(lista_n))
       n=lista_n(k)
       m=lista_m(k)
       somatoria=x
       for(i=1:itr)
          somatoria=SomaFloat1(somatoria,delta,n,m)
       end
       somatoria_cond=SomaFloat1(x,itr*delta,n,m)
       printf("Somatoria(%2d,%2d)= %.10f (%.10f)\n",n,m,somatoria,somatoria_cond)
    end
  end
endfunction

function exemplo_arredondamento1b(x)
  printf("Condicionamento: somar antes os números pequenos entre si\n")
  lista_n=[11, 8, 8]
  lista_m=[53,24,16]
  lista_itr  =[10^2,10^3,10^4,10^6]
  lista_delta=10^-2./lista_itr
  for(i=1:length(lista_itr))
    itr=lista_itr(i)
    delta = lista_delta(i)
    printf("Somar %d vezes o número %f ao número %f\n",itr,delta,x)
    for (k=1:length(lista_n))
       n=lista_n(k)
       m=lista_m(k)
       somatoria=x
       for(i=1:itr)
          somatoria=SomaFloat1(somatoria,delta,n,m)
       end
       somatoria_cond=delta
       for(i=1:itr-1)
          somatoria_cond=SomaFloat1(somatoria_cond,delta,n,m)
       end
       somatoria_cond=SomaFloat1(x,somatoria_cond,n,m)
       printf("Somatoria(%2d,%2d)= %.10f (%.10f)\n",n,m,somatoria,somatoria_cond)
    end
  end
endfunction


function exemplo_arredondamento2(a,b,c)
    x=poly(0,'x')
    y=a*x^2+b*x+c 
    z = roots(y)
    b2     =  -(b)/(2*a)
    delta2 =  sqrt(b^2-4*a*c) /(2*a)
    printf("f(x)=(%.3f)x^2+(%.3f)*x+(%.3f)\n",a,b,c)
    printf("b2     = -b/(2a)=%f\n",b2)
    printf("delta2 =  sqrt(b^2 - 4ac)/(2a)=%.4f\n",delta2)
    printf("x1 = b2 + delta2 =%.4f  + %.4f\n",b2,delta2)
    printf("x2 = b2 - delta2 =%.4f  - %.4f\n",b2,delta2)
    printf("           (subtração 2 números próximos!!\n")
    printf("condicionamento x1*x2 = c/a ->  x2=c/(a*x1)\n")
    printf("raizes exatas  = %.8e\t%.8e\t(condicionamento)\n",z(1),z(2)) 
    
    lista_n=[11, 8, 8, 8, 5]
    lista_m=[53,24,16, 8, 5]
    for (k=1:5)
        n=lista_n(k)
        m=lista_m(k)
        delta2 =   sqrt(   SomaFloat1(b^2,-4*a*c,n,m) )  /(2*a)
        x1 = SomaFloat1(b2,+delta2,n,m)
        x2 = SomaFloat1(b2,-delta2,n,m)
        x2_cond = c/(a*x1)
        printf("raizes (%2d,%2d) = %.8e\t%.8e\t(%.8e)\n",n,m,x1,x2,x2_cond)
    end
endfunction

function exemplo_arredondamento3(x)
    printf("Calcular y=1/dx*(sin(x+dx)-sin(x)), dx pequeno\n"); 
    printf("subtração 2 números próximos!!\n")
    printf("Condicionamento por Taylor y_cond= cos(x)-0.5*dx*sin(x)\n")
    lista_dx=[1e-2,1e-4,1e-5,1e-8,1e-16]
    lista_n=[11, 8, 8, 8, 8]
    lista_m=[53,24,16, 8, 5]
    for(itr=1:length(lista_dx))
        dx=lista_dx(itr)
        printf("dx=%.1e\n",dx)
        for (k=1:5)
            n=lista_n(k)
            m=lista_m(k)
            if sin(x+dx)>sin(x)
                 y = 1/dx*SomaFloat1(sin(x+dx),-sin(x),n,m)
            else
                 y = -1/dx*SomaFloat1(sin(x),-sin(x+dx),n,m)
            end
            y_cond = SomaFloat1(cos(x),-0.5*dx*sin(x),n,m)
            printf("y(%2d,%2d) = %.16f\t(%.16f)\n",n,m,y,y_cond)
        end
    end
endfunction

function exemplo_arredondamento4(x,f)
    printf("Calcular y=f(x+dx)-f(x), dx pequeno\n"); 
    printf("subtração 2 números próximos!!\n")
    printf("Condicionamento por derivada y_cond= (dx)f''(x)\n")
    //deff ('y=f(x)' , 'y=sin(x)' )
    lista_dx=[1e-2,1e-4,1e-5,1e-8,1e-16]
    lista_n=[11, 8, 8, 8, 8]
    lista_m=[53,24,16, 8, 5]
    for(itr=1:length(lista_dx))
        dx=lista_dx(itr)
        printf("dx=%.1e\n",dx)
        for (k=1:5)
            n=lista_n(k)
            m=lista_m(k)
            if(f(x+dx)>f(x))
                 y = SomaFloat1(f(x+dx),-f(x),n,m)
             else
                 y = SomaFloat1(f(x),-f(x+dx),n,m)
             end
            y_cond = dx*numderivative(f,x)
            printf("y(%2d,%2d) = %.8e\t(%.8e)\n",n,m,y,y_cond)
        end
    end
endfunction

function exemplo_arredondamento5()
    printf("Calcular y=(1-cos(x))/sin(x), x pequeno\n"); 
    printf("subtração 2 números próximos!!\n")
    printf("Condicionamento por trigonometria y_cond= 2*sin(x/2)^2/sin(x)\n")
    lista_dx=[1e-2,1e-4,1e-5,1e-8]
    lista_n=[11, 8, 8, 8]
    lista_m=[53,24,16, 8]
    for(itr=1:length(lista_dx))
        dx=lista_dx(itr)
        printf("dx=%.1e\n",dx)
        for (k=1:length(lista_n))
            n=lista_n(k)
            m=lista_m(k)
            if cos(dx)<1
                 y = 1/sin(dx)*SomaFloat1(1,-cos(dx),n,m)
            else
                 y = -1/sin(dx)*SomaFloat1(cos(dx),-1,n,m)
            end
            y_cond = 2*sin(dx/2)^2/sin(dx)
            printf("y(%2d,%2d) = %.8e\t(%.8e)\n",n,m,y,y_cond)
        end
    end
endfunction


function exemplo_arredondamento6(x)
    printf("Calcular y=log(x+dx)-log(x), x pequeno\n"); 
    printf("subtração 2 números próximos!!\n")
    printf("Condicionamento por logaritmo  y_cond= log((x+dx)/x)\n")
    lista_dx=[1e-2,1e-4,1e-5,1e-8,1e-16]
    lista_n=[11, 8, 8, 8]
    lista_m=[53,24,16, 8]
    for(itr=1:length(lista_dx))
        dx=lista_dx(itr)
        printf("dx=%.1e\n",dx)
        for (k=1:length(lista_n))
            n=lista_n(k)
            m=lista_m(k)
            y = SomaFloat1(log(x+dx),-log(x),n,m)
            y_cond = log((x+dx)/x)
            printf("y(%2d,%2d) = %.8e\t(%.8e)\n",n,m,y,y_cond)
        end
    end
endfunction


function exemplo_arredondamento7()
    printf("Calcular y=sqrt(x^2+1)-1, x muito pequeno\n"); 
    printf("subtração 2 números próximos!!\n")
    printf("Condicionamento por produto notável  y_cond= x^2/(sqrt(x^2+1)+1)\n")
    lista_dx=[1e-2,1e-4,1e-5,1e-8]
    lista_n=[11, 8, 8, 8]
    lista_m=[53,24,16, 8]
    for(itr=1:length(lista_dx))
        dx=lista_dx(itr)
        printf("dx=%.1e\n",dx)
        for (k=1:length(lista_n))
            n=lista_n(k)
            m=lista_m(k)
            y = SomaFloat1(sqrt(dx^2+1),-1,n,m)
            y_cond = dx^2/SomaFloat1(sqrt(dx^2+1),1,n,m)
            printf("y(%2d,%2d) = %.8e\t(%.8e)\n",n,m,y,y_cond)
        end
    end
endfunction
