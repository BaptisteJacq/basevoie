/*
Création de la table TA_TAMPON_LITTERALIS_ZONE_PARTICULIERE - de la structure tampon du projet LITTERALIS - regroupant les voies ou parties de voie par zone d''agglomération ou hors agglomération.
*/
/*
DROP TABLE G_BASE_VOIE.TA_TAMPON_LITTERALIS_ZONE_PARTICULIERE CASCADE CONSTRAINTS;
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'TA_TAMPON_LITTERALIS_ZONE_PARTICULIERE';
*/
-- 1. Création de la table dans laquelle insérer les seuils affecter à un tronçon disposant d'une seule domanialité et affecté à une seule voie
CREATE TABLE G_BASE_VOIE.TA_TAMPON_LITTERALIS_ZONE_PARTICULIERE(
	GEOMETRY SDO_GEOMETRY,
	OBJECTID NUMBER(38,0) GENERATED BY DEFAULT AS IDENTITY(START WITH 1 INCREMENT BY 1),
	TYPE_ZONE VARCHAR2(254 BYTE) NOT NULL,
	CODE_VOIE VARCHAR2(254 BYTE) NOT NULL,
	COTE_VOIE VARCHAR2(254 BYTE) NOT NULL,
	CODE_INSEE VARCHAR2(254 BYTE) NOT NULL,
	CATEGORIE NUMBER(8,0) NOT NULL,
	FID_VOIE NUMBER(38,0) NOT NULL
);

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_TAMPON_LITTERALIS_ZONE_PARTICULIERE IS 'Table tampon - de la structure tampon du projet LITTERALIS - regroupant les voies ou parties de voie par zone d''agglomération ou hors agglomération.';
COMMENT ON COLUMN G_BASE_VOIE.TA_TAMPON_LITTERALIS_ZONE_PARTICULIERE.GEOMETRY IS 'Géométrie de type multiligne.';
COMMENT ON COLUMN G_BASE_VOIE.TA_TAMPON_LITTERALIS_ZONE_PARTICULIERE.OBJECTID IS 'Clé primaire auto-incrémentée de la table.';
COMMENT ON COLUMN G_BASE_VOIE.TA_TAMPON_LITTERALIS_ZONE_PARTICULIERE.TYPE_ZONE IS 'Type de zone à laquelle appartient l''entité.';
COMMENT ON COLUMN G_BASE_VOIE.TA_TAMPON_LITTERALIS_ZONE_PARTICULIERE.CODE_VOIE IS 'Code voie issu de la table TA_TAMPON_LITTERALIS_VOIE.';
COMMENT ON COLUMN G_BASE_VOIE.TA_TAMPON_LITTERALIS_ZONE_PARTICULIERE.COTE_VOIE IS 'Côté de la voie situé dans la zone d''agglomération ou hors agglomération.';
COMMENT ON COLUMN G_BASE_VOIE.TA_TAMPON_LITTERALIS_ZONE_PARTICULIERE.CODE_INSEE IS 'Code INSEE de la voie.';
COMMENT ON COLUMN G_BASE_VOIE.TA_TAMPON_LITTERALIS_ZONE_PARTICULIERE.CATEGORIE IS 'Catégorie de la voie sur cette zone.';
COMMENT ON COLUMN G_BASE_VOIE.TA_TAMPON_LITTERALIS_ZONE_PARTICULIERE.FID_VOIE IS 'Clé étrangère vers la table TA_TAMPON_LITTERALIS_VOIE.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_TAMPON_LITTERALIS_ZONE_PARTICULIERE
ADD CONSTRAINTS TA_TAMPON_LITTERALIS_ZONE_PARTICULIERE_PK
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
    'TA_TAMPON_LITTERALIS_ZONE_PARTICULIERE',
    'GEOMETRY',
    SDO_DIM_ARRAY(SDO_DIM_ELEMENT('X', 684540, 719822.2, 0.005),SDO_DIM_ELEMENT('Y', 7044212, 7078072, 0.005)), 
    2154
);
COMMIT;

-- 5. Création de l'index spatial sur le champ geom
CREATE INDEX TA_TAMPON_LITTERALIS_ZONE_PARTICULIERE_SIDX
ON G_BASE_VOIE.TA_TAMPON_LITTERALIS_ZONE_PARTICULIERE(GEOMETRY)
INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2
PARAMETERS('sdo_indx_dims=2, layer_gtype=MULTILINE, tablespace=G_ADT_INDX, work_tablespace=DATA_TEMP');

CREATE INDEX TA_TAMPON_LITTERALIS_ZONE_PARTICULIERE_CODE_VOIE_IDX
ON G_BASE_VOIE.TA_TAMPON_LITTERALIS_ZONE_PARTICULIERE(CODE_VOIE)
TABLESPACE G_ADT_INDX;

CREATE INDEX TA_TAMPON_LITTERALIS_ZONE_PARTICULIERE_CATEGORIE_IDX
ON G_BASE_VOIE.TA_TAMPON_LITTERALIS_ZONE_PARTICULIERE(CATEGORIE)
TABLESPACE G_ADT_INDX;

CREATE INDEX TA_TAMPON_LITTERALIS_ZONE_PARTICULIERE_COTE_VOIE_IDX
ON G_BASE_VOIE.TA_TAMPON_LITTERALIS_ZONE_PARTICULIERE(COTE_VOIE)
TABLESPACE G_ADT_INDX;

CREATE INDEX TA_TAMPON_LITTERALIS_ZONE_PARTICULIERE_CODE_INSEE_IDX
ON G_BASE_VOIE.TA_TAMPON_LITTERALIS_ZONE_PARTICULIERE(CODE_INSEE)
TABLESPACE G_ADT_INDX;

CREATE INDEX TA_TAMPON_LITTERALIS_ZONE_PARTICULIERE_FID_VOIE_IDX
ON G_BASE_VOIE.TA_TAMPON_LITTERALIS_ZONE_PARTICULIERE(FID_VOIE)
TABLESPACE G_ADT_INDX;

-- 6. Affection des droits
GRANT SELECT ON G_BASE_VOIE.TA_TAMPON_LITTERALIS_ZONE_PARTICULIERE TO G_ADMIN_SIG;

/

