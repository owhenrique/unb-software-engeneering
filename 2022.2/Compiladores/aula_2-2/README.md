# Compiladores 1 -Um compilador simples de uma passagem

Definição da sintaxe.

## Definições

Uma gramática deve descrever a estrutura hierárquica de seus elementos. Por exemplo, o comando *if-else* da linguagem **C** possui a seguinte forma:

<center>if(expressão) comando else comando</center>

a qual pode ser expressa como, *cmd* -> **if** (*expr*) *cmd* **else** *cmd*.

A Expressão acima é uma regra de produção, onde a seta significa "pode ter a forma". Os elementos léxicos da produção (palavras-chaves, parêntesis) são chamados **tokens** ou terminais.

Variáveis como *expr* e *cmd* representam sequências de tokens e são denominadas não-terminais.

```
Então a produção cmd -> if(expr) cmd else cmd, tem os seguintes elementos:

cmd, expr: sequência de tokens não terminais

if, (), else: tokens ou terminais
```

## Componentes da linguagem livre de contexto

1. Um conjunto de *token*, denominados símbolos terminais;
2. UM conjunto de *não-terminais*;
3. UM conjunto de produções. Cada produção é definida por um não-terminal (lado esquerdo), seguido de uma seta, sucedida por uma sequência de tokens e/ou não-terminais (lado direito);
4. Designação de um dos não-terminais como símbolo de partida.

## Convenções de notação de gramática livre de contexto

A gramática livre de contexto é especificada por uma lista de produções. O símbolo de partida é definido como o não-terminal da primeira produção listada. Dígitos, símbolos e palavras em negrito são terminais. Não-terminais são grafados em itálico. Os demais símbolos são tokens.

Produções distintas de um mesmo não-terminal podem ser agrupadas por do caractere '|', que significa, neste conxtexto, "ou".

### Exemplo de sintaxe para expressões infixas com adição e subtração

Considere a seguinte gramática para expressões compostas por dígitos decimais e as operações de adição e subtração, em forma infixa:

*expr* -> *expr* + *digito* | *expr* - *digito* | *digito*

*digito* -> 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9

Os tokens desta gramática são os dez dígitos decimais e os caracteres '+' e '-'. Os não-terminais são *expr* e *digito*. O símbolo de partida é o não-terminal *expr*.

## Cadeia de tokens

Uma cadeia de tokens é uma sequência de zero ou mais tokens. Uma cadeia contendo zero tokens, grafada como ∈, é denominada cadeia vazia. Uma gramática deriva cadeias de tokens começando pelo símbolo de partida, substituindo repetidamente um não-terminal pelo lado direito de uma produção deste não-terminal. O conjunto de todas as cadeias de tokens possíveis gerados deta maneira formam a linguagem definida pela gramática. 

### Exemplo de construção da expressão 1-2+3 por meio da gramática

1. 1 é *expr*, pois 1 é *digito* (terceira alternativa para a produção de *expr*);
2. Pela segunda alternativa de produção de *expr*, 1-2 é também *expr*, pois 1 é *expr* e 2 é *digito* ;
3. Por fim, pela primeira alternativa de produção de *expr*, 1-2+3 é *expr*, pois 1-2 é *epxr* e 3 é *digito*.

## Árvore gramatical

Dada a gramática livre de contexto, uma árvore gramatical possui as seguintes propriedades:

1. A raiz é rotulada pelo símbolo de partida;
2. Cada folha é rotulada por um token ou por ∈;
3. Cada nó interior é rotulado por um não-terminal;
4. Se *A* é um não-terminal que rotula um nó interior e **X1,X2,...,Xn** são os rótulos de seus filhos (da esquerda para a direita), então:

*A* -> **X1 X2 ... Xn**

é uma produção.

### Visualização da árvore gramatical da expressão 1-2+3

![imagem1](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-2/Captura%20de%20tela%20de%202022-12-02%2000-13-53.png)

## Características da árvore gramatical

As folhas da árvore gramatical, quando lidas da esquerda para a direita, formam o produto da árvore, que é a cadeia gerada ou derivada a partir da raiz não-terminal. O processo de encontrar uma árvore gramatical para uma dada cadeia de tokens é chamado de análise gramatical ou análise sintática daquela cadeia. 

Uma gramática que permite a construção de duas ou mais árvores gramaticais distintas para uma mesma cadeia de tokens é denominada gramática ambígua. A gramatica apresentada não é ambígua. Contudo, se removida a distinção entre *expr* e *digito*, a gramática passaria a ser ambígua. Por exemplo:

*expr* -> *expr* + *expr* | *expr - expr* | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9

### Exemplo de gramática ambígua

![imagem2](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-2/Captura%20de%20tela%20de%202022-12-02%2000-22-19.png)

## Associatividade de operadores

Quando um operando está, simultaneamente, à esquerda e a à direita de dois operadores (por exemplo, o dígito 2 na expressão 1-2+3), é preciso dicidir qual destes operadores receberá o operando.

Uma operação + é associativa à esquerda se *a + b + c = (a + b) + c*. Na maioria das linguagens de programação, os operadores aritméticos (+, -, * e /) são associativos à esquerda.

Uma operação + é associativa à direita se *a + b + c = a + (b + c)*. Por exemplo, a atribuição (operador = ) da linguagem C é associativa à direita, a expressão *a = b = c* equivale a expressão *a = (b = c)*. Uma gramática possível para esta atribuição seria: 

*expr* -> *var* = *expr* | *var*

*var* -> *a | b | ... | z*

## Precedência dos operadores

Algumas expressões da aritmética contém ambiguidades que não podem ser resolvidas apenas por meio da associatividade. Por exemplo, qual seria o resultado da expressão 1 + 2 * 3? 9 ou 7?

Dizemos que o operador * tem maior precedência do que o operador + se * captura os operandos antes que + o faça. Na aritmética, a multiplicação e a divisão tem maior precedência do que a adição e a subtração.

Se dois operadores tem a mesma precêndia, a associatividade determina a ordem que as operações serão realizadas.

## Construção de gramáticas com precedência de operadores

É possível construir uma gramática com precêndia de operadores a partir dos seguintes passos: 

1. Construa uma tabela com a a associatividade e a precedência dos operadores, em ordem crescente de precedência (operadores com mesma precedência aparecem na mesma linha):

<center>associatividade à esquerda + e -</center>
<center>associativadade à direita * e /</center>

2. Cire um não-terminal para cada nível (*expr* e *termo*) e um não-terminal extra para as unidades básicas da expressão (*fator*):

*fator* -> **digito** | *expr*

3. Defina as produções para o último terminal criado para os níveis a partir dos operadores com maior precedência: 

*termo* -> *termo* * *fator* | *termo* / *fator* | *fator*

4. Faça o mesmo para os demais operadores, em ordem decrescente de precedêmcoa e crescente na lista de terminais criados para os níveis:

*expr* -> *expr* + *termo | *expr* - *termo* | *termo*

A presença de parêntesis na definição de *fator* permite escrever expressões com níveis arbitrários de aninhamento, sendo que os parêntesis tem precedência sobre todos os operadores definidos.



