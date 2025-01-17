-- Désactivation des contraintes et des index des tables de correction des tronçons affectés à plusieurs voies et de la latéralité des voies.
-- Désactivation des contraintes
ALTER TABLE G_BASE_VOIE.TEMP_A_TRONCON DISABLE CONSTRAINT TEMP_A_TRONCON_FID_PNOM_SAISIE_FK;
ALTER TABLE G_BASE_VOIE.TEMP_A_TRONCON DISABLE CONSTRAINT TEMP_A_TRONCON_FID_PNOM_MODIFICATION_FK;
ALTER TABLE G_BASE_VOIE.TEMP_A_TRONCON DISABLE CONSTRAINT TEMP_A_TRONCON_FID_VOIE_PHYSIQUE_FK;
ALTER TABLE G_BASE_VOIE.TEMP_A_TRONCON DISABLE CONSTRAINT TEMP_A_TRONCON_FID_METADONNEE_FK;
ALTER TABLE G_BASE_VOIE.TEMP_A_VOIE_ADMINISTRATIVE DISABLE CONSTRAINT TEMP_A_VOIE_ADMINISTRATIVE_FID_VOIE_PHYSIQUE_FK;
ALTER TABLE G_BASE_VOIE.TEMP_A_VOIE_ADMINISTRATIVE DISABLE CONSTRAINT TEMP_A_VOIE_ADMINISTRATIVE_FID_TYPE_VOIE_FK;
ALTER TABLE G_BASE_VOIE.TEMP_A_VOIE_ADMINISTRATIVE DISABLE CONSTRAINT TEMP_A_VOIE_ADMINISTRATIVE_FID_PNOM_SAISIE_FK;
ALTER TABLE G_BASE_VOIE.TEMP_A_VOIE_ADMINISTRATIVE DISABLE CONSTRAINT TEMP_A_VOIE_ADMINISTRATIVE_FID_PNOM_MODIFICATION_FK;

-- Suppression des index
DROP INDEX TEMP_A_TRONCON_FID_METADONNEE_IDX;
DROP INDEX TEMP_A_TRONCON_FID_PNOM_SAISIE_IDX;
DROP INDEX TEMP_A_TRONCON_FID_PNOM_MODIFICATION_IDX;
DROP INDEX TEMP_A_TRONCON_FID_VOIE_PHYSIQUE_IDX;
DROP INDEX TEMP_A_VOIE_ADMINISTRATIVE_LIBELLE_VOIE_IDX;
DROP INDEX TEMP_A_VOIE_ADMINISTRATIVE_COMPLEMENT_NOM_VOIE_IDX;
DROP INDEX TEMP_A_VOIE_ADMINISTRATIVE_CODE_INSEE_IDX;
DROP INDEX TEMP_A_VOIE_ADMINISTRATIVE_FID_LATERALITE_IDX;
DROP INDEX TEMP_A_VOIE_ADMINISTRATIVE_FID_PNOM_SAISIE_IDX;
DROP INDEX TEMP_A_VOIE_ADMINISTRATIVE_FID_PNOM_MODIFICATION_IDX;
DROP INDEX TEMP_A_VOIE_ADMINISTRATIVE_FID_VOIE_PHYSIQUE_IDX;
DROP INDEX TEMP_A_VOIE_ADMINISTRATIVE_FID_TYPE_VOIE_IDX;

