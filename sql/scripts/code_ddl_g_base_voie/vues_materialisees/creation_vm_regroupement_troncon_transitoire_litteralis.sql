/*
Création d'une vue matérialisée matérialisant la géométrie des voies.
*/
-- 1. Suppression de la VM et de ses métadonnées
/*DROP MATERIALIZED VIEW G_BASE_VOIE.VM_REGROUPEMENT_TRONCON_TRANSITOIRE_LITTERALIS;
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'VM_REGROUPEMENT_TRONCON_TRANSITOIRE_LITTERALIS';
COMMIT;
*/
-- 2. Création de la VM
CREATE MATERIALIZED VIEW "G_BASE_VOIE"."VM_REGROUPEMENT_TRONCON_TRANSITOIRE_LITTERALIS" ("ID_TRONCON", "GEOM")        
REFRESH ON DEMAND
FORCE
DISABLE QUERY REWRITE AS
WITH
    C_1 AS(
        SELECT
            id_troncon
        FROM
            TEMP_TRONCON_CORRECT_LITTERALIS_V2
        UNION ALL
        SELECT
            id_troncon
        FROM
            TEMP_TRONCON_DOUBLON_DOMANIA_LITTERALIS_V2
        UNION ALL
        SELECT
            id_troncon
        FROM
            TEMP_TRONCON_DOUBLON_VOIE_LITTERALIS_V2
    )

    SELECT
        objectid,
        geom
    FROM
        TA_TRONCON
    WHERE
        objectid IN(SELECT id_troncon FROM C_1);

-- 3. Création des commentaires de la VM
COMMENT ON MATERIALIZED VIEW G_BASE_VOIE.VM_REGROUPEMENT_TRONCON_TRANSITOIRE_LITTERALIS IS 'Vue matérialisée regroupant tous les tronçons disposant d''une relation 1:1 avec une voie, pour le moment dans le tables de travail LITTERALIS.';

-- 4. Création des métadonnées spatiales
INSERT INTO USER_SDO_GEOM_METADATA(
    TABLE_NAME, 
    COLUMN_NAME, 
    DIMINFO, 
    SRID
)
VALUES(
    'VM_REGROUPEMENT_TRONCON_TRANSITOIRE_LITTERALIS',
    'GEOM',
    SDO_DIM_ARRAY(SDO_DIM_ELEMENT('X', 684540, 719822.2, 0.005),SDO_DIM_ELEMENT('Y', 7044212, 7078072, 0.005)), 
    2154
);
COMMIT;

-- 5. Création de la clé primaire
ALTER MATERIALIZED VIEW VM_REGROUPEMENT_TRONCON_TRANSITOIRE_LITTERALIS 
ADD CONSTRAINT VM_REGROUPEMENT_TRONCON_TRANSITOIRE_LITTERALIS_PK 
PRIMARY KEY (ID_TRONCON);

-- 6. Création des index
CREATE INDEX VM_REGROUPEMENT_TRONCON_TRANSITOIRE_LITTERALIS_SIDX
ON G_BASE_VOIE.VM_REGROUPEMENT_TRONCON_TRANSITOIRE_LITTERALIS(GEOM)
INDEXTYPE IS MDSYS.SPATIAL_INDEX
PARAMETERS(
  'sdo_indx_dims=2, 
  layer_gtype=MULTILINE, 
  tablespace=G_ADT_INDX, 
  work_tablespace=DATA_TEMP'
);

-- 7. Affectations des droits
GRANT SELECT ON G_BASE_VOIE.VM_REGROUPEMENT_TRONCON_TRANSITOIRE_LITTERALIS TO G_ADMIN_SIG;
