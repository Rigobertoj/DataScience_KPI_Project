CREATE PROCEDURE dbo.SpVentasPorPeriodo
    @FechaInicio DATE,
    @FechaFin    DATE
AS
BEGIN
    SELECT
        O.ShipRegion                    AS Región,
        C.CategoryName                  AS Categoria,
        YEAR(O.OrderDate)               AS Año,
        MONTH(O.OrderDate)              AS Mes,
        SUM(OD.UnitPrice*OD.Quantity)   AS TotalVentas
        FROM Orders O
    JOIN [Order Details] OD ON OD.OrderID   = O.OrderID
    JOIN Products P        ON P.ProductID   = OD.ProductID
    JOIN Categories C      ON C.CategoryID  = P.CategoryID
    WHERE
        O.OrderDate >= @FechaInicio
    AND O.OrderDate <= @FechaFin
    GROUP BY
        O.ShipRegion,
        C.CategoryName,
        YEAR(O.OrderDate),
        MONTH(O.OrderDate)
    ORDER BY
        O.ShipRegion,
        C.CategoryName,
        YEAR(O.OrderDate),
        MONTH(O.OrderDate);
END;
GO

EXEC dbo.SpVentasPorPeriodo
    @FechaInicio = '1996-07-01',
    @FechaFin    = '1996-08-28'
