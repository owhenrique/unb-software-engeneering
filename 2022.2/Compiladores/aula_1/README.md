# COMPILADORES 1 

## Definição de um compilador (informal)
Um compilador é um programa, que lê um programa escrito em uma **linguagem (fonte)** e traduz para outra **linguagem (alvo)**.

## Características dos compiladores

> - O processo de compilação deve identificar e relatar possíveis erros no programa fonte;

> - No geral, linguagens como *C/C++*, *Python* e *Java* são as linguagens fonte;

> - Linguagens alvo podem ser tanto linguagens tradicionais quanto liguagens de máquina.

### Exemplo do fluxo de geração de um programa executável

![imagem1](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula1/Captura%20de%20tela%20de%202022-11-30%2000-43-55.png)

## Análise e Síntese

O processo de compilação é composto por duas etapas, a **análise** e a **síntese**. 

> Análise: divide o programa fonte em partes constituintes e as organiza em uma representação intermediária.

Em geral, a **representação intermediária** consiste em uma árvore sintática, onde cada nó representa uma operação e cada filho representa um operando.

> Sintése: constrói o programa alvo a partir desta representação intermediária.

### Exemplo de árvore sintática

![imagem2](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula1/Captura%20de%20tela%20de%202022-11-30%2000-56-15.png)

### Análise do programa fonte 

A análise é composta por três fases, e são elas:

* A **análise linear**, onde o fluxo de caracteres que compõem o programa alvo é lido, da esquerda para a direita, e agrupado em *tokens* (sequência de caracteres com significado coletivo);

* A **análise hierárquica**, onde os *tokens* são ordenados hierarquicamente em coleções aninhadas com significado coletivo;

* A **análise semântica**, onde ocorre a verificação que garante que os componentes do programa se combinam de forma significativa.

## Análise léxica

Em compiladores, também podemos chamar a fase de análise linear de **análise léxica** ou esquadrinhamento. Por exemplo, 

<center>F = 1.8 + C * 32</center>

a análise léxica identificaria os seguintes *tokens*:

1. O identificador *F* ;
2. o símbolo de atribuição *=* ;
3. A constante em ponto flutuante *1.8* ;
4. O símbolo de adição *+* ;
5. O identificador *C* ;
6. O símbolo de multiplicação _*_ ;
7. A constante inteira *32*.

## Análise sintática

A análise hierárquica, também conhecida como **análise sintática** ou gramatical, agrupa tokens hierarquicamente. Em geral, em uma árvore gramatical.

A estrutura hierárquica pode ser definida por meio de regras recursivas. Por exemplo, 

1. Qualquer identificador é uma expressão;
2. Qualquer número é uma expressão;
3. Se *E1* e *E2* são expressões, também são expressões *E1 + E2* e *E1 * E2*;
4. Se *I* é um identificador e *E* é uma expressão, então *I = E* é um enunciado.

### Exemplo de árvore gramatical

![imagem3](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula1/Captura%20de%20tela%20de%202022-11-30%2001-24-04.png)

## Análise semântica

A **análise semântica** verifica potenciais erros semânticos no programa alvo. Ela usa a árvore da análise sintática (árvore gramatical) para identificar operadores e operandos das expressões enunciados. 

A análise semantica também faz verificação de tipos, caso os tipos dos operandos não sejam compatíveis com os tipos esperados pelos operadores, esta análise ou retorna um erro ou adiciona uma promoção (conversão) de tipo. Isto vai depender da linguagem alvo. Por exemplo, na expressão à direita do enunciado **F = 1.8 + C * 32**, o operando à esqueda da multiplicação tem um ponto flutuante e o da direita é do tipo inteiro, então, o valor **32** deve ser promovido para ponto flutuante ou deve ser sinalizado um erro de tipo.  

## As fases de um compilador

Por conceito, o compilador opera em fases. Cada fase manipula o programa fonte e entrega o resultado para a próxima fase. Entretanto, na prática algumas fases podem ser agrupadas, e a representação intermediária entre elas pode não ser construída explicitamente. 

As primeiras fases estão relacionadas à análise do programa fonte, as últimas estão relacionadas à síntese (construção do programa alvo). E duas atividades interagem com todas as fases: a gerência da tabela de símbolos e o tratamento de erros.

### Representação típica das fases de um compilador

![imagem4](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula1/Captura%20de%20tela%20de%202022-11-30%2002-37-50.png)

## Gerenciamento da tabela de símbolos

O gerenciamento da tabela de símbolos é responsável por registrar os identificadores do programa alvo e identificar seus diversos atributos. Exemplos de possíveis atributos de um identificador são o nome, o tipo, a memória e o escopo.

Caso o identificador se refira a um procedimento, dentro seus atributos devem constar a quantidade de seus parâmetros e respectivos tipos, modo de passagem (cópia ou referência) e o tipo do retorno, se houver.

Os identificadores e seus respectivos atributos são armazenados em uma estrutura denominada tabela de símbolos.

## Tratamento de erros

A cada fase da compilação podem acontecer um ou mais erros. Após identificar um erro, o compilador deve tratá-lo de alguma maneira e, se possível, continuar o processo em busca de mais erros.

Abortar a compilação logo após o primeiro erro pode diminuir a utilidade do compilador. Por exemplo, o prosseguimento da compilação após um erro léxico pode ajudar na geração de uma sugestão de correção para o erro.

```
OBS.: Um erro sintático é um caso em que as "frases" de um programa (instruções, expressões) estão mal formuladas, aquilo que comumente chamamos de "erro gramatical". Exemplos:

1. Parênteses que abrem mas não fecham;
2. Duas instruções sem um ponto-e-vírgula entre elas.

Há um outro tipo de erro, que é quando o símbolo em si está mal formado (ex: um número com letras no meio "123y4"), que seria um erro "léxico" ou, "erro de ortografia".

Já um erro semântico se refere ao significado daquilo que eu quis dizer. Quando as instruções dadas podem estar bem formatadas mas não fazem aquilo que quem programou quer, nada de útil, ou impossível. Por exemplo:

1. Dividir um número por uma string;
2. Criar uma classe que herda de si mesma.
```

## Geração de código intermediário

Na geração de código intermediário, a árvore resultante da análise semântica é transformada pelo compilador em um código intermediário. Esta representação pode ser entendida como um código para uma máquina abstrata.

O código intermediário deve ter duas qualidades fundamentais:

* deve ser fácil de gerar;
* deve ser fácil de traduzir para o programa alvo.

Uma representação possível é o código de três endereços. Além de computar expressões, esta representação também precisa tratar dos fluxos de controle e das chamadas de procedimentos. 

### Exemplo de geração de código intermediário

![imagem5](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula1/Captura%20de%20tela%20de%202022-11-30%2003-12-59.png)

## Otimização de código

Esta fase procura formas de melhorar o código intermediário, com o intuito de melhorar a performance do código de máquina do programa alvo. Algumas otimizações são triviais, já outras demandam algoritmos sofisticados que impactam no tempo de compilação.

As otimizações não devem alterar a semântica do código intermediário. Elas podem melhorar, além do tempo de execução, o uso de memória do programa alvo.

### Exemplo de otimização de código intermediário

![imagem6](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula1/Captura%20de%20tela%20de%202022-11-30%2003-18-37.png)

## Geração de código

A geração de código é a última etapa da compilação, ela produz o programa alvo, em geral em linguagem de máquina relocável ou código de montagem. Nesta etapa devem ser atribuídas localizações de memória para as variáveis e também feita a atribuição das variáveis aos registradores.

### Exemplo de geração de código em pseudo assembly

![imagem7](https://github.com/owhenrique/COMPILADORES_studies/blob/main/img/aula1/Captura%20de%20tela%20de%202022-11-30%2003-22-24.png)

## Interface de vanguarda

Na prática, as fases de um compilador são agrupadas em duas interfaces: de ***vanguarda*** e de ***retaguarda***.

A interface de vanguarda contém as fases que dependem primariamente do programa fonte e que independem da máquina alvo. Em geral, ela inclui as fases de análise, a criação da tabela de símbolos e a geração de código intermediário. Ela também inclui o tratamento de erros associados a estas fases.

Embora a otimização faça parte primariamente da interface de retaguarda, é possível aplicar algum nível de otimização na interface de vanguarda.

```
Ou seja, a interface de vanguarda abrange da análise léxica até a geração de código intermediário (4 fases).
```

## Interface de retaguarda

A interface de retaguarda contém as fases que dependem primariamente da máquina alvo e independem do programa alvo.

O ponto de partida é o código intermediário. Assim, esta interface contém, em geral, as fases de otimização e geração do código (2 fases). Ela também manipula a tabela de símbolos e trata dos erros assiociados à estas últimas fases.

No cenário deial, ambas são independentes, o que permite fixar uma delas e alterar a outra para obter diferentes compiladores com diferentes objetivos.

## Ferramentas para a construção de compiladores

Sendo o compilador um software, todas as ferramentas úteis no desenvolvimento de um software também serão úteis na construção de um compilador (editor de texto, depuradores, gerenciadores de versão e etc).

Existem, entretanto, ferramentas especializadas nas diferentes fases da compilação, as quais podem ser usadas na construção de novos compiladores. 

Os geradores de analisadores gramaticais produzem analisadores sintáticos a partir de uma entrada baseada em uma gramática livre de contexto (Yacc, Bison, etc). Os geradores de analisadores léxicos geram os mesmos a partir de especificações baseadas em expressões regulares (Lex, Flex, etc). Os dispositivos de tradução dirigidos pela sintaxe produzem uma coleção de rotinas que percorrem uma árvore gramatical, gerando código intermediário a partir dela. Os geradores automáticos de código estipulam regras que traduzem cada operação da linguagem intermediária para a linguagem de máquina alvo. Os dispositivos de fluxo de dados atuam na fase de otimização a partir da observação do fluxo de dados entre diferentes partes de um programa.  
