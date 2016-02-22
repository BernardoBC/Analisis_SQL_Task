--SQL Drop Table if table exists
IF OBJECT_ID('dbo.PreguntaUno', 'U') IS NOT NULL 
  DROP TABLE dbo.PreguntaUno; 

--CreaTabla
CREATE TABLE PreguntaUno
(
TipoBombillo INT not Null primary key,
Descripcion VARCHAR(30),
VoltajeMaximo DOUBLE PRECISION,
VoltajeMinimo DOUBLE PRECISION
);

--InsertsRegistros
INSERT INTO dbo.PreguntaUno
VALUES (35,'Bombillo de 35 watts',40.58,25.73);
INSERT INTO dbo.PreguntaUno
VALUES (110,'Bombillo de 110 watts',119.52,106.81);
INSERT INTO dbo.PreguntaUno
VALUES (17,'Bombillo de 17 watts',21.82,13.49);
INSERT INTO dbo.PreguntaUno
VALUES (65,'Bombillo de 65 watts',82.39,48.92 );

--Get Bombillo
IF EXISTS
(
	SELECT        TipoBombillo
	FROM            PreguntaUno
	WHERE        (VoltajeMinimo <= @voltaje) AND (VoltajeMaximo >= @voltaje)
) 
BEGIN
   SELECT        @bombillo=TipoBombillo
	FROM            PreguntaUno
	WHERE        (VoltajeMinimo <= @voltaje) AND (VoltajeMaximo >= @voltaje)
END
ELSE
BEGIN
   SELECT @error = CONCAT
   	(
   		'El bombillo con serie ',
   		CONVERT(varchar, @serie),
   		' y voltaje Medido de ',
   		CONVERT(varchar, @voltaje),
   		',watts no corresponde a un tipo definido en el sistema'
   	),
   	@bombillo=0;
END

--CasosTipoBombillos
DECLARE @volMinReal as numeric;
DECLARE @volMaxReal as numeric;
DECLARE @volMinPropuesto as numeric;
DECLARE @volMaxPropuesto as numeric;

IF (@bombilloReal=@bombilloPropuesto)
BEGIN
	SELECT	@volMinPropuesto=VoltajeMinimo,@volMaxPropuesto=VoltajeMaximo
		FROM	PreguntaUno
		WHERE	TipoBombillo=@bombilloReal;
		SELECT @salida=CONCAT
		(
			'El bombillo con serie ',
			CONVERT(varchar, @serie),
			' y voltaje Medido de ',
			CONVERT(varchar, @voltaje),
			' watts coincide con el tipo de bombillo propuesto (',
			CONVERT(varchar, @bombilloPropuesto),
			'), el cual se ubica en el rango de ',
			CONVERT(varchar, @volMinPropuesto),
			' watts hasta ',
			CONVERT(varchar, @volMaxPropuesto),
			' watts' 		
		);
END
ELSE
BEGIN
	SELECT	@volMinReal=VoltajeMinimo,@volMaxReal=VoltajeMaximo
		FROM	PreguntaUno
		WHERE	TipoBombillo=@bombilloReal;
   	SELECT	@volMinPropuesto=VoltajeMinimo,@volMaxPropuesto=VoltajeMaximo
		FROM	PreguntaUno
		WHERE	TipoBombillo=@bombilloPropuesto;
		SELECT	@salida=CONCAT
	   	(
	   		'El bombillo con serie ',
	   		CONVERT(varchar, @serie),
	   		' y voltaje Medido de ',
	   		CONVERT(varchar, @voltaje),
	   		' watts fue encontrado en la tabla con el tipo de bombillo (',
	   		CONVERT(varchar, @bombilloReal),
	   		'), el cual se ubica en el rango de ',
	   		CONVERT(varchar, @volMinReal),
	   		' watts hasta ',
	   		CONVERT(varchar, @volMaxReal),
	   		' watts; sin embargo, el tipo de bombillo propuesto es ',
	   		CONVERT(varchar, @bombilloPropuesto),
	   		'el cual se mueve en el rango de ',
	   		CONVERT(varchar, @volMinPropuesto),
	   		' watts hasta ',
	   		CONVERT(varchar, @volMaxPropuesto),
	   		' watts'	
	   	);
END