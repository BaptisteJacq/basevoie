@echo off
echo Bienvenu dans la creation des tables, vues, VM, fonctions, sequences et declencheurs du projet j de correction de la Base Voie !

:: 1. Configurer le système d'encodage des caractères en UTF-8
SET NLS_LANG=AMERICAN_AMERICA.AL32UTF8

:: 2. Déclaration et valorisation des variables
SET /p chemin_code_table="Veuillez saisir le chemin d'acces du dossier contenant le code DDL des TABLES du schema : "
SET /p chemin_code_trigger="Veuillez saisir le chemin d'acces du dossier contenant le code DDL des DECLENCHEURS du schema : "
SET /p chemin_code_sequence="Veuillez saisir le chemin d'acces du dossier contenant le code DDL des SEQUENCES du schema : "
::SET /p chemin_code_fonction="Veuillez saisir le chemin d'acces du dossier contenant le code DDL des FONCTIONS du schema : "
::SET /p chemin_code_vue="Veuillez saisir le chemin d'acces du dossier contenant le code DDL des VUES du schema : "
::SET /p chemin_code_vue_materialisees="Veuillez saisir le chemin d'acces du dossier contenant le code DDL des VUES MATERIALISEES du schema : "
SET /p chemin_code_temp="Veuillez saisir le chemin d'acces du dossier integration\correction_base_voie\creation_structures_transitoires : "

copy /b %chemin_code_sequence%\creation_seq_ta_troncon_objectid.sql + ^
%chemin_code_table%\creation_ta_agent.sql + ^
%chemin_code_table%\creation_ta_famille.sql + ^
%chemin_code_table%\creation_ta_famille_libelle.sql + ^
%chemin_code_table%\creation_ta_libelle.sql + ^
%chemin_code_table%\creation_ta_type_voie.sql + ^
%chemin_code_table%\creation_ta_rivoli.sql + ^
%chemin_code_table%\creation_ta_voie_physique.sql + ^
%chemin_code_table%\creation_ta_voie_administrative.sql + ^
%chemin_code_table%\creation_ta_troncon.sql + ^
%chemin_code_table%\creation_ta_relation_voie_physique_administrative.sql + ^
%chemin_code_table%\creation_ta_hierarchisation_voie.sql + ^
%chemin_code_table%\creation_ta_seuil.sql + ^
%chemin_code_table%\creation_ta_infos_seuil.sql + ^
%chemin_code_table%\creation_ta_seuil_log.sql + ^
%chemin_code_table%\creation_ta_infos_seuil_log.sql + ^
%chemin_code_table%\creation_ta_troncon_log.sql + ^
%chemin_code_table%\creation_ta_voie_physique_log.sql + ^
%chemin_code_table%\creation_ta_voie_administrative_log.sql + ^
%chemin_code_table%\creation_ta_relation_voie_physique_administrative.sql + ^
%chemin_code_table%\creation_ta_hierarchisation_log.sql + ^
%chemin_code_trigger%\creation_b_iux_ta_troncon_date_pnom.sql + ^
%chemin_code_temp%\desactivation_contraintes_index_tables.sql ^
%chemin_code_temp%\temp_code_ddl_schema_final.sql

:: 3. lancement de SQL plus.
::CD C:/ora12c/R1/BIN

:: 4. Execution de sqlplus. pour lancer les requetes SQL.
::sqlplus.exe %USER%/%MDP%@%INSTANCE% @%chemin_code_temp%\temp_code_ddl_schema_transitoire_projet_j.sql

:: 5. MISE EN PAUSE
PAUSE