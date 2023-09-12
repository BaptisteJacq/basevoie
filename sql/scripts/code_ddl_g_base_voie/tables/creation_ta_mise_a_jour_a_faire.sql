/*
Création de la table TA_MISE_A_JOUR_A_FAIRE dans laquelle les agents participant à la correction de la Base Voie peuvent renseigner les mises à jour qu''il faudra faire une fois la base passée en production.
*/
-- Supression de la table
/*
DROP TABLE G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE CASCADE CONSTRAINTS;
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'TA_MISE_A_JOUR_A_FAIRE';
*/
-- 1. Création de la table TA_INFOS_SEUIL
CREATE TABLE G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE(
    OBJECTID NUMBER(38,0) DEFAULT SEQ_TA_MISE_A_JOUR_A_FAIRE_OBJECTID.NEXTVAL, 
	ID_SEUIL NUMBER(38,0), 
	ID_TRONCON NUMBER(38,0), 
	ID_VOIE_ADMINISTRATIVE NUMBER(38,0),
    CODE_INSEE VARCHAR2(5), 
	EXPLICATION VARCHAR2(4000),  
	DATE_SAISIE DATE, 
    DATE_MODIFICATION DATE, 
    FID_PNOM_SAISIE NUMBER(38,0),
	FID_PNOM_MODIFICATION NUMBER(38,0), 
	FID_ETAT_AVANCEMENT NUMBER(38,0) DEFAULT 110 NOT NULL ENABLE,
    GEOM SDO_GEOMETRY
);

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE IS 'Table dans laquelle les agents participant à la correction de la Base Voie peuvent renseigner les mises à jour qu''il faudra faire une fois la base passée en production.';
COMMENT ON COLUMN G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE.objectid IS 'Clé primaire auto-incrémentée de la table.';
COMMENT ON COLUMN G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE.id_seuil IS 'Identifiant du seuil si l''entité concerne un seuil.';
COMMENT ON COLUMN G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE.id_troncon IS 'Identifiant du tronçon si l''entité concerne un tronçon.';
COMMENT ON COLUMN G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE.id_voie_administrative IS 'Identifiant de la voie administrative si l''entité concerne une voie administrative.';
COMMENT ON COLUMN G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE.code_insee IS 'Code insee de la mise à jour à faire.';
COMMENT ON COLUMN G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE.explication IS 'Explication de la mise à jour qu''il faudra effectuer.';
COMMENT ON COLUMN G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE.date_saisie IS 'Date de saisie de la mise à jour à faire.';
COMMENT ON COLUMN G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE.date_modification IS 'Dernière date de modification de la mise à jour à faire.';
COMMENT ON COLUMN G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE.fid_pnom_saisie IS 'Clé étrangère vers la table TA_AGENT permettant de savoir qui a créé chaque point de mise à jour.';
COMMENT ON COLUMN G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE.fid_pnom_modification IS 'Clé étrangère vers la table TA_AGENT permettant de savoir qui a modifié le point en dernier.';
COMMENT ON COLUMN G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE.fid_etat_avancement IS 'Champ permettant de connaître l''état d''avancement de la mise à jour.';
COMMENT ON COLUMN G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE.geom IS 'Géométrie de type point.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE 
ADD CONSTRAINT TA_MISE_A_JOUR_A_FAIRE_PK 
PRIMARY KEY ("OBJECTID")
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des métadonnées spatiales
INSERT INTO USER_SDO_GEOM_METADATA(
    TABLE_NAME, 
    COLUMN_NAME, 
    DIMINFO, 
    SRID
)
VALUES(
    'TA_MISE_A_JOUR_A_FAIRE',
    'GEOM',
    SDO_DIM_ARRAY(SDO_DIM_ELEMENT('X', 684540, 719822.2, 0.005),SDO_DIM_ELEMENT('Y', 7044212, 7078072, 0.005)), 
    2154
);
COMMIT;

-- 5. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE
ADD CONSTRAINT TA_MISE_A_JOUR_A_FAIRE_FID_PNOM_SAISIE_FK 
FOREIGN KEY (fid_pnom_saisie)
REFERENCES G_BASE_VOIE.TA_AGENT(numero_agent);

ALTER TABLE G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE
ADD CONSTRAINT TA_MISE_A_JOUR_A_FAIRE_FID_PNOM_MODIFICATION_FK
FOREIGN KEY (fid_pnom_modification)
REFERENCES G_BASE_VOIE.TA_AGENT(numero_agent);

ALTER TABLE G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE
ADD CONSTRAINT TA_MISE_A_JOUR_A_FAIRE_FID_LATERALITE_FK
FOREIGN KEY (fid_etat_avancement)
REFERENCES G_BASE_VOIE.TA_LIBELLE(objectid);

-- 6. Création des index
CREATE INDEX G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE_SIDX ON G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE (geom) 
   INDEXTYPE IS "MDSYS"."SPATIAL_INDEX_V2"  PARAMETERS ('sdo_indx_dims=2, layer_gtype=POINT, tablespace=G_ADT_INDX, work_tablespace=DATEMP_I_TEMP');

CREATE INDEX G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE_ID_SEUIL_IDX ON G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE (id_seuil) 
    TABLESPACE G_ADT_INDX;

CREATE INDEX G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE_ID_TRONCON_IDX ON G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE (id_troncon) 
    TABLESPACE G_ADT_INDX;

CREATE INDEX G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE_ID_VOIE_ADMINISTRATIVE_IDX ON G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE (id_voie_administrative) 
    TABLESPACE G_ADT_INDX;

CREATE INDEX G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE_CODE_INSEE_IDX ON G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE (code_insee) 
    TABLESPACE G_ADT_INDX;

CREATE INDEX G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE_DATE_SAISIE_IDX ON G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE (date_saisie) 
    TABLESPACE G_ADT_INDX;

CREATE INDEX G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE_DATE_MODIFICATION_IDX ON G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE (date_modification) 
    TABLESPACE G_ADT_INDX;

CREATE INDEX G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE_fid_pnom_modification_IDX ON G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE (fid_pnom_modification) 
    TABLESPACE G_ADT_INDX;

CREATE INDEX G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE_FID_PNOM_SAISIE_IDX ON G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE (fid_pnom_saisie) 
    TABLESPACE G_ADT_INDX;

CREATE INDEX G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE_FID_ETAT_AVANCEMENT_IDX ON G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE (fid_etat_avancement) 
    TABLESPACE G_ADT_INDX;

-- 7. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_MISE_A_JOUR_A_FAIRE TO G_ADMIN_SIG;

/

