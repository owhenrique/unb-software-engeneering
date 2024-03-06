# Compiladores 1 - Análise léxica 

Uma linguagem para especificação de analisadores léxicos

## Flex

Flex (Fast Lexical Analyzer Generator) é um programa para a geração de analisadores léxicos. Ele foi escrito em linguagem C por Vern Paxson por volta de 1987. Ele pode ser usado em conjunto com um gerador de analisadores sintáticos (por exemplo, o Yacc e o GNU Bison).

Flex é o mais flexível e gera códigos mais rápidos que o Lex, outro programa gerador de analisadores léxicos. Ele pode ser instalado, em distribuições Linux baseadas no Debian, por meio do comando

```
    $ sudo apt-get install flex
```

## Fluxo de uso do Flex para a geração de analisadores léxicos

![imagem1]()

## Programas Lex


Programas Lex são salvos em arquivos com extensão .l (ou lex). Estes programas exportam uma função chamada yylex() que, ao ser chamada, extrai o próximo token do programa fonte. O código gerado (arquivos lex.yy.c) pode ser usado para gerar um executável independente, ou poder ser compilado como código objeto e ser integrado ao analisador sintático. 

Os programas Lex são dividos em três partes: a seção de definições, a seção de regras e a seção de códigos de usuário. A vantagem do uso de programas Lex é que eles permitem a especificação dos tokens por meio de expressões regulares, e a implementação dos diagramas de transição é feita automaticamente pelo Flex.

## Seção de definições

Nesta seção são declaradas variáveis, constantes e definições regulares. As declarações desta seção devem ser delimitadas pelas sequências de caracteres "%{" e "%}".

O conteúdo desta seção é copiado diretamente para o arquivo lex.yy.c.

As definições regulares devem ser declaradas após esta seção, na forma *nome regex*. Uma vez definido um nome, ele pode ser usado nas definições regulares subsequentes, desde que sejam delimitados por chaves.


## Seção de regras

Esta seção contém uma série de regras, uma por linha, na forma *padrão ação*. O padrão deve estar identado e deve estar na mesma linha da ação. O padrão pode conter algum nome presente nas declarações regulares. Neste caso, o nome deve ser delimitado por chaves. Esta seção é delimitada pela sequência de caracteres %%.


