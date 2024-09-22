# Exercícios 4FN

**Entrega Módulo 3**

**Aluno:** Paulo Henrique Almeida da Silva

**Matrícula:** 17/0020291

**Disciplina:** SGBD1


## Exercício Transporte

  1. 
  ```
  NavioNome -> NavioTipo
  ViagemID -> NavioNome, Carga
  NavioNome, DataChegada -> ViagemID, Porto
  ```
  2. 

  ``NavioNome, DataChegada`` é chave candidata.

  3. 

  ``ViagemID, DataChegada`` é chave candidata.

  4.

  ``NavioNome -> NavioTipo`` é uma dependência parcial, já que ``NavioNome`` é parte da chave ``NavioNome, DataChegada``. 

  5. 
  ``ViagemID -> Carga`` viola a 2FN.

  6. 
  ``ViagemID -> NavioNome`` viola a FNBC.
  
  **Então temos:**

  Transporte = {DataChegada, ViagemID, Porto}

  Viagem = {ViagemID, NavioNome, Carga}

  Navio = {NavioNome, NavioTipo}

## Exercício Determinar forma normal

  ``A, B`` é uma chave candidata, pois determina todos os outros atributos. E outra é ``E, F, B``.

  ``A → C`` é uma dependência parcial, pois ``A`` faz parte da chave ``A, B``, e ``C`` é determinado apenas por ``A``, não pela chave completa.
  
  A relação **não** está na 2FN devido a essa dependência parcial. A relação ``R(A, B, C, D, E, F, G)`` está atualmente na 1FN, mas não está na 2FN devido à dependência parcial ``A → C``. Não há violação da 3FN, porém há violação da FNBC em ``E, F -> A``.

## Exercício Considerar as instâncias

- `PecaNum, Fabric` -> Todos os outros atributos, o que indica que `{PecaNum, Fabric}` é uma chave candidata.
- `PecaNum` -> `Descr`
- `Fabric` -> `FabricEnd`
- `Vendedor` -> `Fabric`, `FabricEnd`
- `Preco` -> `Desconto`

  O atributo `FabricEnd` não está em conformidade com a 1FN porque é um atributo composto. Para resolver isso, seria necessário dividir o atributo em dois: `Cidade` e `Estado`.

#### Chaves Candidatas

- `{PecaNum, Fabric}` e, por transitividade, `{PecaNum, Vendedor}`.

#### Relações e Violações de Forma Normal

- `FabricanteEnd = {Fabric, FabricEnd}` → Viola a 2FN porque `FabricEnd` é um atributo composto.
- `PecaDescr = {PecaNum, Descr}` → Viola a 2FN devido à dependência parcial.
- `PrecoDesconto = {Preco, Desconto}` → Viola a 3FN devido à dependência transitiva.
- `Vendedor` → `Fabric` → Viola a FNBC porque `Vendedor` não é uma chave candidata.
- `VendedorFabric = {Vendedor, Fabric}`
- `Preco = {PecaNum, Vendedor, Preco}`

# Exercícios FNBC

## Exercício Lote

1. As possíveis chaves candidatas são `PropId` e `Municipio, LotNum`.

2. Considerando apenas as chaves evidentes `PropId` e `Municipio, LotNum`, a 3FN seria comprometida, pois a dependência `Municipio, LotNum → Area` e `Area → Preco` leva a uma dependência transitiva `Municipio, LotNum → Preco`. O mesmo ocorre para a chave `PropId`. 

   No entanto, `Area → Municipio`, por transitividade, `LotNum, Area` também pode ser uma chave candidata. Assim, a dependência `Area → Preco` viola a 2FN, pois há uma dependência parcial em relação à chave candidata `LotNum, Area`.
   

3. Pode-se definir uma relação `Preco = Area, Preco` e a relação `Lote` se tornaria `PropId, Municipio, LotNum, Area, Imposto`.

4. A relação `Lote` não satisfaz a FNBC, pois `Area → Municipio`, e o atributo `Area`, apesar de ser primo, não é uma chave candidata por si só.

5. Pode-se criar uma relação `Municipio = Area, Municipio` ou até mesmo uma extensão da relação `Preco`, resultando em `Preco = Area, Preco, Municipio`. Isso faria com que a relação `Lote` fosse `PropId, LotNum, Area, Imposto`.

6. Após a normalização até a FNBC, as chaves candidatas seriam `PropId` e `LotNum, Area`.