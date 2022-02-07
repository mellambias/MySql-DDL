/*
https://www.javatpoint.com/mysql-join
Sintaxis SQL 1
SELECT *
FROM tabla1, tabla2
WHERE tabla1.FK = tabla2.PK

Sintaxis SQL 2

SELECT * 
FROM tabla1 
INNER JOIN tabla2
ON tabla1.FK = tabla2.PK

LEFT JOIN muestran los valores no relacionados por la izquierda.
Muestra la tabla1 y todos los relacionados de la tabla2:

SELECT *
FROM tabla1 
LEFT JOIN tabla2
ON tabla1.columna = tabla2.columna;



RIGTH JOIN muestra los valores no relacionados por la derecha.
Muestra la tabla2 y todos los relacionados de la tabla1

SELECT *
FROM tabla1 
LEFT JOIN tabla2
ON tabla1.columna = tabla2.columna;
*/

/*
INNER JOIN de varias tablas

SELECT columns  
FROM table1  
INNER JOIN table2 ON condition1  
INNER JOIN table3 ON condition2  
*/
/*
Podemos usar un campo con el mismo nombre en la tabla1 y tabla2

SELECT columns  
FROM table1  
INNER JOIN table2 
USING(campoComun)

podemos añadir un filtro a USING

SELECT columns  
FROM table1  
INNER JOIN table2 
USING(campoComun) WHERE campo = condicion
*/
--1.Lista el nombre del producto, precio y nombre de fabricante para todos los productos de la base de datos.
select p.nombre, p.precio, f.nombre
from producto p
inner join
fabricante f
on p.codigo_fabricante = f.codigo

-- 2 Lista el precio medio los productos de cada fabricante, mostrando solamente el nombre del fabricante.
select avg(p.precio) as precio_medio, f.nombre as nombre
from producto p
inner join
fabricante f
on p.codigo_fabricante = f.codigo
group by f.nombre

--3 Lista los nombres de los fabricantes cuyos productos tienen un precio medio mayor o igual a 150€.

-- Lista el nombre de cada fabricante con el nombre y el precio de su producto más caro.
SELECT p.nombre,p.precio,f.nombre
from  producto p INNER JOIN fabricante f
on f.codigo = p.codigo_fabricante
and
p.precio = (SELECT max(p.precio) from producto p where p.codigo_fabricante = f.codigo)