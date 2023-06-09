/*
Création de la vue matérialisée VM_TAMPON_LITTERALIS_ADRESSE - de la structure tampon du projet LITTERALIS - regroupant les données des seuils des tables TA_INFOS_SEUIL et TA_SEUIL.
*/
-- Suppression de la VM
/*
DROP INDEX VM_TAMPON_LITTERALIS_ADRESSE_SIDX;
DROP MATERIALIZED VIEW G_BASE_VOIE.VM_TAMPON_LITTERALIS_ADRESSE;
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'VM_TAMPON_LITTERALIS_ADRESSE';
COMMIT;
*/
-- 1. Création de la VM
CREATE MATERIALIZED VIEW G_BASE_VOIE.VM_TAMPON_LITTERALIS_ADRESSE (
    geometry, 
    objectid, 
    code_point, 
    code_voie, 
    nature, 
    libelle, 
    numero, 
    repetition, 
    cote, 
    fid_voie
)        
REFRESH ON DEMAND
FORCE
DISABLE QUERY REWRITE AS
WITH
    C_1 AS(
        SELECT DISTINCT
            a.id_seuil AS OBJECTID,
            a.id_geom,
            CAST(d.objectid AS VARCHAR2(254 BYTE)) AS CODE_VOIE,
            CAST(a.id_seuil AS VARCHAR2(254)) AS CODE_POINT,
            d.objectid AS ID_VOIE,
            b.objectid AS ID_TRONCON,
            c.id_voie_physique,
            CAST('ADR' AS VARCHAR2(254)) AS NATURE,
            d.nom_voie AS LIBELLE,
            CAST(a.numero  AS NUMBER(8,0)) AS NUMERO,
            CAST(TRIM(a.complement_numero) AS VARCHAR2(254)) AS REPETITION,
            CASE
                WHEN c.lateralite = 'droit'
                    THEN 'Pair'
                WHEN c.lateralite = 'gauche'
                    THEN 'Impair'
                ELSE
                    'LesDeuxCotes' 
            END AS COTE
        FROM
            G_BASE_VOIE.VM_CONSULTATION_SEUIL a
            INNER JOIN G_BASE_VOIE.VM_TAMPON_LITTERALIS_TRONCON b ON b.objectid = a.id_troncon
            INNER JOIN G_BASE_VOIE.VM_CONSULTATION_BASE_VOIE c ON c.id_troncon = b.objectid AND c.code_insee = a.code_insee
            INNER JOIN G_BASE_VOIE.VM_TAMPON_LITTERALIS_VOIE_ADMINISTRATIVE d ON d.objectid = c.id_voie_administrative AND c.code_insee = CASE WHEN a.code_insee IN('59355', '59298') THEN '59350' ELSE a.code_insee END
        WHERE
            -- Cette condition est nécessaire pour supprimer certains doublons de code_voie, nature, numero, repetition : le numéro 97T est en doublon (doublon aussi dans la BdTopo) car il est affecté à deux parcelles.
            a.id_seuil NOT IN(241295, 32915, 423830, 405371, 405372, 405373, 403572, 405374, 429444, 418366, 37897, 39111, 41292, 41293, 426054, 355617, 359366, 359365, 359364, 359363, 359362, 359361, 359360, 359244, 51594, 64736, 65124, 393958, 373827, 394209, 65585, 65583, 65581, 65580, 65579, 65584, 65582, 373826, 373825, 394325, 418154, 418155, 374459, 81178, 90190, 90189, 330688, 368214, 393303, 106029, 330781, 330782, 428501, 145112, 330819, 383476, 383475, 145111, 145716, 330862, 125358, 383284, 126822, 427937, 428676, 429030, 428198, 330981, 428178, 328367, 369418, 328368, 142229, 428687, 427810, 333163, 159049, 374858, 367335, 429551, 398549, 189812, 189114, 380857, 206308, 384462, 431311, 376634, 27207, 27261, 242734, 242735, 242736, 242743, 407604, 407605, 407606, 407593, 407594, 407595, 407596, 407597, 407518, 406363, 406364, 406365, 243643, 247063, 247068, 367139, 379324, 249233, 430507, 430735, 430691, 256788, 256787, 256789, 256790, 257524, 258408, 367564, 396741, 294271, 302007, 377745, 5754, 377746, 377743, 370688, 370964, 324107, 371347, 326672, 29744, 5755, 5757, 8858, 429850, 429851, 392134, 371755)
    )
    
    SELECT
        b.GEOM,
        a.OBJECTID,
        a.CODE_POINT,
        a.CODE_VOIE,
        a.NATURE,
        a.LIBELLE,
        a.NUMERO,
        a.REPETITION,
        a.COTE,
        a.ID_VOIE
    FROM
        C_1 a
        INNER JOIN G_BASE_VOIE.TA_SEUIL b ON b.objectid = a.id_geom;

-- 2. Création des commentaires sur la table et les champs
COMMENT ON MATERIALIZED VIEW G_BASE_VOIE.VM_TAMPON_LITTERALIS_ADRESSE IS 'Vue matérialisée - de la structure tampon du projet LITTERALIS - regroupant les données des seuils des tables TA_INFOS_SEUIL et TA_SEUIL.';
COMMENT ON COLUMN G_BASE_VOIE.VM_TAMPON_LITTERALIS_ADRESSE.GEOMETRY IS 'Géométrie du seuil de type point.';
COMMENT ON COLUMN G_BASE_VOIE.VM_TAMPON_LITTERALIS_ADRESSE.OBJECTID IS 'Clé primaire de la table correspondant aux identifiants des seuils de la table TA_INFOS_SEUIL.';
COMMENT ON COLUMN G_BASE_VOIE.VM_TAMPON_LITTERALIS_ADRESSE.CODE_POINT IS 'Identifiant des seuils au format LITTERALIS.';
COMMENT ON COLUMN G_BASE_VOIE.VM_TAMPON_LITTERALIS_ADRESSE.CODE_VOIE IS 'Identifiant de la voie associée au seuil et présente dans TA_TAMPON_VOIE_ADMINISTRATIVE.';
COMMENT ON COLUMN G_BASE_VOIE.VM_TAMPON_LITTERALIS_ADRESSE.NATURE IS 'Nature du seuil : ADR = Adresse.';
COMMENT ON COLUMN G_BASE_VOIE.VM_TAMPON_LITTERALIS_ADRESSE.LIBELLE IS 'Libellé du point au format LITTERALIS. C''est le libellé qui sera affiché sur les arrêtés.';
COMMENT ON COLUMN G_BASE_VOIE.VM_TAMPON_LITTERALIS_ADRESSE.NUMERO IS 'Numéro du seuil sur la voie.';
COMMENT ON COLUMN G_BASE_VOIE.VM_TAMPON_LITTERALIS_ADRESSE.REPETITION IS 'Valeur de répétition d’un numéro sur une rue (quand elle existe).';
COMMENT ON COLUMN G_BASE_VOIE.VM_TAMPON_LITTERALIS_ADRESSE.COTE IS 'Côté du seuil par rapport à la voie : LesDeuxCotes ; Impair ; Pair.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.VM_TAMPON_LITTERALIS_ADRESSE
ADD CONSTRAINTS VM_TAMPON_LITTERALIS_ADRESSE_PK
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
    'VM_TAMPON_LITTERALIS_ADRESSE',
    'GEOMETRY',
    SDO_DIM_ARRAY(SDO_DIM_ELEMENT('X', 684540, 719822.2, 0.005),SDO_DIM_ELEMENT('Y', 7044212, 7078072, 0.005)), 
    2154
);
COMMIT;

-- 5. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.VM_TAMPON_LITTERALIS_ADRESSE
ADD CONSTRAINT VM_TAMPON_LITTERALIS_ADRESSE_FID_VOIE_FK
FOREIGN KEY (fid_voie)
REFERENCES G_BASE_VOIE.VM_TAMPON_LITTERALIS_VOIE_ADMINISTRATIVE(objectid);

-- 6. Création de l'index spatial sur le champ geom
CREATE INDEX VM_TAMPON_LITTERALIS_ADRESSE_SIDX
ON G_BASE_VOIE.VM_TAMPON_LITTERALIS_ADRESSE(GEOMETRY)
INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2
PARAMETERS('sdo_indx_dims=2, layer_gtype=POINT, tablespace=G_ADT_INDX, work_tablespace=DATA_TEMP');

CREATE INDEX VM_TAMPON_LITTERALIS_ADRESSE_CODE_POINT_IDX
ON G_BASE_VOIE.VM_TAMPON_LITTERALIS_ADRESSE(CODE_POINT)
TABLESPACE G_ADT_INDX;

CREATE INDEX VM_TAMPON_LITTERALIS_ADRESSE_CODE_VOIE_IDX
ON G_BASE_VOIE.VM_TAMPON_LITTERALIS_ADRESSE(CODE_VOIE)
TABLESPACE G_ADT_INDX;

CREATE INDEX VM_TAMPON_LITTERALIS_ADRESSE_NATURE_IDX
ON G_BASE_VOIE.VM_TAMPON_LITTERALIS_ADRESSE(NATURE)
TABLESPACE G_ADT_INDX;

CREATE INDEX VM_TAMPON_LITTERALIS_ADRESSE_LIBELLE_IDX
ON G_BASE_VOIE.VM_TAMPON_LITTERALIS_ADRESSE(LIBELLE)
TABLESPACE G_ADT_INDX;

CREATE INDEX VM_TAMPON_LITTERALIS_ADRESSE_NUMERO_IDX
ON G_BASE_VOIE.VM_TAMPON_LITTERALIS_ADRESSE(NUMERO)
TABLESPACE G_ADT_INDX;

CREATE INDEX VM_TAMPON_LITTERALIS_ADRESSE_REPETITION_IDX
ON G_BASE_VOIE.VM_TAMPON_LITTERALIS_ADRESSE(REPETITION)
TABLESPACE G_ADT_INDX;

-- 6. Affection des droits
GRANT SELECT ON G_BASE_VOIE.VM_TAMPON_LITTERALIS_ADRESSE TO G_ADMIN_SIG;

/
