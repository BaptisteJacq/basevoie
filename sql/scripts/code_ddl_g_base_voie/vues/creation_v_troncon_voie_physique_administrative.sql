/*
Création de la vue V_TRONCON_VOIE_PHYSIQUE_ADMINISTRATIVE - pour la comparaison BdTopo / Base Voie MEL - compilant toutes les informations des tronçons, voies physiques et voies administratives de la nouvelle structure base voie.
*/
/*
DROP VIEW G_BASE_VOIE.V_TRONCON_VOIE_PHYSIQUE_ADMINISTRATIVE;
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'V_TRONCON_VOIE_PHYSIQUE_ADMINISTRATIVE';
COMMIT;
*/
-- 1. Création de la vue
CREATE OR REPLACE FORCE EDITIONABLE VIEW "G_BASE_VOIE"."V_TRONCON_VOIE_PHYSIQUE_ADMINISTRATIVE" (GEOM, ID_TRONCON, ID_VOIE_PHYSIQUE, ACTION_VOIE_PHYSIQUE, ID_VOIE_DROITE, ID_VOIE_GAUCHE, NOM_VOIE_DROITE, NOM_VOIE_GAUCHE, CODE_INSEE_VOIE_DROITE, CODE_INSEE_VOIE_GAUCHE, COMMENTAIRE_VOIE_DROITE, COMMENTAIRE_VOIE_GAUCHE, 
	CONSTRAINT "V_TRONCON_VOIE_PHYSIQUE_ADMINISTRATIVE_PK" PRIMARY KEY ("ID_TRONCON") DISABLE) AS 
SELECT
    a.geom,
	a.objectid AS id_troncon,
	b.objectid AS id_voie_physique,
	g.libelle_court AS action_voie_physique,
	d.objectid AS id_voie_droite,
    j.objectid AS id_voie_gauche,
	CAST(SUBSTR(UPPER(TRIM(e.libelle)), 1, 1) || SUBSTR(LOWER(TRIM(e.libelle)), 2) || CASE WHEN d.libelle_voie IS NOT NULL THEN ' ' || TRIM(d.libelle_voie) ELSE '' END || CASE WHEN d.complement_nom_voie IS NOT NULL THEN ' ' || TRIM(d.complement_nom_voie) ELSE '' END || CASE WHEN d.code_insee = '59298' THEN ' (Hellemmes-Lille)' WHEN d.code_insee = '59355' THEN ' (Lomme)' END AS VARCHAR2(254)) AS nom_voie_droite,
    CAST(SUBSTR(UPPER(TRIM(k.libelle)), 1, 1) || SUBSTR(LOWER(TRIM(k.libelle)), 2) || CASE WHEN j.libelle_voie IS NOT NULL THEN ' ' || TRIM(j.libelle_voie) ELSE '' END || CASE WHEN j.complement_nom_voie IS NOT NULL THEN ' ' || TRIM(j.complement_nom_voie) ELSE '' END || CASE WHEN j.code_insee = '59298' THEN ' (Hellemmes-Lille)' WHEN j.code_insee = '59355' THEN ' (Lomme)' END AS VARCHAR2(254)) AS nom_voie_gauche,
	d.code_insee AS code_insee_voie_droite,
    j.code_insee AS code_insee_voie_gauche,
	d.commentaire AS commentaire_voie_droite,
    j.commentaire AS commentaire_voie_gauche
FROM
	G_BASE_VOIE.TEMP_I_TRONCON a
	INNER JOIN G_BASE_VOIE.TEMP_I_VOIE_PHYSIQUE b ON b.objectid = a.fid_voie_physique
	INNER JOIN G_BASE_VOIE.TEMP_I_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE c ON c.fid_voie_physique = b.objectid
	INNER JOIN G_BASE_VOIE.TEMP_I_VOIE_ADMINISTRATIVE d ON d.objectid = c.fid_voie_administrative
	INNER JOIN G_BASE_VOIE.TEMP_I_TYPE_VOIE e ON e.objectid = d.fid_type_voie
	INNER JOIN G_BASE_VOIE.TEMP_I_LIBELLE g ON g.objectid = b.fid_action   
    INNER JOIN G_BASE_VOIE.TEMP_I_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE i ON i.fid_voie_physique = b.objectid
	INNER JOIN G_BASE_VOIE.TEMP_I_VOIE_ADMINISTRATIVE j ON j.objectid = i.fid_voie_administrative
	INNER JOIN G_BASE_VOIE.TEMP_I_TYPE_VOIE k ON k.objectid = j.fid_type_voie
WHERE
    c.fid_lateralite IN(1,3)
    AND i.fid_lateralite IN(2,3);

-- 2. Création des commentaires
COMMENT ON TABLE G_BASE_VOIE.V_TRONCON_VOIE_PHYSIQUE_ADMINISTRATIVE IS 'Vue compilant toutes les informations des tronçons, voies physiques et voies administratives de la nouvelle structure base voie au "format" BdTopo.';

-- 3. Création des métadonnées spatiales
INSERT INTO USER_SDO_GEOM_METADATA(
    TABLE_NAME, 
    COLUMN_NAME, 
    DIMINFO, 
    SRID
)
VALUES(
    'V_TRONCON_VOIE_PHYSIQUE_ADMINISTRATIVE',
    'GEOM',
    SDO_DIM_ARRAY(SDO_DIM_ELEMENT('X', 684540, 719822.2, 0.005),SDO_DIM_ELEMENT('Y', 7044212, 7078072, 0.005)), 
    2154
);

-- 4. Création des droits
GRANT SELECT ON G_BASE_VOIE.V_TRONCON_VOIE_PHYSIQUE_ADMINISTRATIVE TO G_ADMIN_SIG;

/

