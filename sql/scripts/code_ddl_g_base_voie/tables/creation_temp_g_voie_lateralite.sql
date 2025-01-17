/*
Table - du projet G de correction de la latéralité des voies en limite de commune - contenant la matéralisation des voies physiques avec leur association aux voies administratives. C''est avec cette table que les agents identifie la latéralité des voies admin pour chaque voie physique.
*/

/*
DROP TABLE TEMP_G_VOIE_LATERALITE CASCADE CONSTRAINTS;
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'TEMP_G_VOIE_LATERALITE';
COMMIT;
*/

-- 1. Création de la table TEMP_G_VOIE_LATERALITE
CREATE TABLE G_BASE_VOIE.TEMP_G_VOIE_LATERALITE(
    geom SDO_GEOMETRY NOT NULL,
    objectid NUMBER(38,0) GENERATED BY DEFAULT AS IDENTITY(START WITH 1 INCREMENT BY 1),
    id_voie_physique NUMBER(38,0),
    id_voie_administrative NUMBER(38,0),
    code_insee VARCHAR2(5 BYTE),
    fid_pnom_correction NUMBER(38,0),
    fid_lateralite NUMBER(38,0)
);

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TEMP_G_VOIE_LATERALITE IS 'Table - du projet G de correction de la latéralité des voies en limite de commune - contenant la matéralisation des voies physiques avec leur association aux voies administratives. C''est avec cette table que les agents identifie la latéralité des voies admin pour chaque voie physique.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_G_VOIE_LATERALITE.geom IS 'Géométrie de type multiligne de chaque voie physique.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_G_VOIE_LATERALITE.objectid IS 'Clé primaire auto-incrémentée de la table identifiant chaque couple voie physique/administrative.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_G_VOIE_LATERALITE.id_voie_physique IS 'Identifiant de la voie physique présente dans la table TEMP_G_VOIE_PHYSIQUE.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_G_VOIE_LATERALITE.id_voie_administrative IS 'Identifiant de la voie physique présente dans la table TEMP_G_VOIE_ADMINISTRATIVE.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_G_VOIE_LATERALITE.code_insee IS 'Code INSEE de la voie administrative présente dans la table TEMP_G_VOIE_ADMINISTRATIVE.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_G_VOIE_LATERALITE.fid_pnom_correction IS 'Clé étrangère vers la table TEMP_G_AGENT permettant d''affecter une entité à un agent pour lui affecter une latéralité.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_G_VOIE_LATERALITE.fid_lateralite IS 'Clé étrangère vers la table TEMP_G_LIBELLE permettant d''affecter une latéralité à une voie en limite de commune (droite/gauche).';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TEMP_G_VOIE_LATERALITE 
ADD CONSTRAINT TEMP_G_VOIE_LATERALITE_PK 
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
    'TEMP_G_VOIE_LATERALITE',
    'GEOM',
    SDO_DIM_ARRAY(SDO_DIM_ELEMENT('X', 684540, 719822.2, 0.005),SDO_DIM_ELEMENT('Y', 7044212, 7078072, 0.005)), 
    2154
);

-- 5. Création de l'index spatial sur le champ geom
CREATE INDEX TEMP_G_VOIE_LATERALITE_SIDX
ON G_BASE_VOIE.TEMP_G_VOIE_LATERALITE(GEOM)
INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2
PARAMETERS('sdo_indx_dims=2, layer_gtype=MULTILINE, tablespace=G_ADT_INDX, work_tablespace=DATA_TEMP');

-- 6. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TEMP_G_VOIE_LATERALITE
ADD CONSTRAINT TEMP_G_VOIE_LATERALITE_FID_PNOM_CORRECTION_FK 
FOREIGN KEY (fid_pnom_correction)
REFERENCES G_BASE_VOIE.TEMP_G_AGENT(numero_agent);

ALTER TABLE G_BASE_VOIE.TEMP_G_VOIE_LATERALITE
ADD CONSTRAINT TEMP_G_VOIE_LATERALITE_FID_LATERALITE_FK 
FOREIGN KEY (fid_lateralite)
REFERENCES G_BASE_VOIE.TEMP_G_LIBELLE(objectid);

-- 7. Création des index sur les clés étrangères et autres
CREATE INDEX TEMP_G_VOIE_LATERALITE_TEMP_G_VOIE_LATERALITE_FID_PNOM_CORRECTION_IDX ON G_BASE_VOIE.TEMP_G_VOIE_LATERALITE(fid_pnom_correction)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TEMP_G_VOIE_LATERALITE_TEMP_G_VOIE_LATERALITE_FID_LATERALITE_IDX ON G_BASE_VOIE.TEMP_G_VOIE_LATERALITE(fid_lateralite)
    TABLESPACE G_ADT_INDX;

-- 8. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TEMP_G_VOIE_LATERALITE TO G_ADMIN_SIG;

/

