/* 
Entrega 2 SGBD
Aluno: Paulo Henrique Almeida da Silva
Matrícula: 17/0020291
*/

/* 1. Liste todas as cidades e os países aos quais pertencem. */
SELECT Nome, Pais 
FROM Cidade;

/* 2. Liste todas as cidades que são capitais. */
SELECT Nome 
FROM Cidade 
WHERE Capital = 'S';

/* 3. Liste todos os atributos dos países onde a expectativa de vida é menor que 70 anos. */
SELECT * 
FROM Pais 
WHERE Expec_vida < 70;

/* 4. Liste todas as capitais e as populações dos países cujos PIB é maior que 1 trilhão de dólares. */
SELECT Cidade.Nome, Pais.Pop 
FROM Cidade 
JOIN Pais ON Cidade.Pais = Pais.Nome 
WHERE Cidade.Capital = 'S' AND Pais.PIB > 1000;

/* 5. Quais é o nome e a população da capital do país onde o rio St. Lawrence tem sua nascente. */
SELECT Cidade.Nome, Cidade.Pop 
FROM Cidade 
JOIN Rio ON Cidade.Pais = Rio.Origem 
WHERE Rio.Nome = 'St. Lawrence' AND Cidade.Capital = 'S';

/* 6. Qual é a média da população das cidades que não são capitais. */
SELECT AVG(Pop) 
FROM Cidade 
WHERE Capital = 'N';

/* 7. Para cada continente retorne o PIB médio de seus países. */
SELECT Continente, AVG(PIB) AS PIB_Medio 
FROM Pais 
GROUP BY Continente;

/* 8. Para cada país onde pelo menos 2 rios tem nascente, encontre o comprimento do menor rio. */
SELECT Origem, MIN(Comprimento) AS Menor_Comprimento 
FROM Rio 
GROUP BY Origem 
HAVING COUNT(Nome) >= 2;

/* 9. Liste os países cujo PIB é maior que o PIB é do Canada. */ 
SELECT Nome 
FROM Pais 
WHERE PIB > (SELECT PIB FROM Pais WHERE Nome = 'Canada');