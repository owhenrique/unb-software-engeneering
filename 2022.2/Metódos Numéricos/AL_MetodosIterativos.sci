prt = %f
function x0=GaussJacobi(A,b,x_ini,tol,prt)
     N = length(b);
     erro = 1;
     x0=x_ini
     sol(:,1)=x0
     erro_vector(1,1)=erro
     for k=2:500
        for j=1:N
            x1(j)=(b(j)-A(j,:)*x0 + A(j,j)*x0(j))/A(j,j);
        end
        if(norm(x1)<>0)  erro=norm(x1-x0)/norm(x1)  end
        x0=x1;
        sol(:,k)=x0
        erro_vector(1,k)=erro
        if  erro<tol    break   end
    end
    if (prt) then
        disp([A b])
        disp(['erro';'x(1)';'x(2)';'x(3)'])
        disp([erro_vector;sol])
        printf ( '\napós %i iterações, erro=%.1e\n',k,erro_vector(1,k))
        plot([0:length(erro_vector)-1],log10(erro_vector+1e-40))
    end
endfunction

function x1=GaussSeidel(A,b,x_ini,tol,prt)
     N = length(b);
     erro = 1;
     x0=x_ini
     sol(:,1)=x0
     erro_vector(1,1)=erro
     for k=2:500
       x1(1)=(b(1)-A(1,2:N)*x0(2:N))/A(1,1);
       for j=2:N-1
            x1(j)=(b(j)-A(j,1:j-1)*x1(1:j-1)-A(j,j+1:N)*x0(j+1:N))/A(j,j);
       end
       x1(N)=(b(N)-A(N,1:N-1)*(x1(1:N-1)))/A(N,N);
       if(norm(x1)<>0)  erro=norm(x1-x0)/norm(x1)  end
       x0=x1;
       sol(:,k)=x0
       erro_vector(1,k)=erro
       if  erro<tol    break   end
    end
    if (prt) then
        disp([A b])
        disp(['erro';'x(1)';'x(2)';'x(3)'])
        disp([erro_vector;sol])
        printf ( '\napós %i iterações, erro=%.1e\n',k,erro_vector(1,k))
        plot([0:length(erro_vector)-1],log10(erro_vector+1e-40))
    end
endfunction

function exemplo_algebraLinear(A,b)
    X=0:0.1:10;
    Y=0:0.1:10;
    for i=1:length(X)
        for j=1:length(Y)
            Z1(i,j)=A(1,1)*X(i)+A(1,2)*Y(j);
            Z2(i,j)=A(2,1)*X(i)+A(2,2)*Y(j);
        end
    end
    contour(X,Y,Z1,[b(1) b(1)]);
    contour(X,Y,Z2,[b(2) b(2)]);
endfunction
