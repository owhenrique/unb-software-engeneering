// x=[3,3.3,3.9,4.3,4.7,5.3,5.9,6.1,6.3,6.6,7];
// y=[0,2,1,5,5,8,9,13,14,20,22];
exec('Polinomio_Interpolacao.sci',-1)
function [pm,A,u]=PolinomioMQ(x,y,ordem)
    N=length(x);
    M=ordem+1
    A=zeros(N,M)
    for(k=1:M)
        A(:,k)=(x.^(k-1))'
    end
    u=EliminacaoGauss((A'*A),(A'*y'),%F) 
    pm=poly(u,'s','coeff')
endfunction

function coef=Programa1(x,y,ordem)
    N=length(x);
    M=ordem+1
    A=zeros(N,M)
    for(k=1:M)
        A(:,k)=(x.^(k-1))'
    end
    coef=inv(A'*A)*(A'*y')
endfunction


function pm=Plot_PolinomioMQ(x,y,ordem)
    [pm,A,u]=PolinomioMQ(x,y,ordem)
    printf("Matriz Aumentada [(A''A)|(A''y))]")
    disp([(A'*A) , (A'*y')])
    printf("Coeficientes u=inv(A''A)*(A''y))")
    disp(u)
    printf("Polinômio Mínimos Quadradros ordem %d\npm=",ordem);
    disp(pm)
    St = sum( (y-mean(y))^2 ); //goodness of fitness
    Sr = sum( (y'-A*u)^2 );
    r2= abs(St-Sr)/St
    printf("r2=%.1f%%\tr=%.3f\n",r2*100,sqrt(r2));
    xp=linspace(min(x),max(x),1000);
    yp=horner(pm,xp)
    plot(xp,yp,'r')
    scatter(x,y)
    xtitle("Polinômio de Mínimos Quadrados");
endfunction

//x=[0,1,1.5,3,3.2,4,5.5,6.4,7.8,9.9];
//y=[2.3,2.9,4.1,6.1,6.8,8.2,14.6,17.3,30.0,70.3];
//x=[0.1 0.12 0.15 0.19 0.25 0.39 0.59 0.62 0.82 1.5 2.6 4.2 5.9 6.9 8.5 9];
//y=[0.5 0.6 0.75 0.81 1.3 1.6 2.4 2.35 2.95 4.1 5.8 6.4 7.7 7.6 8.25 8.3];

function [a0,a1, A, b]=MQL(x,y)
    n=length(x)
    A=[n,sum(x);sum(x),sum(x.^2)]
    b=[sum(y);sum(x.*y)]
    u=inv(A)*b
    a0=u(1)
    a1=u(2)
endfunction

function plot_MQL(x,y)
    [a0,a1, A, b]=MQL(x,y)
    St = sum( (y-mean(y))^2 );
    Sr = sum( (y-a0-a1*x)^2 );
    r2= abs(St-Sr)/St
    printf("Matriz Aumentada [(A)|(b))]")
    disp([A,b])
    printf("y=%.3f+%.3f*x\n",a0,a1)
    printf("r2=%.1f%%\tr=%.3f\n",r2*100,sqrt(r2));
    xp=linspace(min(x),max(x),1000);
    plot(xp,a0+a1*xp,'r')
    scatter(x,y)
endfunction

