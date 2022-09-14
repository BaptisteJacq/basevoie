/*
La table TEMP_C_LIBELLE - du projet C de correction de la latéralité des voies - liste les types et états permettant de catégoriser les objets de la base voie.
*/

-- 1. Création de la table TEMP_C_LIBELLE
CREATE TABLE G_BASE_VOIE.TEMP_C_LIBELLE(
    objectid NUMBER(38,0) GENERATED BY DEFAULT AS IDENTITY,
    libelle_court VARCHAR2(100 BYTE),
    libelle_long VARCHAR2(4000 BYTE)
);

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TEMP_C_LIBELLE IS 'Table - du projet C de correction de la latéralité des voies - listant les types et états permettant de catégoriser les objets de la base voie.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_LIBELLE.objectid IS 'Clé primaire auto-incrémentée de la table.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_LIBELLE.libelle_court IS 'Valeur courte pouvant être prise par un libellé de la nomenclature de la base voie.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_LIBELLE.libelle_long IS 'Valeur longue pouvant être prise par un libellé de la nomenclature de la base voie.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TEMP_C_LIBELLE 
ADD CONSTRAINT TEMP_C_LIBELLE_PK 
PRIMARY KEY("OBJECTID") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 7. Création des index sur les clés étrangères et autres
CREATE INDEX TEMP_C_LIBELLE_LIBELLE_COURT_IDX ON G_BASE_VOIE.TEMP_C_LIBELLE(libelle_court)
    TABLESPACE G_ADT_INDX;

-- 8. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TEMP_C_LIBELLE TO G_ADMIN_SIG;

/

