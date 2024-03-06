# Compiladores 1 - Um compilador simples de uma passagem

Análise léxica.

## Scanners

Em uma dada gramática, as sentenças de uma linguagem são compostas por cadeia de tokens. A sequência de caracteres que compõem um único token é denominada **lexema**.

Um *scanner* (ou analisador léxico) processa a entrada para produzir uma sequência de tokens. Dentre as diferentes tarefas que um *scanner* pode realizar estão: remoção de espaços em branco e comentário, identificação de constantes, identificadores e palavras-chave.

## Remoção de espaços em branco e comentários

No fluxo de entrada, a presença de outros caracteres que não fazem parte da gramática pode levar a erros no tradutor. Várias linguagens permitem a presença de "espaços em branco" (espaço em branco, nova linha, tabulação, etc) entre os tokens. 

Os espaços em branco podem ser tratados de duas maneiras:

1. A gramática deve ser alterada para contemplar os espaços (localização, quantidade, etc), o que traz dificuldades para a especificação da gramática e para a implementação do scanner.

2. O scanner simplesmente ignora os espaços em branco (solução mais comum).

O *scanner* também pode ignorar os comentários, de modo que estes possam ser tratados como espaços em branco.

## Identificação de constantes inteiras

Constantes inteiras são sequências de dígitos. As constantes podem ser inseridas na gramática da linguagem por meio de produções, ou sua identificação pode ser delegada para o analisador léxico, que irá criar tokens para estas constantes. A segunda alternativa permite tratar constantes inteiras como unidades autônomas durante a tradução.

Para cada constante inteira, o scanner gerará um token de um atributo, sendo o token um identificador de constantes inteiras (por exemplo, num) e o atributo o valor inteiro da constante. Por exemplo, a entrada 3 + 14 + 15 seria transformada na sequência de tokens **<num, 3> <+,> <num, 14> <+,> <num, 15>** onde o par <x, y> indica que o token x tem o atributo y. 

## Reconhecimento de identificadores e palavras-chave

As linguagens de programação utilizam identificadores para nomear variáveis, vetores, funções e outros elementos. As gramáticas das linguagens, em geral, tratam os identificadores como tokens.

Os analisadores gramaticais (*parsers*) destas gramáticas esperam um mesmo token (por exemplo, **id**) sempre que um identificador aparece na entrada. Por exemplo, a expresão x = x + y; deve ser convertida pelo *scanner* para **id = id + id;**.

Na análise sintática, é útil saber que as duas primeiras ocorrências de **id** se referem ao lexema x, enquanto que a última se refere ao lexema y.

## Reconhecimento de identificadores e palavras-chave

Uma tabela de símbolos pode ser usada para determinar se um dado lexema já foi encontrado ou não. Na primeira ocorrência o lexema é armazenado na tabela de símbolos e também nela, e em todas as demais ocorrências, o lexema se torna o atributo do token **id**.

As palavras-chave da linguagem são cadeias fixas de caracteres usadas como pontuação ou para identificar determinadas construções. Em geral, as palavras-chave seguem a mesma regra da formação dos identificadores. Se as palavras-chave forem reservadas, isto é, não puderem ser usadas como identificadores, a situação fica facilitada: um lexema só será um identificador caso não seja uma palavra-chave.

## Interface para um analisador léxico

![imagem1](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-6/Captura%20de%20tela%20de%202022-12-04%2015-39-36.png)

## Produto e consumidor

O analisador léxico e o analisador gramatical formam um par produtor-consumidor. O analisador léxico produz tokens e o analisador gramatical os consome.

A interação entre ambos depende do *buffer* que armazena os tokens produzidos: o *scanner* não pode gerar novos tokens se o *buffer* está cheio, o *parser* não pode prosseguir se o *buffer* estiver vazio. Em geral, o *buffer* armazena um único token. Neste caso, o *parser* pode requisitar ao scanner, por demanda a produção de novos tokens.

## Implementação da identificação de constantes inteiras

Para que as constantes inteiras possam ser devidamente identificadas no código do scanner, é preciso que elas façam parte da gramática. Por exemplo, a produção do não-terminal *fator*:

*fator* -> **digito** | *(expr)*

pode ser modificada para

*fator* -> *(expr)* | **num** {*imprimir*(**num**.*valor*)}

Em relação à implementação, um token deve ser identificado por um par contendo o identificador do token e o seu atributo.

## Exemplo de implementação do terminal *fator* em C++

```
using token_t = std::pair<int, int>;

// Num deve ter um valor diferente de qualquer caractere da tabela ASCII
const int NUM { 256 };

void fator()
{
    auto [token, valor] = lookahead;

    if(token == '(') {
        reconhecer('(');
        expr();
        reconhecer(')');
    } else if(token == NUM) {
        reconhecer(NUM);
        std::cout << valor;
    } else
        erro();
}
```

## Exemplo de implementação de um scanner de constantes inteiras em C++

```
#include <bits/stdc++.h>

using token_t = std::pair<int, int>;
const int NUM = 256, NONE = -1;

token_t scanner()
{
    while(not std::cin.eof())
    {
        auto c = std::cin.get();

        if(isspace(c))
            continue;

        if(isdigit(c))
        {
            int valor = c - '0';

            while (not std::cin.eof() and (c = std::cin.get(), isdigit(c))
                valor = 10 * valor + (c - '0');

            std::cin.unget();

            return { NUM, valor };
        } else
            return { c, NONE };
    }

    return { EOF, NONE };
}
```

## Exemplo de implementação de um scanner de constantes inteiras em C++

```
int main()
{
    while(true)
    {
        auto [lookahead, valor] = scanner();

        if(lookahead == EOF)
            break;
        else if (lookahead == NUM)
            std::cout << "Número lido: " << valor << '\n';
        else
            std::cout << "Token lido: " << (char) lookahead << '\n';
    }

    return 0;
}
```
