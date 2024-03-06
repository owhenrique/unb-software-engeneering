function x_seq=NewtonRaphson_seq(f,df,x_ini,tol)
    x_seq(1)=x_ini // armazena sequencia de raízes
    erro = 1;
    for (k=2:50)
       f0=feval(x_seq(k-1),f)
       df0=feval(x_seq(k-1),df)
       if (f0==0) x_seq(k)=x_seq(k-1); 
       else       x_seq(k) = x_seq(k-1) - f0/df0   end
       if(x_seq(k)<>0)  erro =abs((x_seq(k)-x_seq(k-1))/x_seq(k))  end
       if  erro<tol  break   end
    end
endfunction

function exemploNewtonRaphson()
    deff ( 'y=f ( x )' , 'y=x^5-6*x^4+10*x^3-10*x^2+5*x-2' )
    deff ( 'y=df ( x )' , 'y=5*x^4-24*x^3+30*x^2-20*x+5' )
    x=linspace(0,5.2,1000)
    y=feval(x,f)
    x_seq=NewtonRaphson_seq(f,df,5,1e-2)
    y_seq=feval(x_seq,f);
    subplot(231)
    plot(x,y)
    xgrid()
    for(k=1:length(x_seq))
        subplot(2,3,k+1)
        plot(x,y)
        plot2d(x_seq(k),y_seq(k),-2)
        xgrid()
        title('iteração='+string(k)) 
        xl=[x_seq(k)-0.6:0.01:x_seq(k)+0.5];
        yl=y_seq(k)+(xl-x_seq(k))*df(x_seq(k))
        plot(xl,yl,'r')
        if (k<>length(x_seq)) 
            plot2d([x_seq(k+1),x_seq(k+1)], [0,y_seq(k+1)],3)
            plot2d(x_seq(k+1),y_seq(k+1),-4)
        end
    end
endfunction

function exemploSecante()
    deff ( 'y=f ( x )' , 'y=4*exp(x/3)-20*exp(-x/5)*sin(x)')
    x=[-10:0.01:10];
    y=feval(x,f)
    xr=NewtonRaphson2(f,5,1,1e-2)
    yr=feval(xr,f);
    subplot(231)
    plot(x,y)
    plot2d(xr,yr,-2)
    plot([0,6],[0,0],'bk')
    for(k=1:length(xr))
        subplot(2,3,k+1)
        plot(x,y)
        plot2d(xr(k),yr(k),-2)
        plot([0,6],[0,0],'bk')
        title('iteração='+string(k))
        
        xl=[xr(k)-0.6:0.01:xr(k)+0.5];
        yl=yr(k)+(xl-xr(k))*numderivative(f,xr(k))
        plot(xl,yl,'r')
        if (k<>length(xr)) 
            plot2d([xr(k+1),xr(k+1)], [0,yr(k+1)],3)
            plot2d(xr(k+1),yr(k+1),-4)
        end
    end
endfunction
