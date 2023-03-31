/*
La table TEMP_J_SEUIL - du projet j de test de production - regroupe tous les seuils de la base voie.
*/
/*
DROP TABLE G_BASE_VOIE.TEMP_J_SEUIL CASCADE CONSTRAINTS;
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'TEMP_J_SEUIL';
*/
-- 1. Création de la table TEMP_J_SEUIL
CREATE TABLE G_BASE_VOIE.TEMP_J_SEUIL(
    objectid NUMBER(38,0) GENERATED BY DEFAULT AS IDENTITY,
    geom SDO_GEOMETRY,
    cote_troncon CHAR(1),
    code_insee VARCHAR2(5 BYTE),
    old_objectid NUMBER(38,0),
    date_saisie DATE DEFAULT sysdate NOT NULL,
    date_modification DATE DEFAULT sysdate NOT NULL,
    fid_pnom_saisie NUMBER(38,0) NOT NULL,
    fid_pnom_modification NUMBER(38,0) NOT NULL,
    fid_troncon NUMBER(38,0)
);

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TEMP_J_SEUIL IS 'Table - du projet j de test de production - contenant les seuils de la Base Voie. Plusieurs seuils peuvent se situer sur le même point géographique. Ancienne table : ILTASEU';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_J_SEUIL.objectid IS 'Clé primaire auto-incrémentée de la table identifiant chaque seuil. Cette pk remplace l''ancien identifiant idseui.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_J_SEUIL.geom IS 'Géométrie de type point de chaque seuil présent dans la table.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_J_SEUIL.cote_troncon IS 'Côté du tronçon auquel est rattaché le seuil. G = gauche ; D = droite. En agglomération le sens des tronçons est déterminé par ses numéros de seuils. En d''autres termes il commence au niveau du seuil dont le numéro est égal à 1. Hors agglomération, le sens du tronçon dépend du sens de circulation pour les rues à sens unique. Pour les rues à double-sens chaque tronçon est doublé donc leur sens dépend aussi du sens de circulation;';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_J_SEUIL.code_insee IS 'Code INSEE de chaque seuil inséré en dur à la saisie.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_J_SEUIL.old_objectid IS 'Champ temporaire servant à l''import des données. Ce champ sera supprimé une fois l''import terminé.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_J_SEUIL.date_saisie IS 'date de saisie du seuil (par défaut la date du jour).';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_J_SEUIL.date_modification IS 'Dernière date de modification du seuil(par défaut la date du jour).';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_J_SEUIL.fid_pnom_saisie IS 'Clé étrangère vers la table TEMP_J_AGENT permettant de récupérer le pnom de l''agent ayant créé un seuil.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_J_SEUIL.fid_pnom_modification IS 'Clé étrangère vers la table TEMP_J_AGENT permettant de récupérer le pnom de l''agent ayant modifié un seuil.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_J_SEUIL.fid_troncon IS 'Clé étrangère vers la table TEMP_J_TRONCON permettant d''associer un troncon à un ou plusieurs seuils.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TEMP_J_SEUIL 
ADD CONSTRAINT TEMP_J_SEUIL_PK 
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
    'TEMP_J_SEUIL',
    'geom',
    SDO_DIM_ARRAY(SDO_DIM_ELEMENT('X', 684540, 719822.2, 0.005),SDO_DIM_ELEMENT('Y', 7044212, 7078072, 0.005)), 
    2154
);

-- 5. Création de l'index spatial sur le champ geom
CREATE INDEX TEMP_J_SEUIL_SIDX
ON G_BASE_VOIE.TEMP_J_SEUIL(GEOM)
INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2
PARAMETERS('sdo_indx_dims=2, layer_gtype=POINT, tablespace=G_ADT_INDX, work_tablespace=DATEMP_J_TEMP');

-- 6. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TEMP_J_SEUIL
ADD CONSTRAINT TEMP_J_SEUIL_FID_PNOM_SAISIE_FK
FOREIGN KEY (fid_pnom_saisie)
REFERENCES G_BASE_VOIE.TEMP_J_AGENT(numero_agent);

ALTER TABLE G_BASE_VOIE.TEMP_J_SEUIL
ADD CONSTRAINT TEMP_J_SEUIL_FID_PNOM_MODIFICATION_FK
FOREIGN KEY (fid_pnom_modification)
REFERENCES G_BASE_VOIE.TEMP_J_AGENT(numero_agent);

ALTER TABLE G_BASE_VOIE.TEMP_J_SEUIL
ADD CONSTRAINT TEMP_J_SEUIL_FID_TRONCON_FK
FOREIGN KEY (fid_troncon)
REFERENCES G_BASE_VOIE.TEMP_J_TRONCON(objectid);

-- 7. Création des index sur les clés étrangères et autres
CREATE INDEX TEMP_J_SEUIL_FID_PNOM_SAISIE_IDX ON G_BASE_VOIE.TEMP_J_SEUIL(fid_pnom_saisie)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TEMP_J_SEUIL_FID_PNOM_MODIFICATION_IDX ON G_BASE_VOIE.TEMP_J_SEUIL(fid_pnom_modification)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TEMP_J_SEUIL_FID_TRONCON_IDX ON G_BASE_VOIE.TEMP_J_SEUIL(fid_troncon)
    TABLESPACE G_ADT_INDX;
    
CREATE INDEX TEMP_J_SEUIL_CODE_INSEE_IDX ON G_BASE_VOIE.TEMP_J_SEUIL(code_insee)
    TABLESPACE G_ADT_INDX;

-- 8. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TEMP_J_SEUIL TO G_ADMIN_SIG;

/
