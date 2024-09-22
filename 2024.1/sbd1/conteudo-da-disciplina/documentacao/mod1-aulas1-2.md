# Bancos 1

Provas:

Módulo 1: 19/04

Módulo 2: 24/05

Módulo 3: 21/06

Bibliografia recomendada:

[Elmasri](https://ia601403.us.archive.org/5/items/sistemas-de-banco-de-dados-ramez-elmasri-shamkant-b.-navathe-z-lib.org/Sistemas%20De%20Banco%20De%20Dados%20%28Ramez%20Elmasri%2C%20Shamkant%20B.%20Navathe%29%20%28z-lib.org%29.pdf)

# Aula 1

### Consistência de dados

> É o “estado ou caráter do que é coerente, do que tem solidez, veracidade, credibilidade, estabilidade, realidade”.
> 

Se determinada informação é replicada (redundância), seu valor é sempre o mesmo.

### Sistema de gerenciamento de bancos de dados

> É um sistema de propósito geral composto por conjuntos de dados e conjuntos de programas.
> 

**Conjunto de dados:** 

- Bases de dados, Tabelas e índices, tuplas;

**Conjunto de programa:** 

- Acesso e manipulação dos dados.

**Suas características compreendem:**

- Manter um conjunto lógico e organizado de dados;
- Armazenar grandes volumes de dados;
- Permitir a busca e atualização dos dados;
- Eficiência;
- Autonomia em realação às aplicações que utilizam os dados.

**Esquema:** 

- Definição da base de dados.
- Descrição, textual ou gráfica, da estrutura de um banco de dados de acordo com um determinado modelo.

**Instância:** 

- Base de dados em si.
- Conjunto de dados armazenado em um banco de dados em determinado instante de tempo.

Os ***requisitos fundamentais*** de um sistema de gerenciamento de bancos de dados compreendem:

- **Segurança** (tanto física, quanto lógica)
    - Segurança lógica - Usernames e passwords, por exemplo.
- **Integridade**
    - Consistência e validade

***Restrições de integridade*** definimento o que é valido e o que não é, por exemplo, “o preço de venda não pode ser menor que o preço de custo” ou “o código do produto tem que ser único”.

- **Recuperação** e **tolerância a falhas**
    - Transações atômicas, registros de log e backup dos dados, são maneiras de se lidar com falhas do sistema.
- **Controle de concorrência**

> Os componentes de um SGBD, compreendem, basicamente, o Processador de consultas; o Gerenciador de armazenamento. O Processador de consultas lida com a aplicação, já o Gerenciador de armazenamento lida com o banco de dados.
> 

### Utilizando um SGBD

A interface dos bancos de dados é definida pela linguagem declarativa SQL (DDL + DML).

**SQL - Data Definition Language (DDL)**

- É um conjunto de comandos para a definição do esquema da base de dados;
- Seus principais elementos são:
    - Create
    - Alter
    - Drop

**SQL - Data Manipulation Language (DML)**

- É um conjunto de comandos para a manipulação dos dados de maneira compatível com o esquema.
- Seus principais elementos são:
    - Select
    - Insert
    - Delete
    - Update

**Procedural:** Exige especificação de quais dados são necessários e como obtê-los, por exemplo, linguagens de programção como C e Pascal. Requer uma sequência específica de operações a serem executadas.

**Declarativo:** Exige apenas especificação de quais dados são necessários. 

---

## Aula 2

### Arquitetura Cliente / Servidor

> A arquitetura cliente servidor pode ser composta de duas ou mais camdas, sendo elas:
> 
- Duas camadas:
    - Dados, regras e o sistema de gerenciamento da base de dados, do lado do servidor. Nesta camada está contida então a base de dados e a pequena parte lógica do negócio ;
    - Aplicações de propósito genérico, do lado do cliente. Já nesta camada, a interface e a maior parte lógica lógica à compõe.
- Três camadas:
    - Dados e regras, o SGBD e servidores de aplicação compõe a camada do servidor;
    - A camada cliente é composta por interfaces mais a parte específica da lógica do negócio.
- Quatro camdas:
    - Dados e regras, SGBD, servidores de aplicação e servidores de interface compõe a camada do servidor;
    - Aplicações-cliente compõe a camda do cliente. Um exemplo, o browser de internet para a utilização de um website.

### Esquema e instância

> Em bancos de dados, **esquemas** compreendem a definição da base de dados armazenada, já **instâncias**, a base de dados armazenada em si.
> 

- **Esquema**:
    - Definção
    - Estático (ou quase!)
- **Instância**:
    - Manipulação
    - Dinâmica

### Three-Schema Architecture

> Os esquemas podem ser definidos em três níveis. O Three-Schema Architecture (arquitetura ANSI/SPARC) possui algumas características, sendo elas, múltiplas visões para os usuários; armazenamento da descrição da base de dados (esquema) em diferentes níveis de abstração e independência de dados.
> 

Os níveis do mais externo para o mais interno são:

- **Nível de visão** (**nível externo**):
    - Sub-Esquemas
        - Descrição de sub-esquemas com modelo conceitual (MER, por exemplo) e modelo de implementação (Modelo Relacional, por exemplo)
    - Define as **visões dos usuários**
        - Descreve a parte da base de dados em que cada grupo de usuários tem interesse
- **Nível conceitual** ou **lógico**:
    - Esquema conceitual e/ou lógico
        - Modelo conceitual, por exemplo, MER
        - Modelo de implementação, por exemplo, Modelo Relacional
    - Descreve a **estrutura da base de dados** sem que detalhes de estrutura de armazenamento físico (quais dados estão armazenados e como estão relacionados)
- **Nível interno** ou **físico**:
    - Esquema físico
    - Descreve a **estrutura física** de armazenamento da base de dados (como os dados serão armazenados)

> **Abstração**: Visualização de níveis de esquema em sistemas de bancos de dados. A abstração esconde detalhes e complexidade nos diferentes níveis, geralmente é uma visão mais geral ou específica do esquema.
> 

### Independência de dados

> Independência na arquitetura de três esquemas: capacidade de modificar o esquema em determinado nível sem afetar o esquema do nível superior (desde que não ocorra downgrade). Geralmente SGBD’s podem suportar **indepedência física** e **lógica.**
> 

**Independência física** de dados são modificações no esquema interno (físico) que não provocam alterações nos esquemas lógicos e externos.

### Desenvolvimento de sistemas de bancos de dados (Elmasri)

**Projeto conceitual**

- **Esquema conceitual** para a base de dados
    - Níveis **conceitual**/**lógico** e **externo**/**de visão**
    - Baseado nos **requisitos de dados**
    - Seus objetivos são:
        - estrutura da base de dados
        - semântica
        - relacionamentos
        - restrições
- Independe do SGBD
- Pode incluir especificação em alto nível de aplicações e caracteríscas funcionais de transações
- Modelo conceitual, por exemplo, MER.

**Projeto lógico**

- **Esquema lógico**
    - Níveis **conceitual**/**lógico** e **externo**/**de visão**
- Mapeamento do modelo conceitual para o modelo do SGBD
    - Passo 1: Mapeamento independente de um SGBD específico, mas depende do “paradigma” (relacional, OO, relacional-objeto)
    - Passo 2: Ajustes de acordo com as características e restrições do modelo implementado por um SGBD específico
    

**Projeto físico**

- Esquema físico
    - nível interno
- Estruturas físicas de armazenamento
    - organizações de registros físicos
    - índices
    - números de discos, processadores, memória
- Critérios
    - tempo de resposta
    - espaço utilizado
    - número de transações

### Modelagem de dados

> Modelo de dados são a “definição abstrata, autônoma e lógica dos **objetos**, **operadores** e outros elementos que, juntos, constituem a máquina abstrata com a qual os usuários interagem”. Onde os objetos representam as estruturas de dados e os operadores representam o comportamento dos dados.
> 

**Modelos conceituais** são a descrição do conteúdo da base de dados. Eles não consideram as estruturas de armazenamento. Seu enfoque esta:

- Na compreensão e descrição da realidade (informação)
- Na compreensão e seleção das propriedades relevantes da informação;
- Na compreensão e descrição das restrições sobre os dados;
- E no diálogo com o usuário.

### Modelo Entidade Relacionamento (MER)

É voltado para representação dos aspectos estáticos (informação) do domínio da aplicação.

- Modelagem **semântica** dos dados

> **Sintaxe** diz respeito à forma que a mensagem é transmita, já a **semântica** diz respeito ao conteúdo da mensagem. Um erro de sintaxe, por exemplo, seria declara um variável do tipo inteiro em C assim: ynt var; Já um erro semântico seria declara uma variável que se espera que seja do tipo inteiro como char ou boolean.
> 

### Construtores sintáticos

Os modelos de dados definem um conjunto, limitado, de **construtores sintáticos**. Estes conjuntos estão separados em: **conjuntos de entidades** (CE), de **relacionamentos** (CR), de **atributos** **de** **entidade** e **atributos** **de** **relacionamento**.

Um mesmo construtor sintático pode ser usado para *representar várias situações do mundo real*, que define uma sobrecarga semântica.

### Entidades

Podem ser “coisas”, pessoas, objetos, entes, etc. do mundo real. Na notação DER (Diagrama Entidade Relacionamento) as entidades são representadas como retângulos.

![sbd1-aula3-pessoa-disciplina.png](Bancos%201%20881f64348ebe46a5b77e750248e22785/d58fabf9-317d-487a-8bc5-1c4972b2113e.png)

### Conjunto de entidades

São coleções de entidades que tem a mesma “estrutura” e o mesmo significado na modelagem (estrutural e semanticamente iguais). O modelo Entidade Relacionamento não trata entidades individuais, apenas conjuntos de entidades. 

### Relacionamentos

São associações entre entidades do mundo real. Na notação DER, os relacionamentos são representados por losangos.

![sbd1-aula-pessoa-cursa-disciplina.png](Bancos%201%20881f64348ebe46a5b77e750248e22785/932037b9-d9d4-489f-90d3-11e6b861d3f5.png)

### Conjunto de relacionamentos

São relacionamentos entre entidades do mesmo conjunto de entidades. Vários conjuntos de relacionamentos podem envolver o mesmo conjunto de entidades, assim como na figura abaixo:

![sbd1-aula3-pessoa-cursa-fazprova-disciplina.png](Bancos%201%20881f64348ebe46a5b77e750248e22785/1369084c-5c02-4d89-919a-2963c72165db.png)

### Atributos

São valores que representam **propriedades** das entidades e relacionamentos do mundo real. Eles podem representar também as propriedades dos relacionamentos. Na notação DER, os atributos são representados por elipses ligados às entidades.

![sbd1-aula3-pessoa-cursa-disciplina-atributos.png](Bancos%201%20881f64348ebe46a5b77e750248e22785/sbd1-aula3-pessoa-cursa-disciplina-atributos.png)

### Restrição de unicidade

Todo conjunto de entidades deve ter um atributo, ou um conjunto de atributos, cujo valor **identifique** **univocamente** cada entidade no conjunto (**CHAVE**). Na notação DER, a chave simples é representada grifada.

### Chave

A chave é o principal meio de acesso à uma entidade. Outros possível atributos identificadores (outras chaves) podem ser anotados separadamente, para efeito de documentação ou projeto lógico.

**Chave composta**

As chaves compostas são utilizadas quando a entidade precisa de mais de um atributo de identificação, como podemos ver na imagem abaixo, a concatenação de todos os atributos grifados (notação DER), representa a **chave única.**

![sbd1-aula3-pessoa-chave-composta.png](Bancos%201%20881f64348ebe46a5b77e750248e22785/2a38cbde-cc6d-49d0-8737-87bb714e60a5.png)

### Atributos de relacionamentos

Observe a imagem à baixo, se adicionassemos o atributo Nota à entidade PESSOA, cada pessoa teria uma nota única para qualquer disciplina. Se adicionassemos o atributo Nota à entidade disciplina, todas as pessoas matriculadas teriam a mesma nota.

![sbd1-aula3-atributo-relacionamento.png](Bancos%201%20881f64348ebe46a5b77e750248e22785/40959a8d-c4e1-4294-be22-4001ecd6eda2.png)

**Observação**: Os CEs sempre possuem atributos, mas os CRs não precisam de atributos para existir. A existência de um CR é justificada pela associação entre CE.

### Tipos de atributos

- **Simples** (**atômico**): não divido, uma única parte;
- **Composto**: dividido em partes, possui sub-atributos;
- **Monovalorado**: pode assumir um único valor para uma entidade, ou relacionamento, em particular;
- **Multivalorado**: pode assumir mais de um valor para cada uma entidade, ou relacionamento, em particular;
- **Armazenado**: atributo armazenado de entidade;
- **Derivado**: valor pode ser obtido através dos valores de outros atributos da entidade ou de informação armazenada em seus relacionamentos.

### Cardinalidade

Cardinalidade são restrições estruturais de conjuntos de relacionamentos. Todo CR associa uma ou mais entidades de um CE¹ a uma ou mais entidade de um CE². Ela determina o número de relacionamentos dos quais cada entidade pode participar.

![sbd1-aula3-cardinalidade.png](Bancos%201%20881f64348ebe46a5b77e750248e22785/sbd1-aula3-cardinalidade.png)

---

## Aula 3