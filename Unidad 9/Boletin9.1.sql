USE Northwind

-- 1.	Nombre de los proveedores y número de productos que nos vende cada uno
SELECT S.CompanyName , COUNT(P.ProductID) AS [Numero de productos]
FROM Products AS P
INNER JOIN Suppliers AS S ON P.SupplierID = S.SupplierID
Group by CompanyName
Order by CompanyName

-- 2.	Nombre completo y telefono de los vendedores que trabajen en
-- New York, Seattle, Vermont, Columbia, Los Angeles, Redmond o Atlanta.
SELECT LastName, FirstName, HomePhone
FROM Employees AS E
INNER JOIN EmployeeTerritories AS ET ON E.EmployeeID = ET.EmployeeID
INNER JOIN Territories AS T ON ET.TerritoryID = T.TerritoryID
WHERE T.TerritoryDescription IN ('New York', 'Seattle', 'Vermont', 'Columbia', 'Los Angeles', 'Redmond', 'Atlanta')
GROUP BY FirstName, LastName, HomePhone

-- 3.	Número de productos de cada categoría y nombre de la categoría.
SELECT COUNT(P.ProductID), C.CategoryName
FROM Products AS P
INNER JOIN Categories AS C ON P.CategoryID = C.CategoryID
GROUP BY CategoryName

-- 4.	Nombre de la compañía de todos los clientes que hayan comprado queso de cabrales o tofu.
SELECT C.CompanyName
FROM Customers AS C
INNER JOIN Products AS P ON


-- 5.	Empleados (ID, nombre, apellidos y teléfono) que han vendido algo a Bon app' o Meter Franken.
-- 6.	Empleados (ID, nombre, apellidos, mes y día de su cumpleaños) que no han vendido nunca nada a ningún cliente de Francia. *
-- 7.	Total de ventas en US$ de productos de cada categoría (nombre de la categoría).
-- 8.	Total de ventas en US$ de cada empleado cada año (nombre, apellidos, dirección).
-- 9.	Ventas de cada producto en el año 97. Nombre del producto y unidades.
-- 10.	Cuál es el producto del que hemos vendido más unidades en cada país. *
-- 11.	Empleados (nombre y apellidos) que trabajan a las órdenes de Andrew Fuller.
-- 12.	Número de subordinados que tiene cada empleado, incluyendo los que no tienen ninguno. Nombre, apellidos, ID.
