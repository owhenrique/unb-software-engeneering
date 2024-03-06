# Compiladores 1 - Um compilador simples de uma passagem

Máquinas de pilha abstratas

## Máquinas de Pilha Abstratas

A interface de vanguarda do compilador produz uma representação intermediária do programa fonte, que será usada pela interface de retaguarda para produzir o programa alvo. Uma possível forma para a representação intermediária é a máquina de pilha abstrata.

Uma máquina de pilha abstrata possui memórias separadas para dados e instruções, e todas as operações aritméticas são realizadas sobre os valores em uma pilha. As instruções são divididas em três classes: aritmética inteira, manipulação de pilha e fluxo de controle. 

O ponteiro *pc* indica qual é a próxima instrução a ser executada.

## Instruções aritméticas

A máquina de pilha abstrata precisa implementar cada operador da linguagem intermediária. Operações elementares, como adição e subtração, são suportadas diretamente. Operações mais sofisticadas devem ser implementadas como uma sequência de instruções de máquina. A título de simplificação, assuma que existe uma instrução para cada operação aritmética.

O código de uma máquina de pilha abstrata para uma expressão simula a avaliação de uma representação posfixa, usando uma pilha. A avaliação segue da esquerda para a direita, empilhando os operandos. Quando o operador é encontrado, seus operandos são extraídos da pilha (do último para o primeiro), a operação é realizada e o resultado é inserido no topo da pilha.

### Exemplo de avaliação da expressão 12+3* por máquina abstrata de pilha

![imagem1](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-8/Captura%20de%20tela%20de%202022-12-04%2022-58-14.png)

![imagem2](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-8/Captura%20de%20tela%20de%202022-12-04%2022-58-30.png)

![imagem3](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-8/Captura%20de%20tela%20de%202022-12-04%2022-58-44.png)

![imagem4](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-8/Captura%20de%20tela%20de%202022-12-04%2022-58-59.png)

![imagem5](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-8/Captura%20de%20tela%20de%202022-12-04%2022-59-10.png)

![imagem6](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-8/Captura%20de%20tela%20de%202022-12-04%2022-59-19.png)

![imagem7](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-8/Captura%20de%20tela%20de%202022-12-04%2023-00-22.png)

![imagem8](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-8/Captura%20de%20tela%20de%202022-12-04%2023-00-49.png)

![imagem9](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-8/Captura%20de%20tela%20de%202022-12-04%2023-01-09.png)

![imagem10](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-8/Captura%20de%20tela%20de%202022-12-04%2023-01-28.png)

![imagem11](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-8/Captura%20de%20tela%20de%202022-12-04%2023-01-52.png)

![imagem12](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-8/Captura%20de%20tela%20de%202022-12-04%2023-02-26.png)

![imagem13](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-8/Captura%20de%20tela%20de%202022-12-04%2023-02-47.png)

![imagem14](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-8/Captura%20de%20tela%20de%202022-12-04%2023-03-32.png)

![imagem15](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-8/Captura%20de%20tela%20de%202022-12-04%2023-03-39.png)

![imagem16](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-8/Captura%20de%20tela%20de%202022-12-04%2023-03-45.png)

![imagem17](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-8/Captura%20de%20tela%20de%202022-12-04%2023-03-51.png)

## Valores-L e Valores-R

O significado de um identificador depende da posição onde ele ocorre em uma atribuição. No lado esquerdo, o identificador se refere à localização de memória onde o valor deve ser armazenado. No lado direito, o identificador se refere ao valor armazenado na localização de memória associada ao identificador.

Valor-L e Valor-R se referem aos valores apropriados para os lados esquerdo e direito de uma atribuição, respectivamente.

Um mesmo identificador pode ser um valor-L e um valor-R na mesma atribuição (por exemplo, o identificador **X** em x = x + 1). 

## Manipulação da pilha

Uma máquina de pilha abstrata suporta as seguintes instruções para a manipulação da pilha:

![imagem18](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-8/Captura%20de%20tela%20de%202022-12-04%2023-16-41.png)

## Tradução de expressões

O código para avaliar uma expressão na máquina de pilha abstrata tem uma relação direta com a notação posfixa. Por exemplo, a expressão a + b é traduzida para o código intermediário

valor-r a

valor-r b

+

As atribuições são traduzidas da seguinte maneira: o valor-L do identificador é empilhado, a expressão à direita é avaliada e o seu valor-r é atribuído ao identificador. Formalmente

*cmd* -> **id** := *expr* { *cmd.t* := "valor-l" || **id**.lexema || *expr* || ":=" }

## Tradução da expressão F = 9 * C / 5 + 32 para máquina de pilha abstrata

```
valor-l     F
push        9
valor-r     C
*
push        5
/
push        32
+
:=
```
## Fluxo de controle

A máquina de pilha abstrata executa as intruções sequencialmente, na ordem em que foram dadas. Há três formass de se especificar um desvio (salto) no fluxo de execução:

1. O operando da instrução fornece o endereço da localização do alvo;
2. O operando da instrução fornece a distância relativa (positiva ou negativa) a ser saltada;
3. O alvo é especificado simbolicamente (a máquina deve suportar rótulos).

Nas duas primeiras formas, uma alternativa é especificar que o salto está no topo da pilha. A terceira forma é a mais simples de se implementar, pois não há necessidade de se recalcular os endereços caso o número de instruções seja modificado durente a otimização.

## Instruções de fluxo de controle

Uma máquina de pilha abstrata suporta as seguintes instruções para o fluxo de controle:

![imagem19](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-8/Captura%20de%20tela%20de%202022-12-04%2023-34-13.png)

## Gabaritos para tradução de condicionais e laços

![imagem20](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula2-8/Captura%20de%20tela%20de%202022-12-04%2023-37-32.png)

## Unicidade dos rótulos

Os rótulos *saída* e *teste* que ilustram os gabaritos das condicionais e dos laços dever ser únicos, para evitar possíveis ambiguidades. É preciso, portanto, de uma estratégia que torne tais rótulos únicos durante a tradução.

Seja *novoRótulo* um procedimento que gera, a cada chamada, um novo rótulo único a ação semântica ao comando if assumiria a seguinte forma:

```
cmd -> if expr then cmd1 { saida := novoRótulo;
                           cmd.t := expr.t
                                 || "gofalse" saida
                                 || cmd1.t
                                 || "rótulo"" saida }
```