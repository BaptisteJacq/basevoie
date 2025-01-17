/*
Suppression des tables temporaires ayant servies à importer les tables de l'ancien schéma de la base voie, G_SIDU.
*/

-- 1. Suppression des tables/VM temporaires
DROP TABLE G_BASE_VOIE.TEMP_ILTATRC CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TEMP_ILTAPTZ CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TEMP_ILTADTN CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TEMP_VOIEVOI CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TEMP_VOIECVT CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TEMP_TYPEVOIE CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TEMP_ILTASEU CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TEMP_ILTASIT CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TEMP_ILTAFILIA CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TEMP_ILTALPU CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TEMP_FUSION_SEUIL CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TEMP_AGENT CASCADE CONSTRAINTS;
DROP TABLE G_BASE_VOIE.TEMP_CODE_FANTOIR CASCADE CONSTRAINTS;

DROP MATERIALIZED VIEW G_BASE_VOIE.VM_TRAVAIL_VOIE_AGGREGEE_CODE_INSEE;
DROP MATERIALIZED VIEW G_BASE_VOIE.VM_HIERARCHIE_VOIE_PRINCIPALE_SECONDAIRE_LONGUEUR;
DROP MATERIALIZED VIEW G_BASE_VOIE.VM_TRAVAIL_VOIE_CODE_INSEE_LONGUEUR;
DROP MATERIALIZED VIEW G_BASE_VOIE.VM_TRAVAIL_VOIE_PRINCIPALE_LONGUEUR;
DROP MATERIALIZED VIEW G_BASE_VOIE.VM_TRAVAIL_VOIE_SECONDAIRE_LONGUEUR;

-- 2. Suppression des métadonnées spatiales des tables temporaires
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'TEMP_ILTATRC';
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'TEMP_ILTAPTZ';
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'TEMP_ILTASEU';
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'TEMP_FUSION_SEUIL';
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'TEMP_ILTALPU';
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'VM_TRAVAIL_VOIE_AGGREGEE_CODE_INSEE';
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'VM_TRAVAIL_VOIE_CODE_INSEE_LONGUEUR';
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'VM_TRAVAIL_VOIE_PRINCIPALE_LONGUEUR';
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'VM_TRAVAIL_VOIE_SECONDAIRE_LONGUEUR';
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'VM_HIERARCHIE_VOIE_PRINCIPALE_SECONDAIRE_LONGUEUR';
COMMIT;