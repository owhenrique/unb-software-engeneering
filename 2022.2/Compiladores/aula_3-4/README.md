## Compiladores 1 - Análise léxica

O reconhecimento de tokens

## Fragmento de gramática que será utilizada nos exemplos

```
    cmd -> if expr then cmd
        |  if expr then cmd else cmd
        |  ∈

    expr -> termo relop termo
         |  termo

    termo -> id
          -> num
```

## Definições regulares dos tokens

```
    if     ->   if
    then   ->   then
    else   ->   else
    relop  ->   < | <= | = | <> | > | >=
    letra  ->   A | B | C | ... | Z | c | b | c | ... | z
    digito ->   0 | 1 | 2 | ... | 9
    id     ->   letra(letra | digito)*
    num    ->   dígito+(.dígito+)?(E(+|-)? dígito+)?
```

## Tratamento de espaços em branco

Assuma que os lexemas sejam separados por espaços em brancos. São considerados espaços em branco: sêquencias de espaços em branco, tabulações e quebras de linhas.

O analisador léxico deve ignorar os espaços em branco.

A definição regular ws identifica os espaços em branco:

```
    delim ->  branco | tabulação | quebradelinha
    ws    ->  delim+
```

Se o analisador léxico identificar o padrão ws, ele não irá gerar um token.

## Especificação dos tokens

![imagem1](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula3-4/Captura%20de%20tela%20de%202023-01-16%2013-38-10.png)

## Diagramas de trasição

Um diagrama de transição é um fluxograma estilizado que delineia as ações a serem tomadas pelo analisador léxico a cada requisição de novo token por parte do parser. 

Os estados são representados por círculos rotulados e identificam posições do diagrama. As transições são representadass por arestas direcionadas, rotuladas por um caractere.

Uma transição do estado X para o estado Y cujo rótulo é o caractere C indica que, se a execução está no estado X e o próximo caractere lido é C, então a execução deve consumir C e seguir para o estado Y.

Um diagrama de transição é determinístico se todas as transições que partem de um estado são rotuladas por caracteres distintos.

## Estados e ações

Um estado deve ser rotulado como estado de partida, o qual marca o início da execução. Se os rótulos dos estados são numéricos, a convenção é que o estado inicial seja o de número zero (ou um).

Alguns estados podem ter ações associadas, as quais são executadas quando a execução atinge tal estado. Executada a ação, se existir, deve ser lido o próximo caractere C da entrada: se existir uma transição rotulada por C, a execução segue para o novo estado, indicado pela aresta; caso constrário, deve ser sinalizado um erro.

Os estados de aceitação, que indicam que um token foi reconhecido, são marcados com um círculo duplo.

## Retrações e erros léxicos

Um estado de aceitação que demande o retorno do último caractere lido para o buffer de entrada é marcado com o símbolo *. Isto ocorre, por exemplo, em casos em que um token é finalizado por um espaço ou por um caractere que inicia um novo token. 

Um analisador léxico pode ter vários diagramas de transição. Se acontecer um erro no fluxo de execução de um diagrama, o ponteiro de leitura deve ser reposicionado ao ponto que estava no estado de partida e um novo diagrama deve ser seguido. Se ocorrem erros em todos os diagramas, então há um erro léxico no programa fonte.

## Diagrama de transição para operadores relacionais

![imagem2](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula3-4/Captura%20de%20tela%20de%202023-01-16%2014-29-34.png)


## Identificadores e palavras-chave

Não é prático identificar as diferentes palavras-chave da linguagem por meio de diagramas de transição. Na maioria das linguagens, as palavras-chave obedecem à mesma regra de construção dos identificadores.

Uma abordagem mais geral e efetiva é construir o diagrama de transição dos identificadores e usá-los para reconhecer tanto os identificadores quanto as palavras-chave. Para isto, os lexemas de todas as palavras-chave devem ser inseridos na tabela de símbolos, com seus respectivos tokens e atributos. 

A função install(s) insere o lexema s na tabela de símbolos como um token id, caso s não esteja presente na tabela; caso contrário, a função retorna o token e os atributos associados a s na tabela.

## Diagrama de transição para identificadores e palavras-chave

![imagem3](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula3-4/Captura%20de%20tela%20de%202023-01-16%2014-47-22.png)

## Identificação de constantes numéricas

A identificação de tokens deve ser gulosa. Por exemplo, se a entrada consiste em 12.3E4, o analisador léxico não deve retornar a constante inteira 12 e nem mesmo a constante em ponto flutuante 12.3: ele deve retornar a constante 12.3E4. Assim, o token deve ser o maior lexema aceito por um diagrama de transição.

Uma forma de implementar a abordagem gulosa é tratar os casos mais longos antes dos mais curtos. Isto pode ser feito assumindo a convenção de que os estados de partida com menores rótulos devem ser testados antes dos estados com maiores rótulos e escrevendo os diagramas apropriadamente.

## Diagramas de transição para constantes numéricas

![imagem4](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula3-4/Captura%20de%20tela%20de%202023-01-16%2014-55-05.png)

![imagem5](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula3-4/Captura%20de%20tela%20de%202023-01-16%2014-58-35.png)

![imagem6](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula3-4/Captura%20de%20tela%20de%202023-01-16%2015-00-16.png)

## Diagramas de transição para espaços em branco

![imagem7](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula3-4/Captura%20de%20tela%20de%202023-01-16%2015-01-28.png)