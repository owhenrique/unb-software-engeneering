# Compiladores 1 - Um compilador simples de uma passagem

Tradução dirigida pela sintaxe.
## Notação posfixa

```
Definição de notação posfixa

A notação posfixa para uma expressão E é definida da seguinte maneira:

1. Se E for uma variável ou uma constante, então a notação posfixa para E é o próprio E;

2. Se E é uma expressão da forma E1 op E2, onde op é um operador binário, então a forma posfixa para E é E1' E2' op, onde E1' e E2' são notações posfixas de E1 e E2, respectivamente;

3. Se E é uma expressão da forma (E1), então a notação posfixa para E1 será a notação posfixa para E.
```

## Definições dirigidas pela sintaxe

Uma definição dirigida pela sintaxe usa a gramatica livre de contexto para especificar a estrutura sintática da entrada. Ela associa, a cada símbolo da gramática, um conjunto de atributos e, a cada produção, um conjunto de regras semânticas para computar os valores dos atributos associados aos símbolos presentes na produção. 

A gramática e o conjunto de regras semânticas constituem a definição dirigida pela sintaxe. 

Um atributo é dito **sintetizado** se seu valor depende apenas dos valores dos atributos dos nós filhos de seu nó na árvore gramatical. Os atributos sintetizados podem ser computados por meio de uma travessia por profundidade.

## Definição dirigida pela sintaxe para a tradução de notação infixa para posfixa

![imagem1](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-3/Captura%20de%20tela%20de%202022-12-02%2002-47-40.png)

### Valores dos atributos nos nós da árvore gramatical da expressão 1-2+3

![imagem2](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-3/Captura%20de%20tela%20de%202022-12-02%2002-50-43.png)

## Esquema de tradução

Um esquema de tradução, é uma gramática livre de contexto no qual fragmentos de programas, denominados ações semânticas, são inseridos no lado direito das produções. Num esquema de tradução, a ordem de avaliação das ações semânticas é explicitamente mostrada. A posição na qual uma ação semântica deve ser executada é marcada no lado direito da produção, por meio de chaves.

Na árvore gramatical uma ação semântica é indicada por um filho extra, conectado por meio de uma linha pontilhada. Nós rotulados por ações gramaticas não possuem filhos.

### Ações semânticas para a tradução de expressões para a notação posfixa

![imagem3](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-3/Captura%20de%20tela%20de%202022-12-02%2002-59-59.png)

### Árvore gramatical com ações semânticas que traduz a expressão 1-2+3

![imagem4](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-3/Captura%20de%20tela%20de%202022-12-02%2003-02-18.png)