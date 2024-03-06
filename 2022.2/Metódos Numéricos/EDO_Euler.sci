prt = %f
// deff ('phi=g(x,y)' , 'phi=(2*x-4*y+x*y-1)/3')
function [x,y]=edo_euler(g,a,b,ya,n,prt)
    h=(b-a)/(n-1);
    x=linspace(a,b,n)'
    y = [ya zeros(1,n-1)]'
    for i=1:n-1
        phi(i) = g(x(i), y(i));
        y(i+1)=y(i)+phi(i)*h
    end
    if (prt)
        printf("   i    x(i)  phi(i)   y(i)")
        disp([[0:n-1]',x, [phi;%nan], y]);
        plot(x,y,"b")
        legend("euler",2)
    end
endfunction

// deff ('phi=f(x,y)' , 'phi=(2*x-4*y+x*y-1)/3')
function [x,y]=edo_heun(g,a,b,ya,n,prt)
    h=(b-a)/(n-1);
    x=linspace(a,b,n)'
    y = [ya zeros(1,n-1)]'
    for i=1:n-1
        k1(i)  = g( x(i)    , y(i) );
        k2(i)  = g( x(i)+ h , y(i)+k1(i)*h);
        phi(i)= (k1(i)+k2(i))/2;
        y(i+1)=y(i)+phi(i)*h
    end
    if (prt)
        printf("   i     x(i)  k1(i)    k2(i)    phi(i)   y(i)")
        disp([[0:n-1]',x, [k1;%nan],[k2;%nan],[phi;%nan], y]);
        plot(x,y,"b")
        legend("heun",2)
    end
endfunction

// deff ('phi=f(x,y)' , 'phi=(2*x-4*y+x*y-1)/3')
function [x,y]=edo_midpoint(g,a,b,ya,n,prt)
    h=(b-a)/(n-1);
    x=linspace(a,b,n)'
    y = [ya zeros(1,n-1)]'
    for i=1:n-1
        k1(i) =  g( x(i)     , y(i));
        k2(i) =  g( x(i)+ h/2, y(i)+k1(i)*h/2);
        phi(i)=  k2(i)
        y(i+1)=y(i)+phi(i)*h
    end
    if (prt)
        printf("   i     x(i)  k1(i)   phi(i)   y(i)")
        disp([[0:n-1]',x, [k1;%nan],[phi;%nan], y]);
        plot(x,y,"b")
        legend("midpoint",2)
    end
endfunction

function [x,y]=edo_ralston(g,a,b,ya,n,prt)
    h=(b-a)/(n-1);
    x=linspace(a,b,n)'
    y = [ya zeros(1,n-1)]'
    for i=1:n-1
        k1(i)    = g( x(i)      , y(i));
        k2(i)    = g( x(i)+3/4*h, y(i)+3/4*k1(i)*h);
        phi(i)   = 1/3*(k1(i) + 2.0*k2(i));
        y(i+1)=y(i)+phi(i)*h
    end
    if (prt)
        printf("   i     x(i)  k1(i)    k2(i)    phi(i)   y(i)")
        disp([[0:n-1]',x, [k1;%nan],[k2;%nan],[phi;%nan], y]);
        plot(x,y,"b")
        legend("ralston",2)
    end
endfunction

function Test_EDO_Ordinaria(g,a,b,ya,n)
    // deff ('phi=f(x,y)' , 'phi=(2*x-4*y+x*y-1)/3')
    h=(b-a)/(n-1);
    x=linspace(a,b,n)'
    [ye, yh, ym, yr] = (zeros(1,n)',zeros(1,n)', zeros(1,n)', zeros(1,n)',zeros(1,n)')
    [ye(1), yh(1), ym(1), yr(1)] = (ya,ya,ya,ya)
    for i=1:n-1
        //Euler 
        k1= g(x(i), ye(i));
        phi = k1;
        ye(i+1)=ye(i)+phi*h
        //heun
        k1= g( x(i)   , yh(i)     );
        k2= g( x(i)+ h, yh(i)+k1*h);
        phi   = 1/2*(k1+k2);
        yh(i+1)=yh(i)+phi*h
        //midpoint
        k1= g( x(i)    , ym(i)        );
        k2= g( x(i)+ h/2, ym(i)+k1*h/2);
        phi = k2;
        ym(i+1)=ym(i)+phi*h
        //ralston
        k1= g( x(i)      , yr(i)         );
        k2= g( x(i)+3/4*h, yr(i)+3/4*k1*h);
        phi   = 1/3*(k1 + 2.0*k2);
        yr(i+1)=yr(i)+phi*h
    end
    printf("   x(i)\ty_e(i)\ty_h(i)\ty_m(i)\ty_r(i)")
    disp([x, ye, yh, ym, yr]);
    plot(x,[ye,yh,ym,yr])
    legend("euler","heun","midpoint","ralston",2)
endfunction
