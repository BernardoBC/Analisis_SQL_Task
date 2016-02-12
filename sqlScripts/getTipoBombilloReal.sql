SELECT        @bombillo = TipoBombillo
FROM            PreguntaUno
WHERE        (VoltajeMinimo <= @voltaje) AND (VoltajeMaximo >= @voltaje)