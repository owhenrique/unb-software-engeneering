prt = %f
function d=det_cofat(A)
    [N,N]=size(A);
    if N>1 then
       for (col=1:N)
            D([1:N-1], [1:N-1])=A([2:N], [1:col-1 col+1:N]);
            Cof(col) = (-1)^(1+col)*det_cofat(D);
        end
        d = A(1,1:N)*Cof
    else
        d=A
        return
    end
endfunction

function d=det_cofat2(A)
    [N,N]=size(A);
    if N>2 then
       for (col=1:N)
            D([1:N-1], [1:N-1])=A([2:N], [1:col-1 col+1:N]);
            Cof(col) = (-1)^(1+col)*det_cofat(D);
        end
        d = A(1,1:N)*Cof
    else
        d=A(1,1)*A(2,2)-A(1,2)*A(2,1)
        return
    end
endfunction

function Ai=inv_cofat(A,prt)
    [N,N]=size(A);
    for (col=1:N)
        for (lin=1:N)
            Dij([1:N-1], [1:N-1])=A([1:lin-1 lin+1:N], [1:col-1 col+1:N]);
            Cof(lin,col) = (-1)^(lin+col)*det_cofat(Dij);
        end
    end
    Adj=Cof';
    Ai=(1/det_cofat(A))*Adj;
    if (prt)
        printf("Matriz A")
        disp(A)
        printf("Matriz de Cofatores")
        disp(Cof)
        printf("Matriz Adunta = transposta da Matriz dos Cofatores")
        disp(Adj)
        printf("Matriz inversa = Matriz Adjunta / det(A)")
    end
endfunction

function x=ResolucaoDireta(A,b)
     x=inv_cofat(A)*b  
endfunction

function x=Cramer(A,b,prt)
    [N N]=size(A);
    C=[A b];
    D=det_cofat(A)
    if (prt) 
        printf("Matriz Aumentada [C=A|b] det(A)=%f",D)
        disp(C)
    end
    for(k=1:N)
        Ak=A;
        Ak(:,k)=b //substitui coluna k por vetor b
        Dk=det_cofat(Ak)
        x(k)=Dk/D
        if (prt)
            printf("Matriz A%d   det(A%1d)=%f",k,k,Dk)
            disp(Ak)
            printf("x(%d)=%f/%f=%f\n",k,Dk,D,x(k))
        end
    end
endfunction

