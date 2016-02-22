--
SELECT @minBillToAddressId=Min(TerritoryID),@maxBillToAddressID=MAX(TerritoryID)
FROM Sales.SalesTerritory 

--
SELECT @salida=CONCAT
	(
		'El valor Minimo (',
		CONVERT(varchar, @min),
		') es mayor al valor Maximo(',
		CONVERT(varchar, @max),
		')'
	)

--
SELECT AddressID,City,StateProvinceID,PostalCode
from Person.Address
WHERE AddressID<=@max AND AddressID>=@min
FOR XML RAW;

--
DELETE FROM Pregunta3;

--CreaTabla
CREATE TABLE Pregunta3
(
TerritoryID INT,
CITY VARCHAR(50),
StateProvinceID INT,
POSTALCODE INT
);


