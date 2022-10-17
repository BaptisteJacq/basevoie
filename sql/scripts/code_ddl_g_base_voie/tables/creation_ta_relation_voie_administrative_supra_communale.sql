/*
La table TA_RELATION_VOIE_ADMINISTRATIVE_SUPRA_COMMUNALE permet d''associer une ou plusieurs voies administratives à une ou plusieurs voies supra-communale.
*/

-- 1. Création de la table TA_RELATION_VOIE_ADMINISTRATIVE_SUPRA_COMMUNALE
CREATE TABLE G_BASE_VOIE.TA_RELATION_VOIE_ADMINISTRATIVE_SUPRA_COMMUNALE(
    objectid NUMBER(38,0) GENERATED BY DEFAULT AS IDENTITY,
    fid_voie_supra_communale NUMBER(38,0),
    fid_voie_administrative NUMBER(38,0)
);

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_RELATION_VOIE_ADMINISTRATIVE_SUPRA_COMMUNALE IS 'Table pivot permettant d''associer une ou plusieurs voies administratives à une ou plusieurs voies supra-communale.';
COMMENT ON COLUMN G_BASE_VOIE.TA_RELATION_VOIE_ADMINISTRATIVE_SUPRA_COMMUNALE.objectid IS 'Clé primaire auto-incrémentée de la table.';
COMMENT ON COLUMN G_BASE_VOIE.TA_RELATION_VOIE_ADMINISTRATIVE_SUPRA_COMMUNALE.fid_voie_supra_communale IS 'Clé étrangère vers la table TA_VOIE_SUPRA_COMMUNALE permettant d''associer une ou plusieurs voies supra-communales à une ou plusieurs administratives.';
COMMENT ON COLUMN G_BASE_VOIE.TA_RELATION_VOIE_ADMINISTRATIVE_SUPRA_COMMUNALE.fid_voie_administrative IS 'Clé étrangère vers la table TA_VOIE_ADMINISTRATIVE permettant d''associer une ou plusieurs voies administratives à une ou plusieurs voies supra-communales.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_RELATION_VOIE_ADMINISTRATIVE_SUPRA_COMMUNALE 
ADD CONSTRAINT TA_RELATION_VOIE_ADMINISTRATIVE_SUPRA_COMMUNALE_PK 
PRIMARY KEY("OBJECTID") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TA_RELATION_VOIE_ADMINISTRATIVE_SUPRA_COMMUNALE
ADD CONSTRAINT TA_RELATION_VOIE_ADMINISTRATIVE_SUPRA_COMMUNALE_FID_VOIE_supra_communale_FK
FOREIGN KEY (fid_voie_supra_communale)
REFERENCES G_BASE_VOIE.TA_VOIE_supra_communale(objectid);

ALTER TABLE G_BASE_VOIE.TA_RELATION_VOIE_ADMINISTRATIVE_SUPRA_COMMUNALE
ADD CONSTRAINT TA_RELATION_VOIE_ADMINISTRATIVE_SUPRA_COMMUNALE_FID_VOIE_ADMINISTRATIVE_FK
FOREIGN KEY (fid_voie_administrative)
REFERENCES G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE(objectid);

-- 5. Création des index sur les clés étrangères
CREATE INDEX TA_RELATION_VOIE_ADMINISTRATIVE_SUPRA_COMMUNALE_FID_VOIE_SUPRA_COMMUNALE_IDX ON G_BASE_VOIE.TA_RELATION_VOIE_ADMINISTRATIVE_SUPRA_COMMUNALE(fid_voie_supra_communale)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_RELATION_VOIE_ADMINISTRATIVE_SUPRA_COMMUNALE_FID_VOIE_ADMINISTRATIVE_IDX ON G_BASE_VOIE.TA_RELATION_VOIE_ADMINISTRATIVE_SUPRA_COMMUNALE(fid_voie_administrative)
    TABLESPACE G_ADT_INDX;

-- 6. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_RELATION_VOIE_ADMINISTRATIVE_SUPRA_COMMUNALE TO G_ADMIN_SIG;

/

