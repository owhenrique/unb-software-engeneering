# Compiladores 1 - Um compilador simples de uma passagem

Incorporando uma tabela de símbolos

## Tabela de símbolos

Uma tabela de símbolos é uma estrutura de dados que armazena informações nas diferentes fases da compilação. As fases de análise coletam informações que são usadas nas fases de síntese para a geração do programa alvo. Por exemplo, na análise léxica os lexemas são adicionados à tabela de símbolos.

As fases posteriores podem adicionar informações a este lexema, como tipo, uso (procedimento, variável, etc) e posição no armazenamento.

## A análise léxica e a tabela de símbolos

As principais interações que ocorrem com a tabela de símbolos na análise léxica tratam do armazenamento e a recuperação de lexemas.

A rotina INSERIR(*s, t*) insere o lexema *s* na tabela, sendo ele associado ao token *t*. A rotina BUSCAR(*s*) resgata o lexama *s*, permitindo a consulta (e, se necessário, atualização) de seu token. Em geral a operação de busca é usada para saber se um determinado lexema já está na tabela ou não.

Em linguagem que possuem dicionários em sua biblioteca padrão, a tabela pode ser implementada por meio de um dicionário.

## Tabela de símbolos e palavras reservadas

As rotinas descritas para a tabela de símbolos permitem um tratamento direto de quaisquer palavras reservadas da linguagem. Por exemplo, considere que **div** e **mod** são palavras reservadas.

A rotina de inserção permite associar os lexemas "div" e "mod" aos tokens **div** e **mod**:

INSERIR("div", **div**)

INSERIR("mod", **mod**)

Qualquer chamada posterior da rotina de busca retornará os tokens, de modo que os lexemas já não poderão ser mais usados como identificadores.

## Pseudocódigo de uma analisador léxico que manipula identificadores

```
function SCANNER()
    loop
        c <- PROXIMOCARACTERE()
        if c é espaço then
            reinicie o laço
        else if c é um dígito then
            v <- LERCONSTANTEINTEIRA()
            return { NUM, v}
        else if c é uma letra then
            lexema <- LERPALAVRA()
            if lexema não está na tabela de símbolos then
                INSERIR(ID, lexema)
            return { OBTERTOKEN(lexema), lexema }
        else
            return { c, NONE }
``` 