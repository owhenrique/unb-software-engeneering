# Compiladores 1 - Um compilador simples de uma passagem

Análisador léxico

## Análise léxica

A análise léxica é a primeira fase de um compilador. Um compilador léxico deve ler os caracteres da entrada e produzir uma sequência de tokens, os quais serão usados pelo parser durante a análise sintática.

Uma forma de se construir um analisador léxico é escrever um diagrama que ilustre a estrutura dos tokens da linguagem fonte e o traduzir manualmente em um programa que os identifique.

As técnicas de construção de um analisador léxico podem ser utilizadas em outras áreas. Como o analisador léxico é responsável pela leitura do programa fonte, ele pode também realizar tarefas secundárias a nível de interface com o usuário, como a remoção e espaços e comentário, por exemplo. 

## Interação entre o analisador léxico e o parser

![imagem1](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula3-1/Captura%20de%20tela_20230112_023342.png)

## Separação entre a análise léxica e a análise gramatical

Há quatro principais motivos para se separar a análise léxica da análise gramatical (parsing):

1. A separação entre estas duas fases pode simplificar uma das duas (ou ambas);

2. A eficiência do compilador é melhorada, uma vez que a separação permite o uso de técnicas especializadas, como buferização, para melhorar o desempenho da leitura da entrada e extração de tokens;

3. A separação permite uma melhor portabilidade do compilador, uma vez que diferenças entra a captura da entrada é codificação de caracteres, em diferentes plataformas, podem ser tratadas de forma isolada na análise léxica;

4. A separação entre as fases permite a criação de ferramentas especializadas para a automação da construção de analisadores léxicos e parsers.

## Tokens, padrões e lexemas

Tokens, padrões e lexemas são conceitos correlacionados e onipresentes na análise léxica.

Token é um símbolo terminal da gramática da linguagem fonte (em geral, grafados em negrito). Na maioria das linguagens de programação, são tokens: palavras-chave, operadores, identificadores, constantes, pontuações, etc. 

Um lexema é um conjunto de caracteres que é reconhecido como um token. Um mesmo token pode ser representado por lexemas distintos (por exemplo, 1 e 42 são lexemas distintos para o token NUM).

Um padrão descreve o conjunto de lexemas que podem representar um token em particular.

## Atributos para tokens

Quando dois ou mais lexemas estão associados a um mesmo token, o analisador léxico deve prover informações adicionais para as fases subsequentes, para que elas possam distinguí-las. Estas informações são os atributos do token. Deste modo, o analisador léxico deve identificar os tokens e seus respectivos atributos, caso existam.

Os tokens influenciam as decisões da análise gramatical, os atributos influenciam a tradução dos tokens. Em tokens numéricos, o valor do número representado pelo lexema pode ser o atributo token. No caso de identificadores, o próprio lexema pode ser o atributo do token. 

## Erros léxicos

Determinados erros não podem ser detectados em nível léxico. Por exemplo, na expressão em C++

```
fi (a == f(x)) {
    ...
}
```
o analisador léxico identificaria fi como um identificador válido, e só na análise gramatical é que seria detectado o erro de digitação da palavra-chave if.

Os erros léxicos mais comuns são aqueles onde o analisador léxico não consegue associar o prefixo lido a nenhum dos padrões associados aos tokens da linguagem. Neste ponto, o analisador léxico pode abortar a leitura, emitindo uma mensagem de erro. Outra alternativa é tentar tratar o erro de alguma maneira.

## Ações de recuperação de erros

Há quatro ações que configuram tentativas de recuperação de erros léxicos:

1. Remover um caractere estranho da entrada;

2. Inserir um caractere ausente;

3. Substituir um dos caracteres incorretos por um caractere certo;

4. Transpor dois caracteres adjacentes.

Se uma ou mais ações conseguem tornar o prefixo em um token válido, o analisador pode indicar ao usuário a sequência de ações como sugestão de correção do programa fonte, ou mesmo prosseguir assumindo esta correção.

