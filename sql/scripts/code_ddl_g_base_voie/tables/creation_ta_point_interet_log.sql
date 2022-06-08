/*
La table TA_POINT_INTERET_LOG  permet d''avoir l''historique de toutes les évolutions des seuils de la base voie.
*/

-- 1. Création de la table TA_POINT_INTERET_LOG
CREATE TABLE G_BASE_VOIE.TA_POINT_INTERET_LOG(
    objectid NUMBER(38,0) GENERATED BY DEFAULT AS IDENTITY,
    geom SDO_GEOMETRY NOT NULL,
    code_insee VARCHAR2(4000) NOT NULL,
    date_action DATE NOT NULL,
    fid_point_interet NUMBER(38,0) NOT NULL,
    fid_type_action NUMBER(38,0),
    fid_pnom NUMBER(38,0) NOT NULL
);

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_POINT_INTERET_LOG IS 'Table de log de la table TA_POINT_INTERET permettant d''avoir l''historique de toutes les évolutions des POI.';
COMMENT ON COLUMN G_BASE_VOIE.TA_POINT_INTERET_LOG.objectid IS 'Clé primaire auto-incrémentée de la table.';
COMMENT ON COLUMN G_BASE_VOIE.TA_POINT_INTERET_LOG.geom IS 'Géométrie de type point de chaque objet de la table.';
COMMENT ON COLUMN G_BASE_VOIE.TA_POINT_INTERET_LOG.fid_point_interet IS 'Identifiant de la table TA_POINT_INTERET permettant de savoir sur quel POI les actions ont été entreprises.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SEUIL_LOG.code_insee IS 'Champ permettant d''associer à chaque POI le code insee de la commune dans laquelle il se trouve (issue de la table G_REFERENTIEL.MEL_COMMUNES).';
COMMENT ON COLUMN G_BASE_VOIE.TA_POINT_INTERET_LOG.date_action IS 'Date de création, modification ou suppression d''un POI.';
COMMENT ON COLUMN G_BASE_VOIE.TA_POINT_INTERET_LOG.fid_type_action IS 'Clé étrangère vers la table TA_LIBELLE permettant de savoir quelle action a été effectuée sur le POI.';
COMMENT ON COLUMN G_BASE_VOIE.TA_POINT_INTERET_LOG.fid_pnom IS 'Clé étrangère vers la table TA_AGENT permettant d''associer le pnom d''un agent au POI qu''il a créé, modifié ou supprimé.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_POINT_INTERET_LOG 
ADD CONSTRAINT TA_POINT_INTERET_LOG_PK 
PRIMARY KEY("OBJECTID") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des métadonnées spatiales
INSERT INTO USER_SDO_GEOM_METADATA(
    TABLE_NAME, 
    COLUMN_NAME, 
    DIMINFO, 
    SRID
)
VALUES(
    'TA_POINT_INTERET_LOG',
    'geom',
    SDO_DIM_ARRAY(SDO_DIM_ELEMENT('X', 684540, 719822.2, 0.005),SDO_DIM_ELEMENT('Y', 7044212, 7078072, 0.005)), 
    2154
);

-- 5. Création de l'index spatial sur le champ geom
CREATE INDEX TA_POINT_INTERET_LOG_SIDX
ON G_BASE_VOIE.TA_POINT_INTERET_LOG(GEOM)
INDEXTYPE IS MDSYS.SPATIAL_INDEX
PARAMETERS('sdo_indx_dims=2, layer_gtype=POINT, tablespace=G_ADT_INDX, work_tablespace=DATA_TEMP');

-- 6. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TA_POINT_INTERET_LOG
ADD CONSTRAINT TA_POINT_INTERET_LOG_FID_TYPE_ACTION_FK 
FOREIGN KEY (fid_type_action)
REFERENCES G_GEO.TA_LIBELLE(objectid);

ALTER TABLE G_BASE_VOIE.TA_POINT_INTERET_LOG
ADD CONSTRAINT TA_POINT_INTERET_LOG_FID_PNOM_FK
FOREIGN KEY (fid_pnom)
REFERENCES G_BASE_VOIE.ta_agent(numero_agent);

-- 7. Création des index sur les clés étrangères et autres champs
CREATE INDEX TA_POINT_INTERET_LOG_fid_point_interet_IDX ON G_BASE_VOIE.TA_POINT_INTERET_LOG(fid_point_interet)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_POINT_INTERET_LOG_FID_TYPE_ACTION_IDX ON G_BASE_VOIE.TA_POINT_INTERET_LOG(fid_type_action)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_POINT_INTERET_LOG_FID_PNOM_IDX ON G_BASE_VOIE.TA_POINT_INTERET_LOG(fid_pnom)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_POINT_INTERET_LOG_CODE_INSEE_IDX ON G_BASE_VOIE.TA_POINT_INTERET_LOG(code_insee)
    TABLESPACE G_ADT_INDX;

-- 8. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_POINT_INTERET_LOG TO G_ADMIN_SIG;

/

