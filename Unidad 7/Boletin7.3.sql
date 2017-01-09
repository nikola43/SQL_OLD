--Boletin 7.3
--Consultas sobre una sola Tabla sin agregados
--Sobre la base de Datos AdventureWorks
USE AdventureWorks2012

--Nombre, numero de producto, precio y color de los productos de color rojo o amarillo cuyo precio est� comprendido entre 50 y 500
SELECT ProductID, Name, StandardCost, Color FROM Production.Product
WHERE Color IN ('Red', 'Yellow') AND StandardCost BETWEEN 50 AND 500

--Nombre, n�mero de producto, precio de coste,  precio de venta, margen de beneficios total y margen de beneficios en % del precio de venta de los productos de categor�as inferiores a 16

SELECT * FROM Production.Product

--Empleados cuyo nombre o apellidos contenga la letra "r". Los empleados son los que tienen el valor "EM" en la columna PersonType de la tabla Person
--LoginID, nationalIDNumber, edad y puesto de trabajo (jobTitle) de los empleados (tabla Employees) de sexo femenino que tengan m�s de cinco a�os de antig�edad
--Ciudades correspondientes a los estados 11, 14, 35 o 70, sin repetir. Usar la tabla Person.Address