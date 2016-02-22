--ComparaFecha
IF (@fechaMenor > @fechaMayor) 
BEGIN
   SELECT        @salida='La variable de FechaMenor tiene un valor superior a la de FechaMayor'
END

--GetRegistros
SELECT SalesOrderID,TotalDue,OrderDate
FROM sales.SalesOrderHeader
WHERE OrderDate<@fechaMayor AND OrderDate>@fechaMenor;

--BorraBitacora
IF OBJECT_ID('Bitacora', 'U') IS NOT NULL 
  DROP TABLE dbo.Bitacora; 

CREATE TABLE Bitacora
(
Mensaje  VARCHAR(500)
);

--SalesID
SELECT @orderQty=SUM(OrderQty),@minPrice=MIN(UnitPrice),@maxPrice=MAX(UnitPrice)
FROM Sales.SalesOrderDetail 
WHERE SalesOrderID = @salesID;

--
INSERT INTO dbo.Bitacora
VALUES (
	CONCAT
	(
		'Para la Orden de venta número ',
		CONVERT(varchar, @salesID),
		' de fecha ',
		CONVERT(varchar, @salesDate),
		' con total ',
		CONVERT(varchar, @salesTotal),
		' se facturaron ',
		CONVERT(varchar, @orderQty),
		' artículos cuyos precios oscilaron entre ',
		CONVERT(varchar, @minPrice),
		' y ',
		CONVERT(varchar, @maxPrice)
	)
	
);

--
SELECT COUNT(Mensaje)
FROM dbo.Bitacora;
