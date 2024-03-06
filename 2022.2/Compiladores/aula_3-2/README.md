# Compiladores 1 - Análise léxica

Buferização da entrada

## Buferização

Como a análise léxica é a única fase do compilador que lê os caracteres do programa fonte, um a um, ela pode concentrar uma parte significativa do tempo de execução do compilador. Isto porque o acesso à entrada (em geral, um arquivo em disco) pode ser o gargalo, em termos de performance, do compilador. 

A buferização consiste no uso de um ou mais vetores auxiliares (buffers), que permitem a leitura da entrada em blocos, de modo que o analisador léxico leia os caracteres a partir destes buffers, os quais são atualizados e preenchidos à medida do necessário. Com a bufferização os acessos aos discos são reduzidos e a leitura dos caracteres passa a ser feita em memória, com acessos consideravalmente mais rápidos. 

## Estratégias para implementação de analisadores léxicos

Há três estratégias gerais para se implementar um analisador léxico, cada uma delas tratando a buferização de modo diferente. São elas, da mais simples para a mais complexa:

1. Usar um gerador de analisador léxico, a partir de uma entrada especificada a partir de expressões regulares. A buferização é tratada pelo próprio gerador.

2. Escrever o analisador léxico em alguma linguagem de programação convecional (C, C++, etc). A buferização fica atrelada aos mecanismos de I/O da linguagem.

3. Escrever o analisador em linguagem de montagem e tratar explicitamente a leitura da entrada e a buderização. 


## Pares de buffers

Na técnica de pares de buffers, um buffer (região contígua da memória) é dividido em duas metades, com N caracteres cada. Em geral, N corresponde ao tamanho de um bloco do disco (por exemplo, 1024 ou 4096 caracteres). Cada metade do buffer é preenchida de uma única vez, por meio da chamada de uma função de leitura do sistema.

Caso restem na entrada menos do que N caracteres, é inserido um caractere especial no buffer para indicar o fim da entrada (em geral, o caractere EOF - End Of File).

Usando esta técnica, os tokens devem ser extraídos do buffer, sem uso de chamadas individuais da rotina que lê um caractere da entrada.

## Dois ponteiros

Os tokens podem ser extraídos do par de buffers por meio do uso de dois ponteiros L e R. Uma cadeia de caracteres delimitada por estes dois ponteiros é o lexema atual.

Inicialmente, L e R apontam para o primeiro caractere do próximo lexema a ser identificado. O ponteiro R então avança até que o padrão de um token que seja reconhecido. Daí o lexema é processado e ambos ponteiros se movem para o próximo caractere após o lexema.

Neste cenário, espaços em branco e comentários são padrões que não produzem tokens.

## Atualização dos buffers e o ponteiro R

Se o ponteiro R tentar se deslocar para além do meio do buffer, será preciso preencher a metade direita com N novos caracteres antes deste avanço. De forma semelhante, se R atingir a extremidade direita do buffer, a metade à esquerda deve ser devidamente atualizada. Após a atualização, R deve retornar para a primeira posição do buffer.

O uso de um par de buffers e dois ponteiros tem uma limitação clara: o lexema pode ter, no máximo, 2N caracteres. O recuo de R, se necessário, também é limitado pela posição que L ocupa. 

## Avanço de R em um par de buffers

```
if R está no fim da primeira metade then
    atualize a segunda metade com a leitura de N novos caracteres
    R <- R + 1

else if R está no fim da segunda metade then
    atualize a primeira metade com a leitura de N novos caracteres
    R <- 0                  // Assuma que os índices de buffer começam em zero

else if then
    R <- R + 1
```

## Sentinelas

O uso de um valor sentinela no fim de cada metade do buffer pertime a redução dos testes para o avanço de R. Além disso, o valor sentinela em outra posição do buffer indica o fim da entrada.

A redução do número de testes (de dois para um, na maioria dos casos) decorrente do uso de sentinelas leva a um ganho de performance do analisador léxico e, consequentemente, do compilador.

O valor sentinela (em geral, EOF) deve ser diferente de qualquer caractere válido da entrada, para evitar um encerramento prematuro da entrada, caso tal caractere faça parte da entrada. 


## Atualização de R com uso de sentinelas

```
R <- R + 1

if R = EOF then
    if R está no fim da primeira metade then
        atualize a segunda metade com a leitura de N novos caracteres
        R <- R + 1
    
    else if R está no fim da segunda metade then
        atualize a primeira metade com a leitura de N novos caracteres
        R <- 0              // Assuma que os índices do buffer começam em zero

    else                    // Eof está no buffer, indicando o fim da entrada
        finalize a análise léxica
```
## Módulo buffer.h

```
#ifndef BUFFER_H
#define BUFFER_H

const int N { 4 };

class IOBuffer {
public:
    static IOBuffer& getInstance();

    bool eof() const;
    int tell() const;
    void seek(int pos);

    int get();
    void unget();

private:
    IOBuffer();

    int pos, last_update;
    char buffer[2*N + 2];

    void update.
};

#endif
```

## Módulo buffer.cpp

```
#include <iostream>
#include "buffer.h"

using namespace std;

IOBuffer&
IObuffer::getinstance()
{
    static IOBuffer buffer;
    return buffer.
}

IOBuffer::IOBuffer() : pos(2*N), last_update(1)
{
    buffer[N] = buffer[2*N + 1] = EOF;
    update();
}

void IOBuffer::update()
{
    ++pos;

    if (buffer[pos] != EOF)
        return;

    if (pos == 2*N + 1)
    {
        pos = 0;

        if(last_update == 1)
        {
            auto size = fread(buffer, sizeof(char), N, stdin);

            if(size < N)
                buffer[size] = EOF;

            last_update = 0;
        }
    }

    else if (pos == N)
    {
        if (last_update == 0)
        {
            auto size = fread(buffer + N + 1, sizeof(char), N, stind);

            if (size < N)
                buffer[N + 1 + size] = EOF;

            last_update = 1;
        } 

        ++pos;
    }
}

bool
IOBuffer::eof() const
{
    return buffer[pos] == EOF;
}

int 
IOBuffer::tell() const
{
    return pos;
}

void
IOBuffer::seek(int p)
{
    pos = p;
}

int
IOBuffer::get()
{
    auto c = buffer[pos];
    update();

    return c;
}

void 
IOBuffer::unget()
{
    --pos;

    if (pos < 0)
        pos = 2*N;
    
    else if(pos == N)
        --pos;
}
```