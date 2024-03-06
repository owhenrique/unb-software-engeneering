# Compiladores 1 - Um compilador simples de uma passagem

Um tradutor para expressões simples.

## Tradutor dirigido pela sintaxe

Quando não há associação de atributos aos não-terminais, um tradutor dirigido pela sintaxe pode ser construído a partir da extensão de um analisador gramatical preditivo. Para isso, inicialmente construa o analisador gramatical preditivo. Em seguida, copie as ações sintáticas do tradutor nas posições adequadas no analisador gramatical preditivo. Se a gramática tiver uma ou mais produções recursivas à esquerda, é preciso modificar a gramatica para eliminar esta recursão antes de proceder com a construção do analisador gramatical preditivo.

## Transformação de produções recursivas à esquerda

```
Transformação de produção recursiva à esquerda

Seja A -> Aα | Aβ | y uma produção recursiva à esquerda. Esta produção esquivale às produções recursivas à direita

    A -> yR
    R -> αR | βR | ∈

onde α e β é uma cadeia de terminais e não-terminais que não começam com A e nem terminam com R.
```

### Exemplo de transformação de produção recursiva à esquerda

![imagem1](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-5/Captura%20de%20tela%20de%202022-12-04%2012-14-51.png)

### Esquema de tradução da gramática para expressões para a notação posfixa

![imagem2](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-5/Captura%20de%20tela%20de%202022-12-04%2012-16-56.png)

## Rotina de extração do próximo token em C++

```
#include <iostream>

using token = char;

token proximo_token()
{
    auto t = std::cin.get();

    return (token) t;
}
```

## Rotina de tratamento de erro e declaração de lookahead em C++

```
token lookahead;

void erro()
{
    std::cerr << "\Erro de sintaxe! lookahead = " << lookahead << '\n';
    exit(-1);
}
```

## Rotina de reconhecimento de tokens em C++

```
void reconhecer(token t)
{
    if(lookahead == t)
        lookahead = proximo_token();
    else
        erro();
}
```

## Rotina associada ao não-terminal *expr* em C++

```
void expr()
{
    digito();
    resto();
}
```
## Rotina associada ao não-terminal *digito* em C++

```
void digito()
{
    if (isdigit(lookahead))
    {
        std::cout.put(lookahead);
        reconhecer(lookahead);
    } else {
        erro();
    }
}
```

## Rotina associada ao não-terminal *resto* em C++

```
void resto()
{
    if(lookahead == '+' or lookahead '-')
    {
        auto c = lookahead;
        reconhecer(c);
        digito();
        std::cout.put(c);
        resto();
    }
}
```

## Rotina principal do tradutor em C++

```
int main()
{
    lookahead = proximo_token();

    expr();

    std::cout.put('\n');

    return 0;
}
```

