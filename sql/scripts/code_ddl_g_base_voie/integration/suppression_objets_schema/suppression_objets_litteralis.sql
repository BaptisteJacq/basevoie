/*
Suppression de tous les objets du projet LITTERALIS présents sur le schéma G_BASE_VOIE + les éléments issus de G_VOIRIE et nécessaires au projet
*/

-- Suppression des vues
DROP VIEW G_BASE_VOIE.V_LITTERALIS_AUDIT_TRONCON_PREPROD;
DROP VIEW G_BASE_VOIE.V_LITTERALIS_AUDIT_ADRESSE_PREPROD;
DROP VIEW G_BASE_VOIE.V_LITTERALIS_AUDIT_ZONE_PARTICULIERE_PREPROD;
DROP VIEW G_BASE_VOIE.V_LITTERALIS_TRONCON_PREPROD;
DROP VIEW G_BASE_VOIE.V_LITTERALIS_ADRESSE_PREPROD;
DROP VIEW G_BASE_VOIE.V_LITTERALIS_REGROUPEMENT_PREPROD;
DROP VIEW G_BASE_VOIE.V_LITTERALIS_ZONE_PARTICULIERE_PREPROD;

-- Suppresion des vues matérialisées
DROP MATERIALIZED VIEW G_BASE_VOIE.VM_INFORMATION_VOIE_LITTERALIS_PREPROD;
DROP INDEX VM_TAMPON_LITTERALIS_ZONE_PARTICULIERE_INTERSECT_HORS_AGGLO_PREPROD_SIDX;
DROP MATERIALIZED VIEW G_BASE_VOIE.VM_TAMPON_LITTERALIS_ZONE_PARTICULIERE_INTERSECT_HORS_AGGLO_PREPROD;
DROP INDEX VM_TAMPON_LITTERALIS_ZONE_PARTICULIERE_INTERSECT_AGGLO_PREPROD_SIDX;
DROP MATERIALIZED VIEW G_BASE_VOIE.VM_TAMPON_LITTERALIS_ZONE_PARTICULIERE_INTERSECT_AGGLO_PREPROD;
DROP INDEX VM_TAMPON_LITTERALIS_ZONE_PARTICULIERE_HORS_AGGLO_PREPROD_SIDX;
DROP MATERIALIZED VIEW G_BASE_VOIE.VM_TAMPON_LITTERALIS_ZONE_PARTICULIERE_HORS_AGGLO_PREPROD;
DROP INDEX VM_TAMPON_LITTERALIS_ZONE_PARTICULIERE_EN_AGGLO_PREPROD_SIDX;
DROP MATERIALIZED VIEW G_BASE_VOIE.VM_TAMPON_LITTERALIS_ZONE_PARTICULIERE_EN_AGGLO_PREPROD;
DROP INDEX VM_TAMPON_LITTERALIS_ZONE_AGGLOMERATION_PREPROD_SIDX;
DROP MATERIALIZED VIEW G_BASE_VOIE.VM_TAMPON_LITTERALIS_ZONE_AGGLOMERATION_PREPROD;
DROP INDEX VM_TAMPON_LITTERALIS_REGROUPEMENT_PREPROD_SIDX;
DROP MATERIALIZED VIEW G_BASE_VOIE.VM_TAMPON_LITTERALIS_REGROUPEMENT_PREPROD;
DROP INDEX VM_UNITE_TERRITORIALE_VOIRIE_PREPROD_SIDX;
DROP MATERIALIZED VIEW G_BASE_VOIE.VM_UNITE_TERRITORIALE_VOIRIE_PREPROD;
DROP INDEX VM_TERRITOIRE_VOIRIE_PREPROD_SIDX;
DROP MATERIALIZED VIEW G_BASE_VOIE.VM_TERRITOIRE_VOIRIE_PREPROD;
DROP INDEX VM_TAMPON_LITTERALIS_ADRESSE_PREPROD_SIDX;
DROP MATERIALIZED VIEW G_BASE_VOIE.VM_TAMPON_LITTERALIS_ADRESSE_PREPROD;
DROP INDEX VM_TAMPON_LITTERALIS_TRONCON_PREPROD_SIDX;
DROP MATERIALIZED VIEW G_BASE_VOIE.VM_TAMPON_LITTERALIS_TRONCON_PREPROD;
DROP INDEX VM_TAMPON_LITTERALIS_VOIE_ADMINISTRATIVE_PREPROD_SIDX;
DROP MATERIALIZED VIEW G_BASE_VOIE.VM_TAMPON_LITTERALIS_VOIE_ADMINISTRATIVE_PREPROD;
DROP MATERIALIZED VIEW G_BASE_VOIE.VM_TAMPON_LITTERALIS_CORRESPONDANCE_DOMANIALITE_CLASSEMENT_PREPROD;

-- Suppression des tables
DROP TABLE G_BASE_VOIE.TA_SECTEUR_VOIRIE_PREPROD CASCADE CONSTRAINTS;

-- Suppression des métadonnées spatiales
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'VM_TAMPON_LITTERALIS_ZONE_PARTICULIERE_INTERSECT_HORS_AGGLO_PREPROD';
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'VM_TAMPON_LITTERALIS_ZONE_PARTICULIERE_INTERSECT_AGGLO_PREPROD';
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'VM_TAMPON_LITTERALIS_ZONE_PARTICULIERE_HORS_AGGLO_PREPROD';
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'VM_TAMPON_LITTERALIS_ZONE_PARTICULIERE_EN_AGGLO_PREPROD';
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'VM_TAMPON_LITTERALIS_ZONE_AGGLOMERATION_PREPROD';
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'VM_TAMPON_LITTERALIS_REGROUPEMENT_PREPROD';
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'VM_UNITE_TERRITORIALE_VOIRIE_PREPROD';
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'VM_TERRITOIRE_VOIRIE_PREPROD';
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'VM_TAMPON_LITTERALIS_ADRESSE_PREPROD';
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'VM_TAMPON_LITTERALIS_TRONCON_PREPROD';
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'VM_TAMPON_LITTERALIS_VOIE_ADMINISTRATIVE_PREPROD';
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'V_LITTERALIS_TRONCON_PREPROD';
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'V_LITTERALIS_ADRESSE_PREPROD';
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'V_LITTERALIS_REGROUPEMENT_PREPROD';
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'V_LITTERALIS_ZONE_PARTICULIERE_PREPROD';
DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME = 'TA_SECTEUR_VOIRIE_PREPROD';

COMMIT;