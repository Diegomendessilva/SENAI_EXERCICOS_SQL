--Você é o gerente da área de compras e precisa criar um relatório com as
--TOP 100 vendas, de acordo com a quantidade vendida. Você precisa fazer
--isso em 10min pois o diretor de compras solicitou essa informação para
--apresentar em uma reunião.
--Utilize seu conhecimento em SQL para buscar essas TOP 100 vendas, de
--acordo com o total vendido (SalesAmount).

--ex 1

select top (100) SalesAmount
from FactSales

--ex 2
--Os TOP 10 produtos com maior UnitPrice possuem exatamente o mesmo
--preço. Porém, a empresa quer diferenciar esses preços de acordo com o
--peso (Weight) de cada um.
--O que você precisará fazer é ordenar esses top 10 produtos, de acordo
--com a coluna de UnitPrice e, além disso, estabelecer um critério de
--desempate, para que seja mostrado na ordem, do maior para o menor.


select top (10) UnitPrice, weight
from DimProduct
order by UnitPrice

--Caso ainda assim haja um empate entre 2 ou mais produtos, pense em
--uma forma de criar um segundo critério de desempate (além do peso).
select top (10)

select top (10) UnitPrice, weight
from DimProduct
order by UnitPrice desc, Weight desc

--ex 3 
--Você é responsável pelo setor de logística da empresa Contoso e precisa
--dimensionar o transporte de todos os produtos em categorias, de acordo
--com o peso.
--Os produtos da categoria A, com peso acima de 100kg, deverão ser
--transportados na primeira leva.
--Faça uma consulta no banco de dados para descobrir quais são estes
--produtos que estão na categoria A.
--a. Você deverá retornar apenas 2 colunas nessa consulta: Nome do
--Produto e Peso.

select ProductName, Weight from DimProduct

--b Renomeie essas colunas com nomes mais intuitivos.

select  ProductName as 'nome' , Weight as 'peso'
from DimProduct

--c Ordene esses produtos do mais pesado para o mais leve.

select  ProductName as 'nome' , Weight as 'peso'
from DimProduct
order by nome desc, peso desc


--4 Você foi alocado para criar um relatório das lojas registradas atualmente
--na Contoso.
--você deverá fazer à tabela DimStore, retorne as seguintes
--informações: StoreName, OpenDate, EmployeeCount.

select StoreName,OpenDate,EmployeeCount
from DimStore

--b Renomeeie as colunas anteriores para deixar a sua consulta mais
--intuitiva.

select StoreName as 'nome da loja',OpenDate as 'data',EmployeeCount as 'contagem de funcionario'
from DimStore

--c. Dessas lojas, descubra quantas (e quais)lojas ainda estão ativas.
select Status
from DimStore
where status like 'on'
-- outra maneira
select Status
from DimStore
where StoreType = 'store' OR status = 'ON'


--ex 5 O gerente da área de controle de qualidade notificou à Contoso que
--todos os produtos Home Theater da marca Litware, disponibilizados
--para venda no dia 15 de março de 2009, foram identificados com
--defeitos de fábrica.
--O que você deverá fazer é identificar os ID’s desses produtos e repassar
--ao gerente para que ele possa notificar as lojas e consequentemente
--solicitar a suspensão das vendas desses produtos.

select 
	ProductKey as 'id produto',
	ProductName as 'nome do produto',
	BrandName as 'marca',
	AvailableForSaleDate as 'disponivel para venda'

from DimProduct
where 
	BrandName = 'Litware'
	and ProductName like '%Home Theater%'
	and AvailableForSaleDate = '20090315'



--6 Imagine que você precise extrair um relatório da tabela DimStore, com
--informações de lojas. Mas você precisa apenas das lojas que não estão
--mais funcionando atualmente.
--a. Utilize a coluna de Status para filtrar a tabela e trazer apenas as
--lojas que não estão mais funcionando.

select Status
from DimStore
where Status like 'off'

--b Agora imagine que essa coluna de Status não existe na sua tabela.
--Qual seria a outra forma que você teria de descobrir quais são as lojas
--que não estão mais funcionando.

select CloseReason
from DimStore
where CloseReason like 'relocation'

--ex 7 determinada quantidade de máquinas de café. As lojas serão divididas em
--3 categorias:

--CATEGORIA 1:De 1 a 20 funcionários ->1 máquina de café
--CATEGORDe acordo com a quantidade de funcionários, cada loja receberá uma
--IA 2:De 21 a 50 funcionários ->2 máquinas de café
--CATEGORIA 3: Acima de 51 funcionários ->3 máquinas de café
--Identifique, para cada caso, quais são as lojas de cada uma das 3
--categorias acima (basta fazer uma verificação).


SELECT * 
FROM DimStore
WHERE EmployeeCount >= 1 AND EmployeeCount <= 20

--75 EMPRESAS VAO RECEBER 1 MAQUINAS

SELECT * 
FROM DimStore
WHERE EmployeeCount >= 21 AND EmployeeCount <= 50

-- 187 EMPRESAS VAO RECEBER 2 MAQUINAS 

SELECT * 
FROM DimStore
WHERE EmployeeCount >= 51 

-- 43 EMPRESAS VAO RECEBER 3 MAQUINAS 






--ex 8 A empresa decidiu que todos os produtos LCD receberão um super
--desconto no próximo mês. O seu trabalho é fazer uma consulta à tabela
--DimProduct e retornar os ID’s, Nomes e Preços de todos os produtos
--LCD existentes.

select ClassID,
	StyleID, 
	WeightUnitMeasureID,
	StockTypeID, 
	ColorID,
	UnitOfMeasureID,
	ETLLoadID,
	ProductName,
	UnitPrice


	
from DimProduct
where ProductDescription like '%LCD%'


select * from DimProduct



SELECT * FROM DimProduct
WHERE NOT ColorName = 'BLUE'

select * from DimCustomer
where FirstName is null