/*
Requêtes sql permettant de supprimer les tables de la base voie avec leur MTD spatiale, index, contraintes, triggers et fonctions.
*/

-- 1. Suppression des tables pivot
DROP TABLE G_BASE_VOIE.TA_RELATION_TRONCON_VOIE CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TA_RELATION_TRONCON_SEUIL CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TA_HIERARCHISATION_VOIE CASCADE CONSTRAINTS;

-- 2. Suppression des tables filles (tables de log avec FK)
DROP TABLE G_BASE_VOIE.TA_TRONCON_LOG CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TA_RELATION_TRONCON_VOIE_LOG CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TA_VOIE_LOG CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TA_SEUIL_LOG CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TA_INFOS_SEUIL_LOG CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TA_POINT_INTERET_LOG CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TA_INFOS_POINT_INTERET_LOG CASCADE CONSTRAINTS;

-- 3. Suppression des tables parentes
DROP TABLE G_BASE_VOIE.TA_AGENT CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TA_TRONCON CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TA_VOIE CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TA_SEUIL CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TA_INFOS_SEUIL CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TA_TYPE_VOIE CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TA_RIVOLI CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TA_POINT_INTERET CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TA_INFOS_POINT_INTERET CASCADE CONSTRAINTS;

-- 4. Suppression des vues
--DROP VIEW G_BASE_VOIE.V_TRONCON_VOIE;

-- 5. Suppression des métadonnées spatiales
DELETE FROM USER_SDO_GEOM_METADATA
WHERE TABLE_NAME = 'TA_TRONCON';

DELETE FROM USER_SDO_GEOM_METADATA
WHERE TABLE_NAME = 'TA_TRONCON_LOG';

DELETE FROM USER_SDO_GEOM_METADATA
WHERE TABLE_NAME = 'TA_SEUIL';

DELETE FROM USER_SDO_GEOM_METADATA
WHERE TABLE_NAME = 'TA_SEUIL_LOG';

DELETE FROM USER_SDO_GEOM_METADATA
WHERE TABLE_NAME = 'TA_POINT_INTERET';

DELETE FROM USER_SDO_GEOM_METADATA
WHERE TABLE_NAME = 'TA_POINT_INTERET_LOG';

DELETE FROM USER_SDO_GEOM_METADATA
WHERE TABLE_NAME = 'VM_VOIE_AGGREGEE';

-- 6. Suppression des fonctions personnalisées
DROP FUNCTION G_BASE_VOIE.GET_CODE_INSEE_97_COMMUNES_CONTAIN_LINE;
DROP FUNCTION G_BASE_VOIE.GET_CODE_INSEE_97_COMMUNES_POURCENTAGE;
DROP FUNCTION G_BASE_VOIE.GET_CODE_INSEE_97_COMMUNES_TRONCON;
DROP FUNCTION G_BASE_VOIE.GET_CODE_INSEE_97_COMMUNES_WITHIN_DISTANCE;
DROP FUNCTION G_BASE_VOIE.GET_CODE_INSEE_CONTAIN_LINE;
DROP FUNCTION G_BASE_VOIE.GET_CODE_INSEE_CONTAIN_POINT;
DROP FUNCTION G_BASE_VOIE.GET_CODE_INSEE_POURCENTAGE;
DROP FUNCTION G_BASE_VOIE.GET_CODE_INSEE_TRONCON;
DROP FUNCTION G_BASE_VOIE.GET_CODE_INSEE_WITHIN_DISTANCE;

-- 7. Suppression des vues matérialisées
DROP MATERIALIZED VIEW G_BASE_VOIE.VM_VOIE_AGGREGEE;
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'VM_VOIE_AGGREGEE';
DROP MATERIALIZED VIEW G_BASE_VOIE.VM_TRAVAIL_VOIE_CODE_INSEE_LONGUEUR;
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'VM_TRAVAIL_VOIE_CODE_INSEE_LONGUEUR';
DROP MATERIALIZED VIEW G_BASE_VOIE.VM_TRAVAIL_VOIE_PRINCIPALE_LONGUEUR;
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'VM_TRAVAIL_VOIE_PRINCIPALE_LONGUEUR';
DROP MATERIALIZED VIEW G_BASE_VOIE.VM_TRAVAIL_VOIE_SECONDAIRE_LONGUEUR;
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'VM_TRAVAIL_VOIE_SECONDAIRE_LONGUEUR';
DROP MATERIALIZED VIEW G_BASE_VOIE.VM_HIERARCHIE_VOIE_PRINCIPALE_SECONDAIRE_LONGUEUR;
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'VM_HIERARCHIE_VOIE_PRINCIPALE_SECONDAIRE_LONGUEUR';
DROP MATERIALIZED VIEW G_BASE_VOIE.VM_HIERARCHIE_VOIE_PRINCIPALE_SECONDAIRE_LONGUEUR;
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'VM_HIERARCHIE_VOIE_PRINCIPALE_SECONDAIRE_LONGUEUR';

COMMIT;
