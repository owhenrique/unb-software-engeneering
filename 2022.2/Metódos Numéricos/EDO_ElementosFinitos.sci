prt = %f
exec('AL_EliminacaoGauss.sci',-1)
function [x,y]=ElementosFinitos_a(a,b,ya,yb,n,fl,fp,fu,fr,prt)
//(fl)*y(i-1)+ ( fp)*y(i) + (fu)*y(i+1) = (fr)
    i=1:n
    h=(b-a)/(n-1)
    x=[a+(i-1)*h]
    el= feval(i,fl)
    ep= feval(i,fp)
    eu= feval(i,fu)
    r= feval(i,fr)
    el(n-1)=0
    ep(1)=1
    ep(n)=1
    eu(1)=0
    r(1)=ya
    r(n)=yb
    y = tridiagonal(el,ep,eu,r)
    if (prt)
        if (n<20) then
            printf("   h=%f\n   [A r]",h)
            disp([diag(eu(1:n-1),1)+diag(ep(1:n))+diag(el(1:n-1),-1) r'])
            printf("   [x y]")
            disp([x' y'])
        end
        plot(x,y,'r')
        printf("h=%.3f\n",h);
        printf("y(%.3f)=%.3f dy(%.3f)=%.3f\n",x(1),y(1),x(1),(-y(3)+4*y(2)-3*y(1))/(2*h));
        printf("y(%.3f)=%.3f dy(%.3f)=%.3f\n",x(n),y(n),x(n),(3*y(n)-4*y(n-1)+y(n-2))/(2*h));
    end
endfunction

function [x,y]=ElementosFinitos(a,b,ya,yb,n,fl,fp,fu,fr,tipo,prt)
    i=1:n
    h=(b-a)/(n-1)
    x=[a+(i-1)*h]
    el= feval(i,fl) //(el)*y(i-1)+ ( ep)*y(i) + (eu)*y(i+1) = (r)
    ep= feval(i,fp)
    eu= feval(i,fu)
    r= feval(i,fr) 
    if tipo==1 then  // ya e yb
        el(n-1)=0
        ep(1)=1
        ep(n)=1
        eu(1)=0
        r(1)=ya
        r(n)=yb
    elseif tipo==2 then  // ya e dyb
        el(n-1)=el(n-1)+eu(n-1)
        ep(1)=1
        eu(1)=0
        r(1)=ya
        r(n)=r(n)-2*yb*h*eu(n-1)
    elseif tipo==3 then   // dya e yb
         el(n-1)=0
         ep(n)=1
         eu(1)=eu(1)+el(1)
         r(1)=r(1)+2*ya*h*el(1)
         r(n)=yb
    elseif tipo==4   //dya e dyb
         el(n-1)=el(n-1)+eu(n-1)
         eu(1)=eu(1)+el(1)
         r(1)=r(1)+2*ya*h*el(1)
         r(n)=r(n)-2*yb*h*eu(n-1)
    end
    y = tridiagonal(el,ep,eu,r)
    if (prt)
        if (n<20) then
            printf("   h=%f\n   [A r]",h)
            disp([diag(eu(1:n-1),1)+diag(ep(1:n))+diag(el(1:n-1),-1) r'])
            printf("   [x y]")
            disp([x' y'])
        end
        plot(x,y,'b')
        printf("h=%.3f\n",h);
        printf("y(%.3f)=%.3f dy(%.3f)=%.3f\n",x(1),y(1),x(1),(-y(3)+4*y(2)-3*y(1))/(2*h));
        printf("y(%.3f)=%.3f dy(%.3f)=%.3f\n",x(n),y(n),x(n),(3*y(n)-4*y(n-1)+y(n-2))/(2*h));
    end
endfunction








