//deff ('y=f(x)' , 'y=exp(sin(2*x)-3*sin(3*x))')
prt = %f
function [xopt,yopt]=Newton_Raphson_opt(f,a,b,xopt,tol,prt)
    dx=1e-4
    erro=1
    if (prt) printf("n\tx\t\tf(x)\t\terro\n") end
    for (k=1:500)
       x0=xopt
       df1=(f(x0+dx)-f(x0-dx))/(2*dx); //1a derivada
       df2=(f(x0+dx)-2*f(x0)+f(x0-dx))/(dx^2); // 2a derivada
       if (prt) printf ( '%d\t%.10f\t%.10f\t%.1e\n',k,x0,f(x0),erro) end
       xopt = x0 - df1/df2
       if(xopt<>0) then   erro =abs((xopt-x0)/xopt) end
       if  erro<tol then  break  end
    end
    yopt=f(xopt)
    if (prt) printf ( '%d\t%.10f\t%.10f\t%.1e\n',k+1,xopt,yopt,erro) end
endfunction


function plot_newton_raphson_opt(f,a,b,xopt,tol)
    [xopt,yopt]=Newton_Raphson_opt(f,a,b,xopt,tol,%t)
    printf ( '%.10f\t%.10f\n',xopt,yopt)
    printf ( '\Ótimo com tolerância %.1e = (%f,%f)\n',tol,xopt,yopt)
   subplot(211)
    x=linspace(a,b,1000)
    y=feval(x,f)  
    plot(x,y)
    plot2d([xopt xopt],[0,yopt],-2)
    legend("f(x)",2);
   subplot(212)
    dx=x(2)-x(1)
    dy=derivada1_centrada(y,dx)
    plot(x,dy,'r')
    plot2d(xopt,0,-2)    
    legend("f ''(x) centrada",2) 
endfunction

//deff ('y=f(x)' , 'y=exp(sin(2*x)-3*sin(3*x))')
function [xopt,yopt]=busca_aleatoria(f,a,b,n,prt)
    x = grand(1, n, "unf", a, b) //x = linspace(a,b,n)  // para comparar
    y=feval(x,f);
    [yopt,index]=max(y)
    xopt=x(index)
    scatter(x,y,1)
    if (prt)
        plot2d(xopt,yopt,-2)
        s=sprintf("Máximo em (x,y)=(%f,%f)\nerro=%.1e",xopt,yopt,(b-a)/n^2)
        disp(s)
    end
endfunction 

function [xopt,yopt]=busca_aleatoria_duas_passagens(f,a,b,n)
    x = grand(1, n, "unf", a, b)
    y=feval(x,f);
    [yopt,index]=max(y)
    xopt=x(index)
    subplot(211)
    scatter(x,y,1)
    plot2d(xopt,yopt,-2)
    s=sprintf("Primeira Passagem Máximo em (x,y)=(%f,%f)\nerro=%.1e",xopt,yopt,(b-a)/(2*n))
    disp(s)
    xtitle(s)
    // segunda passagem
    x=grand(1, n, "unf",xopt-(b-a)/n,xopt+(b-a)/n);
    y=feval(x,f);
    [yopt,index]=max(y)
    xopt=x(index)
    subplot(212)
    scatter(x,y,1)
    plot2d(xopt,yopt,-2)
    s=sprintf("Segunda Passagem Máximo em (x,y)=(%f,%f)\nerro=%.1e",xopt,yopt,(b-a)/n^2)
    disp(s)
    xtitle(s)
endfunction 

//deff ('y=f(x)' , 'y=exp(sin(2*x)-3*sin(3*x))')
function [xopt,yopt]=busca_aurea(f,a,b,tol,prt)
   phi = (sqrt(5)-1)/2;
   nIter = ceil(log(tol/abs(b-a))/log(phi));
   x1 = b-phi*(b-a);
   x2 = a+phi*(b-a);
   f1 = f(x1);
   f2 = f(x2);
   if (prt) 
       x=linspace(a,b,1000)
       plot(x,feval(x,f))
       printf ('i \ta\t\tx1\t\tx2\t\t\b\t\terro\n')
   end
   for (k=0:nIter-1)
     if f1 > f2  // f1 < f2 para o mínimo
        if (prt)
             printf ('%d\t%.7f\t%.7f(+)\t%.7f(-)\t(%.7f)\t%.1e\n',k,a,x1,x2,b,(phi)*abs(b-a))
        end
        b = x2; 
        x2 = x1; 
        f2 = f1;
        x1 = b-phi*(b-a); 
        f1 = f(x1); 
     else
        if (prt)
            printf ('%d\t(%.7f)\t%.7f(-)\t%.7f(+)\t%.7f\t%.1e\n',k,a,x1,x2,b,(phi)*abs(b-a))
        end
        a = x1;
        x1 = x2;
        f1 = f2;
        x2 = a + phi*(b-a); 
        f2 = f(x2);
     end 
   end
   if f1 > f2  then
        xopt = x1;  // f1<f2 para o mínimo
   else  
        xopt = x2;  
   end 
   yopt = f(xopt)
   if (prt)
      printf ('%d\t%.7f\t%.7f\t%.7f\t%.7f\t%.1e\n',nIter,a,x1,x2,b,(phi)*abs(b-a))
      printf("máximo no ponto (x,f(x))=(%.7f , %.7f)",xopt,yopt)
      plot2d(xopt,yopt,-2)
   end
endfunction

//inclinacao=6
//azimute=240;
//box=[3,7,-2,2]
//n=50;
function Plot_3DView(f,n,inclinacao,azimute,box)
        gcf().color_map = jetcolormap(64);
        x_lin = linspace(box(1),box(2),n);
        y_lin = linspace(box(3),box(4),n);
        plot3d1(x_lin,y_lin,feval(x_lin,y_lin,f))
        gca().rotation_angles = [inclinacao, azimute];
        xtitle("Superfície 3d")
end    
//param3d(x, y, fxy,azimute,inclinacao)
//gce().foreground = color("white");
//gce().thickness = 2


//deff ('z=f(x,y)' , 'z=exp(sin(2*x-y)-3*sin(3*x)*cos(2*y))')
function [x,y,z,index]=busca_aleatoria_2d(f,box,n,prt)
    x = grand(n, 1, "unf",box(1),box(2));
    y = grand(n, 1, "unf",box(3),box(4));
    z=f(x,y)
    [z_max,index]=max(z)
    if (prt)
       printf("Máximo em (x,y,z)=(%.5f ,%.5f, %.5f)\n",x(index),y(index),z_max)
    end
endfunction

//        Plot_3DView(f,60,-155,box)
//        scatter3d([x_max,x_max],[y_max,y_max],[z_max,z_max],50)
//        gca().rotation_angles = [60, -155]

function Plot_Scatter3d(x,y,z,index,inclinacao,azimute)   
        gcf().color_map = jetcolormap(64);  
        scatter3d(x,y,z,1,z)
        scatter3d([x(index),x(index)],[y(index),y(index)],[z(index),z(index)],50)
        gca().rotation_angles = [inclinacao, azimute];
        s=sprintf("Máximo em (x,y,z)=(%.5f ,%.5f, %.5f)\n",...
        x(index),y(index),z(index));
        xtitle(s)
endfunction 

function h=otimiza_h(f,x0,y0,dx,dy,grad)
       for (i=1:40)  
          h = 2^(-i)
          f_h(i)=f(x0+h*dx/grad ,y0+h*dy/grad )
       end
       [f_max, index] = max(f_h)
       h = (2)^(-index)
endfunction

//deff ('z=f(x,y)' , 'z=exp(sin(2*x-y)-3*sin(3*x)*cos(2*y))')
function [x,y]=SteepestAscent(f,x0,y0,tol,prt)
    delta = 1e-8;
    x(1)=x0
    y(1)=y0
    if(prt)  
        printf("itr\tx\t\ty\t\tf(x,y)\t\th\t\tgrad\n")
    end
    for (k=1:1000)
        dx = (f(x(k)+delta,y(k))-f(x(k)-delta,y(k)))/(2*delta)
        dy = (f(x(k),y(k)+delta)-f(x(k),y(k)-delta))/(2*delta)   
        grad = sqrt(dx^2+dy^2)
        if (grad<1e-12) break; end
        h= otimiza_h(f,x(k),y(k),dx,dy,grad)
       // h= 2^(-k+1);
        if(prt) 
            printf("%d\t%f\t%f\t%.10f\t%.2e\t%.2e\n",k,x(k),y(k),f(x(k),y(k)),h,grad)
        end
        x(k+1)= x(k)+ h * dx/grad
        y(k+1)= y(k)+ h * dy/grad
        erro = abs((f(x(k+1),y(k+1))-f(x(k),y(k)))/f(x(k+1),y(k)))
        if ( erro < tol) break; end
    end
    if(prt)
        printf("k=%d  máximo (%f,%f)=%.10f",k+1,x(k+1),y(k+1),f(x(k+1),y(k+1)))
    end
endfunction


function Plot_Gradiente(f,box)
        xt = linspace(box(1),box(2),200);
        yt = linspace(box(3),box(4),200);
        gcf().color_map = jetcolormap(64);
        Sgrayplot(xt,yt,feval(xt,yt,f).^(1/3))
        n=40
        x_lin = linspace(box(1),box(2),n);
        y_lin = linspace(box(3),box(4),n);
        delta = 1e-8;
        for i=1:n
           for j=1:n
              dx(i,j) = (f(x_lin(i)+delta,y_lin(j))-f(x_lin(i)-delta,y_lin(j)))/(2*delta);
              dy(i,j) = (f(x_lin(i),y_lin(j)+delta)-f(x_lin(i),y_lin(j)-delta))/(2*delta); 
           end
        end
        champ(x_lin, y_lin, dx, dy,0.7)
endfunction
// gce().thickness = 2
// plot(x, y, 'w')

