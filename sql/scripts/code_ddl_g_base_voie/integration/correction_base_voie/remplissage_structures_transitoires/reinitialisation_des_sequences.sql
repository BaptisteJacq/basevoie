-- Réinitialisation de la séquenc d'incrémentation de la clé primaire de la table TEMP_B_TRONCON
SET SERVEROUTPUT ON
DECLARE
	id_max NUMBER(38,0);
BEGIN
	SELECT
		MAX(objectid)+1
		INTO id_max
	FROM
		G_BASE_VOIE.TEMP_B_TRONCON;

	EXECUTE IMMEDIATE 'DROP SEQUENCE SEQ_TEMP_B_TRONCON_OBJECTID';
	EXECUTE IMMEDIATE 'CREATE SEQUENCE SEQ_TEMP_B_TRONCON_OBJECTID START WITH ' ||id_max|| ' INCREMENT BY 1';

END;