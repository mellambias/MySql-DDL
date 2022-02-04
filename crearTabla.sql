/*
https://josejuansanchez.org/bd/unidad-04-teoria/index.html#crear-una-tabla
https://josejuansanchez.org/bd/unidad-04-teoria/index.html#n%C3%BAmeros-enteros
https://gestionbasesdatos.readthedocs.io/es/latest/Tema4/Actividades.html#practicas
CENTROS
Campo	Nulo	Tipo de datos	Observaciones
NUMCE	NOT NULL	NUMBER(4)	Número de centro
NOMCE	 	VARCHAR2(25)	Nombre de centro
DIRCE	 	VARCHAR2(25)	Dirección del centro
*/
use ejercicio;

CREATE TABLE IF NOT EXISTS centros (
    numce INT UNSIGNED PRIMARY KEY,
    nomce VARCHAR(25),
    dirce VARCHAR(25)
);
/*
DEPARTAMENTOS
Campo	Nulo	Tipo de datos	Observaciones
NUMDE	NOT NULL	NUMBER(3)	Número de departamento
NUMCE	 	NUMBER(4)	Número de centro FK
DIREC	 	NUMBER(3)	Director
TIDIR	 	CHAR(1)	Tipo de director (en Propiedad, en Funciones)
PRESU	 	NUMBER(3,1)	Presupuesto en miles de €
DEPDE	 	NUMBER(3)	Departamento del que depende
NOMDE	 	VARCHAR2(20)	Nombre de departamento
*/
CREATE TABLE IF NOT EXISTS departamentos(
    numde INT UNSIGNED PRIMARY KEY,
    numce INT UNSIGNED,
    direc INT,
    tidir CHAR(1),
    presu FLOAT(3,1),
    depde INT UNSIGNED,
    nomde VARCHAR(20),
    FOREIGN KEY (numce) REFERENCES centros(numce),
    FOREIGN KEY (depde) REFERENCES departamentos(numde)
);

/*
EMPLEADOS
Campo	Nulo	Tipo de datos	Observaciones
NUMEM	NOT NULL	NUMBER(3)	Número de empleado
EXTEL	 	NUMBER(3)	Extensión telefónica
FECNA	 	DATE	Fecha de nacimiento
FECIN	 	DATE	Fecha de incorporación
SALAR	 	NUMBER(5)	Salario
COMIS	 	NUMBER(3)	Comisión
NUMHI	 	NUMBER(1)	Número de hijos
NOMEM	 	VARCHAR2(10)	Nombre de empleado
NUMDE	 	NUMBER(3)	Número de departamento
*/
CREATE TABLE IF NOT EXISTS empleados(
    numem INT UNSIGNED PRIMARY KEY,
    extel MEDIUMINT UNSIGNED,
    fecna DATE,
    fecin DATE,
    salar FLOAT,
    COMIS FLOAT,
    numhi INT UNSIGNED,
    nomem VARCHAR(10),
    numde INT UNSIGNED,
    FOREIGN KEY (numde) REFERENCES departamentos(numde)
);

