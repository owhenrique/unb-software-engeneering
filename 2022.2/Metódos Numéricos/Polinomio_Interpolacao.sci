prt =%f
exec('AL_EliminacaoGauss.sci',-1)
function [pv,A,coef]=PolinomioVandermonde(x,y)
    N=length(x); 
    A=zeros(N,N)
    for(k=1:N)
        A(:,k)=(x.^(k-1))'
    end
    coef=EliminacaoGauss(A,y',%F);
    pv=poly(coef,'s','coeff')
endfunction

function Plot_PolinomioVandermonde(x,y,prt)
    [pv,A,coef]=PolinomioVandermonde(x,y);
    if (prt)
        printf("Matriz Aumentada [A|y]")
        disp([A,y'])
        printf("Coeficientes coef=A^-1 * y")
        disp(coef)
        printf("Polinômio de Vandermonde\npv(s)=")
        disp(pv)
    end
    xp=linspace(min(x),max(x),1000);
    yp=horner(pv,xp)
    plot(xp,yp,'r')
    scatter(x,y)
    xtitle("Polinômio de Vandermonde");
endfunction

function [coef,D]=PolinomioNewton(x,y)
    N=length(x);   //Cálculo dos coeficientes 
    D(:,1)=y';
    for j=2:N  // D(N,N) - Tabela de diferenças
        for k=j:N
            D(k,j)=(D(k,j-1)-D(k-1,j-1))/(x(k)-x(k-j+1));
        end
    end
    coef=diag(D)
endfunction

function yp=InterNewton(xp,x,coef)
  N=length(coef)  
  yp=coef(N);  
  for k=(N-1):-1:1
       disp(k)
       yp=yp.*(xp-x(k)) + coef(k);
  end
endfunction

function Plot_PolinomioNewton(x,y)
    [coef,D]=PolinomioNewton(x,y) 
    N=length(x) 
    printf("Tabela de diferenças")
    disp(D)
    printf("Coeficientes coef=diag(D)")
    disp(coef)
    printf("Polinômio de Newton\npn(s)=\n")
    for k=(N-1):-1:1
        printf("(%.5e)",coef(N-k+1))
        for(j=N-1:-1:k)
           printf("(x-(%.5f))",x(N-j))
        end
        if (k>1) then printf(" + \n") end
    end 
    xp=linspace(min(x),max(x),1000);
    yp=InterNewton(xp,x,coef);
    plot(xp,yp,'r')
    scatter(x,y)
    xtitle("Polinômio de Newton")
endfunction


function yp=InterLagrange(xp,x,y)
    N=length(x)
    M=length(xp)
    for k=1:M
       for (i=1:N)   
           Li(i)=y(i)
           for j=[1:N]
              if (j<>i) Li(i)=Li(i)*(xp(k)-x(j))/(x(i)-x(j)); end
           end
       end
       yp(k)=sum(Li)
    end
endfunction

function  Plot_PolinomioLagrange(x,y)
    N=length(x); 
    printf("Polinômio de Lagrange\n")
    s=poly(0,'s');
    linha_s = "------------------------------------------------------"
    for i=1:N
        num_s = ""
        den_s = ""
        for j=[1:N]
            if (j<>i)
                num_s=sprintf("%s(x-(%.4f))",num_s,x(j))
                den_s=sprintf("%s(%.4f)",den_s,x(i)-x(j))
            end
        end
        printf("L[%d,%d](x)=\n\t%s\n(%.4f)%s\n\t%s\n",i-1,N-1,num_s,y(i),linha_s,den_s)
    end 
    printf("pl=")
    for i=1:N-1  printf("y(%d)*L[%d,%d](x)+",i-1,i-1,N-1) end
    printf("y(%d)*L[%d,%d](x)\n",N-1,N-1,N-1)
    xp=linspace(min(x),max(x),1000);
    yp=InterLagrange(xp,x,y);
    plot(xp,yp,'r')
    scatter(x,y)
    xtitle("Polinômio de Lagrange");
endfunction

//pontos equiespaçados
 function InterpolacaoShannon(xmin,xmax,ys)
    N=length(ys)
    M=1000
    x = linspace(xmin,xmax,N)
    xn=linspace(1,N,M);
    for(m=1:M)
        yi(m)=0
        n=[1:N]'
        yi(m)=yi(m)+ ys(n)*sinc(%pi*(xn(m)-n));
    end
    xi =linspace(xmin,xmax,M)
    plot(xi,yi,'r')
    scatter(x,ys)
    xtitle("Interpolação de Shannon");
 endfunction

