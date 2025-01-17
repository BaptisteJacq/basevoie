/*
La table TEMP_H_SEUIL - du projet H de correction des relations tronçons/seuils - regroupe tous les seuils de la base voie.
*/

-- 1. Création de la table TEMP_H_SEUIL
CREATE TABLE G_BASE_VOIE.TEMP_H_SEUIL(
    objectid NUMBER(38,0) GENERATED BY DEFAULT AS IDENTITY,
    geom SDO_GEOMETRY,
    cote_troncon CHAR(1),
    code_insee AS (TRIM(GET_CODE_INSEE_97_COMMUNES_CONTAIN_POINT('TEMP_H_SEUIL', geom))),
    date_saisie DATE DEFAULT sysdate NOT NULL,
    date_modification DATE DEFAULT sysdate NOT NULL,
    fid_pnom_saisie NUMBER(38,0) NOT NULL,
    fid_pnom_modification NUMBER(38,0) NOT NULL,
    fid_troncon NUMBER(38,0),
    temp_idseui NUMBER(38,0)
);

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TEMP_H_SEUIL IS 'Table - du projet H de correction des relations tronçons/seuils - contenant les seuils de la Base Voie. Plusieurs seuils peuvent se situer sur le même point géographique. Ancienne table : ILTASEU';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_H_SEUIL.objectid IS 'Clé primaire auto-incrémentée de la table identifiant chaque seuil. Cette pk remplace l''ancien identifiant idseui.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_H_SEUIL.geom IS 'Géométrie de type point de chaque seuil présent dans la table.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_H_SEUIL.cote_troncon IS 'Côté du tronçon auquel est rattaché le seuil. G = gauche ; D = droite. En agglomération le sens des tronçons est déterminé par ses numéros de seuils. En d''autres termes il commence au niveau du seuil dont le numéro est égal à 1. Hors agglomération, le sens du tronçon dépend du sens de circulation pour les rues à sens unique. Pour les rues à double-sens chaque tronçon est doublé donc leur sens dépend aussi du sens de circulation;';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_H_SEUIL.code_insee IS 'Code INSEE de chaque seuil calculé à partir du référentiel des communes G_REFERENTIEL.MEL_COMMUNE_LLH.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_H_SEUIL.date_saisie IS 'date de saisie du seuil (par défaut la date du jour).';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_H_SEUIL.date_modification IS 'Dernière date de modification du seuil(par défaut la date du jour).';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_H_SEUIL.fid_pnom_saisie IS 'Clé étrangère vers la table TEMP_H_AGENT permettant de récupérer le pnom de l''agent ayant créé un seuil.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_H_SEUIL.fid_pnom_modification IS 'Clé étrangère vers la table TEMP_H_AGENT permettant de récupérer le pnom de l''agent ayant modifié un seuil.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_H_SEUIL.fid_troncon IS 'Clé étrangère vers la table TEMP_H_TRONCON permettant d''associer un troncon à un ou plusieurs seuils.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_H_SEUIL.temp_idseui IS 'Champ temporaire servant à l''import des données. Ce champ sera supprimé une fois l''import terminé.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TEMP_H_SEUIL 
ADD CONSTRAINT TEMP_H_SEUIL_PK 
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
    'TEMP_H_SEUIL',
    'geom',
    SDO_DIM_ARRAY(SDO_DIM_ELEMENT('X', 684540, 719822.2, 0.005),SDO_DIM_ELEMENT('Y', 7044212, 7078072, 0.005)), 
    2154
);

-- 5. Création de l'index spatial sur le champ geom
CREATE INDEX TEMP_H_SEUIL_SIDX
ON G_BASE_VOIE.TEMP_H_SEUIL(GEOM)
INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2
PARAMETERS('sdo_indx_dims=2, layer_gtype=POINT, tablespace=G_ADT_INDX, work_tablespace=DATEMP_H_TEMP');

-- 6. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TEMP_H_SEUIL
ADD CONSTRAINT TEMP_H_SEUIL_FID_PNOM_SAISIE_FK
FOREIGN KEY (fid_pnom_saisie)
REFERENCES G_BASE_VOIE.TEMP_H_AGENT(numero_agent);

ALTER TABLE G_BASE_VOIE.TEMP_H_SEUIL
ADD CONSTRAINT TEMP_H_SEUIL_FID_PNOM_MODIFICATION_FK
FOREIGN KEY (fid_pnom_modification)
REFERENCES G_BASE_VOIE.TEMP_H_AGENT(numero_agent);

ALTER TABLE G_BASE_VOIE.TEMP_H_SEUIL
ADD CONSTRAINT TEMP_H_SEUIL_FID_TRONCON_FK
FOREIGN KEY (fid_troncon)
REFERENCES G_BASE_VOIE.TEMP_H_TRONCON(objectid);

-- 7. Création des index sur les clés étrangères et autres
CREATE INDEX TEMP_H_SEUIL_FID_PNOM_SAISIE_IDX ON G_BASE_VOIE.TEMP_H_SEUIL(fid_pnom_saisie)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TEMP_H_SEUIL_FID_PNOM_MODIFICATION_IDX ON G_BASE_VOIE.TEMP_H_SEUIL(fid_pnom_modification)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TEMP_H_SEUIL_FID_TRONCON_IDX ON G_BASE_VOIE.TEMP_H_SEUIL(fid_troncon)
    TABLESPACE G_ADT_INDX;
    
-- Cet index dispose d'une fonction permettant d'accélérer la récupération du code INSEE de la commune d'appartenance du seuil. 
-- Il créé également un champ virtuel dans lequel on peut aller chercher ce code INSEE.
CREATE INDEX TEMP_H_SEUIL_CODE_INSEE_IDX
ON G_BASE_VOIE.TEMP_H_SEUIL(GET_CODE_INSEE_CONTAIN_POINT('TEMP_H_SEUIL', geom))
TABLESPACE G_ADT_INDX;

-- 8. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TEMP_H_SEUIL TO G_ADMIN_SIG;

/

