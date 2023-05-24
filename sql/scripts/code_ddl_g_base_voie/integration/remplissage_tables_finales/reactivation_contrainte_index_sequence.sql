-- Réinitialisation de la séquence d'incrémentation de la clé primaire de la table TA_TRONCON et réactivation des contraintes et index
SET SERVEROUTPUT ON
DECLARE
	id_max NUMBER(38,0);
BEGIN
	SELECT
		MAX(objectid)+1
		INTO id_max
	FROM
		G_BASE_VOIE.TA_VOIE_PHYSIQUE;

	EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_TA_VOIE_PHYSIQUE_OBJECTID START WITH ' ||id_max|| ' INCREMENT BY 1';

	SELECT
		MAX(objectid)+1
		INTO id_max
	FROM
		G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE;

	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE MODIFY OBJECTID NUMBER(38,0) GENERATED BY DEFAULT AS IDENTITY (START WITH ' ||id_max|| ' INCREMENT BY 1)';

	SELECT
		MAX(objectid)+1
		INTO id_max
	FROM
		G_BASE_VOIE.TA_LIBELLE;

	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_LIBELLE MODIFY OBJECTID NUMBER(38,0) GENERATED BY DEFAULT AS IDENTITY (START WITH ' ||id_max|| ' INCREMENT BY 1)';

	SELECT
		MAX(objectid)+1
		INTO id_max
	FROM
		G_BASE_VOIE.TA_SEUIL;

	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_SEUIL MODIFY OBJECTID NUMBER(38,0) GENERATED BY DEFAULT AS IDENTITY (START WITH ' ||id_max|| ' INCREMENT BY 1)';

	SELECT
		MAX(objectid)+1
		INTO id_max
	FROM
		G_BASE_VOIE.TA_INFOS_SEUIL;

	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_INFOS_SEUIL MODIFY OBJECTID NUMBER(38,0) GENERATED BY DEFAULT AS IDENTITY (START WITH ' ||id_max|| ' INCREMENT BY 1)';

	SELECT
		MAX(objectid)+1
		INTO id_max
	FROM
		G_BASE_VOIE.TA_TRONCON;
        
    EXECUTE IMMEDIATE 'ALTER SEQUENCE SEQ_TA_TRONCON_OBJECTID START WITH ' ||id_max|| ' INCREMENT BY 1';
    
	-- Réactivation des contraintes et des index des tables de correction du projet C
	-- Réactivation des contraintes
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_TRONCON ENABLE CONSTRAINT TA_TRONCON_FID_PNOM_SAISIE_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_TRONCON ENABLE CONSTRAINT TA_TRONCON_FID_PNOM_MODIFICATION_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE ENABLE CONSTRAINT TA_VOIE_ADMINISTRATIVE_FID_TYPE_VOIE_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE ENABLE CONSTRAINT TA_VOIE_ADMINISTRATIVE_FID_PNOM_SAISIE_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE ENABLE CONSTRAINT TA_VOIE_ADMINISTRATIVE_FID_PNOM_MODIFICATION_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE ENABLE CONSTRAINT TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_FID_VOIE_PHYSIQUE_FK';    
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE ENABLE CONSTRAINT TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_FID_VOIE_ADMINISTRATIVE_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_TRONCON ENABLE CONSTRAINT TA_TRONCON_FID_PNOM_SAISIE_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_TRONCON ENABLE CONSTRAINT TA_TRONCON_FID_PNOM_MODIFICATION_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE ENABLE CONSTRAINT TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_FID_VOIE_ADMINISTRATIVE_FK';
    EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE ENABLE CONSTRAINT TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_FID_VOIE_PHYSIQUE_FK';    
    EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_SEUIL ENABLE CONSTRAINT TA_SEUIL_FID_PNOM_SAISIE_FK';
    EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_SEUIL ENABLE CONSTRAINT TA_SEUIL_FID_PNOM_MODIFICATION_FK';
    EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_SEUIL ENABLE CONSTRAINT TA_SEUIL_FID_TRONCON_FK';
    EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_INFOS_SEUIL ENABLE CONSTRAINT TA_INFOS_SEUIL_FID_SEUIL_FK';
    EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_INFOS_SEUIL ENABLE CONSTRAINT TA_INFOS_SEUIL_FID_PNOM_SAISIE_FK';
    EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_INFOS_SEUIL ENABLE CONSTRAINT TA_INFOS_SEUIL_FID_PNOM_MODIFICATION_FK';

	-- Re-création des index
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_ADMINISTRATIVE_LIBELLE_VOIE_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE(libelle_voie) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_ADMINISTRATIVE_COMPLEMENT_NOM_VOIE_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE(complement_nom_voie) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_ADMINISTRATIVE_CODE_INSEE_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE(code_insee) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_ADMINISTRATIVE_FID_PNOM_SAISIE_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE(fid_pnom_saisie) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_ADMINISTRATIVE_FID_PNOM_MODIFICATION_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE(fid_pnom_modification) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_ADMINISTRATIVE_FID_TYPE_VOIE_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE(fid_type_voie) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_FID_VOIE_PHYSIQUE_IDX ON G_BASE_VOIE.TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE(fid_voie_physique) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_FID_VOIE_ADMINISTRATIVE_IDX ON G_BASE_VOIE.TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE(fid_voie_administrative) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_TRONCON_SIDX ON G_BASE_VOIE.TA_TRONCON(GEOM) INDEXTYPE IS MDSYS.SPATIAL_INDEX PARAMETERS(''sdo_indx_dims=2, layer_gtype=LINE, tablespace=G_ADT_INDX, work_tablespace=DATA_TEMP'')';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_SEUIL_FID_PNOM_SAISIE_IDX ON G_BASE_VOIE.TA_SEUIL(fid_pnom_saisie) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_SEUIL_FID_PNOM_MODIFICATION_IDX ON G_BASE_VOIE.TA_SEUIL(fid_pnom_modification) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_SEUIL_FID_TRONCON_IDX ON G_BASE_VOIE.TA_SEUIL(fid_troncon) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_SEUIL_CODE_INSEE_IDX ON G_BASE_VOIE.TA_SEUIL(code_insee) TABLESPACE G_ADT_INDX';
    EXECUTE IMMEDIATE 'CREATE INDEX TA_SEUIL_SIDX ON G_BASE_VOIE.TA_SEUIL(GEOM) INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2 PARAMETERS(''sdo_indx_dims=2, layer_gtype=POINT, tablespace=G_ADT_INDX, work_tablespace=DATA_TEMP'')';
    EXECUTE IMMEDIATE 'CREATE INDEX TA_INFOS_SEUIL_FID_SEUIL_IDX ON G_BASE_VOIE.TA_INFOS_SEUIL(fid_seuil) TABLESPACE G_ADT_INDX';
    EXECUTE IMMEDIATE 'CREATE INDEX TA_INFOS_SEUIL_FID_PNOM_SAISIE_IDX ON G_BASE_VOIE.TA_INFOS_SEUIL(fid_pnom_saisie) TABLESPACE G_ADT_INDX';
    EXECUTE IMMEDIATE 'CREATE INDEX TA_INFOS_SEUIL_FID_PNOM_MODIFICATION_IDX ON G_BASE_VOIE.TA_INFOS_SEUIL(fid_pnom_modification) TABLESPACE G_ADT_INDX';
    EXECUTE IMMEDIATE 'CREATE INDEX TA_INFOS_SEUIL_NUMERO_SEUIL_IDX ON G_BASE_VOIE.TA_INFOS_SEUIL(numero_seuil) TABLESPACE G_ADT_INDX';

	-- Réactivation des triggers
	EXECUTE IMMEDIATE 'ALTER TRIGGER B_IUX_TA_TRONCON_DATE_PNOM ENABLE';

END;