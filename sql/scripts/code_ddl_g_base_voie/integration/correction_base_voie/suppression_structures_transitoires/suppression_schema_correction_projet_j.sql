/*
Requêtes sql permettant de supprimer les tables de la base voie du projet i d''homogénéisation des latéralités par voie administrative.
*/

-- 1. Suppression des tables
DROP TABLE G_BASE_VOIE.TEMP_J_TRONCON CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TEMP_J_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TEMP_J_VOIE_PHYSIQUE CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TEMP_J_VOIE_ADMINISTRATIVE CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TEMP_J_LIBELLE CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TEMP_J_TYPE_VOIE CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TEMP_J_AGENT CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TEMP_J_HIERARCHISATION_VOIE CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TEMP_J_RIVOLI CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TEMP_J_SEUIL CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TEMP_J_INFOS_SEUIL CASCADE CONSTRAINTS;

-- 2. Suppression des métadonnées spatiales
DELETE FROM USER_SDO_GEOM_METADATA
WHERE TABLE_NAME = 'TEMP_J_TRONCON';

DELETE FROM USER_SDO_GEOM_METADATA
WHERE TABLE_NAME = 'TEMP_J_SEUIL';

-- 3. Suppression des séquences
DROP SEQUENCE SEQ_TEMP_J_TRONCON_OBJECTID;

COMMIT;