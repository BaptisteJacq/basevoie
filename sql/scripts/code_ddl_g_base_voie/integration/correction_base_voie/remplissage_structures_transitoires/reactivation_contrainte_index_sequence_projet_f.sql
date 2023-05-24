-- Réinitialisation de la séquence d'incrémentation de la clé primaire de la table TEMP_F_TRONCON et réactivation des contraintes et index
SET SERVEROUTPUT ON
DECLARE
	id_max NUMBER(38,0);
BEGIN
	SELECT
		MAX(objectid)+1
		INTO id_max
	FROM
		G_BASE_VOIE.TEMP_F_TRONCON;

	EXECUTE IMMEDIATE 'DROP SEQUENCE SEQ_TEMP_F_TRONCON_OBJECTID';
	EXECUTE IMMEDIATE 'CREATE SEQUENCE SEQ_TEMP_F_TRONCON_OBJECTID START WITH ' ||id_max|| ' INCREMENT BY 1';

	-- Réactivation des contraintes et des index des tables de correction du projet C
	-- Réactivation des contraintes
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TEMP_F_TRONCON ENABLE CONSTRAINT TEMP_F_TRONCON_FID_PNOM_SAISIE_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TEMP_F_TRONCON ENABLE CONSTRAINT TEMP_F_TRONCON_FID_PNOM_MODIFICATION_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TEMP_F_VOIE_ADMINISTRATIVE ENABLE CONSTRAINT TEMP_F_VOIE_ADMINISTRATIVE_FID_TYPE_VOIE_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TEMP_F_VOIE_ADMINISTRATIVE ENABLE CONSTRAINT TEMP_F_VOIE_ADMINISTRATIVE_FID_PNOM_SAISIE_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TEMP_F_VOIE_ADMINISTRATIVE ENABLE CONSTRAINT TEMP_F_VOIE_ADMINISTRATIVE_FID_PNOM_MODIFICATION_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TEMP_F_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE ENABLE CONSTRAINT TEMP_F_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_FID_VOIE_PHYSIQUE_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TEMP_F_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE ENABLE CONSTRAINT TEMP_F_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_FID_VOIE_ADMINISTRATIVE_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TEMP_F_TRONCON ENABLE CONSTRAINT TEMP_F_TRONCON_FID_PNOM_SAISIE_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TEMP_F_TRONCON ENABLE CONSTRAINT TEMP_F_TRONCON_FID_PNOM_MODIFICATION_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TEMP_F_TRONCON ENABLE CONSTRAINT TEMP_F_TRONCON_FID_ETAT_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TEMP_F_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE DISABLE CONSTRAINT TEMP_F_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_FID_VOIE_ADMINISTRATIVE_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TEMP_F_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE DISABLE CONSTRAINT TEMP_F_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_FID_VOIE_PHYSIQUE_FK';


	-- Re-création des index
	EXECUTE IMMEDIATE 'CREATE INDEX TEMP_F_VOIE_ADMINISTRATIVE_LIBELLE_VOIE_IDX ON G_BASE_VOIE.TEMP_F_VOIE_ADMINISTRATIVE(libelle_voie) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TEMP_F_VOIE_ADMINISTRATIVE_COMPLEMENT_NOM_VOIE_IDX ON G_BASE_VOIE.TEMP_F_VOIE_ADMINISTRATIVE(complement_nom_voie) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TEMP_F_VOIE_ADMINISTRATIVE_CODE_INSEE_IDX ON G_BASE_VOIE.TEMP_F_VOIE_ADMINISTRATIVE(code_insee) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TEMP_F_VOIE_ADMINISTRATIVE_FID_LATERALITE_IDX ON G_BASE_VOIE.TEMP_F_VOIE_ADMINISTRATIVE(fid_lateralite) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TEMP_F_VOIE_ADMINISTRATIVE_FID_PNOM_SAISIE_IDX ON G_BASE_VOIE.TEMP_F_VOIE_ADMINISTRATIVE(fid_pnom_saisie) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TEMP_F_VOIE_ADMINISTRATIVE_FID_PNOM_MODIFICATION_IDX ON G_BASE_VOIE.TEMP_F_VOIE_ADMINISTRATIVE(fid_pnom_modification) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TEMP_F_VOIE_ADMINISTRATIVE_FID_TYPE_VOIE_IDX ON G_BASE_VOIE.TEMP_F_VOIE_ADMINISTRATIVE(fid_type_voie) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TEMP_F_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_FID_VOIE_PHYSIQUE_IDX ON G_BASE_VOIE.TEMP_F_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE(fid_voie_physique) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TEMP_F_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_FID_VOIE_ADMINISTRATIVE_IDX ON G_BASE_VOIE.TEMP_F_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE(fid_voie_administrative) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TEMP_F_TRONCON_SIDX ON G_BASE_VOIE.TEMP_F_TRONCON(GEOM) INDEXTYPE IS MDSYS.SPATIAL_INDEX PARAMETERS(''sdo_indx_dims=2, layer_gtype=LINE, tablespace=G_ADT_INDX, work_tablespace=DATA_TEMP'')';

	-- Réactivation des triggers
	EXECUTE IMMEDIATE 'ALTER TRIGGER B_IUX_TEMP_F_TRONCON_DATE_PNOM ENABLE';

END;