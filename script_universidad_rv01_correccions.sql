/* ----- Base de dades "Universidad" ----- */
USE universidad;
/*1 Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.*/
SELECT apellido1 AS "ALUMNOS: apellido1", apellido2, nombre FROM persona WHERE tipo LIKE 'alumno' ORDER BY apellido1, apellido2, nombre ASC;
/*2 Esbrina el nom i els dos cognoms dels/les alumnes que no han donat d'alta el seu número de telèfon en la base de dades.*/
SELECT nombre, apellido1, apellido2, telefono FROM persona WHERE tipo LIKE 'alumno' AND telefono IS NULL ORDER BY apellido1, apellido2, nombre ASC;
/*3 Retorna el llistat dels/les alumnes que van néixer en 1999.*/
SELECT apellido1, apellido2, nombre, fecha_nacimiento FROM persona WHERE tipo LIKE 'alumno' AND fecha_nacimiento LIKE '1999%';
/*4 Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.*/
SELECT nombre, apellido1, apellido2, telefono, nif FROM persona WHERE tipo LIKE 'profesor' AND telefono IS NULL AND nif LIKE '%K';
/*5 Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.*/
SELECT nombre AS 'Asignatures' FROM asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;
/*6 Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats/des. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.*/
SELECT apellido1, apellido2, persona.nombre, departamento.nombre AS departamento FROM persona RIGHT JOIN profesor ON persona.id = profesor.id_profesor JOIN departamento ON profesor.id_departamento = departamento.id WHERE tipo LIKE 'profesor' ORDER BY apellido1, persona.nombre ASC;
/*7 Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.*/
SELECT asignatura.nombre AS asignatura, anyo_inicio, anyo_fin FROM asignatura JOIN curso_escolar ON asignatura.id = curso_escolar.id JOIN alumno_se_matricula_asignatura ON asignatura.id = alumno_se_matricula_asignatura.id_asignatura JOIN persona ON alumno_se_matricula_asignatura.id_alumno = persona.id WHERE nif LIKE '26902806M' ORDER BY asignatura.nombre, anyo_inicio;
/*8 Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).*/
SELECT DISTINCT departamento.nombre AS departamento, grado.nombre AS grado FROM departamento JOIN profesor ON departamento.id = profesor.id_departamento JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor JOIN grado ON asignatura.id_grado = grado.id WHERE grado.nombre LIKE 'Grado en Ingeniería Informática (Plan 2015)';
/*9 Retorna un llistat amb tots els/les alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.*/
SELECT DISTINCT apellido1, apellido2, persona.nombre, anyo_inicio, anyo_fin FROM persona JOIN alumno_se_matricula_asignatura ON persona.id = alumno_se_matricula_asignatura.id_alumno JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id WHERE anyo_inicio = 2018 AND anyo_fin = 2019 ORDER BY apellido1 ASC;

/*Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.*/
/*1 Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats/des. El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.*/
/*--> NOTA: tots els professors estan vinculats a un departament, per tant no es mostra cap professor amb departament NULL*/
SELECT departamento.nombre AS departamento, apellido1, apellido2, persona.nombre FROM persona LEFT JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN departamento ON profesor.id_departamento = departamento.id WHERE tipo LIKE 'profesor' ORDER BY departamento.nombre, apellido1, apellido2, persona.nombre ASC;
/*2 Retorna un llistat amb els professors/es que no estan associats a un departament.*/
/*--> NOTA: no hi ha professors que no estiguin associats a un departament, però el codi per mostrar-los si fos el cas seria: */ 
SELECT departamento.nombre AS departamento, apellido1, apellido2, persona.nombre FROM persona LEFT JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN departamento ON departamento.id = profesor.id_departamento WHERE tipo LIKE 'profesor' AND departamento.nombre IS NULL ORDER BY apellido1, apellido2, persona.nombre;
/*3 Retorna un llistat amb els departaments que no tenen professors/es associats.*/
SELECT departamento.nombre AS departamento, id_profesor FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento LEFT JOIN persona ON profesor.id_profesor = persona.id WHERE persona.nombre IS NULL ORDER BY departamento.nombre;
/*4 Retorna un llistat amb els professors/es que no imparteixen cap assignatura.*/
SELECT persona.nombre, apellido1, apellido2, asignatura.nombre AS asignatura FROM persona LEFT JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor WHERE asignatura.nombre IS NULL AND persona.tipo = 'profesor' ORDER BY apellido1, apellido2, persona.nombre;
/*5 Retorna un llistat amb les assignatures que no tenen un professor/a assignat.*/
SELECT asignatura.nombre AS asignatura, asignatura.id_profesor FROM asignatura LEFT JOIN profesor ON profesor.id_profesor = asignatura.id_profesor WHERE asignatura.id_profesor IS NULL ORDER BY asignatura.nombre;
/*6 Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.*/
SELECT DISTINCT departamento.nombre AS "Departaments que mai han impartit assignatures" FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor WHERE asignatura.nombre IS NULL;

/*Consultes resum*/
/*1 Retorna el nombre total d'alumnes que hi ha.*/
SELECT COUNT(*) AS "NUMERO TOTAL ALUMNOS" FROM persona WHERE tipo LIKE 'alumno';
/*2 Calcula quants/es alumnes van néixer en 1999.*/
SELECT COUNT(*) AS "NUMERO ALUMNOS NACIDOS EN 1999" FROM persona WHERE tipo LIKE 'alumno' AND fecha_nacimiento LIKE '1999%';
/*3 Calcula quants/es professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.*/
SELECT departamento.nombre AS departamento, COUNT(*) AS "NUM. PROFESORES DPTO." FROM persona LEFT JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN departamento ON profesor.id_departamento = departamento.id WHERE persona.tipo = 'profesor' GROUP BY departamento.nombre ORDER BY COUNT(*) DESC, departamento.nombre ASC;
/*4 Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Té en compte que poden existir departaments que no tenen professors/es associats/des. Aquests departaments també han d'aparèixer en el llistat.*/
SELECT departamento.nombre AS departamento, COUNT(profesor.id_profesor) AS "NUM. PROFESORES" FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento GROUP BY departamento.nombre ORDER BY departamento.nombre;
/*5 Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Té en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.*/
SELECT grado.nombre AS grado, COUNT(asignatura.nombre) AS "NUM. ASIGNATURAS" FROM grado LEFT JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre ORDER BY COUNT(asignatura.nombre) DESC;
/*6 Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.*/
SELECT grado.nombre AS grado, COUNT(asignatura.nombre) AS "NUM. ASIGNATURAS" FROM grado LEFT JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre HAVING COUNT(asignatura.nombre) > 40 ORDER BY COUNT(asignatura.nombre) DESC;
/*7 Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.*/
SELECT grado.nombre AS "nombre del grado", asignatura.tipo AS tipo_asignatura, SUM(creditos) AS total_creditos FROM grado LEFT JOIN asignatura ON grado.id = asignatura.id_grado WHERE creditos IS NOT NULL GROUP BY grado.nombre, asignatura.tipo ORDER BY grado.nombre;
/*8 Retorna un llistat que mostri quants/es alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats/des.*/
SELECT anyo_inicio, COUNT(DISTINCT persona.nombre) AS nombre_alumnes_matriculats FROM curso_escolar LEFT JOIN alumno_se_matricula_asignatura ON curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar LEFT JOIN persona ON alumno_se_matricula_asignatura.id_alumno = persona.id GROUP BY anyo_inicio ORDER BY anyo_inicio;
/*9 Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.*/
SELECT persona.id, persona.nombre, apellido1, apellido2, COUNT(asignatura.id_profesor) AS "NUM. ASIGNATURAS" FROM persona LEFT JOIN asignatura ON persona.id = asignatura.id_profesor WHERE persona.tipo LIKE 'profesor' GROUP BY persona.id ORDER BY COUNT(asignatura.id_profesor) DESC;
/*10 Retorna totes les dades de l'alumne més jove.*/
SELECT apellido1 AS "ALUMNO MÁS JOVEN: apellido1", apellido2, persona.nombre, fecha_nacimiento FROM persona WHERE tipo LIKE 'alumno' AND fecha_nacimiento = (SELECT MAX(fecha_nacimiento) FROM persona);
/*11 Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.*/
SELECT persona.nombre AS "PROFESOR: nombre", apellido1, apellido2, departamento.nombre AS departamento, asignatura.nombre AS asignatura FROM persona LEFT JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN departamento ON profesor.id_departamento = departamento.id LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor WHERE persona.tipo LIKE 'profesor' AND asignatura.nombre IS NULL;