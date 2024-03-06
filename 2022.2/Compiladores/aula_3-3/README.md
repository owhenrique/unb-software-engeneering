# Compiladores 1 - Análise léxica

Especificação dos tokens

## Alfabetos

Definição de alfabeto
```
Um alfabeto, ou classe de caracteres, é um conjunto finito de símbolos.
```

Exemplos de alfabetos: ASCII, EBCDIC, o alfabeto binário { 0, 1 }, os dígitos decimais, etc.

## Cadeias 

Definição de cadeia
```
Uma cadeia sobre um alfabeto A é uma sequência finita de elementos de A. Os termos sentença, palavra e string são geralmente usados como sinônimos de cadeia.
```

## Conceitos associados à cadeias

* - O comprimento (número de caracteres) de uma cadeia s é denotado por |s|; 
* - A cadeia vazia ∈ tem comprimento igual a zero;
* - Um prefixo de s é uma cadeia obtida pela remoção de zero ou mais caracteres do fim de s;
* - Um sufixo de s é uma cadeia obtida pela remoção de zero ou mais caracteres do inicio de s;
* - Uma subcadeia de s é uma cadeia obtida pela remoção de um prefixo e de um sufixo de s;
* - Um prefixo, sufixo ou subcadeia de s são ditos próprios se diferem de ∈ e de s;
* - Uma subsequência de s é uma cadeia obtida pela remoção de zero ou mais símbolos de s, não necessariamente contíguos.

## Linguagens

Definição de linguagem
```
Uma linguagem é um conjunto de cadeias sobre algum alfabeto A fixo.
```

Esta definição contempla também linguagens abstratas como Ø (o conjunto vazio), ou { ∈ }, o conjunto contendo apenas a cadeia vazia.

## Operações em cadeias

Se x e y são duas cadeias, então a concatenação de x e y, denotada xy, é a cadeia formada pelo acréscimo, ao final de x, de todos os caracteres de y, na mesma ordem. Por exemplo, se x = "rodo" e y = "via", então xy = "rodovia".

A cadeia vazia ∈ é o elemento neutro da concatenação. Se a concatenação for vizualizada como um produto, é possível definir uma "exponenciação" de cadeias. Seja s uma cadeia e n um natural. Então:
    
    1 - s⁰ = ∈
    2 - s^n = ss^(n-1) 

## Operações em linguagens 

Sejam L e M duas lingaugens. São definidas as seguintes operações sobre linguagens.

![imagem1](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula3-3/Captura%20de%20tela%20de%202023-01-15%2023-22-59.png)

## Exemplos de operações em linguagens

Seja L = { A, B, C, ..., Z, a, b, c, ..., z} e M = { 0, 1, 2, ..., 9}. Então:

1. LUM é o conjunto de letras e dígitos;
2. LM é o conjunto de cadeias formadas por uma letra, seguida de um dígito;
3. L⁴ é o conjunto de todas as cadeias formadas por exatamente quatro letras;
4. L* é o conjunto de todas as cadeias formadas por letras, incluíndo a cadeia ∈;
5. L(LUM)* é o conjunto de cadeias de letras e dígitos, que iniciam com uma letra;
6. M+ é o conjunto de cadeias formadas por um ou mais dígitos. 

## Expressões regulares

Definição de expressão regular
```
Sejam ∑ um alfabeto. As expressões regulares sobre ∑ são definidas pelas seguintes regras, onde cada expressão regular define uma linguagem:
    1. ∈ é uma expressão regular que denota a linguagem { ∈ };
    2. Se a ∈ ∑, então a é uma expressão regular que denota a linguagem { a };
    3. Se r e s são duas expressões regulares que denotam as linguagens L(r) e L(s), então
        A. (r) é uma expressão regular que denota L(r);
        B. (r) | (s) é uma expressão regular que denota L(r) U L(s);
        C. (r)(s) é uma expressão regular que denota L(r)L(s);
        D. (r)* é uma expressão regular que denota (L(r))*.
```

## Expressões regulares e parêntesis

O uso de parêntesis em expressões regulares pode ser reduzido se forem adotadas as seguintes convenções: 

1. O operador unário * possui a maior precedência e é associativo à esquerda;

2. a concatenação tem a segunda maior precedência e é associativa à esquerda;

3. O operador | tem a menor precedência e é associativo à esquerda.

Neste cenário, a expressão regular (a) | ((b) * (c)) equivale a a | b* c.

## Exemplos de expressões regulares 

Sejam ∑ = { a, b }. Então:

1. a | b denota a linguagem { a, b };
2. (a | b)(a | b) denota { aa, ab, ba, bb };
3. a* denota { ∈, a, aa, aaa, ... }
4. (a| b)* denota todas as cadeias formadas por zero ou mais instâncias de a ou de b;
5. a | a* b denota a cadeia a e todas as cadeias iniciadas por zero ou mais a's, seguidos de um b.

## Propriedades das expressões regulares

Sejam r,s,t expressões regulares. Valem as seguintes propriedades:

![imagem2](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula3-3/Captura%20de%20tela%20de%202023-01-15%2023-56-18.png)

## Definições regulares

Definição
```
Sejam ∑ um alfabeto. Uma definição regular sobre ∑ é uma sequência de definições da forma

        d1 -> r1
        d2 -> r2
        ...
        dn -> rn

onde cada di é um nome distinto e ri uma expressão regular sobre o alfabeto ∑ U { d1, d2, ..., di-1 }.
```

## Exemplo de definição regular

Os identificadores de Pascal, e em muitas outras linguaguens, são formados por cadeias de caracteres e dígitos, começando com uma letra.

Abaixo segue a definição regular para o conjunto de todos os identificadores válidos em Pascal:

```
    letra - > A | B | C | ... | Z | c | b | c | ... | z
    digito -> 0 | 1 | 2 | ... | 9
    id -> letra (letra | digito)*
```

## Simplificações notacionais 

As seguintes notações podem simplificar as expressões regulares:

1. Uma ou mais ocorrências. Se r é uma expressão regular, então (r)+ denota (L(r))+. O operador + tem a mesma associatividade e precedência do operador *. 

    Vale lembrar que r* = r+ | ∈ e que r+ = rr*.

2. Zero ou uma. Se r é uma expressão regular, então r? denota L(r) U ∈. O operador ? é posfixo e unário, e r? = r | ∈.

3. Classes de caracteres. A notação [abc], onde a, b, c são símbolos do alfabeto, denota a expressão regular a | b | c. A notação [a-z] abrevia a expressão regular a | b | ... | z.

## Limitações das expressões regulares

Existem linguagens que não podem ser descritas por meio de expressões regulares. Por exemplo, não é possível descrever o conjunto P de todas as cadeias de parêntesis balanceados por meio de expressões regulares. Contudo, o conjunto P pode ser descrito por meio de uma gramática livre de contexto. 

Existem linguagens que não podem ser descritas nem mesmo por meio de uma gramática livre de contexto. Por exemplo, o conjunto C = { wcw | w é uma cadeia de a's e b's }. Não pode ser descrito nem por expressões regulares e nem por meio de uma gramática livre de contexto.
