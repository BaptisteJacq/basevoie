@echo off
:: utilisation de ogr2ogr pour exporter des tables de CUDL vers MULTIT
:: 1. gestion des identifiants Oracle
SET /p USER_D="Veuillez saisir l'utilisateur Oracle de destination: "
SET /p USER_P="Veuillez saisir l'utilisateur Oracle de provenance: "
SET /p MDP_D="Veuillez saisir le mot de passe de l'utilisateur Oracle de destination: "
SET /p MDP_P="Veuillez saisir le mot de passe de l'utilisateur Oracle de provenance: "
SET /p INSTANCE_D="Veuillez saisir l'instance Oracle de destination: "
SET /p INSTANCE_P="Veuillez saisir l'instance Oracle de provenance: "

:: 2. se mettre dans l'environnement QGIS
cd C:\Program Files\QGIS 3.16\bin

:: 3. Configurer le système d'encodage des caractères en UTF-8
SET NLS_LANG=AMERICAN_AMERICA.AL32UTF8

:: 4. Rediriger la variable PROJ_LIB vers le bon fichier proj.db afin qu'ogr2ogr trouve le bon scr
setx PROJ_LIB "C:\Program Files\QGIS 3.16\share\proj"

:: 5. commande ogr2ogr pour exporter les couches du schéma présent dans oracle 11g vers le schéma présent sur oracle 12c
:: 5.1. table CORRECTION_ILTATRC
ogr2ogr.exe -f OCI OCI:%USER_D%/%MDP_D%@%INSTANCE_D% OCI:%USER_P%/%MDP_P%@%INSTANCE_P% -sql "SELECT * FROM "%USER_P%".CORRECTION_ILTATRC" -nln TEMP_TA_TRONCON -nlt LINE -lco SRID=2154 -dim 2

:: 5.2. table CORRECTION_ILTAPTZ
ogr2ogr.exe -f OCI OCI:%USER_D%/%MDP_D%@%INSTANCE_D% OCI:%USER_P%/%MDP_P%@%INSTANCE_P% -sql "SELECT * FROM "%USER_P%".CORRECTION_ILTAPTZ" -nln TEMP_TA_NOEUD -nlt POINT -lco SRID=2154 -dim 2

:: 5.3. table CORRECTION_ILTADTN
ogr2ogr.exe -f OCI OCI:%USER_D%/%MDP_D%@%INSTANCE_D% OCI:%USER_P%/%MDP_P%@%INSTANCE_P% -sql "SELECT * FROM "%USER_P%".CORRECTION_ILTADTN" -nln TEMP_RELATION_NOEUD_TRONCON

:: 5.4. table CORRECTION_ILTALPU
ogr2ogr.exe -f OCI OCI:%USER_D%/%MDP_D%@%INSTANCE_D% OCI:%USER_P%/%MDP_P%@%INSTANCE_P% -sql "SELECT * FROM "%USER_P%".CORRECTION_ILTALPU" -nln TEMP_TA_POINT_INTERET - nlt POINT -lco SRID=2154 -dim 2

:: 5.5. table CORRECTION_ILTASEU
ogr2ogr.exe -f OCI OCI:%USER_D%/%MDP_D%@%INSTANCE_D% OCI:%USER_P%/%MDP_P%@%INSTANCE_P% -sql "SELECT * FROM "%USER_P%".CORRECTION_ILTASEU" -nln TEMP_TA_SEUIL

:: 5.6. table CORRECTION_ILTASIT
ogr2ogr.exe -f OCI OCI:%USER_D%/%MDP_D%@%INSTANCE_D% OCI:%USER_P%/%MDP_P%@%INSTANCE_P% -sql "SELECT * FROM "%USER_P%".CORRECTION_ILTASIT" -nln TEMP_TA_RELATION_SEUIL_TRONCON

:: 5.7. table CORRECTION_ILTAFILIA
ogr2ogr.exe -f OCI OCI:%USER_D%/%MDP_D%@%INSTANCE_D% OCI:%USER_P%/%MDP_P%@%INSTANCE_P% -sql "SELECT * FROM "%USER_P%".CORRECTION_ILTAFILIA" -nln TEMP_TA_TRONCON_LOG

:: 5.8. table CORRECTION_VOIEVOI
ogr2ogr.exe -f OCI OCI:%USER_D%/%MDP_D%@%INSTANCE_D% OCI:%USER_P%/%MDP_P%@%INSTANCE_P% -sql "SELECT * FROM "%USER_P%".CORRECTION_VOIEVOI" -nln TEMP_TA_VOIE

:: 5.9. table CORRECTION_VOIECVT
ogr2ogr.exe -f OCI OCI:%USER_D%/%MDP_D%@%INSTANCE_D% OCI:%USER_P%/%MDP_P%@%INSTANCE_P% -sql "SELECT * FROM "%USER_P%".CORRECTION_VOIECVT" -nln TEMP_TA_RELATION_VOIE_TRONCON

:: 5.10. table CORRECTION_TYPEVOIE
ogr2ogr.exe -f OCI OCI:%USER_D%/%MDP_D%@%INSTANCE_D% OCI:%USER_P%/%MDP_P%@%INSTANCE_P% -sql "SELECT * FROM "%USER_P%".CORRECTION_TYPEVOIE" -nln TEMP_TA_TYPEVOIE

:: 5.12. table CORRECTION_RUE
ogr2ogr.exe -f OCI OCI:%USER_D%/%MDP_D%@%INSTANCE_D% OCI:%USER_P%/%MDP_P%@%INSTANCE_P% -sql "SELECT * FROM "%USER_P%".CORRECTION_RUE" -nln TEMP_TA_RUE

:: 5.13. table CORRECTION_RUELPU
ogr2ogr.exe -f OCI OCI:%USER_D%/%MDP_D%@%INSTANCE_D% OCI:%USER_P%/%MDP_P%@%INSTANCE_P% -sql "SELECT * FROM "%USER_P%".CORRECTION_RUELPU" -nln TEMP_TA_RELATION_RUE_POINT_INTERET

:: 5.15. table CORRECTION_RUEVOIE
ogr2ogr.exe -f OCI OCI:%USER_D%/%MDP_D%@%INSTANCE_D% OCI:%USER_P%/%MDP_P%@%INSTANCE_P% -sql "SELECT * FROM "%USER_P%".CORRECTION_RUEVOIE" -nln TEMP_TA_RELATION_RUE_VOIE

:: 6. MISE EN PAUSE
PAUSE