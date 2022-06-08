/*
Création d'une vue matérialisée regroupant toutes les voies avec leur nom, code INSEE et longueur
*/

-- 2. Création de la VM
CREATE MATERIALIZED VIEW "G_BASE_VOIE"."VM_TRAVAIL_VOIE_CODE_INSEE_LONGUEUR" ("ID_VOIE","TYPE_DE_VOIE","LIBELLE_VOIE","COMPLEMENT_NOM_VOIE","CODE_INSEE","LONGUEUR_VOIE", "GEOM")        
REFRESH ON DEMAND
FORCE
DISABLE QUERY REWRITE AS
SELECT
    b.id_voie,
    b.type_de_voie,
    b.libelle_voie,
    b.complement_nom_voie,
    b.code_insee,
    SDO_GEOM.SDO_LENGTH(b.geom) AS longueur_voie,
    b.geom
FROM
    G_BASE_VOIE.TA_VOIE a
    INNER JOIN G_BASE_VOIE.VM_TRAVAIL_VOIE_AGGREGEE_CODE_INSEE b ON b.id_voie = a.objectid;

-- 3. Création des commentaires de la VM
COMMENT ON MATERIALIZED VIEW G_BASE_VOIE.VM_TRAVAIL_VOIE_CODE_INSEE_LONGUEUR IS 'Vue matérialisée récupérant le code INSEE, la longueur, le type , le nom, la géométrie et le complément de chaque voie.';

-- 2. Création des métadonnées spatiales
INSERT INTO USER_SDO_GEOM_METADATA(
    TABLE_NAME, 
    COLUMN_NAME, 
    DIMINFO, 
    SRID
)
VALUES(
    'VM_TRAVAIL_VOIE_CODE_INSEE_LONGUEUR',
    'GEOM',
    SDO_DIM_ARRAY(SDO_DIM_ELEMENT('X', 684540, 719822.2, 0.005),SDO_DIM_ELEMENT('Y', 7044212, 7078072, 0.005)), 
    2154
);
COMMIT;

-- 3. Création de la clé primaire
ALTER MATERIALIZED VIEW VM_TRAVAIL_VOIE_CODE_INSEE_LONGUEUR 
ADD CONSTRAINT VM_TRAVAIL_VOIE_CODE_INSEE_LONGUEUR_PK 
PRIMARY KEY (ID_VOIE);

-- 4. Création des index
CREATE INDEX VM_TRAVAIL_VOIE_CODE_INSEE_LONGUEUR_SIDX
ON G_BASE_VOIE.VM_TRAVAIL_VOIE_CODE_INSEE_LONGUEUR(GEOM)
INDEXTYPE IS MDSYS.SPATIAL_INDEX
PARAMETERS(
  'sdo_indx_dims=2, 
  layer_gtype=MULTILINE, 
  tablespace=G_ADT_INDX, 
  work_tablespace=DATA_TEMP'
);

CREATE INDEX VM_TRAVAIL_VOIE_CODE_INSEE_LONGUEUR_CODE_INSEE_IDX ON G_BASE_VOIE.VM_TRAVAIL_VOIE_CODE_INSEE_LONGUEUR(CODE_INSEE)
    TABLESPACE G_ADT_INDX;

CREATE INDEX VM_TRAVAIL_VOIE_CODE_INSEE_LONGUEUR_LONGUEUR_VOIE_IDX ON G_BASE_VOIE.VM_TRAVAIL_VOIE_CODE_INSEE_LONGUEUR(LONGUEUR_VOIE)
    TABLESPACE G_ADT_INDX;

CREATE INDEX VM_TRAVAIL_VOIE_CODE_INSEE_LONGUEUR_LIBELLE_VOIE_IDX ON G_BASE_VOIE.VM_TRAVAIL_VOIE_CODE_INSEE_LONGUEUR(LIBELLE_VOIE)
    TABLESPACE G_ADT_INDX;

-- 5. Affectations des droits
GRANT SELECT ON G_BASE_VOIE.VM_TRAVAIL_VOIE_CODE_INSEE_LONGUEUR TO G_ADMIN_SIG;

/
