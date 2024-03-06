# COMPILADORES 1 - Um Compilador simples de uma passagem

Visão geral.

## Caracterização de uma linguagem de programação

Uma linguagem de programação pode ser caracterizada por sua sintaxe (aparência e forma de seus elementos) e por sua semântica (o significado destes elementos). Uma forma de especificar a sintaxe de uma linguagem é a gramática livre de contexto (BNF - Forma de Backus-Naur).

Além de especificar a semântica, a gramática livre de contexto auxilia a tradução do programa, por meio da técnica denominada tradução diriga pela sintaxe.

A especificação da semântica é mais complicada, de modo que em muitos casos é feita por meio de exemplos e descrições informais.

## Compilador de expressões infixas para posfixas

A tradução dirigida pela sintaxe será ilustrada por meio do desenvolvimento de um compilador simples de uma passagem que traduz expressões na forma infixa para a forma posfixa. Por exemplo, a expressão 1-2+3, que está na forma infixa (o operador está posicionado entre os operandos), corresponde a expressão posfixa 12-3+ (o operador sucede os dois operandos, assuma que cada operando consiste em um único dígito). A forma posfixa pode ser convertida diretamente para um programa que executa a expressão usando uma pilha.

O analisador léxico gerará um fluxo de tokens que alimentarão o tradutor dirigido pela sintaxe (o qual combinará o analisador sintático com o gerador de código intermediário), que por sua vez gerará a representação posfixa. 

## Estrutura da interface de vanguarda do compilador

![imagem1](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-1/Captura%20de%20tela%20de%202022-12-01%2000-39-34.png)