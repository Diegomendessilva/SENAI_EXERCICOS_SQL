use ContosoRetailDW
--ex 1 
--a. Faça um resumo da quantidade vendida (SalesQuantity) de acordo
--com o canal de vendas (channelkey).

select channelKey,
	count (SalesQuantity) as 'quantidade vendida'
from FactSales
group by channelKey

--b b. Faça um agrupamento mostrando a quantidade total vendida
--(SalesQuantity) e quantidade total devolvida (Return Quantity) de
--acordo com o ID das lojas (StoreKey).

select StoreKey,
	sum (SalesQuantity) as 'quantidade total vendida',
	sum (ReturnQuantity) as 'quantidade total devolvida'
from FactSales
group by StoreKey
order by StoreKey


--c Faça um resumo do valor total vendido (SalesAmount) para cada
--canal de venda, mas apenas para o ano de 2007.

select 
	channelKey as 'canal de vendas',
	sum (SalesAmount) as 'qt.'
from FactSales
where DateKey like '%2007%'
group by channelKey
order by [qt.]desc

select * from FactSales

--ex 2 Você precisa fazer uma análise de vendas por produtos. O objetivo final é
--descobrir o valor total vendido (SalesAmount) por produto (ProductKey).
--a. A tabela final deverá estar ordenada de acordo com a quantidade
--vendida e, além disso, mostrar apenas os produtos que tiveram um
--resultado final de vendas maior do que $5.000.000.

SELECT
	ProductKey AS 'ID do Produto',
	SUM(SalesAmount) AS 'Faturamento Total'
FROM
	FactSales
GROUP BY ProductKey
HAVING SUM(SalesAmount) >= 5000000
ORDER BY SUM(SalesAmount) DESC


--b. Faça uma adaptação no exercício anterior e mostre os Top 10
--produtos com mais vendas. Desconsidere o filtro de $5.000.000
--aplicado.
SELECT
	TOP (10) ProductKey AS 'ID do Produto',
	SUM(SalesAmount) AS 'Faturamento Total'
FROM
	FactSales
GROUP BY ProductKey
HAVING SUM(SalesAmount) >= 5000000
ORDER BY SUM(SalesAmount) DESC


select 
top (10) ProductKey 
from FactSales



--ex 3 a. Você deve fazer uma consulta à tabela FactOnlineSales e descobrir
--qual é o ID (CustomerKey) do cliente que mais realizou compras
--online (de acordo com a coluna SalesQuantity).

select top (1) CustomerKey,
	sum(SalesQuantity) as 'top 1 vendas'
from FactOnlineSales
group by CustomerKey
order by sum(SalesQuantity) desc




--b Feito isso, faça um agrupamento de total vendido (SalesQuantity) por
--ID do produto e descubra quais foram os top 3 produtos mais
--comprados pelo cliente da letra a).

select top (3) ProductKey as 'ID do produto',
	sum(SalesQuantity) as 'total vendido'
	from FactOnlineSales
where CustomerKey = '19037' 
group by ProductKey
order by sum(SalesQuantity) desc


select *
from FactOnlineSales

--4 a) Faça um agrupamento e descubra a quantidade total de produtos por marca.

select  BrandName as 'marca',
count (ProductKey) as 'total produto'
from DimProduct
group by BrandName
--use o count para saber quanta linhas do produto repete, de forma que chegue no resulta desejado


--b b) Determine a média do preço unitário (UnitPrice) para cada ClassName.

select ClassName,
avg (UnitPrice) as 'preço do média'
from DimProduct
group by ClassName

--c Faça um agrupamento de cores e descubra o peso total que cada cor de produto possui. 

select ColorName as 'cor',
	sum(Weight) as 'peso'
from DimProduct
group by ColorName
order by sum(Weight) desc

-- 5 Você deverá descobrir o peso total para cada tipo de produto (StockTypeName).
--A tabela final deve considerar apenas a marca ‘Contoso’ e ter os seus valores classificados em
--ordem decrescente.

select StockTypeName as'tipo de produto',
	sum (Weight) as 'peso total'
from DimProduct
where BrandName = 'contoso'
group by StockTypeName
order by sum(Weight)desc


--6. Você seria capaz de confirmar se todas as marcas dos produtos possuem à disposição todas as
--16 opções de cores

select BrandName as 'marca',
	count (ColorName) as 'cor',
	count (Status) as 'disponivel'
from DimProduct
where Status = 'on'
group by BrandName
order by count (Status) desc

--7 Faça um agrupamento para saber o total de clientes de acordo com o Sexo e também a média
--salarial de acordo com o Sexo. Corrija qualquer resultado “inesperado” com os seus
--conhecimentos em SQL.

SELECT
	Gender AS 'Gênero',
	COUNT(CustomerKey) AS 'Total de Cliente'
FROM
	DimCustomer
WHERE Gender IS NOT NULL
Group BY Gender

-- Média Salarial de acordo com o Gênero.
SELECT
	Gender AS 'Gênero',
	AVG(YearlyIncome) AS 'Média Salárial'
FROM
	DimCustomer
WHERE Gender IS NOT NULL
Group BY Gender

-- Total de Cliente e Média Salarial de acordo com o Gênero
SELECT
	Gender AS 'Gênero',
	COUNT(CustomerKey) AS 'Total de Cliente',
	AVG(YearlyIncome) AS 'Média Salárial'
FROM
	DimCustomer
WHERE Gender IS NOT NULL
Group BY Gender

--8 Faça um agrupamento para descobrir a quantidade total de clientes e a média salarial de
--acordo com o seu nível escolar. Utilize a coluna Education da tabela DimCustomer para fazer
--esse agrupamento.

select Education as 'educa',
	count(CustomerKey) as 'total de clientes',
	avg(YearlyIncome) as 'media salarial'
from DimCustomer
where Education is not NULL
group by Education



--9 Faça uma tabela resumo mostrando a quantidade total de funcionários de acordo com o
--Departamento (DepartmentName). Importante: Você deverá considerar apenas os
--funcionários ativos.

SELECT
	DepartmentName AS 'Departamento',
	COUNT(EmployeeKey) AS 'QTD. de Funcionários'
FROM
	DimEmployee
WHERE Status = 'Current' OR EndDate IS NULL
GROUP BY DepartmentName

--10 Faça uma tabela resumo mostrando o total de VacationHours para cada cargo (Title). 
--Você deve considerar apenas as mulheres, dos departamentos de Production, Marketing, 
--Engineering e Finance, para os funcionários contratados entre os anos de 1999 e 2000.  */

SELECT * FROM DimEmployee

SELECT
	Title AS 'Cargo',
	SUM(VacationHours) AS 'Horas Totais'
FROM
	DimEmployee
WHERE Gender = 'F' AND 
	DepartmentName IN ('Production', 'Marketing', 'Engineering', 'Finance')  AND
	HireDate BETWEEN '1999-01-01' AND '2000-12-31'
GROUP BY Title




