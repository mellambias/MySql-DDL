/* 1. Hallar, por orden alfabético, los nombres de los departamentos 
cuyo director lo es en funciones y no en propiedad.
*/

SELECT nomde FROM departamentos
WHERE tidir="F"
ORDER BY nomde ASC;

/* 2. Obtener un listín telefónico de los empleados
 del departamento 121 incluyendo nombre de empleado, 
 número de empleado y extensión telefónica. Por orden alfabético.
 */

 SELECT nomem,numem,extel
 FROM empleados
 WHERE numde = 121
 ORDER BY nomem ASC;

 /*
  3.Obtener por orden creciente una relación de todos los números de extensiones telefónicas
  de los empleados, junto con el nombre de estos, 
  para aquellos que trabajen en el departamento 110. 
  Mostrar la consulta tal y como aparece en la imagen.
  */
                     
 SELECT nomem as "Nombre", extel as "Extensión Telefónica"
 FROM empleados
 WHERE numde = 110
 order by nomem;

 /*
 4. Hallar la comisión, nombre y salario de los empleados 
 que tienen tres hijos, clasificados por comisión, y 
 dentro de comisión por orden alfabético.
 */

 SELECT COMIS,nomem,salar
 FROM empleados
 WHERE numhi=3
 ORDER BY COMIS IS NULL, COMIS ASC, nomem;

 /*
 5. Hallar la comisión, nombre y salario de los empleados que tienen tres hijos,
  clasificados por comisión, y dentro de comisión por orden alfabético, 
  para aquellos empleados que tienen comisión.
 */
 SELECT COMIS,nomem,salar
 FROM empleados
 WHERE numhi=3
 AND
 COMIS IS NOT NULL
 ORDER BY COMIS IS NULL, COMIS ASC, nomem;

 /*
 6.Obtener salario y nombre de los empleados sin hijos 
 y cuyo salario es mayor que 1200 y menor que 1500 €. 
 Se obtendrán por orden decreciente de salario y 
 por orden alfabético dentro de salario.
 */

SELECT salar,nomem,numhi
 FROM empleados
 WHERE numhi=0
 AND
 salar > 1200 AND salar < 1500
 ORDER BY salar DESC,nomem;

 /*
 Obtener los números de los departamentos donde trabajan empleados
  cuyo salario sea inferior a 1500 €
 */
 SELECT numde
 FROM empleados
 WHERE salar<1500
 GROUP BY numde;

 /*
8.Obtener las distintas comisiones que hay en el departamento 110.
 */
 SELECT DISTINCT COMIS
 FROM empleados
 WHERE numde = 110 AND COMIS IS NOT NULL;