use ContosoRetailDW
/* Exercício 1:
O gerente comercial pediu a você uma análise da Quantidade Vendida e Quantidade Devolvida para o canal de venda mais importante da empresa:  Store. 
Utilize uma função SQL para fazer essas consultas no seu banco de dados. Obs: Faça essa 
análise considerando a tabela FactSales. */

SELECT TOP (100) * FROM FactSales

SELECT
	SUM(SalesQuantity) AS 'QTD. Vendida',
	SUM(ReturnQuantity) AS 'QTD. Devolvida'
FROM
	FactSales
WHERE ChannelKey = 1

SELECT * FROM DimChannel

------------------------------

/* Exercício 2:
Uma nova ação no setor de Marketing precisará avaliar a média salarial de todos os clientes da empresa, mas apenas de ocupação Professional.  Utilize um comando SQL para atingir esse resultado. */

SELECT * FROM DimCustomer

SELECT
	AVG(YearlyIncome) AS 'Média Salárial'
FROM
	DimCustomer
WHERE Occupation = 'Professional'

------------------------------

/* Exercício 3:
Você precisará fazer uma análise da quantidade de funcionários das lojas registradas na empresa. O seu gerente te pediu os seguintes números e informações: 

a) Quantos funcionários tem a loja com mais funcionários? 
b) Qual é o nome dessa loja? 
c) Quantos funcionários tem a loja com menos funcionários? 
d) Qual é o nome dessa loja? */

SELECT * FROM DimStore

-- a) Quantos funcionários tem a loja com mais funcionários? 
SELECT
	MAX(EmployeeCount) AS 'QTD. Máx. Funcionários'
FROM
	DimStore


-- b) Qual é o nome dessa loja? 
SELECT
	TOP(1) StoreName AS 'Nome da Loja',
	EmployeeCount AS 'QTD. Funcionários'
FROM
	DimStore
ORDER BY EmployeeCount DESC


-- c) Quantos funcionários tem a loja com menos funcionários? 
SELECT
	MIN(EmployeeCount) AS 'QTD. Mín. Funcionários'
FROM
	DimStore


-- d) Qual é o nome dessa loja? 
SELECT
	TOP(1) StoreName AS 'Nome da Loja',
	EmployeeCount AS 'QTD. Funcionários'
FROM
	DimStore
WHERE EmployeeCount IS NOT NULL
ORDER BY EmployeeCount

------------------------------

/* Exercício 4: 
A área de RH está com uma nova ação para a empresa, e para isso precisa saber a quantidade total de funcionários do sexo Masculino e do sexo Feminino.  

a) Descubra essas duas informações utilizando o SQL. 
b) O funcionário e a funcionária mais antigos receberão uma homenagem. Descubra as 
seguintes informações de cada um deles: Nome, E-mail, Data de Contratação. */

SELECT * FROM DimEmployee

-- Qtd. Sexo Masculino
SELECT
	COUNT(Gender) AS 'QTD. Funcionários Masc.'
FROM
	DimEmployee
WHERE Gender = 'M'

-- Qtd. Sexo Feminino
SELECT
	COUNT(Gender) AS 'QTD. Funcionários Fem.'
FROM
	DimEmployee
WHERE Gender = 'F'

-- Funcionário mais antigo - Masculino
SELECT
	TOP(1)FirstName AS 'Nome',
	LastName AS 'Sobrenome',
	EmailAddress AS 'E-mail',
	Gender AS 'Gênero',
	HireDate AS 'Data da Contratação'
FROM
	DimEmployee
WHERE Gender = 'M'
ORDER BY HireDate

-- Funcionária mais antiga - Feminino
SELECT
	TOP(1)FirstName AS 'Nome',
	LastName AS 'Sobrenome',
	EmailAddress AS 'E-mail',
	Gender AS 'Gênero',
	HireDate AS 'Data da Contratação'
FROM
	DimEmployee
WHERE Gender = 'F'
ORDER BY HireDate

------------------------------

/* Exercício 5: 
Agora você precisa fazer uma análise dos produtos. Será necessário descobrir as seguintes informações: 

a) Quantidade distinta de cores de produtos. 
b) Quantidade distinta de marcas 
c) Quantidade distinta de classes de produto 
Para simplificar, você pode fazer isso em uma mesma consulta. */

SELECT * FROM DimProduct

SELECT
	COUNT(DISTINCT BrandName) AS 'QTD. Marcas',
	COUNT(DISTINCT ClassName) AS 'QTD. Classes de Produto',
	COUNT(DISTINCT ColorName) AS 'QTD. Cores'
FROM
	DimProduct