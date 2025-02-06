--Voc� � o gerente da �rea de compras e precisa criar um relat�rio com as
--TOP 100 vendas, de acordo com a quantidade vendida. Voc� precisa fazer
--isso em 10min pois o diretor de compras solicitou essa informa��o para
--apresentar em uma reuni�o.
--Utilize seu conhecimento em SQL para buscar essas TOP 100 vendas, de
--acordo com o total vendido (SalesAmount).

--ex 1

select top (100) SalesAmount
from FactSales

--ex 2
--Os TOP 10 produtos com maior UnitPrice possuem exatamente o mesmo
--pre�o. Por�m, a empresa quer diferenciar esses pre�os de acordo com o
--peso (Weight) de cada um.
--O que voc� precisar� fazer � ordenar esses top 10 produtos, de acordo
--com a coluna de UnitPrice e, al�m disso, estabelecer um crit�rio de
--desempate, para que seja mostrado na ordem, do maior para o menor.


select top (10) UnitPrice, weight
from DimProduct
order by UnitPrice

--Caso ainda assim haja um empate entre 2 ou mais produtos, pense em
--uma forma de criar um segundo crit�rio de desempate (al�m do peso).
select top (10)

select top (10) UnitPrice, weight
from DimProduct
order by UnitPrice desc, Weight desc

--ex 3 
--Voc� � respons�vel pelo setor de log�stica da empresa Contoso e precisa
--dimensionar o transporte de todos os produtos em categorias, de acordo
--com o peso.
--Os produtos da categoria A, com peso acima de 100kg, dever�o ser
--transportados na primeira leva.
--Fa�a uma consulta no banco de dados para descobrir quais s�o estes
--produtos que est�o na categoria A.
--a. Voc� dever� retornar apenas 2 colunas nessa consulta: Nome do
--Produto e Peso.

select ProductName, Weight from DimProduct

--b Renomeie essas colunas com nomes mais intuitivos.

select  ProductName as 'nome' , Weight as 'peso'
from DimProduct

--c Ordene esses produtos do mais pesado para o mais leve.

select  ProductName as 'nome' , Weight as 'peso'
from DimProduct
order by nome desc, peso desc


--4 Voc� foi alocado para criar um relat�rio das lojas registradas atualmente
--na Contoso.
--voc� dever� fazer � tabela DimStore, retorne as seguintes
--informa��es: StoreName, OpenDate, EmployeeCount.

select StoreName,OpenDate,EmployeeCount
from DimStore

--b Renomeeie as colunas anteriores para deixar a sua consulta mais
--intuitiva.

select StoreName as 'nome da loja',OpenDate as 'data',EmployeeCount as 'contagem de funcionario'
from DimStore

--c. Dessas lojas, descubra quantas (e quais)lojas ainda est�o ativas.
select Status
from DimStore
where status like 'on'
-- outra maneira
select Status
from DimStore
where StoreType = 'store' OR status = 'ON'


--ex 5 O gerente da �rea de controle de qualidade notificou � Contoso que
--todos os produtos Home Theater da marca Litware, disponibilizados
--para venda no dia 15 de mar�o de 2009, foram identificados com
--defeitos de f�brica.
--O que voc� dever� fazer � identificar os ID�s desses produtos e repassar
--ao gerente para que ele possa notificar as lojas e consequentemente
--solicitar a suspens�o das vendas desses produtos.

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



--6 Imagine que voc� precise extrair um relat�rio da tabela DimStore, com
--informa��es de lojas. Mas voc� precisa apenas das lojas que n�o est�o
--mais funcionando atualmente.
--a. Utilize a coluna de Status para filtrar a tabela e trazer apenas as
--lojas que n�o est�o mais funcionando.

select Status
from DimStore
where Status like 'off'

--b Agora imagine que essa coluna de Status n�o existe na sua tabela.
--Qual seria a outra forma que voc� teria de descobrir quais s�o as lojas
--que n�o est�o mais funcionando.

select CloseReason
from DimStore
where CloseReason like 'relocation'

--ex 7 determinada quantidade de m�quinas de caf�. As lojas ser�o divididas em
--3 categorias:

--CATEGORIA 1:De 1 a 20 funcion�rios ->1 m�quina de caf�
--CATEGORDe acordo com a quantidade de funcion�rios, cada loja receber� uma
--IA 2:De 21 a 50 funcion�rios ->2 m�quinas de caf�
--CATEGORIA 3: Acima de 51 funcion�rios ->3 m�quinas de caf�
--Identifique, para cada caso, quais s�o as lojas de cada uma das 3
--categorias acima (basta fazer uma verifica��o).


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






--ex 8 A empresa decidiu que todos os produtos LCD receber�o um super
--desconto no pr�ximo m�s. O seu trabalho � fazer uma consulta � tabela
--DimProduct e retornar os ID�s, Nomes e Pre�os de todos os produtos
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