use ContosoRetailDW
--ex 1 
--a. Fa�a um resumo da quantidade vendida (SalesQuantity) de acordo
--com o canal de vendas (channelkey).

select channelKey,
	count (SalesQuantity) as 'quantidade vendida'
from FactSales
group by channelKey

--b b. Fa�a um agrupamento mostrando a quantidade total vendida
--(SalesQuantity) e quantidade total devolvida (Return Quantity) de
--acordo com o ID das lojas (StoreKey).

select StoreKey,
	sum (SalesQuantity) as 'quantidade total vendida',
	sum (ReturnQuantity) as 'quantidade total devolvida'
from FactSales
group by StoreKey
order by StoreKey


--c Fa�a um resumo do valor total vendido (SalesAmount) para cada
--canal de venda, mas apenas para o ano de 2007.

select 
	channelKey as 'canal de vendas',
	sum (SalesAmount) as 'qt.'
from FactSales
where DateKey like '%2007%'
group by channelKey
order by [qt.]desc

select * from FactSales

--ex 2 Voc� precisa fazer uma an�lise de vendas por produtos. O objetivo final �
--descobrir o valor total vendido (SalesAmount) por produto (ProductKey).
--a. A tabela final dever� estar ordenada de acordo com a quantidade
--vendida e, al�m disso, mostrar apenas os produtos que tiveram um
--resultado final de vendas maior do que $5.000.000.

SELECT
	ProductKey AS 'ID do Produto',
	SUM(SalesAmount) AS 'Faturamento Total'
FROM
	FactSales
GROUP BY ProductKey
HAVING SUM(SalesAmount) >= 5000000
ORDER BY SUM(SalesAmount) DESC


--b. Fa�a uma adapta��o no exerc�cio anterior e mostre os Top 10
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



--ex 3 a. Voc� deve fazer uma consulta � tabela FactOnlineSales e descobrir
--qual � o ID (CustomerKey) do cliente que mais realizou compras
--online (de acordo com a coluna SalesQuantity).

select top (1) CustomerKey,
	sum(SalesQuantity) as 'top 1 vendas'
from FactOnlineSales
group by CustomerKey
order by sum(SalesQuantity) desc




--b Feito isso, fa�a um agrupamento de total vendido (SalesQuantity) por
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

--4 a) Fa�a um agrupamento e descubra a quantidade total de produtos por marca.

select  BrandName as 'marca',
count (ProductKey) as 'total produto'
from DimProduct
group by BrandName
--use o count para saber quanta linhas do produto repete, de forma que chegue no resulta desejado


--b b) Determine a m�dia do pre�o unit�rio (UnitPrice) para cada ClassName.

select ClassName,
avg (UnitPrice) as 'pre�o do m�dia'
from DimProduct
group by ClassName

--c Fa�a um agrupamento de cores e descubra o peso total que cada cor de produto possui. 

select ColorName as 'cor',
	sum(Weight) as 'peso'
from DimProduct
group by ColorName
order by sum(Weight) desc

-- 5 Voc� dever� descobrir o peso total para cada tipo de produto (StockTypeName).
--A tabela final deve considerar apenas a marca �Contoso� e ter os seus valores classificados em
--ordem decrescente.

select StockTypeName as'tipo de produto',
	sum (Weight) as 'peso total'
from DimProduct
where BrandName = 'contoso'
group by StockTypeName
order by sum(Weight)desc


--6. Voc� seria capaz de confirmar se todas as marcas dos produtos possuem � disposi��o todas as
--16 op��es de cores

select BrandName as 'marca',
	count (ColorName) as 'cor',
	count (Status) as 'disponivel'
from DimProduct
where Status = 'on'
group by BrandName
order by count (Status) desc

--7 Fa�a um agrupamento para saber o total de clientes de acordo com o Sexo e tamb�m a m�dia
--salarial de acordo com o Sexo. Corrija qualquer resultado �inesperado� com os seus
--conhecimentos em SQL.

SELECT
	Gender AS 'G�nero',
	COUNT(CustomerKey) AS 'Total de Cliente'
FROM
	DimCustomer
WHERE Gender IS NOT NULL
Group BY Gender

-- M�dia Salarial de acordo com o G�nero.
SELECT
	Gender AS 'G�nero',
	AVG(YearlyIncome) AS 'M�dia Sal�rial'
FROM
	DimCustomer
WHERE Gender IS NOT NULL
Group BY Gender

-- Total de Cliente e M�dia Salarial de acordo com o G�nero
SELECT
	Gender AS 'G�nero',
	COUNT(CustomerKey) AS 'Total de Cliente',
	AVG(YearlyIncome) AS 'M�dia Sal�rial'
FROM
	DimCustomer
WHERE Gender IS NOT NULL
Group BY Gender

--8 Fa�a um agrupamento para descobrir a quantidade total de clientes e a m�dia salarial de
--acordo com o seu n�vel escolar. Utilize a coluna Education da tabela DimCustomer para fazer
--esse agrupamento.

select Education as 'educa',
	count(CustomerKey) as 'total de clientes',
	avg(YearlyIncome) as 'media salarial'
from DimCustomer
where Education is not NULL
group by Education



--9 Fa�a uma tabela resumo mostrando a quantidade total de funcion�rios de acordo com o
--Departamento (DepartmentName). Importante: Voc� dever� considerar apenas os
--funcion�rios ativos.

SELECT
	DepartmentName AS 'Departamento',
	COUNT(EmployeeKey) AS 'QTD. de Funcion�rios'
FROM
	DimEmployee
WHERE Status = 'Current' OR EndDate IS NULL
GROUP BY DepartmentName

--10 Fa�a uma tabela resumo mostrando o total de VacationHours para cada cargo (Title). 
--Voc� deve considerar apenas as mulheres, dos departamentos de Production, Marketing, 
--Engineering e Finance, para os funcion�rios contratados entre os anos de 1999 e 2000.  */

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




