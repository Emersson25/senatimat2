USE senatimat;

DELIMITER $$
CREATE PROCEDURE spu_estudiantes_listar()
BEGIN
	SELECT	EST.idestudiante,
				EST.apellidos, EST.nombres,
				EST.tipodocumento, EST.nrodocumento,
				EST.fechanacimiento,
				ESC.escuela,
				CAR.carrera,
				SED.sede,
				EST.fotografia
		FROM estudiantes EST
		INNER JOIN carreras CAR ON CAR.idcarrera = EST.idcarrera
		INNER JOIN sedes SED ON SED.idsede = EST.idsede
		INNER JOIN escuelas ESC ON ESC.idescuela = CAR.idescuela
		WHERE EST.estado = '1';
END $$

CALL spu_estudiantes_listar();

DELIMITER $$
CREATE PROCEDURE spu_estudiantes_registrar
(
	IN _apellidos 			VARCHAR(40),
	IN _nombres 			VARCHAR(40),
	IN _tipodocumento		CHAR(1),
	IN _nrodocumento		CHAR(8),
	IN _fechanacimiento	DATE,
	IN _idcarrera 			INT,
	IN _idsede 				INT,
	IN _fotografia 		VARCHAR(100)
)
BEGIN
	
	INSERT INTO estudiantes 
	(apellidos, nombres, tipodocumento, nrodocumento, fechanacimiento, idcarrera, idsede, fotografia) VALUES
	(_apellidos, _nombres, _tipodocumento, _nrodocumento, _fechanacimiento, _idcarrera, _idsede, _fotografia);
END $$


CALL spu_estudiantes_registrar('Francia Minaya', 'Jhon', 'D', '12345678', '1984-09-20', 5, 1, '');
CALL spu_estudiantes_registrar('Munayco', 'José', 'D', '77779999', '1999-09-20', 3, 2, NULL);
CALL spu_estudiantes_registrar('Prada', 'Teresa', 'C', '01234567', '2002-09-25', 3, 2, '');
SELECT * FROM estudiantes;


DELIMITER $$
CREATE PROCEDURE spu_sedes_listar()
BEGIN
	SELECT * FROM sedes ORDER BY 2;
END $$

DELIMITER $$
CREATE PROCEDURE spu_escuelas_listar()
BEGIN 
	SELECT * FROM escuelas ORDER BY 2;
END $$

DELIMITER $$
CREATE PROCEDURE spu_carreras_listar(IN _idescuela INT)
BEGIN
	SELECT idcarrera, carrera 
		FROM carreras
		WHERE idescuela = _idescuela;
END $$

CALL spu_carreras_listar(3);
-- ///////////////////////////////////////////////////////////////////////////////////
-- COLABORADORES
-- LISTAR
DELIMITER $$
CREATE PROCEDURE spu_colaboradores_listar()
BEGIN
	SELECT	COL.idcolaborador,
			COL.apellidos, COL.nombres,
			COL.telefono, COL.tipocontrato,
			COL.cv, COL.direccion,
			car.cargo,
			sed.sede
	FROM colaboradores COL
	INNER JOIN cargos car ON car.idcargo = COL.idcargo
	INNER JOIN sedes sed ON sed.idsede = COL.idsede
	WHERE COL.estado = '1';
END $$

CALL spu_colaboradores_listar();

-- REGISTRAR
DELIMITER $$
CREATE PROCEDURE spu_colaboradores_registrar
(
	IN _apellidos 			VARCHAR(50),
	IN _nombres 			VARCHAR(50),
	IN _telefono			CHAR(9),
	IN _tipocontrato		CHAR(1),
	IN _cv					VARCHAR(100),
	IN _direccion			VARCHAR(70),
	IN _idcargo	 			INT,
	IN _idsede 				INT
)
BEGIN
			
	
	INSERT INTO colaboradores 
	(apellidos, nombres, telefono, tipocontrato, cv, direccion, idcargo, idsede ) VALUES
	(_apellidos, _nombres, _telefono, _tipocontrato, _cv, _direccion, _idcargo, _idsede);
END $$

CALL spu_colaboradores_registrar('Salvatierra', 'Alejandro','965832101','P','','Calle San Alejandro',1,3);
CALL spu_colaboradores_registrar('Quispe', 'Andres','965835483','C','', 'Av. Tupac Amaru',2,4);
CALL spu_colaboradores_registrar('Munayco', 'Alosno','965835483','C','', 'Av. Lomas',4,4);   
SELECT * FROM colaboradores;

DELIMITER $$
CREATE PROCEDURE spu_cargos_listar()
BEGIN
	SELECT * FROM cargos ORDER BY 2;
END $$
CALL spu_cargos_listar();
