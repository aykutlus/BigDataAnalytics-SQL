#QUESTION1 :)
SELECT P.ID,P.NOMBRE,P.APELLIDO1,P.APELLIDO2,ASI.CODIGO,ASI.NOMBRE ASIGNATURA
FROM PROFESORES P,ASIGNATURAS ASI, IMPARTIR I
WHERE I.PROFESORES_ID = P.ID AND I.ASIGNATURA_CODIGO = ASI.CODIGO;

#QUESTION2 :)
SELECT P.NOMBRE PROFESOR, IFNULL(P.DIRIGE_TESIS,'NO TIENE')DIRECTOR
FROM PROFESORES P;

#QUESTION3 :)
SELECT P1.NOMBRE,P1.APELLIDO1,P1.APELLIDO2, timestampdiff(year,P1.ANTIGUEDAD,sysdate()) antiguedad, P2.NOMBRE,P2.APELLIDO1,P2.APELLIDO2 ,timestampdiff(year,P2.ANTIGUEDAD,sysdate()) antiguedad               
FROM PROFESORES P1,PROFESORES P2
WHERE P1.DEPARTAMENTO_CODIGO = P2.DEPARTAMENTO_CODIGO AND P1.ID < P2.ID AND ABS(timestampdiff(YEAR,P1.ANTIGUEDAD,P2.ANTIGUEDAD)) < 2;

#QUESTION4 :)
SELECT A1.NOMBRE,A2.NOMBRE,A3.NOMBRE,A1.MATE_CODIGO MATERIA
FROM ASIGNATURAS A1,ASIGNATURAS A2,ASIGNATURAS A3
WHERE A1.MATE_CODIGO=A2.MATE_CODIGO=A3.MATE_CODIGO AND A1.CODIGO < A2.CODIGO AND A2.CODIGO < A3.CODIGO 
AND A1.CODIGO != A2.CODIGO AND A1.CODIGO != A3.CODIGO AND A2.CODIGO !=A3.CODIGO;

#QUESTION5 :)
SELECT AL.NOMBRE,AL.APELLIDO1,AL.APELLIDO2
FROM (MATRICULAR M JOIN ALUMNOS AL ON AL.DNI=M.ALUMNOS_DNI) JOIN (IMPARTIR I JOIN PROFESORES P ON I.PROFESORES_ID=P.ID)
WHERE I.ASIGNATURA_CODIGO=M.ASIGNATURAS_CODIGO AND I.GRUPO=M.GRUPO AND I.CURSO = M.CURSO AND UPPER(P.NOMBRE) = 'Enrique' AND UPPER(P.APELLIDO1)='Soler'
ORDER BY AL.APELLIDO1,AL.APELLIDO2,AL.NOMBRE;

#QUESTION6 :)
SELECT ASI.NOMBRE ASIGNATURA,M.NOMBRE MATERIA,CONCAT(P.NOMBRE,' ',P.APELLIDO1,' ',IFNULL(P.APELLIDO2,' '))PROFESOR,I.CARGA_CREDITOS
FROM ASIGNATURAS ASI,PROFESORES P,IMPARTIR I, MATERIAS M
WHERE I.PROFESORES_ID=P.ID AND I.ASIGNATURA_CODIGO=ASI.CODIGO AND ASI.MATE_CODIGO=M.CODIGO AND I.CARGA_CREDITOS IS NOT NULL
ORDER BY M.CODIGO ,ASI.NOMBRE DESC;

#QUESTION7 :)
SELECT A.NOMBRE, D.NOMBRE,A.CREDITOS, CAST(A.PRACTICOS /A.CREDITOS * 100 AS DECIMAL(5,2)) '% PERCENTAGE'
FROM ASIGNATURAS A JOIN DEPARTAMENTOS D ON A.DEPARTAMENTO_CODIGO=D.CODIGO 
WHERE (A.PRACTICOS/A.CREDITOS)*100  IS NOT NULL
ORDER BY 4 DESC ;    # => ORDERS DEPENDING ON 4TH COLUMN
 
#QUESTION8 :)
SELECT APELLIDO1
FROM ALUMNOS
WHERE APELLIDO1 LIKE '%ll%'
UNION
SELECT APELLIDO2
FROM ALUMNOS
WHERE APELLIDO2 LIKE '%ll%'
UNION
SELECT APELLIDO1
FROM PROFESORES 
WHERE APELLIDO1 LIKE '%ll%'
UNION
SELECT APELLIDO2
FROM PROFESORES 
WHERE APELLIDO2 LIKE '%ll%';


#QUESTION9 :)
SELECT CONCAT('El director de ',P1.NOMBRE,' ',P1.APELLIDO1,' es ',P2.NOMBRE,' ',P2.APELLIDO1)TESIS ,IFNULL(I.TRAMOS,0) TRAMOS
FROM (PROFESORES P1 JOIN PROFESORES P2 ON P1.DIRIGE_TESIS=P2.ID)  LEFT OUTER JOIN INVESTIGADORES I ON I.PROFESORES_ID=P2.ID;


#QUESTION10 :)
SELECT NOMBRE, APELLIDO1, APELLIDO2, null NOMBRE2, null APELLIDO1_2, null APELLIDO2_2
FROM ALUMNOS
WHERE DNI NOT IN(
	SELECT AL1.DNI
	FROM (ALUMNOS AL1 JOIN ALUMNOS AL2 ON AL1.FECHA_PRIM_MATRICULA=AL2.FECHA_PRIM_MATRICULA)
	WHERE AL1.DNI != AL2.DNI AND AL1.DNI<AL2.DNI)
UNION
SELECT AL1.NOMBRE, AL1.APELLIDO1, AL1.APELLIDO2, AL2.NOMBRE, AL2.APELLIDO1,AL2.APELLIDO2
FROM (ALUMNOS AL1 JOIN ALUMNOS AL2 ON AL1.FECHA_PRIM_MATRICULA=AL2.FECHA_PRIM_MATRICULA)
WHERE AL1.DNI != AL2.DNI AND AL1.DNI < AL2.DNI
ORDER BY APELLIDO1, APELLIDO2, NOMBRE;



