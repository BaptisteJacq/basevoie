/*
La table TA_INFOS_SEUIL regroupe le détail des seuils de la base voie.
*/

-- 1. Création de la table TA_INFOS_SEUIL
CREATE TABLE G_BASE_VOIE.TA_INFOS_SEUIL(
    objectid NUMBER(38,0) GENERATED BY DEFAULT AS IDENTITY,
    numero_seuil NUMBER(5,0) NOT NULL,
    numero_parcelle CHAR(9) NOT NULL,
    complement_numero_seuil VARCHAR2(10),
    date_saisie DATE DEFAULT sysdate NOT NULL,
    fid_pnom_saisie NUMBER(38,0),
    date_modification DATE DEFAULT sysdate NOT NULL,
    fid_pnom_modification NUMBER(38,0)
);

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_INFOS_SEUIL IS 'Table contenant le détail des seuils, c''est-à-dire les numéros de seuil, de parcelles et les compléments de numéro de seuil. Cela permet d''associer un ou plusieurs seuils à un et un seul point géométrique au besoin.';
COMMENT ON COLUMN G_BASE_VOIE.TA_INFOS_SEUIL.objectid IS 'Clé primaire auto-incrémentée de la table.';
COMMENT ON COLUMN G_BASE_VOIE.TA_INFOS_SEUIL.numero_seuil IS 'Numéro de seuil.';
COMMENT ON COLUMN G_BASE_VOIE.TA_INFOS_SEUIL.numero_parcelle IS 'Numéro de parcelle issu du cadastre.';
COMMENT ON COLUMN G_BASE_VOIE.TA_INFOS_SEUIL.complement_numero_seuil IS 'Complément du numéro de seuil. Exemple : 1 bis';
COMMENT ON COLUMN G_BASE_VOIE.TA_INFOS_SEUIL.date_saisie IS 'Date de saisie des informations du seuil (automatique).';
COMMENT ON COLUMN G_BASE_VOIE.TA_INFOS_SEUIL.fid_pnom_saisie IS 'Clé étrangère vers la table TA_AGENT permettant de récupérer le pnom de l''agent ayant créé les informations d''un seuil.';
COMMENT ON COLUMN G_BASE_VOIE.TA_INFOS_SEUIL.date_modification IS 'Date de modification des informations du seuil (via un trigger).';
COMMENT ON COLUMN G_BASE_VOIE.TA_INFOS_SEUIL.fid_pnom_modification IS 'Clé étrangère vers la table TA_AGENT permettant de récupérer le pnom de l''agent ayant modifié les informations d''un seuil.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_INFOS_SEUIL 
ADD CONSTRAINT TA_INFOS_SEUIL_PK 
PRIMARY KEY("OBJECTID") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TA_INFOS_SEUIL
ADD CONSTRAINT TA_INFOS_SEUIL_FID_PNOM_SAISIE_FK 
FOREIGN KEY (fid_pnom_saisie)
REFERENCES G_BASE_VOIE.ta_agent(numero_agent);

ALTER TABLE G_BASE_VOIE.TA_INFOS_SEUIL
ADD CONSTRAINT TA_INFOS_SEUIL_FID_PNOM_MODIFICATION_FK
FOREIGN KEY (fid_pnom_modification)
REFERENCES G_BASE_VOIE.ta_agent(numero_agent);

-- 5. Création des index sur les clés étrangères
CREATE INDEX TA_INFOS_SEUIL_FID_PNOM_SAISIE_IDX ON G_BASE_VOIE.TA_INFOS_SEUIL(fid_pnom_saisie)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_INFOS_SEUIL_FID_PNOM_MODIFICATION_IDX ON G_BASE_VOIE.TA_INFOS_SEUIL(fid_pnom_modification)
    TABLESPACE G_ADT_INDX;

-- 6. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_INFOS_SEUIL TO G_ADMIN_SIG;
