/*
Création de la vue VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE dénombrant et géolocalisant les doublons de numéros de seuil par voie administrative et par commune.
*/
/*
DROP INDEX VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE_SIDX;
DROP MATERIALIZED VIEW G_BASE_VOIE.VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE;
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE';
COMMIT;
*/

-- 1. Création de la vue
CREATE MATERIALIZED VIEW G_BASE_VOIE.VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE (
    OBJECTID, 
    NUMERO, 
    ID_VOIE_ADMINISTRATIVE, 
    NOM_VOIE,
    CODE_INSEE, 
    NOM_COMMUNE,
    NOMBRE,
    GEOM
)        
REFRESH ON DEMAND
FORCE
DISABLE QUERY REWRITE AS
    WITH 
        C_1 AS(-- Sélection des doublons de numéro de seuil
            SELECT
                a.numero || ' ' || a.complement_numero AS numero,
                a.code_insee,
                a.nom_commune,
                a.id_voie_administrative,
                a.nom_voie,
                COUNT(a.id_seuil) AS nombre,
                SDO_CS.MAKE_2D(SDO_AGGR_UNION(SDOAGGRTYPE(a.geom, 0.001))) AS geom
            FROM
                G_BASE_VOIE.VM_CONSULTATION_SEUIL a
            GROUP BY
                a.numero || ' ' || a.complement_numero,
                a.code_insee,
                a.nom_commune,
                a.id_voie_administrative,
                a.nom_voie
            HAVING
                COUNT(a.id_seuil) > 1
        )

    SELECT
        rownum AS objectid,
        a.numero,
        a.id_voie_administrative,
        a.nom_voie,
        a.code_insee,
        a.nom_commune,
        a.nombre,
        a.geom
    FROM
        C_1 a;

-- 2. Création des commentaires
COMMENT ON MATERIALIZED VIEW G_BASE_VOIE.VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE IS 'Vue matérialisée dénombrant et géolocalisant les doublons de numéros de seuil par voie administrative et par commune. Mise à jour tous les samedis à 15h00.';
COMMENT ON COLUMN G_BASE_VOIE.VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE.objectid IS 'Clé primaire de la vue.';
COMMENT ON COLUMN G_BASE_VOIE.VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE.numero IS 'Numéro du seuil (numéro + concaténation).';
COMMENT ON COLUMN G_BASE_VOIE.VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE.code_insee IS 'Code INSEE de la commune d''appartenance du seuil et de la voie administrative.';
COMMENT ON COLUMN G_BASE_VOIE.VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE.nom_commune IS 'Nom de la commune.';
COMMENT ON COLUMN G_BASE_VOIE.VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE.id_voie_administrative IS 'Identifiant de la voie administrative associée au seuil.';
COMMENT ON COLUMN G_BASE_VOIE.VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE.nom_voie IS 'Nom de voie (Type de voie + libelle de voie + complément nom de voie + commune associée).';
COMMENT ON COLUMN G_BASE_VOIE.VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE.nombre IS 'Nombre de numéros de seuil en doublon par voie administrative et par commune.';
COMMENT ON COLUMN G_BASE_VOIE.VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE.geom IS 'Géométrie de type multipoint rassemblant les points des seuils par doublon.';

-- 3. Création des métadonnées spatiales
INSERT INTO USER_SDO_GEOM_METADATA(
    TABLE_NAME, 
    COLUMN_NAME, 
    DIMINFO, 
    SRID
)
VALUES(
    'VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE',
    'GEOM',
    SDO_DIM_ARRAY(SDO_DIM_ELEMENT('X', 684540, 719822.2, 0.005),SDO_DIM_ELEMENT('Y', 7044212, 7078072, 0.005)), 
    2154
);
 
-- 4. Création de la clé primaire
ALTER MATERIALIZED VIEW VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE 
ADD CONSTRAINT VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE_PK 
PRIMARY KEY (OBJECTID);

-- 5. Création des index
-- index spatial
CREATE INDEX VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE_SIDX
ON G_BASE_VOIE.VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE(GEOM)
INDEXTYPE IS MDSYS.SPATIAL_INDEX
PARAMETERS(
  'sdo_indx_dims=2, 
  layer_gtype=MULTIPOINT, 
  tablespace=G_ADT_INDX, 
  work_tablespace=DATA_TEMP'
);

-- Autres index  
CREATE INDEX VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE_NUMERO_IDX ON G_BASE_VOIE.VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE(NUMERO)
    TABLESPACE G_ADT_INDX;

CREATE INDEX VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE_CODE_INSEE_IDX ON G_BASE_VOIE.VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE(CODE_INSEE)
    TABLESPACE G_ADT_INDX;

CREATE INDEX VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE_NOM_COMMUNE_IDX ON G_BASE_VOIE.VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE(NOM_COMMUNE)
    TABLESPACE G_ADT_INDX;

CREATE INDEX VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE_ID_VOIE_ADMINISTRATIVE_IDX ON G_BASE_VOIE.VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE(ID_VOIE_ADMINISTRATIVE)
    TABLESPACE G_ADT_INDX;

CREATE INDEX VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE_NOM_VOIE_IDX ON G_BASE_VOIE.VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE(NOM_VOIE)
    TABLESPACE G_ADT_INDX;
    
CREATE INDEX VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE_NOMBRE_IDX ON G_BASE_VOIE.VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE(NOMBRE)
    TABLESPACE G_ADT_INDX;
    
-- 3. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.VM_AUDIT_DOUBLON_NUMERO_SEUIL_PAR_VOIE_ADMINISTRATIVE TO G_ADMIN_SIG;

/
