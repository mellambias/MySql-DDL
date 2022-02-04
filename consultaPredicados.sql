/*
Práctica 3: Consultas con Predicados Básicos

1. Obtener una relación por orden alfabético de los departamentos 
cuyo presupuesto es inferior a 30.000 € 
El nombre de los departamentos vendrá precedido de las palabras 
“DEPARTAMENTO DE “. 
Nota: El presupuesto de los departamentos viene expresado en miles de €.
*/
SELECT concat("DEPARTAMENTO DE ",nomde) AS "NOMBRE"
FROM departamentos
WHERE presu < 30
ORDER BY nomde;

/*
2. Muestra el número y el nombre de cada departamento separados por un guión
 y en un mismo campo llamado “Número-Nombre”, además del tipo de director mostrado
  como “Tipo de Director”, para aquellos departamentos con presupuesto inferior a 30.000 €.
*/
SELECT CONCAT_WS ("-", numde, nomde) AS "Número-Nombre", 
tidir AS "Tipo de Director"
FROM departamentos
WHERE presu < 30;

/*
3. Suponiendo que en los próximos dos años el coste de vida va a aumentar un 8% anual
 y que se suben los salarios solo un 2% anual, 
 hallar para los empleados con más de 4 hijos su nombre y su sueldo anual,
  actual y para cada uno de los próximos dos años, 
  clasificados por orden alfabético. Muestra la consulta tal y como aparece en la captura.
*/
SELECT nomem, 
12*salar as "Salario 2014", 
12*1.02*salar as "Salario 2015", 
12*1.02*1.02*salar as "Salario 2016"
FROM empleados
WHERE numhi > 4
ORDER BY nomem

/*
4.Hallar, por orden alfabético, los nombres de los empleados 
tales que si se les da una gratificación de 120 € por hijo, 
el total de esta gratificación supera el 20% de su salario.
*/
SELECT nomem, (numhi*120) AS gratificacion, ((salar*20)/100) AS "20% salario"
FROM empleados
WHERE (numhi*120) > ((salar*20)/100)
ORDER BY nomem;

/*
5. Para los empleados del departamento 112 hallar el nombre y el salario total
 (salario más comisión), 
 por orden de salario total decreciente, 
 y por orden alfabético dentro de salario total.
*/
SELECT nomem, (salar+COMIS) AS salTotal
FROM empleados
WHERE numde = 112
ORDER BY -salTotal,salTotal DESC, nomem;

/*
6. Vemos que para Micaela no se muestra nada en Salario Total, 
esto es debido a que su comisión es Nula 
(Lo que no significa que sea 0–> significa que no se ha introducido ningún valor). 
Esto impide hacer el cálculo de la suma. 
Muestra entonces la misma consulta anterior pero sólo para aquellos empleados 
cuya comisión no sea nula.
*/
SELECT nomem, (salar+COMIS) AS salTotal
FROM empleados
WHERE numde = 112 and COMIS IS NOT NULL
ORDER BY -salTotal,salTotal DESC, nomem;

/*
7. Repite la consulta anterior para mostrarla como sigue:
*/
SELECT nomem, concat((salar+COMIS)," eur") AS salTotal
FROM empleados
WHERE numde = 112 and COMIS IS NOT NULL
ORDER BY -salTotal,salTotal DESC, nomem;

/*
8. En una campaña de ayuda familiar se ha decidido dar a los empleados
 una paga extra de 60 € por hijo, a partir del cuarto inclusive. 
 Obtener por orden alfabético para estos empleados: 
 nombre y salario total que van a cobrar incluyendo esta paga extra. 
 Mostrarlo como en la imagen.
*/

SELECT nomem, (salar+((numhi-3)*60)) as "SALARIO TOTAL", salar,numhi, numhi*60
FROM empleados
WHERE numhi >= 4
ORDER BY nomem;

-- Introducción a SELECT subordinado. 
/*
9.Imaginemos la misma consulta anterior, 
pero en la que se nos pide mostrar los mismos campos pero para aquellos empleados
cuyo número de hijos iguale o supere a los de Juliana. 
Es decir, Juliana tiene 4 hijos pero no lo sabemos. 
Lo que sabemos es el nombre. 
En este caso haremos otro SELECT cuyo resultado de la búsqueda sea el número de hijos de Juliana.
*/

SELECT nomem, (salar+(numhi*60)) as "SALARIO TOTAL", salar,numhi, numhi*60
FROM empleados
WHERE numhi >= (SELECT numhi FROM empleados WHERE nomem="JULIANA")
ORDER BY nomem;

/*
10. Obtener por orden alfabético los nombres de los empleados cuyos sueldos
 igualan o superan al de CLAUDIA en más del 15%.
*/

SELECT nomem, salar
FROM empleados
WHERE salar >= (SELECT salar*1.15 FROM empleados WHERE nomem = "CLAUDIA")
ORDER BY nomem;

/*
11.Obtener los nombres de los departamentos que no dependen funcionalmente de otro.
*/
SELECT nomde
FROM departamentos
WHERE depde IS NULL;

-- Práctica 4: Consultas con Predicados Cuantificados. ALL, SOME o ANY.

/*
1. Obtener por orden alfabético los nombres de los empleados cuyo salario supera
 al máximo salario de los empleados del departamento 122.
*/
SELECT nomem
FROM empleados
WHERE salar > (SELECT MAX(salar) from empleados where numde=122);

/*
2. La misma consulta pero para el departamento 150.
 Explica por qué obtenemos la relación de todos los empleados por orden alfabético.
*/

SELECT nomem
FROM empleados
WHERE salar > (SELECT MAX(salar) from empleados where numde=150);
-- El salario devuelto para el departamento 150 es null ya que no existe.

/*
3. Obtener por orden alfabético los nombres de los empleados
    cuyo salario supera en dos veces y media o más al mínimo salario
    de los empleados del departamento 122.
*/
SELECT nomem
FROM empleados
WHERE salar > (SELECT MIN(salar)*2.5 from empleados where numde=122)
ORDER BY nomem;

/*
4. Obtener los nombres y salarios de los empleados 
cuyo salario coincide con la comisión multiplicada por 10 
de algún otro o la suya propia
*/
SELECT nomem, salar
FROM empleados
WHERE salar IN (SELECT distinct (COMIS*10) from empleados)
ORDER BY salar;

/*
5. Obtener por orden alfabético los nombres y salarios de los empleados 
cuyo salario es superior a la comisión máxima existente multiplicada por 20.
*/
SELECT nomem, salar
FROM empleados
WHERE salar > (SELECT MAX(COMIS)*20 from empleados)
ORDER BY nomem;

/*
6. Obtener por orden alfabético los nombres y salarios de los empleados
 cuyo salario es inferior a veinte veces la comisión más baja existente.
*/
SELECT nomem, salar
FROM empleados
WHERE salar < (SELECT MIN(COMIS)*20 from empleados)
ORDER BY nomem;

--Práctica 5: Consultas con Predicados BETWEEN
/*
1. Obtener por orden alfabético los nombres de los empleados cuyo salario está entre 1500 € y 1600 €.-
*/

SELECT nomem
FROM empleados
WHERE salar BETWEEN 1500 AND 1600
ORDER BY nomem;

/*
2. Obtener por orden alfabético los nombres y salarios de los empleados
con comisión, 
cuyo salario dividido por su número de hijos cumpla una, 
o ambas, de las dos condiciones siguientes:
Que sea inferior de 720 €
Que sea superior a 50 veces su comisión.
*/

SELECT nomem, salar/numhi, salar, COMIS*50
FROM empleados
WHERE
COMIS IS NOT NULL
and
(salar/numhi) BETWEEN 720 AND (COMIS*50)
ORDER BY nomem;

-- Práctica 6: Consultas con Predicados LIKE
/*
1. Obtener por orden alfa el nombre y el salario de aquellos empleados
 que comienzan por la letra “A” y muestra la consulta como aparece en la captura.
*/
SELECT nomem as Nombre, concat(salar," eur") as Salario
FROM empleados
WHERE nomem LIKE "A%"
ORDER BY nomem;

/*
2.Obtener por orden alfabético los nombres de los empleados que tengan 8 letras.
*/
SELECT nomem
FROM empleados
WHERE nomem LIKE "________"
ORDER BY nomem;

/*
3. Obtener por orden alfabético los nombres y el presupuesto
 de los departamentos que incluyen la palabra “SECTOR”. 
 La consulta la deberás mostrar como la imagen.
*/

SELECT concat("DEPARTAMENTO DE ",nomde) as Departamento
FROM departamentos
WHERE nomde LIKE "%SECTOR%"
ORDER BY nomde;

-- Práctica 7: Consultas con Predicados IN
/*
1. Obtener por orden alfabético los nombres de los empleados cuya extensión telefónica es 250 o 750.
*/
SELECT nomem, extel
FROM empleados
WHERE extel IN (250,750)
ORDER BY nomem;

/*
2. Obtener por orden alfabético los nombres de los empleados que trabajan 
en el mismo departamento que PILAR o DOROTEA.
*/

SELECT nomem
FROM empleados
WHERE numde IN (SELECT numde FROM empleados WHERE nomem IN ( "PILAR" ,"DOROTEA"))
ORDER BY nomem;

/*
3. Obtener por orden alfabético los nombres de los departamentos cuyo director
 es el mismo que el del departamento: DIRECC.COMERCIAL o el del departamento: 
 PERSONAL Mostrar la consulta como :
 Nombres Departamentos          Identificador de su director
------------------------------ ----------------------------
SECTOR INDUSTRIAL              180
DIRECC.COMERCIAL               180
PERSONAL                       150
ORGANIZACIÓN                   150
*/
SELECT nomde as "Nombres Departamentos", direc as "Identificador de su director"
FROM departamentos
WHERE direc IN (SELECT direc FROM departamentos WHERE nomde IN ("DIRECC.COMERCIAL", "PERSONAL"))
ORDER BY nomde;

--Práctica 8: Consultas con Predicados EXISTS
/*
1.Obtener los nombres de los centros de trabajo si hay alguno que esté en la calle ATOCHA.
*/
SELECT nomce
FROM centros
WHERE EXISTS (SELECT * FROM centros WHERE dirce LIKE "%ATOCHA%")
ORDER BY nomce;

/*
2.Obtener los nombres y el salario de los empleados del departamento 100
 si en él hay alguno que gane más de 1300 €.
*/

SELECT nomem, salar
FROM empleados
WHERE 
numde=100
AND
EXISTS (SELECT * FROM empleados WHERE numde=100 AND salar > 1300)
ORDER BY nomem;

-- Práctica 10: Consultas con Fechas
/*
1. Obtener por orden alfabético, los nombres y fechas de nacimiento
 de los empleados que cumplen años en el mes de noviembre.
*/
SELECT nomem, date_Format(fecna,"%d/%m/%Y") AS nacimiento
FROM empleados
WHERE  MONTH(fecna) = 11
ORDER BY nomem;

/*
2. Obtener los nombres de los empleados que cumplen años en el día de hoy.
*/
SELECT nomem, fecna
FROM empleados
WHERE 
DAY(fecna)=DAY(now())
AND
MONTH(fecna) = MONTH(now())
ORDER BY nomem;

/*
10. Obtener los empleados y su mes de incorporación
 siempre que esté entre los meses de Enero y Junio (ambos inclusive) 
 y el mes de nacimiento coincida en dicho mes.
*/
SELECT nomem, MONTHNAME(fecin)
FROM empleados
WHERE
month(fecin) BETWEEN 1 AND 6
AND
month(fecin) = month(fecna)
ORDER BY nomem;
-- 3
SELECT TIMESTAMPDIFF(year,min(fecna),NOW()) as edad, min(fecna)
from empleados
WHERE numde=110;

--Práctica 12: Agrupamiento de filas. GROUP BY
/*
1. Hallar cuántos empleados hay en cada departamento.
*/
SELECT numde as depertamento, count(*) as empleados
FROM empleados
GROUP BY numde;

/*
2.Hallar para cada departamento el salario medio, el mínimo y el máximo.
*/
SELECT numde, 
round(sum(salar)/count(*),2) as "salario medio",
min(salar) as "salario mínimo",
max(salar) as "salario máximo"
FROM empleados
GROUP BY numde;

/*
5.Hallar el salario medio y la edad media en años cumplidos 
para cada grupo de empleados del mismo departamento y con igual comisión.
*/
SELECT numde, 
COMIS,
round(avg(salar),2) as "salario medio",
AVG(TIMESTAMPDIFF(year,fecna,NOW())) as EdadMedia
FROM empleados
GROUP BY numde, COMIS;

-- Práctica 13: Agrupamiento de filas. CLÁUSULA HAVING

/*
1. Hallar el número de empleados que usan la misma extensión telefónica. 
Solamente se desea mostrar aquellos grupos que tienen más de 1 empleado.
*/

SELECT extel, count(numem)
FROM empleados
GROUP BY extel
HAVING count(numen) > 1;