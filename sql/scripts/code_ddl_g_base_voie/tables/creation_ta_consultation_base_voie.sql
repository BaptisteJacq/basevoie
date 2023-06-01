/*
La table TA_CONSULTATION_BASE_VOIE regroupe tous les tronçons de la base voie avec leurs voie physiques et administratives.
*/
/*
DROP TABLE TA_CONSULTATION_BASE_VOIE CASCADE CONSTRAINTS;
DELETE FROM USER_SDO_GEOM_METADATA WHERE table_name = 'TA_CONSULTATION_BASE_VOIE';
COMMIT;
*/
-- 1. Création de la table TA_CONSULTATION_BASE_VOIE
CREATE TABLE G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE(
    objectid NUMBER(38,0),
    id_troncon NUMBER(38,0),
    id_voie_physique NUMBER(38,0),
    action_sens VARCHAR2(100 BYTE),
    id_voie_administrative NUMBER(38,0),
    code_insee VARCHAR2(5 BYTE),
    nom_commune VARCHAR2(200 BYTE), 
    type_voie VARCHAR2(100 BYTE),
    libelle_voie VARCHAR2(1000 BYTE),
    complement_nom_voie VARCHAR2(200 BYTE),
    nom_voie VARCHAR2(4000 BYTE),
    hierarchie VARCHAR2(100 BYTE),
    lateralite VARCHAR2(100 BYTE),
    commentaire VARCHAR2(4000 BYTE),
    geom SDO_GEOMETRY NULL
);

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE IS 'Table contenant les tronçons, voies physiques et voies administratives de la base voie. Cette table est mise à jour toutes les minutes par un job.';
COMMENT ON COLUMN G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE.objectid IS 'Clé primaire de la vue.';
COMMENT ON COLUMN G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE.id_troncon IS 'Identifiant du tronçon.';
COMMENT ON COLUMN G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE.id_voie_physique IS 'Identifiant de la voie physique.';
COMMENT ON COLUMN G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE.action_sens IS 'Action sur le sens de la voie physique.';
COMMENT ON COLUMN G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE.id_voie_administrative IS 'Identifiant de la voie administrative.';
COMMENT ON COLUMN G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE.code_insee IS 'Code INSEE de la voie administrative.';
COMMENT ON COLUMN G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE.nom_commune IS 'Nom de la commune d''appartenance de la voie administrative.';
COMMENT ON COLUMN G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE.type_voie IS 'Type de la voie administrative.';
COMMENT ON COLUMN G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE.libelle_voie IS 'Libelle de la voie administrative.';
COMMENT ON COLUMN G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE.complement_nom_voie IS 'Complément de nom de la voie administrative.';
COMMENT ON COLUMN G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE.nom_voie IS 'Nom de la voie administrative.';
COMMENT ON COLUMN G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE.hierarchie IS 'Hiérarchie de la voie administrative : principale ou secondaire.';
COMMENT ON COLUMN G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE.lateralite IS 'Latéralité de la voie administrative par rapport à sa voie physique.';
COMMENT ON COLUMN G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE.commentaire IS 'Commentaire de la voie administrative.';
COMMENT ON COLUMN G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE.geom IS 'Géométrie du tronçon de type ligne simple.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE 
ADD CONSTRAINT TA_CONSULTATION_BASE_VOIE_PK 
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
    'TA_CONSULTATION_BASE_VOIE',
    'GEOM',
    SDO_DIM_ARRAY(SDO_DIM_ELEMENT('X', 684540, 719822.2, 0.005),SDO_DIM_ELEMENT('Y', 7044212, 7078072, 0.005)), 
    2154
);

-- 5. Création de l'index spatial sur le champ geom
CREATE INDEX TA_CONSULTATION_BASE_VOIE_SIDX
ON G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE(GEOM)
INDEXTYPE IS MDSYS.SPATIAL_INDEX
PARAMETERS('sdo_indx_dims=2, layer_gtype=LINE, tablespace=G_ADT_INDX, work_tablespace=DATA_TEMP');

-- 6. Création des index sur les clés étrangères et autres
CREATE INDEX TA_CONSULTATION_BASE_VOIE_ID_TRONCON_IDX ON G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE(id_troncon)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_CONSULTATION_BASE_VOIE_ID_VOIE_PHYSIQUE_IDX ON G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE(id_voie_physique)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_CONSULTATION_BASE_VOIE_ACTION_SENS_IDX ON G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE(action_sens)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_CONSULTATION_BASE_VOIE_ID_VOIE_ADMINISTRATIVE_IDX ON G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE(id_voie_administrative)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_CONSULTATION_BASE_VOIE_CODE_INSEE_IDX ON G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE(code_insee)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_CONSULTATION_BASE_VOIE_NOM_COMMUNE_IDX ON G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE(nom_commune)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_CONSULTATION_BASE_VOIE_TYPE_VOIE_IDX ON G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE(type_voie)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_CONSULTATION_BASE_VOIE_LIBELLE_VOIE_IDX ON G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE(libelle_voie)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_CONSULTATION_BASE_VOIE_COMPLEMENT_NOM_VOIE_IDX ON G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE(complement_nom_voie)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_CONSULTATION_BASE_VOIE_NOM_VOIE_IDX ON G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE(nom_voie)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_CONSULTATION_BASE_VOIE_HIERARCHIE_IDX ON G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE(hierarchie)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_CONSULTATION_BASE_VOIE_LATERALITE_IDX ON G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE(lateralite)
    TABLESPACE G_ADT_INDX;

-- 7. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_CONSULTATION_BASE_VOIE TO G_ADMIN_SIG;

/

