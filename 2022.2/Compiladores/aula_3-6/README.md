# Compiladores 1 - Análise léxica

Autômatos finitos

## Reconhecedores

Um reconhecedor é um programa que identifica, respondendo "sim" ou "nao", se uma cadeia é ou não uma sentença válida de uma determinada linguagem. 

Uma estratégia para a compilação de expressões regulares em reconhecedores é o uso de diagramas de transição generalizados, denominados autômatos finitos. Um autômato finito pode ser determiniístico ou não-determinístico: no segundo caso, podem existir duas ou mais transições como o mesmo rótulo partindo de um mesmo estado. Autômatos determinísticos podem resultar em reconhecimentos mais rápidos do que os não-determinísticos, porém em geral são muito maiores, no que diz respeito ao número de estados e transições.

É possível representar expressões regulares em ambos tipos de autômatos finitos.

## Autômatos finitos não-determinísticos

Definição de AFN
```
Um autômato finito não-determinístico (AFN) é um modelo matemático que consiste em:
    
    1. um conjunto de estados S;
    2. um alfabeto ∑ de símbolos de entrada;
    3. uma função de transição que mapeia pares (estados, símbolo) em um conjunto de estados;
    4. um estado S0, denominado estado inicial ou de partida;
    5. um conjunto F de estados de aceitação (ou estados finais).
```
## Grafos de transição

Um AFN pode ser representado por meio de um grafo direcionado e rotulado, denominado grafo de transição. Em um grafo de transição, os nós representam os estados e as arestas definem a função de transição.

Os rótudos das arestas são os símbolos associados à transição, e a direção da aresta parte do estado atual para o próximo estado.

Grafos de transição se assemelham aos diagramas de transição, com duas diferenças fundamentais. A primeira diferença é que um mesmo rótulo pode estar associado a duas ou mais arestas partindo de um mesmo estado. A segunda é que o símbolo ∈ pode rotular uma aresta.

## Grafo de transição para a linguagem (a|b)*abb

![imagem1](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula3-6/Captura%20de%20tela%20de%202023-01-17%2014-29-54.png)

## Tabela de transições

Uma alternativa para a implementação da função de transição é a tabela de transições.

Em uma tabela de transições cada linha representa um estado e cada coluna representa um rótulo. Se necessário, é necessário adicionar uma coluna para o rótulo ∈.

A entrada posicionada na linha i, coluna c, contém o conjunto de estados que podem suceder o estado i quando o caractere c for lido na entrada. De fato, a tabela de transições corresponde à representação do grafo de transições como uma matriz de adjacências. Outra alternativa é representar o grafo por meio de uma lista de adjacências.

## Tabela de transições do AFN da linguagem (a|b)*abb

| Estado | Símbolo de entrada a | Símbolo de entrada b |
| :---: | :---: | :---: |
| 0 | { 0, 1 } | { o } |
| 1 | - | { 2 } |
| 2 | - | { 3 } |

## Caminhos

Um caminho em um grafo de transições é uma sequência de arestas de transição. Os rótulos das arestas, quando concatenadas, formam uma cadeia de s. Caso o símbolo ∈ seja o rótulo de uma ou mais arestas de um caminho, na concatenação dos rótulos este símbolo é descartado.

Um AFN aceita uma cadeia de entrada s se, e somente se, existe um caminho no grafo de transições que parte do estado inicial e que termina em algum estado de aceitação. Pode existir mais de um caminho que leva a um estado de aceitação.

A linguagem definida por um AFN é o conjunto de cadeias que são aceitas.

## AFN da linguagem aa*|bb*

![imagem2](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula3-6/Captura%20de%20tela%20de%202023-01-17%2014-53-21.png)

![imagem3](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula3-6/Captura%20de%20tela%20de%202023-01-17%2014-56-29.png)

## Autômatos finitos determinísticos

Definição de AFD
```
Um autômato finito determinístico (AFD) é um caso especial de AFN no qual:
    
    1. nenhum estado possui uma transição rotulada pelo símbolo ∈ (denominada transição-∈);
    2.para cada estado s existo no máxim uma transição rotulada com o caractere c partindo de s.
```

**Observação:** em um AFD, cada entrada da tabela de transições contém um único estado, o que simplifica o processo de verificação de aceitação de uma cadeia.

## Pseudocódigo para verficação de cadeias por meio de um AFD

**Input:** uma cadeia de entrada x terminada por um EOF
**Output:** "sim", caso a cadeia seja uma sentença válida da linguagem, ou "nao", caso contrario

```
s   <-  S0
c   <-  PRÓXIMOCARACTERE()

while c != EOF do
    s   <-  TRANSIÇÃO(s,c)
    c   <-  PRÓXIMOCARACTERE()

if s ∈ F then
    return "sim"

else
    return "nao"
```

## Conversão de um AFN em um AFD

Dado um AFN, é possível determinar um AFD que reconheça a mesma linguagem. A ideia central da conversão de um AFN para um AFD é fazer com que cada estado do AFD corresponda a um conjunto de estados do AFN. Seja n um AFN e d um AFD:

O primeiro passo para a conversão é construir uma tabela de transições dtrans para d.

Cada estado do AFD corresponderá a um conjunto de estados do AFN e dtrans será construída de forma a simular, "em paralelo", todas as possíveis transições de n para uma dada entrada.

Para esta tarefa, são necessárias algumas operações que envolvem um estado s de n e um conjunto t de estados de n.

## Operações sobre os estados de um AFN

| Operação | Descrição |
| :---: | :---: |
| FECHAMENTO-∈(s) | Conjunto de estados do AFN atingíveis a partir do estado s somente por meio de transições-∈ |
| FECHAMENTO-∈(t) | Conjunto de estados do AFN atingivéis a partir de algum estado s ∈ t somente por meio de transições-∈ |
| MOVIMENTO(t,a) | Conjunto de estados do AFN para o qual existe uma transição partindo de s ∈ t cujo rótulo é o símbola da entrada a |

## Relação entre as operações sobre os estados de um AFN

Antes mesmo de ver o primeiro símbolo da entrada, n pode estar em qualquer estado pertencente a FECHAMENTO-∈(s0), onde s0 é o estado inicial.

Seja t o conjunto de todos os estados atingíveis a partir de s0 e que a seja o próximo símbolo da entrada. Ao ver a, n pode seguir para qualquer estado em MOVIMENTO(t,a).

Se existem transições-∈, n pode estar em qualquer estado em FECHAMENTO-∈(m), onde m = MOVIMENTO(t,a), após ver a.

## Estados-D

O conjunto de todos os estados de d é denominado Estados-D. Cada estado de d corresponde a um conjunto de estados de AFN que poderiam ser atingidos em n após uma sequência de símbolos da entrada, incluindo as possíveis transições-∈ antes ou depois dos símbolos serem vistos.

O estado de partida de d é o FECHAMENTO-∈(s0). Os demais estados são adicionados segundo o algoritmo descrito a seguir. Os estados de aceitação de d são aqueles cujo conjunto de estados de AFN que ele representa contém ao menos um estado de aceitação de n.

## Construção de subconjuntos

```
f   <-  FECHAMENTO-∈(s0)
Desmarque f
Inclua em f os Estados-D
while existe um estado t ∈ Estados-D não marcado do
    Marque t
    for cada símbolo de entrada a do
        m   <-  MOVIMENTO(t,a)
        u   <-  FECHAMENTO-∈(m)
        if u ∉ Estados-D then
            Desmarque u
            Inclua u e Estados-D
        dtrans[t,a] <-  u
```

## Cálculo de FECHAMENTO-∈(t)

```
Seja p uma pilha
Empilhe em p todos os estados em t
Inclua t em FECHAMENTO-∈(t)
while p não estiver vazia do
    desempilhe o topo t de p
    for cada estado u que é chegada de uma aresta partindo de t com rótulo ∈ do
        if u ∉ FECHAMENTO-∈(t) then
            Inclua u em FECHAMENTO-∈(t)
            Empilhe u
```

## AFN para a linguagem (a|b)*abb

![imagem4](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula3-6/Captura%20de%20tela%20de%202023-01-17%2015-45-26.png)

## Convertendo o AFN em um AFD

O estado inicial do AFD será o estado A = FECHAMENTO-∈(0) = { 0, 1, 2, 4, 7 }

Veja que no cálculo de FECHAMENTO-∈(0), o estado 0 é atingível por meio de um caminho vazio.

O alfabeto da linguagem é ∑ = { a,b }.

Seguindo o algoritmo, o próximo estado será B = FECHAMENTO-∈(m), onde m = MOVIMENTO(A,a). Segue que m = MOVIMENTO(A,a) = MOVIMENTO({ 0, 1, 2, 4, 7},a) = { 3, 8 }.

Daí B = FECHAMENTO-∈({ 3, 8 }) = { 1, 2, 3, 4, 6, 7, 8 }.

A transição entre estes dois estados deve ser registrada na tabela dtrans, dtrans[A,a] = B.

O próximo estado c é computado a partir de MOVIMENTO(A, b) = { 5 }: C = FECHAMENTO-∈({ 5 }) = { 1, 2, 3, 4, 5, 6, 7 }.

Assim, dtrans[A,b] = C.

Seguindo o algoritmo, apenas mais dois estados distindos serão encontrados: D = { 1, 2, 4, 5, 6, 7, 9} e E = { 1, 2, 4, 5, 6, 7, 10 }.

Dentre os estados identificados, apenas E é estado de aceitação, pois contém o estado 10 de n. No pior caso, seriam identificados 2^n novos estados, onde n é o número de estados do AFN.

## Resultado da conversão do AFN para um AFD

![imagem 5](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula3-6/Captura%20de%20tela%20de%202023-01-17%2016-08-55.png)

