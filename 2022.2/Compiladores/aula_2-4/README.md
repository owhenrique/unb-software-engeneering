# Compiladores 1 -Um compilador simples de uma passagem

A análise gramatical.

## Análise gramatical

A análise gramatical é o processo de se determinar se uma cadeia de tokens pode ser gerada por uma gramática.

O compilador deve ser capaz de construir uma árvore gramatical, mesmo que de forma implícita. Um analisador gramatical pode ser construído para qualquer gramática. Existe um analisador gramatical que analisa N tokens com complexidade O(N³) para qualquer gramática livre de contexto. Contudo, existem analisadores lineares para quase todas as gramáticas livre de contexto que surgem na prática.

## Análise top-down e bottom-up

Há duas classes principais de analisadores gramaticais. Analisadores top-down, a construção parte da raiz da árvore gramatical para suas folhas. Analisadores bottom-up partem das folhas em direção à raiz.

Os analisadores top-down são mais populares, pois é possível construir analisadores eficientes desta classe de forma manual. Já analisadores bottom-up podem manipular uma gama mais ampla de gramáticas.

Geradores de analisadores gramaticais tendem a usar métodos bottom-up.

## Construção top-down de uma árvore gramatical

1. Inicie na raiz, rotulada pelo não-terminal de partida.
2. Repita os seguintes passos:
    * Para o nó *n*, rotulado pelo não-terminal *A*, selecione uma das produções para *A* e construa os filhos de *n* com os símbolos do lado direito da produção.
    * Encontre o próximo nó no qual uma subárvore deve ser construída.

```
Obs.:

(i) A depender da gramática, esta construção pode ser implementada com uma única passagem da entrada, da esquerda para a direita.

(ii) O token que está sendo observado é frequentemente denomidado lookahead.

(iii) Inicialmente lookahead é o token mais à esqueda da entrada.
```
### Exemplo de gramática para geração de subtipos em Pascal

![imagem1](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-4/Captura%20de%20tela%20de%202022-12-03%2019-51-05.png)

### Exemplo de construção top-down da árvore gramatical

Considere a expressão **array of [num..num] of integer**, gerada a partir da gramática de subtipos em Pascal.

1. A construção inicial na raiz da árvore. O rótulo da raiz é não-terminal de partida *tipo*

2. A única produção de *tipo* que inica com **lookahead** (neste momento, **array**) é a terceira. Esta produção será usada para a criação dos filhos do nó raiz.

![imagem2](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-4/Captura%20de%20tela%20de%202022-12-03%2019-56-20.png)

3. O filho mais à esquerda tem como rótulo **array**. Como este rótulo coincide com lookahead, a construção prossegue para o próximo filho.

4. Lookahead é atualizado para **[**, e confrontado com o segundo filho à esquerda da raiz. Como há nova coincidência entre o rótulo e lookahead, a construção prossegue.

5. O nó seguinte contém o não-terminal *primitivo* e lookahead contém o token **num**. Assim a terceira produção de *primitivo* é atualizada para gerar os novos filhos.

![imagem3](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-4/Captura%20de%20tela%20de%202022-12-03%2020-41-06.png)

6. Os próximos tokens (**:**, **num**, **of**) coincidem com os respectivos filhos.

7. O último valor que lookahead assume é o **integer**, o qual é confrontado com o filho mais à direita da raiz. Como o nó tem como rótudlo o não-terminal *tipo*, a primeira produção deste deve ser usada para construir o novo nó, que por sua vez usa a primeira produção de *primitivo* para construir seu único filho.

![imagem4](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-4/Captura%20de%20tela%20de%202022-12-03%2020-44-45.png)

## Análise gramatical preditiva

Uma análise gramatical descendente recursiva é um método top-down de análise sintática na qual são executados procedimentos recursivos para processar a entrada. Cada não-terminal da entrada é associado a um procedimento. Se lookahead determina, sem ambiguidades, o procedimento a ser executado, a análise gramatical descendente recursiva é denominada análise gramatical preditiva. A sequência de chamadas de procedimentos no processamento da entrada determina, de forma implícita, a árvore gramatica. Além dos procedimentos associados aos não terminais, a análise pode definir outros procedimentos auxiliares que podem simplificar tardefas como a leitura de tokens e a atualização de lookahead.

## Reconhecimento de tokens

O procedimento **RECONHECER()** confronta o valor de lookahead e um determinado token. Em caso de coincidência, ele atualiza lookahead com o próximo token da entrada. 

![imagem5](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-4/Captura%20de%20tela%20de%202022-12-03%2020-57-22.png)

## Procedimento associado ao não-terminal *tipo*

![imagem6](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-4/Captura%20de%20tela%20de%202022-12-03%2021-00-17.png)

## Procedimento associado ao não-terminal *primitivo*

![imagem7](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-4/Captura%20de%20tela%20de%202022-12-03%2021-02-17.png)

## Primeiros símbolos

```
Definição de primeiros símbolos

Seja α o lado direito de uma produção, então PRIMEIRO(α) é o conjunto de tokens que figuram como primeiros símbolos de uma ou mais cadeias geradas a partir de α. Se ∈ (cadeia contendo zero tokens) pode ser gerado a partir de α, então ∈ pertence a PRIMEIRO(α).
```
Por exemplo, na gramática de geração de subtipos em Pascal,

<center> PRIMEIRO(primitivo) = {integer, char, num} </center>

e

<center>PRIMEIRO(↑id)={↑id}</center>

## Primeiros símbolos e análise gramatica preditiva

A análise gramatical preditiva depende dos conjuntos PRIMEIRO(X) de todos os não-terminais X da gramática. Isto acontece principalmente nos casos onde a gramática possui duas ou mais produções para um mesmo não-terminal (por exemplo, A -> α e A -> β). Para que a análise gramatical recursiva descente seja preditiva é necessário que os primeiros símbolos de cada produção sejam distintos. No exemplo dado, PRIMEIRO(α) ∩ PRIMEIRO(β) = Ø. Caso esta condição se verifique para todos os pares de produções distintas de um mesmo não-terminal, a produção y deve ser usada se lookahead ∈ PRIMEIRO(y).

## Projeto de um analisador gramatical preditivo

Um analisador gramatical preditivo é um programa que contém um procedimento para cada não-terminal. Cada procedimento deve seguir dois passos.

1. Determinar a produção a ser usada a partir de lookahead. Para tanto, deve ser localizada, entre as produções α1, α2, ..., αn, a produção αi tal que lookahead ∈ PRIMEIRO(αi) (deve valer a seguinte propriedade: PRIMEIRO(αi) ∩ PRIMEIRO(αj) = Ø se i != j). Se αk = ∈ para algum k, αk deve ser usada se lookahead não estiver presente em nenhuma outra produção.

2. Identificada a produção, o procedimento imita a produção, reconhecendo os terminais da produção e chamando os procedimentos dos não-terminais, na mesma ordem da produção. 

## Produções recursivas à esquerda

```
Definição de produção recursiva à esquerda

Uma produção é recursiva à esquerda se o não-terminal à esquerda da produção figura como primeiro símbolo da produção. Por exemplo, se α e β são sequências de terminais e não-terminais que não iniciam em A, então a produção A -> Aα | β, é recursiva à esquerda. 

Obs.: Analisadores gramaticais recursivos descendentes pode rodar indefinidamente caso usem uma produção recursiva à esquerda.
```

## Produções recursivas à direita

```
Definição de produção recursiva à direita

Uma produção é recursiva à direita se o não-terminal à esquerda da produção figura como último símbolo da produção. Por exemplo se α e β são sequências de terminais e não-terminais que não terminam em R, então a segunda produção abaixo: 

A -> β
R -> αR | ∈

é recursiva à direita.

Obs.: produções recursivas à direita dificultam a tradução de expressões que contém operadores associativos à esquerda.
```