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

	EXECUTE IMMEDIATE 'CREATE SEQUENCE SEQ_TA_VOIE_PHYSIQUE_OBJECTID START WITH '||id_max||' INCREMENT BY 1';

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
        
    	EXECUTE IMMEDIATE 'CREATE SEQUENCE SEQ_TA_TRONCON_OBJECTID START WITH '||id_max||' INCREMENT BY 1';

    SELECT
		MAX(objectid)+1
		INTO id_max
	FROM
		G_BASE_VOIE.TA_VOIE_SUPRA_COMMUNALE;
        
    	EXECUTE IMMEDIATE 'CREATE SEQUENCE SEQ_TA_VOIE_SUPRA_COMMUNALE_OBJECTID START WITH '||id_max||' INCREMENT BY 1';
    
	-- Réactivation des contraintes et des index des tables de correction du projet C
	-- Réactivation des contraintes
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_HIERARCHISATION_VOIE ENABLE CONSTRAINT TA_HIERARCHISATION_VOIE_FID_VOIE_PRINCIPALE_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_HIERARCHISATION_VOIE ENABLE CONSTRAINT TA_HIERARCHISATION_VOIE_FID_VOIE_SECONDAIRE_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_INFOS_SEUIL ENABLE CONSTRAINT TA_INFOS_SEUIL_FID_PNOM_MODIFICATION_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_INFOS_SEUIL ENABLE CONSTRAINT TA_INFOS_SEUIL_FID_PNOM_SAISIE_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_INFOS_SEUIL ENABLE CONSTRAINT TA_INFOS_SEUIL_FID_SEUIL_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_INFOS_SEUIL_LOG ENABLE CONSTRAINT TA_INFOS_SEUIL_LOG_FID_PNOM_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_INFOS_SEUIL_LOG ENABLE CONSTRAINT TA_INFOS_SEUIL_LOG_FID_TYPE_ACTION_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_RELATION_VOIE_ADMINISTRATIVE_SUPRA_COMMUNALE ENABLE CONSTRAINT TA_RELATION_VOIE_ADMINISTRATIVE_SUPRA_COMMUNALE_FID_VOIE_ADMINISTRATIVE_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE ENABLE CONSTRAINT TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_FID_LATERALITE_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE ENABLE CONSTRAINT TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_FID_VOIE_ADMINISTRATIVE_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE ENABLE CONSTRAINT TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_FID_VOIE_PHYSIQUE_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE ENABLE CONSTRAINT TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_FID_LATERALITE_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_HIERARCHISATION_VOIE ENABLE CONSTRAINT TA_HIERARCHISATION_VOIE_FID_VOIE_SECONDAIRE_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_HIERARCHISATION_VOIE ENABLE CONSTRAINT TA_HIERARCHISATION_VOIE_FID_VOIE_PRINCIPALE_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_LOG ENABLE CONSTRAINT TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_LOG_FID_PNOM_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_LOG ENABLE CONSTRAINT TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_LOG_FID_TYPE_ACTION_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_SEUIL ENABLE CONSTRAINT TA_SEUIL_FID_LATERALITE_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_SEUIL ENABLE CONSTRAINT TA_SEUIL_FID_PNOM_MODIFICATION_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_SEUIL ENABLE CONSTRAINT TA_SEUIL_FID_PNOM_SAISIE_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_SEUIL ENABLE CONSTRAINT TA_SEUIL_FID_POSITION_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_SEUIL ENABLE CONSTRAINT TA_SEUIL_FID_TRONCON_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_SEUIL_LOG ENABLE CONSTRAINT TA_SEUIL_LOG_FID_PNOM_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_SEUIL_LOG ENABLE CONSTRAINT TA_SEUIL_LOG_FID_TYPE_ACTION_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_TRONCON ENABLE CONSTRAINT TA_TRONCON_FID_PNOM_MODIFICATION_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_TRONCON ENABLE CONSTRAINT TA_TRONCON_FID_PNOM_SAISIE_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_TRONCON_LOG ENABLE CONSTRAINT TA_TRONCON_LOG_FID_PNOM_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_TRONCON_LOG ENABLE CONSTRAINT TA_TRONCON_LOG_FID_TYPE_ACTION_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE ENABLE CONSTRAINT TA_VOIE_ADMINISTRATIVE_FID_PNOM_MODIFICATION_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE ENABLE CONSTRAINT TA_VOIE_ADMINISTRATIVE_FID_PNOM_SAISIE_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE ENABLE CONSTRAINT TA_VOIE_ADMINISTRATIVE_FID_RIVOLI_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE ENABLE CONSTRAINT TA_VOIE_ADMINISTRATIVE_FID_TYPE_VOIE_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE ENABLE CONSTRAINT TA_VOIE_ADMINISTRATIVE_FID_GENRE_VOIE_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE ENABLE CONSTRAINT TA_VOIE_ADMINISTRATIVE_FID_RIVOLI_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG ENABLE CONSTRAINT TA_VOIE_ADMINISTRATIVE_LOG_FID_PNOM_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG ENABLE CONSTRAINT TA_VOIE_ADMINISTRATIVE_LOG_FID_TYPE_ACTION_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_VOIE_PHYSIQUE_LOG ENABLE CONSTRAINT TA_VOIE_PHYSIQUE_LOG_FID_PNOM_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_VOIE_PHYSIQUE_LOG ENABLE CONSTRAINT TA_VOIE_PHYSIQUE_LOG_FID_TYPE_ACTION_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_VOIE_SUPRA_COMMUNALE ENABLE CONSTRAINT TA_VOIE_SUPRA_COMMUNALE_FID_PNOM_MODIFICATION_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_VOIE_SUPRA_COMMUNALE ENABLE CONSTRAINT TA_VOIE_SUPRA_COMMUNALE_FID_PNOM_SAISIE_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_VOIE_SUPRA_COMMUNALE_LOG ENABLE CONSTRAINT TA_VOIE_SUPRA_COMMUNALE_LOG_FID_PNOM_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_VOIE_SUPRA_COMMUNALE_LOG ENABLE CONSTRAINT TA_VOIE_SUPRA_COMMUNALE_LOG_FID_TYPE_ACTION_FK';
	EXECUTE IMMEDIATE 'ALTER TABLE G_BASE_VOIE.TA_TRONCON ENABLE CONSTRAINT TA_TRONCON_FID_VOIE_PHYSIQUE_FK';

	-- Re-création des index
	EXECUTE IMMEDIATE 'CREATE INDEX TA_TRONCON_FID_PNOM_SAISIE_IDX ON G_BASE_VOIE.TA_TRONCON(fid_pnom_saisie) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_TRONCON_FID_PNOM_MODIFICATION_IDX ON G_BASE_VOIE.TA_TRONCON(fid_pnom_modification) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_TRONCON_FID_VOIE_PHYSIQUE_IDX ON G_BASE_VOIE.TA_TRONCON(fid_voie_physique) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_PHYSIQUE_FID_ACTION_IDX ON G_BASE_VOIE.TA_VOIE_PHYSIQUE(fid_action) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_ADMINISTRATIVE_LIBELLE_VOIE_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE(libelle_voie) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_ADMINISTRATIVE_COMPLEMENT_NOM_VOIE_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE(complement_nom_voie) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_ADMINISTRATIVE_CODE_INSEE_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE(code_insee) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_ADMINISTRATIVE_FID_PNOM_SAISIE_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE(fid_pnom_saisie) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_ADMINISTRATIVE_FID_PNOM_MODIFICATION_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE(fid_pnom_modification) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_ADMINISTRATIVE_FID_TYPE_VOIE_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE(fid_type_voie) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_ADMINISTRATIVE_FID_GENRE_VOIE_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE(fid_genre_voie) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_FID_VOIE_ADMINISTRATIVE_IDX ON G_BASE_VOIE.TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE(fid_voie_administrative) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_FID_VOIE_PHYSIQUE_IDX ON G_BASE_VOIE.TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE(fid_voie_physique) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_FID_LATERALITE_IDX ON G_BASE_VOIE.TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE(fid_lateralite) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_TRONCON_SIDX ON G_BASE_VOIE.TA_TRONCON(GEOM) INDEXTYPE IS MDSYS.SPATIAL_INDEX PARAMETERS(''sdo_indx_dims=2, layer_gtype=LINE, tablespace=G_ADT_INDX, work_tablespace=DATA_TEMP'')';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_TRONCON_OLD_OBJECTID_IDX ON G_BASE_VOIE.TA_TRONCON(old_objectid) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_SEUIL_CODE_INSEE_IDX ON G_BASE_VOIE.TA_SEUIL(code_insee) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_SEUIL_SIDX ON G_BASE_VOIE.TA_SEUIL(geom) INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2 PARAMETERS(''sdo_indx_dims=2, layer_gtype=POINT, tablespace=G_ADT_INDX, work_tablespace=DATA_TEMP'')';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_SEUIL_FID_PNOM_SAISIE_IDX ON G_BASE_VOIE.TA_SEUIL(fid_pnom_saisie) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_SEUIL_FID_PNOM_MODIFICATION_IDX ON G_BASE_VOIE.TA_SEUIL(fid_pnom_modification) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_SEUIL_FID_TRONCON_IDX ON G_BASE_VOIE.TA_SEUIL(fid_troncon) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_SEUIL_FID_POSITION_IDX ON G_BASE_VOIE.TA_SEUIL(fid_position) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_INFOS_SEUIL_FID_SEUIL_IDX ON G_BASE_VOIE.TA_INFOS_SEUIL(fid_seuil) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_INFOS_SEUIL_FID_PNOM_SAISIE_IDX ON G_BASE_VOIE.TA_INFOS_SEUIL(fid_pnom_saisie) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_INFOS_SEUIL_FID_PNOM_MODIFICATION_IDX ON G_BASE_VOIE.TA_INFOS_SEUIL(fid_pnom_modification) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_INFOS_SEUIL_NUMERO_SEUIL_IDX ON G_BASE_VOIE.TA_INFOS_SEUIL(numero_seuil) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_INFOS_SEUIL_LOG_ID_INFOS_SEUIL_IDX ON G_BASE_VOIE.TA_INFOS_SEUIL_LOG(id_infos_seuil) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_TRONCON_LOG_FID_TYPE_ACTION_IDX ON G_BASE_VOIE.TA_TRONCON_LOG(fid_type_action) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_TRONCON_LOG_FID_PNOM_IDX ON G_BASE_VOIE.TA_TRONCON_LOG(fid_pnom) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_TRONCON_LOG_ID_TRONCON_IDX ON G_BASE_VOIE.TA_TRONCON_LOG(id_troncon) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_TRONCON_LOG_ID_VOIE_PHYSIQUE_IDX ON G_BASE_VOIE.TA_TRONCON_LOG(id_voie_physique) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_TRONCON_LOG_OLD_ID_TRONCON_IDX ON G_BASE_VOIE.TA_TRONCON_LOG(old_id_troncon) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_TRONCON_LOG_SIDX ON G_BASE_VOIE.TA_TRONCON_LOG(geom) INDEXTYPE IS MDSYS.SPATIAL_INDEX PARAMETERS(''sdo_indx_dims=2, layer_gtype=LINE, tablespace=G_ADT_INDX, work_tablespace=DATA_TEMP'')';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_ADMINISTRATIVE_LOG_FID_TYPE_ACTION_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG(fid_type_action) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_ADMINISTRATIVE_LOG_FID_PNOM_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG(fid_pnom) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_ADMINISTRATIVE_FID_RIVOLI_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE(fid_rivoli) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_LOG_FID_TYPE_ACTION_IDX ON G_BASE_VOIE.TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_LOG(fid_type_action) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_LOG_FID_PNOM_IDX ON G_BASE_VOIE.TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_LOG(fid_pnom) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_LOG_ID_LATERALITE_IDX ON G_BASE_VOIE.TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_LOG(id_lateralite) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_LOG_ID_VOIE_ADMINISTRATIVE_IDX ON G_BASE_VOIE.TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_LOG(id_voie_administrative) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_LOG_ID_VOIE_PHYSIQUE_IDX ON G_BASE_VOIE.TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_LOG(id_voie_physique) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_ADMINISTRATIVE_LOG_CODE_INSEE_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG(code_insee) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_ADMINISTRATIVE_LOG_COMPLEMENT_NOM_VOIE_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG(complement_nom_voie) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_ADMINISTRATIVE_LOG_ID_RIVOLI_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG(id_rivoli) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_ADMINISTRATIVE_LOG_ID_TYPE_VOIE_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG(id_type_voie) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_ADMINISTRATIVE_LOG_ID_VOIE_ADMINISTRATIVE_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG(id_voie_administrative) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_ADMINISTRATIVE_LOG_LIBELLE_VOIE_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG(libelle_voie) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_ADMINISTRATIVE_LOG_ID_GENRE_VOIE_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG(id_genre_voie) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_PHYSIQUE_LOG_FID_TYPE_ACTION_IDX ON G_BASE_VOIE.TA_VOIE_PHYSIQUE_LOG(fid_type_action) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_PHYSIQUE_LOG_FID_PNOM_IDX ON G_BASE_VOIE.TA_VOIE_PHYSIQUE_LOG(fid_pnom) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_PHYSIQUE_LOG_ID_ACTION_IDX ON G_BASE_VOIE.TA_VOIE_PHYSIQUE_LOG(id_action) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_PHYSIQUE_LOG_ID_VOIE_PHYSIQUE_IDX ON G_BASE_VOIE.TA_VOIE_PHYSIQUE_LOG(id_voie_physique) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_SEUIL_LOG_FID_TYPE_ACTION_IDX ON G_BASE_VOIE.TA_SEUIL_LOG(fid_type_action) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_SEUIL_LOG_FID_PNOM_IDX ON G_BASE_VOIE.TA_SEUIL_LOG(fid_pnom) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_SEUIL_LOG_CODE_INSEE_IDX ON G_BASE_VOIE.TA_SEUIL_LOG(code_insee) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_SEUIL_LOG_ID_SEUIL_IDX ON G_BASE_VOIE.TA_SEUIL_LOG(id_seuil) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_SEUIL_LOG_ID_TRONCON_IDX ON G_BASE_VOIE.TA_SEUIL_LOG(id_troncon) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_SEUIL_LOG_SIDX ON G_BASE_VOIE.TA_SEUIL_LOG(geom) INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2 PARAMETERS(''sdo_indx_dims=2, layer_gtype=POINT, tablespace=G_ADT_INDX, work_tablespace=DATA_TEMP'')';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_INFOS_SEUIL_LOG_FID_TYPE_ACTION_IDX ON G_BASE_VOIE.TA_INFOS_SEUIL_LOG(fid_type_action) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_INFOS_SEUIL_LOG_FID_PNOM_IDX ON G_BASE_VOIE.TA_INFOS_SEUIL_LOG(fid_pnom) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_HIERARCHISATION_VOIE_FID_VOIE_PRINCIPALE_IDX ON G_BASE_VOIE.TA_HIERARCHISATION_VOIE(fid_voie_principale) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_HIERARCHISATION_VOIE_FID_VOIE_SECONDAIRE_IDX ON G_BASE_VOIE.TA_HIERARCHISATION_VOIE(fid_voie_secondaire) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_LIBELLE_LIBELLE_COURT_IDX ON G_BASE_VOIE.TA_LIBELLE(libelle_court) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_RIVOLI_CLE_CONTROLE_IDX ON G_BASE_VOIE.TA_RIVOLI(cle_controle) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_RIVOLI_CODE_RIVOLI_IDX ON G_BASE_VOIE.TA_RIVOLI(code_rivoli) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_TYPE_VOIE_CODE_TYPE_VOIE_IDX ON G_BASE_VOIE.TA_TYPE_VOIE(code_type_voie) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_SUPRA_COMMUNALE_FID_PNOM_SAISIE_IDX ON G_BASE_VOIE.TA_VOIE_SUPRA_COMMUNALE(fid_pnom_saisie) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_SUPRA_COMMUNALE_ID_SIREO_IDX ON G_BASE_VOIE.TA_VOIE_SUPRA_COMMUNALE(id_sireo) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_VOIE_SUPRA_COMMUNALE_FID_PNOM_MODIFICATION_IDX ON G_BASE_VOIE.TA_VOIE_SUPRA_COMMUNALE(fid_pnom_modification) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_RELATION_VOIE_ADMINISTRATIVE_SUPRA_COMMUNALE_FID_VOIE_ADMINISTRATIVE_IDX ON G_BASE_VOIE.TA_RELATION_VOIE_ADMINISTRATIVE_SUPRA_COMMUNALE(fid_voie_administrative) TABLESPACE G_ADT_INDX';
	EXECUTE IMMEDIATE 'CREATE INDEX TA_RELATION_VOIE_ADMINISTRATIVE_SUPRA_COMMUNALE_FID_VOIE_SUPRA_COMMUNALE_IDX ON G_BASE_VOIE.TA_RELATION_VOIE_ADMINISTRATIVE_SUPRA_COMMUNALE(fid_voie_supra_communale) TABLESPACE G_ADT_INDX';

	-- Réactivation des triggers
	EXECUTE IMMEDIATE 'ALTER TRIGGER A_IXX_TA_SEUIL ENABLE';
	EXECUTE IMMEDIATE 'ALTER TRIGGER A_IXX_TA_VOIE_ADMINISTRATIVE ENABLE';
	EXECUTE IMMEDIATE 'ALTER TRIGGER B_IUD_TA_INFOS_SEUIL_LOG ENABLE';
	EXECUTE IMMEDIATE 'ALTER TRIGGER B_IUD_TA_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_LOG ENABLE';
	EXECUTE IMMEDIATE 'ALTER TRIGGER B_IUD_TA_SEUIL_LOG ENABLE';
	EXECUTE IMMEDIATE 'ALTER TRIGGER B_IUD_TA_TRONCON_LOG ENABLE';
	EXECUTE IMMEDIATE 'ALTER TRIGGER B_IUD_TA_VOIE_ADMINISTRATIVE_LOG ENABLE';
	EXECUTE IMMEDIATE 'ALTER TRIGGER B_IUD_TA_VOIE_PHYSIQUE_LOG ENABLE';
	EXECUTE IMMEDIATE 'ALTER TRIGGER B_IUD_TA_VOIE_SUPRA_COMMUNALE_LOG ENABLE';
	
END;