DECLARE @resultado int; 
SELECT        @resultado = TipoBombillo
FROM            PreguntaUno
WHERE        (VoltajeMinimo <= @voltaje) AND (VoltajeMaximo >= @voltaje)

CASE WHEN (@resultado IS NULL) THEN @error = @resultado ELSE @bombillo = @resultado END