/*****Consultas de ayudas*****/


/*********** suma de creditos  **********/
SELECT  SUM(asi_creditos)
FROM SIA_NOTAS n 
INNER JOIN SIA_PROYECCIONES p ON n.PRO_CODIGO=p.PRO_CODIGO
INNER JOIN SIA_ASIGNATURAS a ON p.ASI_CODIGO=a.ASI_CODIGO
INNER JOIN SIA_ESTUDIANTES e ON e.EST_CODIGO=p.EST_CODIGO
GROUP BY e.EST_CODIGO;


/*********** suma de multiplicacion de notadefinitiva por credito  ******/
select e.EST_CODIGO, asi_creditos*not_definitiva
FROM SIA_NOTAS n 
INNER JOIN SIA_PROYECCIONES p ON n.PRO_CODIGO=p.PRO_CODIGO
INNER JOIN SIA_ASIGNATURAS a ON p.ASI_CODIGO=a.ASI_CODIGO
INNER JOIN SIA_ESTUDIANTES e ON e.EST_CODIGO=p.EST_CODIGO
ORDER BY e.EST_CODIGO;
 /**************  FIN CONSULTAS AYUDAS ****************************/




/** CONSULTASS**/
SELECT e.EST_COD_MATRICULA, UPPER(e.EST_NOMBRES), UPPER(e.EST_APELLIDOS), fn_multiplicacion(e.est_codigo)/fn_suma_creditos(e.est_codigo)
FROM SIA_NOTAS n 
INNER JOIN SIA_PROYECCIONES p ON n.PRO_CODIGO=p.PRO_CODIGO
INNER JOIN SIA_ASIGNATURAS a ON p.ASI_CODIGO=a.ASI_CODIGO
INNER JOIN SIA_ESTUDIANTES e ON e.EST_CODIGO=p.EST_CODIGO
WHERE (fn_multiplicacion(e.est_codigo)/fn_suma_creditos(e.est_codigo)) >=3
GROUP BY e.EST_CODIGO, e.EST_COD_MATRICULA, e.EST_NOMBRES, e.EST_APELLIDOS
ORDER BY e.EST_COD_MATRICULA;

SELECT fn_cantidad_asi_tipo('A'), fn_suma_credi_tipo('A')
FROM  SIA_ASIGNATURAS
WHERE ASI_TIPO='A'
GROUP BY ASI_TIPO;




SELECT UPPER(e.EST_NOMBRES), UPPER(e.EST_APELLIDOS), ROUND(fn_multiplicacion(e.est_codigo)/fn_suma_creditos(e.est_codigo),2)
FROM SIA_NOTAS n
INNER JOIN SIA_PROYECCIONES p ON n.PRO_CODIGO=p.PRO_CODIGO
INNER JOIN SIA_ASIGNATURAS a ON p.ASI_CODIGO=a.ASI_CODIGO
INNER JOIN SIA_ESTUDIANTES e ON e.EST_CODIGO=p.EST_CODIGO
WHERE (fn_multiplicacion(e.est_codigo)/fn_suma_creditos(e.est_codigo)) = (SELECT MAX(fn_multiplicacion(e.est_codigo)/fn_suma_creditos(e.est_codigo))
FROM SIA_NOTAS n
INNER JOIN SIA_PROYECCIONES p ON n.PRO_CODIGO=p.PRO_CODIGO
INNER JOIN SIA_ASIGNATURAS a ON p.ASI_CODIGO=a.ASI_CODIGO
INNER JOIN SIA_ESTUDIANTES e ON e.EST_CODIGO=p.EST_CODIGO
WHERE e.est_estado = 1)
AND e.est_estado = 1 
GROUP BY e.EST_CODIGO, e.EST_NOMBRES, e.EST_APELLIDOS
ORDER BY e.EST_CODIGO;
