prt=%f
pivot=%t
function [C,m]=EliminarLinha(lin,p,C,prt)
  [N,M]=size(C)
  if (prt)
    printf("(L%d)=(L%d)-(%f)/(%f)*L(%d)",lin,lin,C(lin,p),C(p,p),p)
    if lin<N then printf("\n") end
  end
  m=C(lin,p)/C(p,p);
  C(lin,p:M)=C(lin,p:M)-m*C(p,p:M);
endfunction

function [C,dist]=PivotarColuna(p,linhas,C,prt)
     [N,M]=size(C)
     [max_lin_p,dist]=max(abs(C(linhas,p)));  // pivotamento
     if(dist<>1) then  
         C([ p, (dist+p-1)],:) = C([ (dist+p-1) , p ],:) //troca linhas
         if(prt)
             printf("Trocando linhas %d e %d",p,dist+p-1)
             disp(C)
         end
     end
endfunction

function y=SubstituicaoProgressiva(A,b,prt)
  [N,M]=size(A)
  y(1)=b(1);
  if (prt)  printf("Substituição Progressiva\ny(%d)=%f\n",1,y(1)); end
  for lin=2:N
        y(lin)= b(lin)-A(lin,1:lin-1)*y(1:lin-1);
         if (prt) printf("y(%d)=%f\n",lin,y(lin)) end
  end
endfunction

function x=SubstituicaoRegressiva(A,b,prt)
  [N,N]=size(A)
  x(N)=b(N)/A(N,N);
  if (prt)  printf("Substituição regressiva\nx(%d)=%f\n",N,x(N)); end
  for lin=N-1:-1:1
     x(lin)=(b(lin)-A(lin,lin+1:N)*x(lin+1:N))/A(lin,lin);
     if (prt) printf("x(%d)=%f\n",lin,x(lin)) end
   end
endfunction

pivot=%f
function x=EliminacaoGauss(A,b,prt,pivot)// com pivotamento
   [N N]=size(A); 
   C=[A b];
   if(prt)
       printf("Matriz Aumentada [C=A|b]")
       disp(C)
   end
   for p=1:N-1
       if(pivot)
            C=PivotarColuna(p,[p:N],C,prt)
        else  
            if C(p,p) == 0 then break; end
        end
      
       if (prt)
            printf("Eliminando coluna %d com Pivô %f\n",p,C(p,p)) 
       end 
       for lin=p+1:N   //eliminação progressiva
           C=EliminarLinha(lin,p,C,prt)
       end 
       if (prt) disp(C)  end
    end
    if C(p,p)<>0 
         x=SubstituicaoRegressiva(C(:,1:N),C(:,N+1))
    else
         printf("Não há solução única pois matriz A é singular")
         x(1:N)=%inf
    end
endfunction

function d=det_gauss(A,prt,pivot)
   [N N]=size(A); 
   if(prt)  disp(A)  end
   npivot=0;
   for p=1:N-1
       dist=1
       if (pivot)
            [A,dist]=PivotarColuna(p,[p:N],A,prt)
            if(dist<>1) npivot=npivot+1 end
       end
       if A(p,p) == 0 then break; end
       if (prt)
            printf("Eliminando coluna %d com Pivô %f\n",p,A(p,p)) 
       end 
       for lin=p+1:N   //eliminação progressiva
           A=EliminarLinha(lin,p,A,prt)
       end 
       if (prt) disp(A)  end
    end
    d=prod(diag(A)) * (-1)^npivot
endfunction


function x=EliminacaoGaussJordan(A,b,prt)
   [N N]=size(A); 
   C=[A b];
   if(prt)
       printf("Matriz Aumentada [C=A|b]")
       disp(C)
   end
   for p=1:N
       C=PivotarColuna(p,[p:N],C,prt)
       if C(p,p) == 0 then break; end
       C(p,:)=C(p,:)/C(p,p);  // normalização da linha p
       if (prt)
           printf("Eliminando coluna %d com Pivô %f\n",p,C(p,p)) 
           printf("(L%d)=(1)/(%f)*(L%d)\n",p,C(p,p),p)
       end 
       for lin=[1:p-1,p+1:N] //eliminação regressiva e progressiva
            C=EliminarLinha(lin,p,C,prt)
       end
       if (prt) disp(C)  end
       disp(C)
    end
    if C(p,p)<>0 
       x=C(:,N+1)
    else
       printf("Não há solução única pois matriz A é singular")
       x(1:N)=%inf
    end
endfunction

function Ai=inv_gauss(A,prt)
   [N N]=size(A); 
   C=[A diag(ones(1:N))];
   if(prt)
       printf("Matriz Aumentada [C=A|Ai]")
       disp(C)
   end
   for p=1:N
       C=PivotarColuna(p,[p:N],C,prt)
       if C(p,p) == 0 then break; end
       C(p,:)=C(p,:)/C(p,p);  // normalização da linha p
       if (prt)
           printf("Eliminando coluna %d com Pivô %f\n",p,C(p,p)) 
           printf("(L%d)=(1)/(%f)*(L%d)\n",p,C(p,p),p)
       end 
       for lin=[1:p-1,p+1:N] //eliminação regressiva e progressiva
            C=EliminarLinha(lin,p,C,prt)
       end
       if (prt) disp(C)  end
    end
    if C(p,p)<>0 
       Ai=C(1:N,N+1:2*N)
    else
       printf("Não há solução única pois matriz A é singular")
       Ai=[]
    end
endfunction

function [L,U,P]= FatoracaoLU(A,prt)
   [N N]=size(A); 
   L=diag(ones(1:N))
   P=L //Matriz de permutação de linhas
   U=A
   if (prt) disp([L,U])  end
   for p=1:N-1
     [U,dist]=PivotarColuna(p,[p:N],U,%f)
     if(dist<>1) // se houve pivotamento
       P([ p, (dist+p-1)],:) = P([ (dist+p-1) , p ],:) //troca linhas
       for (col=1:p) // troca linhas abaixo da diagonal
         if (col<p) L([p,(dist+p-1)],col) = L([(dist+p-1),p],col) end
       end
       if (prt)
          printf("Trocando linhas %d e %d de U\n",p,p+dist-1) 
          printf("Trocando linhas %d e %d de L abaixo da diagonal",p,p+dist-1) 
          disp([L,U])
       end
     end
     if U(p,p) == 0 then break; end
     if (prt)   
         printf("Eliminando coluna %d com Pivô %f\n",p,U(p,p)) 
     end 
     for lin=p+1:N   //eliminação progressiva
        [U,m]=EliminarLinha(lin,p,U,prt) 
        L(lin,p) = m;
     end 
     if (prt) disp([L,U])  end
  end
endfunction

function x= SolucaoLU(L,U,P,b,prt)
    bp=P*b
    y=SubstituicaoProgressiva(L,bp,%f)
    x=SubstituicaoRegressiva(U,y,%f)
    if (prt)
        printf("[b bp]")
        disp([b bp])
        printf("matriz aumentada  [L  bp y]")
        disp([L bp y])
        printf("matriz aumentada  [U y x]")
        disp([U y x])
    end
endfunction

//  A=diag(dl,-1)+diag(dp)+diag(du,1)
//  A y = r
function y=tridiagonal(dl,dp,du,r)
    N=length(r);
    for k=2:N  //eliminação progressiva
        m=dl(k-1)/dp(k-1);
        dp(k)=dp(k)-m*du(k-1);
        r(k)=r(k)-m*r(k-1);
    end
    y(1,N)=r(N)/dp(N); //substituição regressiva
    for k= N-1:-1:1
        y(1,k)=(r(k)-du(k)*y(k+1))/dp(k);
    end
endfunction

