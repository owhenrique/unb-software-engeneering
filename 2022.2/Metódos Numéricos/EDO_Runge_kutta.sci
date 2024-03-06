prt=%f
// deff ('phi=g(x,y)' , 'phi=(2*x-4*y+x*y-1)/3')
function [x,y]=runge_kutta3(g,a,b,ya,n,prt)
    h=(b-a)/(n-1);
    x=linspace(a,b,n)'
    y = [ya zeros(1,n-1)]'
    for i=1:n-1
        k1(i) = g( x(i)      , y(i));
        k2(i) = g( x(i)+1/2*h, y(i)+1/2*k1(i)*h);
        k3(i) = g( x(i)+h    , y(i)+(2*k2(i)-k1(i))*h);
        phi(i)= 1/6*(k1(i)+4*k2(i)+k3(i))
        y(i+1)=y(i)+phi(i)*h
    end
    if (prt)
        printf("   i\tx(i)\tk1(i)\tk2(i)\tk3(i)\tphi(i)\ty(i)")
        disp([[0:n-1]',x, [k1;%nan],[k2;%nan],[k3;%nan],[phi;%nan], y]);
        plot(x,y,"b")
        legend("Runge-Kutta 3",2)
    end
endfunction

function [x,y]=runge_kutta4(g,a,b,ya,n,prt)
    h=(b-a)/(n-1);
    x=linspace(a,b,n)'
    y = [ya zeros(1,n-1)]'
    for i=1:n-1
        k1(i) = g( x(i)      , y(i));
        k2(i) = g( x(i)+1/2*h, y(i)+1/2*k1(i)*h);
        k3(i) = g( x(i)+1/2*h, y(i)+1/2*k2(i)*h);
        k4(i) = g( x(i)+h    , y(i)+k3(i)*h);
        phi(i)= 1/6*(k1(i)+2*k2(i)+2*k3(i)+k4(i))
        y(i+1)=y(i)+phi(i)*h
    end
    if (prt)
        printf("   i\tx(i)\tk1(i)\tk2(i)\tk3(i)\tk4(i)\tphi(i)\ty(i)")
        disp([[0:n-1]',x, [k1;%nan],[k2;%nan],...
        [k3;%nan],[k4;%nan],[phi;%nan], y]);
        plot(x,y,"r")
        legend("Runge-Kutta 4",2)
    end
endfunction

function [x,y]=runge_kutta6(g,a,b,ya,n,prt)
    h=(b-a)/(n-1);
    x=linspace(a,b,n)'
    y = [ya zeros(1,n-1)]'
    for i=1:n-1
        k1(i) = g( x(i)      , y(i));
        k2(i) = g( x(i)+1/4*h, y(i)+1/4*k1(i)*h);
        k3(i) = g( x(i)+1/4*h, y(i)+1/8*k1(i)*h+1/8*k2(i)*h);
        k4(i) = g( x(i)+1/2*h, y(i)-1/2*k2(i)*h+k3(i)*h);
        k5(i) = g( x(i)+3/4*h, y(i)+3/16*k1(i)*h+9/16*k4(i)*h);
        k6(i) = g( x(i)+h    , y(i)-3/7*k1(i)*h+2/7*k2(i)*h+ ...
                     12/7*k3(i)*h-12/7*k4(i)*h+8/7*k5(i)*h);
        phi(i)= 1/90*(7*k1(i) + 32*k3(i) + 12*k4(i) + 32*k5(i) + 7*k6(i));
        y(i+1)=y(i)+phi(i)*h
    end
    if (prt)
        printf("   i\tx(i)\tk1(i)\tk2(i)\tk3(i)\tk4(i)\tk5(i)\tk6(i)\tphi(i)\ty(i)")
        disp([[0:n-1]',x, [k1;%nan],[k2;%nan],...
        [k3;%nan],[k4;%nan],[k5;%nan],[k6;%nan],[phi;%nan], y]);
        plot(x,y,"b")
        legend("Runge-Kutta 6",2)
    end
endfunction

function Teste_RungeKutta(g,a,b,ya,n)
    h=(b-a)/(n-1);
    x=linspace(a,b,n)'
    [yr3, yr4] = (zeros(1,n)', zeros(1,n)')
    [yr3(1), yr4(1)] = (ya,ya)
    for i=1:n-1
        //Runge-Kutta 3
        k1 = g( x(i)      , yr3(i));
        k2 = g( x(i)+1/2*h, yr3(i)+1/2*k1*h);
        k3 = g( x(i)+h    , yr3(i)+(2*k2-k1)*h);
        phi= 1/6*(k1+4*k2+k3)
        yr3(i+1)=yr3(i)+phi*h
        //Runge-Kutta 4
        k1 = g( x(i)      , yr4(i));
        k2 = g( x(i)+1/2*h, yr4(i)+1/2*k1*h);
        k3 = g( x(i)+1/2*h, yr4(i)+1/2*k2*h);
        k4 = g( x(i)+h    , yr4(i)+k3*h);
        phi= 1/6*(k1+2*k2+2*k3+k4)
        yr4(i+1)=yr4(i)+phi*h  
    end
    printf("   x(i)  yr3(i)   yr4i)")
    disp([x, yr3, yr4]);
    plot(x,[yr3,yr4])
    legend("Runge Kutta 3","Runge Kutta 4",2)
endfunction

// y''-y'+xy=exp(x)*(x^2+1)
// y'=u
// u'=u-xy+exp(x)*(x^2+1)
// deff ('phi=g(x,y,u)' , 'phi=u-x*y+exp(x)*(x^2+1)')
function [x,y]=Euler_EDO_2a_Ordem(g2,a,b,ya,dya,n,prt)
    deff ('phi=g1(u)' , 'phi=u')
    h=(b-a)/(n-1);
    x=linspace(a,b,n)'
    y = [ya zeros(1,n-1)]'
    u = [dya zeros(1,n-1)]'
    for i=1:n-1
        phi_m = g1(u(i));
        y(i+1)=y(i)+phi_m*h
        phi_k = g2(x(i),y(i),phi_m);
        u(i+1)=u(i)+phi_k*h 
    end
    if (prt)
        printf("   i\tx(i)\tu(i)\ty(i)")
        disp([[0:n-1]',x, u, y]);
        plot(x,y,"b")
        legend("Euler- EDO 2a Ordem",1)
    end
endfunction

function [x,y]=Runge_Kutta4_EDO_2a_Ordem(g2,a,b,ya,dya,n,prt)
    deff ('phi=g1(u)' , 'phi=u')
    h=(b-a)/(n-1);
    x=linspace(a,b,n)'
    y = [ya zeros(1,n-1)]'
    u = [dya zeros(1,n-1)]'
    for i=1:n-1
        m1 = g1(u(i));
        k1 = g2(x(i),y(i),m1);
        m2 = g1(u(i)+1/2*k1*h);
        k2 = g2(x(i)+1/2*h, y(i)+1/2*m1*h, m2);
        m3 = g1(u(i)+1/2*k2*h);
        k3 = g2(x(i)+1/2*h, y(i)+1/2*m2*h, m3);
        m4 = g1(u(i)+k3*h);
        k4 = g2(x(i)+h, y(i)+m3*h, m4);
        phi_m=1/6*(m1+2*m2+2*m3+m4)
        disp(phi_m)
        y(i+1)=y(i)+phi_m*h
        phi_k= 1/6*(k1+2*k2+2*k3+k4)
        u(i+1)=u(i)+phi_k*h 
    end
    if (prt)
        printf("   i\tx(i)\tu(i)\ty(i)")
        disp([[0:n-1]',x, u, y]);
        plot(x,y,"b")
        legend("Runge-Kutta 4- EDO 2a Ordem",1)
    end
endfunction
