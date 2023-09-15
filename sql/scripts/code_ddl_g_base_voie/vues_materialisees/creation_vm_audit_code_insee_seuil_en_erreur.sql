/*
Création de la vue matérialisée VM_AUDIT_CODE_INSEE_SEUIL_EN_ERREUR identifiant les seuils dont le code INSEE ne correspond pas au référentiel des communes (G_REFERENTIEL.MEL_COMMUNE_LLH)
*/
-- Suppression de la VM
/*
DROP INDEX VM_AUDIT_CODE_INSEE_SEUIL_EN_ERREUR_SIDX;
DROP MATERIALIZED VIEW G_BASE_VOIE.VM_AUDIT_CODE_INSEE_SEUIL_EN_ERREUR;
DELETE FROM USER_SDO_GEOM_METADATA WHERE table_name = 'VM_AUDIT_CODE_INSEE_SEUIL_EN_ERREUR';
COMMIT;
*/

SELECT * FROM G_REFERENTIEL.MEL_COMMUNE_LLH;

/


-- 1. Création de la VM
CREATE MATERIALIZED VIEW G_BASE_VOIE.VM_AUDIT_CODE_INSEE_SEUIL_EN_ERREUR (
    ID_SEUIL,
    ID_GEOM_SEUIL,
    CODE_INSEE_BASE,
    CODE_INSEE_CALCULE,
    GEOM
)        
REFRESH ON DEMAND
FORCE
DISABLE QUERY REWRITE AS
SELECT
    b.objectid AS id_seuil,
    a.objectid AS id_geom_seuil,
    a.code_insee AS code_insee_base,
    TRIM(GET_CODE_INSEE_97_COMMUNES_CONTAIN_POINT('TA_SEUIL', a.geom)) AS code_insee_calcule,
    a.geom
FROM
    G_BASE_VOIE.TA_SEUIL a 
    INNER JOIN G_BASE_VOIE.TA_INFOS_SEUIL b ON b.fid_seuil = a.objectid 
WHERE
    TRIM(GET_CODE_INSEE_97_COMMUNES_CONTAIN_POINT('TA_SEUIL', a.geom)) <> a.code_insee;

-- 2. Création des commentaires de la VM
COMMENT ON MATERIALIZED VIEW G_BASE_VOIE.VM_AUDIT_CODE_INSEE_SEUIL_EN_ERREUR IS 'Vue matérialisée identifiant les seuils dont le code INSEE ne correspond pas au référentiel des communes (G_REFERENTIEL.MEL_COMMUNE_LLH). Mise à jour tous les samedis à 18h00.';
COMMENT ON COLUMN G_BASE_VOIE.VM_AUDIT_CODE_INSEE_SEUIL_EN_ERREUR.id_seuil IS 'Identifiants des seuils correspondant à la clé primaire de la vue.';
COMMENT ON COLUMN G_BASE_VOIE.VM_AUDIT_CODE_INSEE_SEUIL_EN_ERREUR.id_geom_seuil IS 'Identifiants de la géométrie des seuils.';
COMMENT ON COLUMN G_BASE_VOIE.VM_AUDIT_CODE_INSEE_SEUIL_EN_ERREUR.code_insee_base IS 'Code INSEE du seuil en base.';
COMMENT ON COLUMN G_BASE_VOIE.VM_AUDIT_CODE_INSEE_SEUIL_EN_ERREUR.code_insee_calcule IS 'Code INSEE du seuil obtenu par requête spatiale.';
COMMENT ON COLUMN G_BASE_VOIE.VM_AUDIT_CODE_INSEE_SEUIL_EN_ERREUR.geom IS 'Géométrie du seuil de type point.';

-- 3. Création de la clé primaire
ALTER MATERIALIZED VIEW VM_AUDIT_CODE_INSEE_SEUIL_EN_ERREUR 
ADD CONSTRAINT VM_AUDIT_CODE_INSEE_SEUIL_EN_ERREUR_PK 
PRIMARY KEY (ID_SEUIL);

-- 4. Création des métadonnées spatiales
INSERT INTO USER_SDO_GEOM_METADATA(
    TABLE_NAME, 
    COLUMN_NAME, 
    DIMINFO, 
    SRID
)
VALUES(
    'VM_AUDIT_CODE_INSEE_SEUIL_EN_ERREUR',
    'GEOM',
    SDO_DIM_ARRAY(SDO_DIM_ELEMENT('X', 684540, 719822.2, 0.005),SDO_DIM_ELEMENT('Y', 7044212, 7078072, 0.005)), 
    2154
);

-- 5. Création des index
CREATE INDEX VM_AUDIT_CODE_INSEE_SEUIL_EN_ERREUR_SIDX
ON G_BASE_VOIE.VM_AUDIT_CODE_INSEE_SEUIL_EN_ERREUR(GEOM)
INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2
PARAMETERS('sdo_indx_dims=2, layer_gtype=POINT, tablespace=G_ADT_INDX, work_tablespace=DATA_TEMP');

CREATE INDEX VM_AUDIT_CODE_INSEE_SEUIL_EN_ERREUR_ID_GEOM_SEUIL_IDX ON G_BASE_VOIE.VM_AUDIT_CODE_INSEE_SEUIL_EN_ERREUR(id_geom_seuil)
    TABLESPACE G_ADT_INDX;

CREATE INDEX VM_AUDIT_CODE_INSEE_SEUIL_EN_ERREUR_CODE_INSEE_BASE_IDX ON G_BASE_VOIE.VM_AUDIT_CODE_INSEE_SEUIL_EN_ERREUR(CODE_INSEE_BASE)
    TABLESPACE G_ADT_INDX;

CREATE INDEX VM_AUDIT_CODE_INSEE_SEUIL_EN_ERREUR_CODE_INSEE_CALCULE_IDX ON G_BASE_VOIE.VM_AUDIT_CODE_INSEE_SEUIL_EN_ERREUR(CODE_INSEE_CALCULE)
    TABLESPACE G_ADT_INDX;

-- 5. Affectations des droits
GRANT SELECT ON G_BASE_VOIE.VM_AUDIT_CODE_INSEE_SEUIL_EN_ERREUR TO G_ADMIN_SIG;

/

