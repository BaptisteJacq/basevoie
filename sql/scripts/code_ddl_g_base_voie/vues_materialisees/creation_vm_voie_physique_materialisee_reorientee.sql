/*
Création de la VM VM_VOIE_PHYSIQUE_MATERIALISEE_REORIENTEE matérialisant la géométrie réorientée des voies physiques.
*/
-- 1. Suppression de la VM et de ses métadonnées
/*DROP MATERIALIZED VIEW G_BASE_VOIE.VM_VOIE_PHYSIQUE_MATERIALISEE_REORIENTEE;
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'VM_VOIE_PHYSIQUE_MATERIALISEE_REORIENTEE';
COMMIT;
*/
-- 2. Création de la VM
CREATE MATERIALIZED VIEW "G_BASE_VOIE"."VM_VOIE_PHYSIQUE_MATERIALISEE_REORIENTEE" ("ID_VOIE_PHYSIQUE", "GEOM")        
REFRESH FORCE
START WITH TO_DATE('06-04-2023 16:00:00', 'dd-mm-yyyy hh24:mi:ss')
NEXT sysdate + 1440/24/1440
DISABLE QUERY REWRITE AS
SELECT
    b.objectid AS id_voie_physique,
    CASE 
        WHEN c.libelle_court = 'à conserver' 
            THEN a.geom 
        WHEN c.libelle_court = 'à inverser' 
            THEN SDO_CS.MAKE_2D(
                    SDO_LRS.REVERSE_GEOMETRY(SDO_LRS.CONVERT_TO_LRS_GEOM(a.geom, m.diminfo)),
                    2154
                )
    END AS geom
FROM
    G_BASE_VOIE.VM_VOIE_PHYSIQUE_MATERIALISEE_NON_REORIENTEE a
    INNER JOIN G_BASE_VOIE.TA_VOIE_PHYSIQUE b ON b.objectid = a.id_voie_physique
    INNER JOIN G_BASE_VOIE.TA_LIBELLE c ON c.objectid = b.fid_action,
    USER_SDO_GEOM_METADATA m
WHERE
    m.table_name = 'VM_VOIE_PHYSIQUE_MATERIALISEE_NON_REORIENTEE';

-- 3. Création des commentaires de la VM
COMMENT ON MATERIALIZED VIEW G_BASE_VOIE.VM_VOIE_PHYSIQUE_MATERIALISEE_REORIENTEE IS 'Vue matérialisée matérialisant la géométrie réorientée des voies physiques.';

-- 4. Création des métadonnées spatiales
INSERT INTO USER_SDO_GEOM_METADATA(
    TABLE_NAME, 
    COLUMN_NAME, 
    DIMINFO, 
    SRID
)
VALUES(
    'VM_VOIE_PHYSIQUE_MATERIALISEE_REORIENTEE',
    'GEOM',
    SDO_DIM_ARRAY(SDO_DIM_ELEMENT('X', 684540, 719822.2, 0.005),SDO_DIM_ELEMENT('Y', 7044212, 7078072, 0.005)), 
    2154
);
COMMIT;

-- 5. Création de la clé primaire
ALTER MATERIALIZED VIEW VM_VOIE_PHYSIQUE_MATERIALISEE_REORIENTEE 
ADD CONSTRAINT VM_VOIE_PHYSIQUE_MATERIALISEE_REORIENTEE_PK 
PRIMARY KEY (ID_VOIE_PHYSIQUE);

-- 6. Création des index
CREATE INDEX VM_VOIE_PHYSIQUE_MATERIALISEE_REORIENTEE_SIDX
ON G_BASE_VOIE.VM_VOIE_PHYSIQUE_MATERIALISEE_REORIENTEE(GEOM)
INDEXTYPE IS MDSYS.SPATIAL_INDEX
PARAMETERS(
  'sdo_indx_dims=2, 
  layer_gtype=MULTILINE, 
  tablespace=G_ADT_INDX, 
  work_tablespace=DATA_TEMP'
);

-- 7. Affectations des droits
GRANT SELECT ON G_BASE_VOIE.VM_VOIE_PHYSIQUE_MATERIALISEE_REORIENTEE TO G_ADMIN_SIG;

/

