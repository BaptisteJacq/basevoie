/*
Création de la table TA_TAMPON_LITTERALIS_ZONE_AGGLOMERATION - de la structure tampon du projet LITTERALIS - regroupant toutes les zones d''agglomération de la DEPV dans une seule géométrie.
*/
/*
DROP TABLE G_BASE_VOIE.TA_TAMPON_LITTERALIS_ZONE_AGGLOMERATION CASCADE CONSTRAINTS;
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'TA_TAMPON_LITTERALIS_ZONE_AGGLOMERATION';
*/
-- 1. Création de la table dans laquelle insérer les seuils affecter à un tronçon disposant d'une seule domanialité et affecté à une seule voie
CREATE TABLE G_BASE_VOIE.TA_TAMPON_LITTERALIS_ZONE_AGGLOMERATION(
	GEOMETRY SDO_GEOMETRY,
	OBJECTID NUMBER(38,0) GENERATED BY DEFAULT AS IDENTITY(START WITH 1 INCREMENT BY 1)
);

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_TAMPON_LITTERALIS_ZONE_AGGLOMERATION IS 'Table tampon - de la structure tampon du projet LITTERALIS - regroupant toutes les zones d''agglomération de la DEPV dans une seule géométrie.';
COMMENT ON COLUMN G_BASE_VOIE.TA_TAMPON_LITTERALIS_ZONE_AGGLOMERATION.GEOMETRY IS 'Géométrie de type multipolygone.';
COMMENT ON COLUMN G_BASE_VOIE.TA_TAMPON_LITTERALIS_ZONE_AGGLOMERATION.OBJECTID IS 'Clé primaire auto-incrémentée de la table.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_TAMPON_LITTERALIS_ZONE_AGGLOMERATION
ADD CONSTRAINTS TA_TAMPON_LITTERALIS_ZONE_AGGLOMERATION_PK
PRIMARY KEY(OBJECTID)
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des métadonnées spatiales
INSERT INTO USER_SDO_GEOM_METADATA(
    TABLE_NAME, 
    COLUMN_NAME, 
    DIMINFO, 
    SRID
)
VALUES(
    'TA_TAMPON_LITTERALIS_ZONE_AGGLOMERATION',
    'GEOMETRY',
    SDO_DIM_ARRAY(SDO_DIM_ELEMENT('X', 684540, 719822.2, 0.005),SDO_DIM_ELEMENT('Y', 7044212, 7078072, 0.005)), 
    2154
);
COMMIT;

-- 5. Création de l'index spatial sur le champ geom
CREATE INDEX TA_TAMPON_LITTERALIS_ZONE_AGGLOMERATION_SIDX
ON G_BASE_VOIE.TA_TAMPON_LITTERALIS_ZONE_AGGLOMERATION(GEOMETRY)
INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2
PARAMETERS('sdo_indx_dims=2, layer_gtype=MULTIPOLYGON, tablespace=G_ADT_INDX, work_tablespace=DATA_TEMP');

-- 6. Affection des droits
GRANT SELECT ON G_BASE_VOIE.TA_TAMPON_LITTERALIS_ZONE_AGGLOMERATION TO G_ADMIN_SIG;

/

