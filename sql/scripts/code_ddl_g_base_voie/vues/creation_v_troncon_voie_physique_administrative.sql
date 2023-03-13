/*
Création de la vue V_TRONCON_VOIE_PHYSIQUE_ADMINISTRATIVE - pour la comparaison BdTopo / Base Voie MEL - compilant toutes les informations des tronçons, voies physiques et voies administratives de la nouvelle structure base voie.
*/
/*
DROP VIEW G_BASE_VOIE.V_TRONCON_VOIE_PHYSIQUE_ADMINISTRATIVE;
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'V_TRONCON_VOIE_PHYSIQUE_ADMINISTRATIVE';
COMMIT;
*/
-- 1. Création de la vue
CREATE OR REPLACE FORCE VIEW "G_BASE_VOIE"."V_TRONCON_VOIE_PHYSIQUE_ADMINISTRATIVE" (TRONCON_GEOM, TRONCON_OBJECTID, TRONCON_DATE_SAISIE, TRONCON_DATE_MODIFICATION, TRONCON_FID_VOIE_PHYSIQUE, VOIE_PHYSIQUE_OBJECTID, VOIE_PHYSIQUE_FID_ACTION, RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_FID_LATERALITE, TYPE_VOIE_LIBELLE, VOIE_ADMINISTRATIVE_OBJECTID, VOIE_ADMINISTRATIVE_GENRE_VOIE, VOIE_ADMINISTRATIVE_LIBELLE_VOIE, VOIE_ADMINISTRATIVE_COMPLEMENT_NOM_VOIE, VOIE_ADMINISTRATIVE_CODE_INSEE, VOIE_ADMINISTRATIVE_COMMENTAIRE, VOIE_ADMINISTRATIVE_DATE_SAISIE, VOIE_ADMINISTRATIVE_DATE_MODIFICATION, RIVOLI_CODE, RIVOLI_CLE_CONTROLE,
    CONSTRAINT "V_TRONCON_VOIE_PHYSIQUE_ADMINISTRATIVE_PK" PRIMARY KEY ("TRONCON_OBJECTID") DISABLE) AS 
SELECT
    a.geom AS troncon_geom,
	a.objectid AS troncon_objectid,
	a.date_saisie AS troncon_date_saisie,
	a.date_modification AS troncon_date_modification,
	a.fid_voie_physique AS troncon_fid_voie_physique,
	b.objectid AS voie_physique_objectid,
	g.libelle_court AS voie_physique_fid_action,
	h.libelle_court AS relation_voie_physique_administrative_fid_lateralite,
	e.libelle AS type_voie_libelle,
	d.objectid AS voie_administrative_objectid,
	d.genre_voie AS voie_administrative_genre_voie,
	d.libelle_voie AS voie_administrative_libelle_voie,
	d.complement_nom_voie AS voie_administrative_complement_nom_voie,
	d.code_insee AS voie_administrative_code_insee,
	d.commentaire AS voie_administrative_commentaire,
	d.date_saisie AS voie_administrative_date_saisie,
	d.date_modification AS voie_administrative_date_modification,
	f.code_rivoli AS rivoli_code,
	f.cle_controle AS rivoli_cle_controle
FROM
	G_BASE_VOIE.TEMP_I_TRONCON a
	INNER JOIN G_BASE_VOIE.TEMP_I_VOIE_PHYSIQUE b ON b.objectid = a.fid_voie_physique
	INNER JOIN G_BASE_VOIE.TEMP_I_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE c ON c.fid_voie_physique = b.objectid
	INNER JOIN G_BASE_VOIE.TEMP_I_VOIE_ADMINISTRATIVE d ON d.objectid = c.fid_voie_administrative
	INNER JOIN G_BASE_VOIE.TEMP_I_TYPE_VOIE e ON e.objectid = d.fid_type_voie
	LEFT JOIN G_BASE_VOIE.TEMP_I_RIVOLI f ON f.objectid = d.fid_rivoli
	INNER JOIN G_BASE_VOIE.TEMP_I_LIBELLE g ON g.objectid = b.fid_action
	INNER JOIN G_BASE_VOIE.TEMP_I_LIBELLE h ON h.objectid = c.fid_lateralite;

-- 2. Création des commentaires
COMMENT ON TABLE G_BASE_VOIE.V_TRONCON_VOIE_PHYSIQUE_ADMINISTRATIVE IS 'Vue compilant toutes les informations des tronçons, voies physiques et voies administratives de la nouvelle structure base voie.';

-- 3. Création des métadonnées spatiales
INSERT INTO USER_SDO_GEOM_METADATA(
    TABLE_NAME, 
    COLUMN_NAME, 
    DIMINFO, 
    SRID
)
VALUES(
    'V_TRONCON_VOIE_PHYSIQUE_ADMINISTRATIVE',
    'TRONCON_GEOM',
    SDO_DIM_ARRAY(SDO_DIM_ELEMENT('X', 684540, 719822.2, 0.005),SDO_DIM_ELEMENT('Y', 7044212, 7078072, 0.005)), 
    2154
);

-- 4. Création des droits
GRANT SELECT ON G_BASE_VOIE.V_TRONCON_VOIE_PHYSIQUE_ADMINISTRATIVE TO G_ADMIN_SIG;

/

