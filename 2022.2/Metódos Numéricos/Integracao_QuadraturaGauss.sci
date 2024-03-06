prt = %f
plt = %t

gauss_z=[
    [           0,          0,          0,          0,          0,          0,          0,          0,          0,          0,          0],
    [ -0.57735027, 0.57735027,          0,          0,          0,          0,          0,          0,          0,          0,          0],
    [ -0.77459667,          0, 0.77459667,          0,          0,          0,          0,          0,          0,          0,          0],
    [ -0.86113631,-0.33998104, 0.33998104, 0.86113634,          0,          0,          0,          0,          0,          0,          0],
    [ -0.90617985,-0.53846931,          0, 0.53846931, 0.90617985,          0,          0,          0,          0,          0,          0],
    [ -0.93246951,-0.66120939,-0.23861918, 0.23861918, 0.66120939, 0.93246951,          0,          0,          0,          0,          0],
    [ -0.94910791,-0.74153119,-0.40584515,          0, 0.40584515, 0.74153119, 0.94910791,          0,          0,          0,          0],
    [ -0.96028986,-0.79666648,-0.52553241,-0.18343464, 0.18343464, 0.52553241, 0.79666648, 0.96028986,          0,          0,          0],
    [ -0.96816024,-0.83603111,-0.61337143,-0.32425342,          0, 0.32425342, 0.61337143, 0.83603111, 0.96816024,          0,          0],
    [ -0.97390653,-0.86506337,-0.67940957,-0.43339539,-0.14887434, 0.14887434, 0.43339539, 0.67940957, 0.86506337, 0.97390653,          0],
    [ -0.97822866,-0.88706250,-0.73015201,-0.51909613,-0.26954316,          0, 0.26954316, 0.51909613, 0.73015201, 0.88706250, 0.97822866]];
    
gauss_w=[
    [          2,          0,          0,          0,          0,          0,          0,          0,          0,          0,          0],
    [          1,          1,          0,          0,          0,          0,          0,          0,          0,          0,          0],
    [ 0.55555555, 0.88888889, 0.55555555,          0,          0,          0,          0,          0,          0,          0,          0],
    [ 0.34785485, 0.65214515, 0.65214515, 0.34785485,          0,          0,          0,          0,          0,          0,          0],
    [ 0.23692689, 0.47862867, 0.56888889, 0.47862867, 0.23692689,          0,          0,          0,          0,          0,          0],
    [ 0.17132449, 0.36076157, 0.46791393, 0.46791393, 0.36076157, 0.17132449,          0,          0,          0,          0,          0],
    [ 0.12948497, 0.27970539, 0.38183005, 0.41795918, 0.38183005, 0.27970539, 0.12948497,          0,          0,          0,          0],
    [ 0.10122854, 0.22238103, 0.31370665, 0.36268378, 0.36268378, 0.31370665, 0.22238103, 0.10122854,          0,          0,          0],
    [ 0.08127439, 0.18064816, 0.26061070, 0.31234708, 0.33023936, 0.31234708, 0.26061070, 0.18064816, 0.08127439,          0,          0],
    [ 0.06667134, 0.14945135, 0.21908636, 0.26926672, 0.29552422, 0.29552422, 0.26926672, 0.21908636, 0.14945135, 0.06667134,          0],
    [ 0.05566857, 0.12558037, 0.18629021, 0.23319376, 0.26280454, 0.27292508, 0.26280454, 0.23319376, 0.18629021, 0.12558037, 0.05566857]];
    
function I=QuadraturaGauss(f,a,b,n,prt,plt)
    z= gauss_z(n,1:n);
    w = gauss_w(n,1:n);
    xi= (b-a)/2*z+(b+a)/2
    yi=feval(xi,f);
    wi = w* (b-a)/2
    I = yi*wi'
    I2=intg(a,b,f);
    str=sprintf("Quadratura Gauss %4d pontos = %f erro=%.1e%%\n",n,I,abs(I-I2)/I2*100)
    if (prt)
        printf("[z  xi w  wi  yi]")
        disp([z' xi'  w' wi' yi'])
        printf("I=soma(yi * wi) = %f\n",I);
        printf("integral exata = %f\n",I2)
        printf("%s\n",str)  
    end
    if (plt)
        scatter(xi,yi)
        xtitle(str);
        t=linspace(a,b,1000)
        plot(t,feval(t,f));
    end
endfunction

function [ps_n,ps]=legendre_rec(n)
     s=poly(0,'s'); // Formula de Recorrência
     ps(1)=1
     ps(2)=s
     for(k=2:n+1)
        index=k+1
        ps(index)=[(2*k-1)*s*ps(index-1) - (k-1)*ps(index-2)]/(k)
     end
     ps_n=ps(n+1)
endfunction


function Plot_Legendre()
    t=linspace(-1,1,200)
    [ps_out, ps] = legendre_rec(10)
    for k=0:10
        subplot(4,3,k+1)
        plot2d(t,horner(ps(k+1),t),modulo(k,6)+1);
        xgrid()
        xtitle("legendre n="+string(k))
        subplot(4,3,12)
        plot2d(t,horner(ps(k+1),t),modulo(k,6)+1);
        xgrid()
    end
endfunction

function [z,w]=raizesLegendre(n)
    ps=legendre_rec(n)
    teta=%pi*(n-(1:n)'+3/4)./(n+1/2)//Francesco Tricomi 
    z=(1-1/(8*n^2)+1/(8*n^3))*cos(teta)//- primeira estimativa raiz
    erro=1
    for (i=1:200) //Newton-Raphson para encontrar raizes z
        z0=z;
        fz=horner(ps,z)
        dfz=horner(derivat(ps),z)
        z=z0-fz./dfz;
        // disp(z)
        erro = norm(z-z0)/norm(z)
        if (erro<1e-16) break; end;
    end
    w=(2)./((1-z.^2).*dfz.^2); //pesos
endfunction  

function [z,w] = quadratura_tabela(Nc)
    w = zeros(Nc,Nc)
    z = zeros(Nc,Nc)
    for (N=1:Nc)
        [z(N,1:N),w(N,1:N)] = raizesLegendre(N)
    end
endfunction

function [fz,dfz]=legendre_itr_vector(n,z)
    fzm1=ones(1:n)'
    fz = z 
    for k=2:n
       fzm2 = fzm1
       fzm1 = fz
       fz=[ (2*k-1)*z.*fzm1-(k-1)*fzm2 ] / k;
    end
    dfz=[n*z.*fz-n*fzm1]./(z.^2-1)
endfunction

function [z,w]=raizesLegendre_vector(n)
    teta=%pi*(n-(1:n)'+3/4)./(n+1/2)//Francesco Tricomi 
    z=(1-1/(8*n^2)+1/(8*n^3))*cos(teta)//- primeira estimativa raiz
    erro=1
    for (i=1:200) //Newton-Raphson para encontrar raizes z
        z0=z;
        [fz,dfz]=legendre_itr_vector(n,z)
        z=z0-fz./dfz;
        erro = norm(z-z0)/norm(z)
        if (erro<1e-16) break; end;
    end
    w=(2)./((1-z.^2).*dfz.^2); //pesos
endfunction 

function I=QuadraturaGauss2(f,a,b,n,prt,plt)
   [z_in,w_in]=raizesLegendre_vector(n)
    z=z_in'
    w=w_in'
    xi= (b-a)/2*z+(b+a)/2
    yi=feval(xi,f);
    wi = w* (b-a)/2
    I = yi*wi'
    I2=intg(a,b,f);
    str=sprintf("Quadratura Gauss %4d pontos = %f erro=%.1e%%\n",n,I,abs(I-I2)/I2*100)
    if (prt)
        printf("[xi yi wi y*wi]")
        disp([xi'  yi' wi' (wi.*yi)'])
        printf("I=soma(yi * wi) = %f\n",I);
        printf("integral exata = %f\n",I2);
        printf("%s\n",str)  
    end
    if (plt)
        scatter(xi,yi)
        xtitle(str)
        t=linspace(a,b,1000)
        plot(t,feval(t,f));
    end
endfunction
  
function Test_QuadraturaGauss(f,a,b)
    I2=intg(a,b,f);
    printf("integral exata = %f\n",I2)
    n=[3,4,5,6,7,8,9,10,11,15,20,25]
    for k=1:12
        subplot(4,3,k)
        I=QuadraturaGauss2(f,a,b,n(k),%f,%t)
        printf("Quadratura Gauss %4d pontos = %f erro=%.1e%%\n",n(k),I,abs(I-I2)/I2*100)
    end
endfunction  

