/*
SEQ_TA_SAUVEGARDE_TRONCON_OBJECTID : création de la séquence d'auto-incrémentation de la clé primaire de la table TA_SAUVEGARDE_TRONCON
*/

CREATE SEQUENCE SEQ_TA_SAUVEGARDE_TRONCON_OBJECTID START WITH 1 INCREMENT BY 1;

/

/*
La table TA_SAUVEGARDE_AGENT regroupant les pnoms de tous les agents ayant travaillés et qui travaillent encore pour la base voie.
*/

-- 1. Création de la table TA_SAUVEGARDE_AGENT
CREATE TABLE G_BASE_VOIE.TA_SAUVEGARDE_AGENT AS 
SELECT *
FROM
    G_BASE_VOIE.TA_AGENT;

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_SAUVEGARDE_AGENT IS 'Table de sauvegarde - source créée le 17/05/2022 - listant les pnoms de tous les agents ayant travaillés et qui travaillent encore pour la base voie.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_AGENT.numero_agent IS 'Numéro d''agent présent sur la carte de chaque agent.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_AGENT.pnom IS 'Pnom de l''agent, c''est-à-dire la concaténation de l''initiale de son prénom et de son nom entier.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_AGENT.validite IS 'Validité de l''agent, c''est-à-dire que ce champ permet de savoir si l''agent continue de travailler dans/pour la base voie ou non : 1 = oui ; 0 = non.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_AGENT 
ADD CONSTRAINT TA_SAUVEGARDE_AGENT_PK 
PRIMARY KEY("NUMERO_AGENT") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_SAUVEGARDE_AGENT TO G_ADMIN_SIG;

/

/*
La table TA_SAUVEGARDE_RIVOLI regroupe tous les tronçons de la base voie.
*/

-- 1. Création de la table TA_SAUVEGARDE_RIVOLI
CREATE TABLE G_BASE_VOIE.TA_SAUVEGARDE_RIVOLI AS 
SELECT *
FROM
    G_BASE_VOIE.TA_RIVOLI;

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_SAUVEGARDE_RIVOLI IS 'Table de sauvegarde - source créée le 17/05/2022 - rassemblant tous les codes fantoirs issus du fichier fantoir et correspondants aux voies présentes sur le territoire de la MEL.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_RIVOLI.objectid IS 'Clé primaire auto-incrémentée de la table identifiant.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_RIVOLI.code_rivoli IS 'Code RIVOLI du code fantoir. Ce code est l''identifiant sur 4 caractères de la voie au sein de la commune. Attention : il ne faut pas confondre ce code avec le code de l''ancien fichier RIVOLI, devenu depuis fichier fantoir. Le code RIVOLI fait partie du code fantoir. Attention cet identifiant est recyclé dans le fichier fantoir, ce champ ne doit donc jamais être utilisé en tant que clé primaire ou étrangère.' ;
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_RIVOLI.cle_controle IS 'Clé de contrôle du code fantoir issue du fichier fantoir.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_RIVOLI 
ADD CONSTRAINT TA_SAUVEGARDE_RIVOLI_PK 
PRIMARY KEY("OBJECTID") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des index
CREATE INDEX TA_SAUVEGARDE_RIVOLI_code_rivoli_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_RIVOLI(code_rivoli)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_RIVOLI_cle_controle_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_RIVOLI(cle_controle)
    TABLESPACE G_ADT_INDX;

-- 5. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_SAUVEGARDE_RIVOLI TO G_ADMIN_SIG;

/

/*
La table TA_SAUVEGARDE_TYPE_VOIE regroupe tous les types de voies de la base voie tels que les avenues, boulevards, rues, senteir, etc.
*/

-- 1. Création de la table TA_SAUVEGARDE_TYPE_VOIE
CREATE TABLE G_BASE_VOIE.TA_SAUVEGARDE_TYPE_VOIE AS 
SELECT *
FROM
    G_BASE_VOIE.TA_TYPE_VOIE;

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_SAUVEGARDE_TYPE_VOIE IS 'Table de sauvegarde - source créée le 17/05/2022 - rassemblant tous les types de voies présents dans la base voie. Ancienne table : TYPEVOIE.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_TYPE_VOIE.objectid IS 'Clé primaire auto-incrémentée de la table.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_TYPE_VOIE.code_type_voie IS 'Code des types de voie présents dans la base voie. Ce champ remplace le champ CCODTVO.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_TYPE_VOIE.libelle IS 'Libellé des types de voie. Exemple : Boulevard, avenue, reu, sentier, etc.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_TYPE_VOIE 
ADD CONSTRAINT TA_SAUVEGARDE_TYPE_VOIE_PK 
PRIMARY KEY("OBJECTID") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 5. Création des index
CREATE INDEX TA_SAUVEGARDE_TYPE_VOIE_CODE_TYPE_VOIE_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_TYPE_VOIE(code_type_voie)
    TABLESPACE G_ADT_INDX;

-- 6. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_SAUVEGARDE_TYPE_VOIE TO G_ADMIN_SIG;

/

/*
La table TA_SAUVEGARDE_VOIE regroupe tous les informations de chaque voie de la base voie.
*/

-- 1. Création de la table TA_SAUVEGARDE_VOIE
CREATE TABLE G_BASE_VOIE.TA_SAUVEGARDE_VOIE AS 
SELECT *
FROM
    G_BASE_VOIE.TA_VOIE;

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_SAUVEGARDE_VOIE IS 'Table de sauvegarde - source créée le 17/05/2022 - rassemblant toutes les informations pour chaque voie de la base. Ancienne table : VOIEVOI';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_VOIE.objectid IS 'Clé primaire auto-incrémentée de la table. Elle remplace l''ancien identifiant ccomvoie.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_VOIE.libelle_voie IS 'Nom de la voie.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_VOIE.complement_nom_voie IS 'Complément du nom de la voie.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_VOIE.date_saisie IS 'Date de saisie de la voie (par défaut la date du jour).';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_VOIE.date_modification IS 'Date de modification de la voie (par défaut la date du jour).';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_VOIE.fid_pnom_saisie IS 'Clé étrangère vers la table TA_SAUVEGARDE_AGENT permettant de récupérer le pnom de l''agent ayant créé une voie.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_VOIE.fid_pnom_modification IS 'Clé étrangère vers la table TA_SAUVEGARDE_AGENT permettant de récupérer le pnom de l''agent ayant modifié une voie.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_VOIE.fid_typevoie IS 'Clé étangère vers la table TA_SAUVEGARDE_TYPE_VOIE permettant de catégoriser les voies de la base.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_VOIE.fid_genre_voie IS 'Clé étrangère vers la table TA_SAUVEGARDE_LIBELLE permettant de connaître le genre du nom de la voie : masculin, féminin, neutre et non-identifié.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_VOIE.fid_rivoli IS 'Clé étrangère vers la table TA_SAUVEGARDE_RIVOLI permettant d''associer un code RIVOLI à chaque voie.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_VOIE.fid_metadonnee IS 'Clé étrangère vers la table G_GEO.TA_SAUVEGARDE_METADONNEE permettant de connaître la source des voies (MEL ou IGN).';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_VOIE 
ADD CONSTRAINT TA_SAUVEGARDE_VOIE_PK 
PRIMARY KEY("OBJECTID") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_VOIE
ADD CONSTRAINT TA_SAUVEGARDE_VOIE_FID_PNOM_SAISIE_FK
FOREIGN KEY (fid_pnom_saisie)
REFERENCES G_BASE_VOIE.TA_SAUVEGARDE_agent(numero_agent);

ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_VOIE
ADD CONSTRAINT TA_SAUVEGARDE_VOIE_FID_PNOM_MODIFICATION_FK
FOREIGN KEY (fid_pnom_modification)
REFERENCES G_BASE_VOIE.TA_SAUVEGARDE_agent(numero_agent);

ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_VOIE
ADD CONSTRAINT TA_SAUVEGARDE_VOIE_FID_TYPEVOIE_FK 
FOREIGN KEY (fid_typevoie)
REFERENCES G_BASE_VOIE.TA_SAUVEGARDE_type_voie(objectid);

ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_VOIE
ADD CONSTRAINT TA_SAUVEGARDE_VOIE_FID_GENRE_VOIE_FK
FOREIGN KEY (fid_genre_voie)
REFERENCES G_GEO.TA_SAUVEGARDE_LIBELLE(objectid);

ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_VOIE
ADD CONSTRAINT TA_SAUVEGARDE_VOIE_FID_RIVOLI_FK
FOREIGN KEY (fid_rivoli)
REFERENCES G_BASE_VOIE.TA_SAUVEGARDE_rivoli(objectid);

ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_VOIE
ADD CONSTRAINT TA_SAUVEGARDE_VOIE_FID_METADONNEE_FK
FOREIGN KEY (fid_metadonnee)
REFERENCES G_GEO.TA_SAUVEGARDE_metadonnee(objectid);

-- 5. Création des index sur les clés étrangères
CREATE INDEX TA_SAUVEGARDE_VOIE_FID_PNOM_SAISIE_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_VOIE(fid_pnom_saisie)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_VOIE_FID_PNOM_MODIFICATION_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_VOIE(fid_pnom_modification)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_VOIE_FID_TYPEVOIE_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_VOIE(fid_typevoie)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_VOIE_FID_GENRE_VOIE_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_VOIE(fid_genre_voie)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_VOIE_FID_RIVOLI_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_VOIE(fid_rivoli)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_VOIE_FID_METADONNEE_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_VOIE(fid_metadonnee)
    TABLESPACE G_ADT_INDX;
    
-- 6. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_SAUVEGARDE_VOIE TO G_ADMIN_SIG;

/

/*
La table TA_SAUVEGARDE_HIERARCHISATION_VOIE permet de hiérarchiser les voies en associant les voies secondaires à leur voie principale.
*/

-- 1. Création de la table TA_SAUVEGARDE_HIERARCHISATION_VOIE
CREATE TABLE G_BASE_VOIE.TA_SAUVEGARDE_HIERARCHISATION_VOIE AS 
SELECT *
FROM
    G_BASE_VOIE.TA_HIERARCHISATION_VOIE;

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_SAUVEGARDE_HIERARCHISATION_VOIE IS 'Table de sauvegarde - source créée le 17/05/2022 - permettant de hiérarchiser les voies en associant les voies secondaires à leur voie principale.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_HIERARCHISATION_VOIE.fid_voie_principale IS 'Clé primaire (partie 1) de la table et clé étrangère vers TA_SAUVEGARDE_VOIE permettant d''associer une voie principale à une voie secondaire';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_HIERARCHISATION_VOIE.fid_voie_secondaire IS 'Clé primaire (partie 2) et clé étrangère vers TA_SAUVEGARDE_VOIE permettant d''associer une voie secondaire à une voie principale.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_HIERARCHISATION_VOIE 
ADD CONSTRAINT TA_SAUVEGARDE_HIERARCHISATION_VOIE_PK 
PRIMARY KEY("FID_VOIE_PRINCIPALE", "FID_VOIE_SECONDAIRE") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_HIERARCHISATION_VOIE
ADD CONSTRAINT TA_SAUVEGARDE_HIERARCHISATION_VOIE_FID_VOIE_PRINCIPALE_FK 
FOREIGN KEY (fid_voie_principale)
REFERENCES G_BASE_VOIE.TA_SAUVEGARDE_voie(objectid);

ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_HIERARCHISATION_VOIE
ADD CONSTRAINT TA_SAUVEGARDE_HIERARCHISATION_VOIE_FID_VOIE_SECONDAIRE_FK 
FOREIGN KEY (fid_voie_secondaire)
REFERENCES G_BASE_VOIE.TA_SAUVEGARDE_voie(objectid);

-- 5. Création des index sur les clés étrangères et autres champs
CREATE INDEX TA_SAUVEGARDE_HIERARCHISATION_VOIE_FID_VOIE_PRINCIPALE_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_HIERARCHISATION_VOIE(fid_voie_principale)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_HIERARCHISATION_VOIE_FID_VOIE_SECONDAIRE_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_HIERARCHISATION_VOIE(fid_voie_secondaire)
    TABLESPACE G_ADT_INDX;

-- 6. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_SAUVEGARDE_HIERARCHISATION_VOIE TO G_ADMIN_SIG;

/

/*
La table TA_SAUVEGARDE_VOIE_LOG rassemble toutes les évolutions de chaque voie issue de TA_SAUVEGARDE_VOIE.
*/

-- 1. Création de la table TA_SAUVEGARDE_VOIE_LOG
CREATE TABLE G_BASE_VOIE.TA_SAUVEGARDE_VOIE_LOG AS 
SELECT *
FROM
    G_BASE_VOIE.TA_VOIE_LOG;

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_SAUVEGARDE_VOIE_LOG IS 'Table de sauvegarde - source créée le 17/05/2022 - rassemblant toutes les informations pour chaque voie de la base. Ancienne table : VOIEVOI';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_VOIE_LOG.objectid IS 'Clé primaire auto-incrémentée de la table. Elle remplace l''ancien identifiant ccomvoie.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_VOIE_LOG.libelle_voie IS 'Nom de la voie.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_VOIE_LOG.complement_nom_voie IS 'Complément du nom de la voie.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_VOIE_LOG.date_action IS 'Date de saisie, modification ou suppression de la voie.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_VOIE_LOG.fid_typevoie IS 'Clé étangère vers la table TA_SAUVEGARDE_TYPE_VOIE permettant de catégoriser les voies de la base.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_VOIE_LOG.fid_genre_voie IS 'Clé étrangère vers la table TA_SAUVEGARDE_LIBELLE permettant de connaître le genre du nom de la voie : masculin, féminin, neutre et non-identifié.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_VOIE_LOG.fid_rivoli IS 'Clé étrangère vers la table TA_SAUVEGARDE_FANTOIR permettant d''associer un code fantoir à chaque voie.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_VOIE_LOG.fid_voie IS 'Identifiant de tronçon de la table TA_SAUVEGARDE_VOIE permettant d''identifier la voie qui a été créée, modifiée ou supprimée.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_VOIE_LOG.fid_type_action IS 'Clé étrangère vers la table TA_SAUVEGARDE_LIBELLE, permettant d''associer un type d''action à une voie.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_VOIE_LOG.fid_pnom IS 'Clé étrangère vers la table TA_SAUVEGARDE_AGENT permettant d''associer le pnom d''un agent à la voie qu''il a créé, modifié ou supprimé.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_VOIE_LOG.fid_metadonnee IS 'Clé étrangère vers la table G_GEO.TA_SAUVEGARDE_METADONNEE permettant de connaître notamment la source et l''organisme créateur de la données.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_VOIE_LOG 
ADD CONSTRAINT TA_SAUVEGARDE_VOIE_LOG_PK 
PRIMARY KEY("OBJECTID") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_VOIE_LOG
ADD CONSTRAINT TA_SAUVEGARDE_VOIE_LOG_FID_TYPE_ACTION_FK
FOREIGN KEY (fid_type_action)
REFERENCES G_GEO.TA_SAUVEGARDE_LIBELLE(objectid);

ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_VOIE_LOG
ADD CONSTRAINT TA_SAUVEGARDE_VOIE_LOG_FID_PNOM_FK
FOREIGN KEY (fid_pnom)
REFERENCES G_BASE_VOIE.TA_SAUVEGARDE_agent(numero_agent);

ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_VOIE_LOG
ADD CONSTRAINT TA_SAUVEGARDE_VOIE_LOG_FID_METADONNEE_FK
FOREIGN KEY (fid_metadonnee)
REFERENCES G_GEO.TA_SAUVEGARDE_metadonnee(objectid);

-- 5. Création des index sur les clés étrangères et autres
CREATE INDEX TA_SAUVEGARDE_VOIE_LOG_FID_TYPEVOIE_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_VOIE_LOG(fid_voie)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_VOIE_LOG_FID_FANTOIR_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_VOIE_LOG(fid_type_action)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_VOIE_LOG_FID_GENRE_VOIE_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_VOIE_LOG(fid_pnom)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_VOIE_LOG_FID_METADONNEE_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_VOIE_LOG(fid_metadonnee)
    TABLESPACE G_ADT_INDX;

-- 6. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_SAUVEGARDE_VOIE_LOG TO G_ADMIN_SIG;

/

/*
La table TA_SAUVEGARDE_TRONCON regroupe tous les tronçons de la base voie.
*/

-- 1. Création de la table TA_SAUVEGARDE_TRONCON
CREATE TABLE G_BASE_VOIE.TA_SAUVEGARDE_TRONCON AS 
SELECT *
FROM
    G_BASE_VOIE.TA_TRONCON;

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_SAUVEGARDE_TRONCON IS 'Table de sauvegarde - source créée le 17/05/2022 - contenant les tronçons de la base voie. Les tronçons sont les objets de base de la base voie servant à constituer les rues qui elles-mêmes constituent les voies. Ancienne table : ILTATRC.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_TRONCON.objectid IS 'Clé primaire de la table identifiant chaque tronçon. Cette pk est auto-incrémentée et remplace l''ancien identifiant cnumtrc.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_TRONCON.geom IS 'Géométrie de type ligne simple de chaque tronçon.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_TRONCON.sens IS 'Code permettant de connaître le sens de saisie du tronçon par rapport au sens de la voie : + = dans le sens de la voie ; - = dans le sens inverse de la voie.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_TRONCON.ordre_troncon IS 'Ordre dans lequel les tronçons se positionnent afin de constituer la voie. 1 est égal au début de la voie et 1 + n est égal au tronçon suivant.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_TRONCON.date_saisie IS 'date de saisie du tronçon (par défaut la date du jour).';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_TRONCON.date_modification IS 'Dernière date de modification du tronçon (par défaut la date du jour).';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_TRONCON.fid_pnom_saisie IS 'Clé étrangère vers la table TA_SAUVEGARDE_AGENT permettant de récupérer le pnom de l''agent ayant créé un tronçon.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_TRONCON.fid_pnom_modification IS 'Clé étrangère vers la table TA_SAUVEGARDE_AGENT permettant de récupérer le pnom de l''agent ayant modifié un tronçon.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_TRONCON.fid_metadonnee IS 'Clé étrangère vers la table G_GEO.TA_SAUVEGARDE_METADONNEE permettant de connaître la source des tronçons (MEL ou IGN).';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_TRONCON 
ADD CONSTRAINT TA_SAUVEGARDE_TRONCON_PK 
PRIMARY KEY("OBJECTID") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des métadonnées spatiales
INSERT INTO USER_SDO_GEOM_METADATA(
    TABLE_NAME, 
    COLUMN_NAME, 
    DIMINFO, 
    SRID
)
VALUES(
    'TA_SAUVEGARDE_TRONCON',
    'geom',
    SDO_DIM_ARRAY(SDO_DIM_ELEMENT('X', 684540, 719822.2, 0.005),SDO_DIM_ELEMENT('Y', 7044212, 7078072, 0.005)), 
    2154
);

-- 5. Création de l'index spatial sur le champ geom
CREATE INDEX TA_SAUVEGARDE_TRONCON_SIDX
ON G_BASE_VOIE.TA_SAUVEGARDE_TRONCON(GEOM)
INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2
PARAMETERS('sdo_indx_dims=2, layer_gtype=LINE, tablespace=G_ADT_INDX, work_tablespace=DATA_TEMP');

-- 6. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_TRONCON
ADD CONSTRAINT TA_SAUVEGARDE_TRONCON_FID_PNOM_SAISIE_FK 
FOREIGN KEY (fid_pnom_saisie)
REFERENCES G_BASE_VOIE.TA_SAUVEGARDE_agent(numero_agent);

ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_TRONCON
ADD CONSTRAINT TA_SAUVEGARDE_TRONCON_FID_PNOM_MODIFICATION_FK
FOREIGN KEY (fid_pnom_modification)
REFERENCES G_BASE_VOIE.TA_SAUVEGARDE_agent(numero_agent);

ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_TRONCON
ADD CONSTRAINT TA_SAUVEGARDE_TRONCON_FID_METADONNEE_FK
FOREIGN KEY (fid_metadonnee)
REFERENCES G_GEO.TA_SAUVEGARDE_metadonnee(objectid);

-- 7. Création des index sur les clés étrangères et autres
CREATE INDEX TA_SAUVEGARDE_TRONCON_FID_PNOM_SAISIE_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_TRONCON(fid_pnom_saisie)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_TRONCON_FID_PNOM_MODIFICATION_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_TRONCON(fid_pnom_modification)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_TRONCON_FID_METADONNEE_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_TRONCON(fid_metadonnee)
    TABLESPACE G_ADT_INDX;

-- Cet index dispose d'une fonction permettant d'accélérer la récupération du code INSEE de la commune d'appartenance du tronçon. 
-- Il créé également un champ virtuel dans lequel on peut aller chercher ce code INSEE.
CREATE INDEX TA_SAUVEGARDE_TRONCON_CODE_INSEE_IDX
ON G_BASE_VOIE.TA_SAUVEGARDE_TRONCON(GET_CODE_INSEE_TRONCON('TA_SAUVEGARDE_TRONCON', geom))
TABLESPACE G_ADT_INDX;

-- 8. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_SAUVEGARDE_TRONCON TO G_ADMIN_SIG;

/

/*
La table TA_SAUVEGARDE_TRONCON_LOG regroupe toutes les évolutions des tronçons de la base voie situés dans TA_SAUVEGARDE_TRONCON.
*/

-- 1. Création de la table TA_SAUVEGARDE_TRONCON_LOG
CREATE TABLE G_BASE_VOIE.TA_SAUVEGARDE_TRONCON_LOG AS 
SELECT *
FROM
    G_BASE_VOIE.TA_TRONCON_LOG;

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_SAUVEGARDE_TRONCON_LOG IS 'Table de sauvegarde - source créée le 17/05/2022 - d''historisation des actions effectuées sur les tronçons de la base voie. Cette table reprend notamment le champ fid_troncon_pere de l''ancienne table ILTAFILIA.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_TRONCON_LOG.objectid IS 'Clé primaire auto-incrémentée de la table.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_TRONCON_LOG.geom IS 'Géométrie de type ligne simple de chaque tronçon.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_TRONCON_LOG.sens IS 'Code permettant de connaître le sens de saisie du tronçon par rapport au sens de la voie : + = dans le sens de la voie ; - = dans le sens inverse de la voie.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_TRONCON_LOG.ordre_troncon IS 'Ordre dans lequel les tronçons se positionnent afin de constituer la voie. 1 est égal au début de la voie et 1 + n est égal au tronçon suivant.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_TRONCON_LOG.date_action IS 'date de saisie, modification et suppression du tronçon.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_TRONCON_LOG.fid_type_action IS 'Clé étrangère vers la table TA_SAUVEGARDE_LIBELLE permettant de catégoriser le type d''action effectué sur les tronçons.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_TRONCON_LOG.fid_pnom IS 'Clé étrangère vers la table TA_SAUVEGARDE_AGENT permettant d''associer le pnom d''un agent au tronçon qu''il a créé, modifié ou supprimé.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_TRONCON_LOG.fid_troncon IS 'Clé étrangère vers la table TA_SAUVEGARDE_TRONCON permettant de savoir sur quel tronçon ont été effectué les actions.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_TRONCON_LOG.fid_troncon_pere IS 'Clé étrangère vers la table TA_SAUVEGARDE_TRONCON permettant, en cas de coupure de tronçon, de savoir quel était le tronçon original.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_TRONCON_LOG.fid_metadonnee IS 'Clé étrangère vers la table G_GEO.TA_SAUVEGARDE_METADONNEE permettant de connaître notamment la source et l''organisme créateur de la données.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_TRONCON_LOG 
ADD CONSTRAINT TA_SAUVEGARDE_TRONCON_LOG_PK 
PRIMARY KEY("OBJECTID") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des métadonnées spatiales
INSERT INTO USER_SDO_GEOM_METADATA(
    TABLE_NAME, 
    COLUMN_NAME, 
    DIMINFO, 
    SRID
)
VALUES(
    'TA_SAUVEGARDE_TRONCON_LOG',
    'geom',
    SDO_DIM_ARRAY(SDO_DIM_ELEMENT('X', 684540, 719822.2, 0.005),SDO_DIM_ELEMENT('Y', 7044212, 7078072, 0.005)), 
    2154
);

-- 5. Création de l'index spatial sur le champ geom
CREATE INDEX TA_SAUVEGARDE_TRONCON_LOG_SIDX
ON G_BASE_VOIE.TA_SAUVEGARDE_TRONCON_LOG(GEOM)
INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2
PARAMETERS('sdo_indx_dims=2, layer_gtype=LINE, tablespace=G_ADT_INDX, work_tablespace=DATA_TEMP');

-- 6. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_TRONCON_LOG
ADD CONSTRAINT TA_SAUVEGARDE_TRONCON_LOG_FID_TYPE_ACTION_FK 
FOREIGN KEY (fid_type_action)
REFERENCES G_GEO.TA_SAUVEGARDE_LIBELLE(objectid);

ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_TRONCON_LOG
ADD CONSTRAINT TA_SAUVEGARDE_TRONCON_LOG_FID_PNOM_FK
FOREIGN KEY (fid_pnom)
REFERENCES G_BASE_VOIE.TA_SAUVEGARDE_AGENT(numero_agent);

ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_TRONCON_LOG
ADD CONSTRAINT TA_SAUVEGARDE_TRONCON_LOG_FID_METADONNEE_FK
FOREIGN KEY (fid_metadonnee)
REFERENCES G_GEO.TA_SAUVEGARDE_METADONNEE(objectid);

-- 7. Création des index sur les clés étrangères
CREATE INDEX TA_SAUVEGARDE_TRONCON_LOG_FID_TRONCON_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_TRONCON_LOG(fid_troncon)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_TRONCON_LOG_FID_TRONCON_PERE_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_TRONCON_LOG(fid_troncon_pere)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_TRONCON_LOG_FID_TYPE_ACTION_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_TRONCON_LOG(fid_type_action)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_TRONCON_LOG_FID_PNOM_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_TRONCON_LOG(fid_pnom)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_TRONCON_LOG_FID_METADONNEE_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_TRONCON_LOG(fid_metadonnee)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_TRONCON_LOG_ORDRE_TRONCON_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_TRONCON_LOG(ordre_troncon)
    TABLESPACE G_ADT_INDX;
    
-- 8. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_SAUVEGARDE_TRONCON_LOG TO G_ADMIN_SIG;

/

/*
La table TA_SAUVEGARDE_SEUIL regroupe tous les seuils de la base voie.
*/

-- 1. Création de la table TA_SAUVEGARDE_SEUIL
CREATE TABLE G_BASE_VOIE.TA_SAUVEGARDE_SEUIL AS 
SELECT *
FROM
    G_BASE_VOIE.TA_SEUIL;

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_SAUVEGARDE_SEUIL IS 'Table de sauvegarde - source créée le 17/05/2022 - contenant les seuils de la Base Voie. Plusieurs seuils peuvent se situer sur le même point géographique. Ancienne table : ILTASEU';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_SEUIL.objectid IS 'Clé primaire auto-incrémentée de la table identifiant chaque seuil. Cette pk remplace l''ancien identifiant idseui.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_SEUIL.geom IS 'Géométrie de type point de chaque seuil présent dans la table.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_SEUIL.cote_troncon IS 'Côté du tronçon auquel est rattaché le seuil. G = gauche ; D = droite. En agglomération le sens des tronçons est déterminé par ses numéros de seuils. En d''autres termes il commence au niveau du seuil dont le numéro est égal à 1. Hors agglomération, le sens du tronçon dépend du sens de circulation pour les rues à sens unique. Pour les rues à double-sens chaque tronçon est doublé donc leur sens dépend aussi du sens de circulation;';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_SEUIL.code_insee IS 'Code INSEE de chaque seuil calculé à partir du référentiel des communes G_REFERENTIEL.MEL_COMMUNE_LLH.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_SEUIL.date_saisie IS 'date de saisie du seuil (par défaut la date du jour).';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_SEUIL.date_modification IS 'Dernière date de modification du seuil(par défaut la date du jour).';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_SEUIL.fid_pnom_saisie IS 'Clé étrangère vers la table TA_SAUVEGARDE_AGENT permettant de récupérer le pnom de l''agent ayant créé un seuil.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_SEUIL.fid_pnom_modification IS 'Clé étrangère vers la table TA_SAUVEGARDE_AGENT permettant de récupérer le pnom de l''agent ayant modifié un seuil.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_SEUIL.temp_idseui IS 'Champ temporaire servant à l''import des données. Ce champ sera supprimé une fois l''import terminé.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_SEUIL 
ADD CONSTRAINT TA_SAUVEGARDE_SEUIL_PK 
PRIMARY KEY("OBJECTID") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des métadonnées spatiales
INSERT INTO USER_SDO_GEOM_METADATA(
    TABLE_NAME, 
    COLUMN_NAME, 
    DIMINFO, 
    SRID
)
VALUES(
    'TA_SAUVEGARDE_SEUIL',
    'geom',
    SDO_DIM_ARRAY(SDO_DIM_ELEMENT('X', 684540, 719822.2, 0.005),SDO_DIM_ELEMENT('Y', 7044212, 7078072, 0.005)), 
    2154
);

-- 5. Création de l'index spatial sur le champ geom
CREATE INDEX TA_SAUVEGARDE_SEUIL_SIDX
ON G_BASE_VOIE.TA_SAUVEGARDE_SEUIL(GEOM)
INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2
PARAMETERS('sdo_indx_dims=2, layer_gtype=POINT, tablespace=G_ADT_INDX, work_tablespace=DATA_TEMP');

-- 6. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_SEUIL
ADD CONSTRAINT TA_SAUVEGARDE_SEUIL_FID_PNOM_SAISIE_FK
FOREIGN KEY (fid_pnom_saisie)
REFERENCES G_BASE_VOIE.TA_SAUVEGARDE_AGENT(numero_agent);

ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_SEUIL
ADD CONSTRAINT TA_SAUVEGARDE_SEUIL_FID_PNOM_MODIFICATION_FK
FOREIGN KEY (fid_pnom_modification)
REFERENCES G_BASE_VOIE.TA_SAUVEGARDE_AGENT(numero_agent);

-- 7. Création des index sur les clés étrangères et autres
CREATE INDEX TA_SAUVEGARDE_SEUIL_FID_PNOM_SAISIE_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_SEUIL(fid_pnom_saisie)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_SEUIL_FID_PNOM_MODIFICATION_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_SEUIL(fid_pnom_modification)
    TABLESPACE G_ADT_INDX;
    
-- Cet index dispose d'une fonction permettant d'accélérer la récupération du code INSEE de la commune d'appartenance du seuil. 
-- Il créé également un champ virtuel dans lequel on peut aller chercher ce code INSEE.
CREATE INDEX TA_SAUVEGARDE_SEUIL_CODE_INSEE_IDX
ON G_BASE_VOIE.TA_SAUVEGARDE_SEUIL(GET_CODE_INSEE_CONTAIN_POINT('TA_SAUVEGARDE_SEUIL', geom))
TABLESPACE G_ADT_INDX;

-- 8. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_SAUVEGARDE_SEUIL TO G_ADMIN_SIG;

/

/*
La table TA_SAUVEGARDE_SEUIL_LOG  permet d''avoir l''historique de toutes les évolutions des seuils de la base voie.
*/

-- 1. Création de la table TA_SAUVEGARDE_SEUIL_LOG
CREATE TABLE G_BASE_VOIE.TA_SAUVEGARDE_SEUIL_LOG AS 
SELECT *
FROM
    G_BASE_VOIE.TA_SEUIL_LOG;

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_SAUVEGARDE_SEUIL_LOG IS 'Table de sauvegarde - source créée le 17/05/2022 - de log de la table TA_SAUVEGARDE_SEUIL permettant d''avoir l''historique de toutes les évolutions des seuils.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_SEUIL_LOG.objectid IS 'Clé primaire auto-incrémentée de la table.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_SEUIL_LOG.geom IS 'Géométrie de type point de chaque seuil présent dans la table.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_SEUIL_LOG.cote_troncon IS 'Côté du tronçon auquel est rattaché le seuil. G = gauche ; D = droite. En agglomération le sens des tronçons est déterminé par ses numéros de seuils. En d''autres termes il commence au niveau du seuil dont le numéro est égal à 1. Hors agglomération, le sens du tronçon dépend du sens de circulation pour les rues à sens unique. Pour les rues à double-sens chaque tronçon est doublé donc leur sens dépend aussi du sens de circulation.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_SEUIL_LOG.code_insee IS 'Champ calculé via une requête spatiale, permettant d''associer à chaque seuil le code insee de la commune dans laquelle il se trouve (issue de la table G_REFERENTIEL.MEL_COMMUNES).';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_SEUIL_LOG.date_action IS 'Date de création, modification ou suppression d''un seuil.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_SEUIL_LOG.fid_type_action IS 'Clé étrangère vers la table TA_SAUVEGARDE_LIBELLE permettant de savoir quelle action a été effectuée sur le seuil.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_SEUIL_LOG.fid_seuil IS 'Clé étrangère vers la table TA_SAUVEGARDE_SEUIL permettant de savoir sur quel seuil les actions ont été entreprises.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_SEUIL_LOG.fid_pnom IS 'Clé étrangère vers la table TA_SAUVEGARDE_AGENT permettant d''associer le pnom d''un agent au seuil qu''il a créé, modifié ou supprimé.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_SEUIL_LOG 
ADD CONSTRAINT TA_SAUVEGARDE_SEUIL_LOG_PK 
PRIMARY KEY("OBJECTID") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des métadonnées spatiales
INSERT INTO USER_SDO_GEOM_METADATA(
    TABLE_NAME, 
    COLUMN_NAME, 
    DIMINFO, 
    SRID
)
VALUES(
    'TA_SAUVEGARDE_SEUIL_LOG',
    'GEOM',
    SDO_DIM_ARRAY(SDO_DIM_ELEMENT('X', 684540, 719822.2, 0.005),SDO_DIM_ELEMENT('Y', 7044212, 7078072, 0.005)), 
    2154
);

-- 5. Création de l'index spatial sur le champ geom
CREATE INDEX TA_SAUVEGARDE_SEUIL_LOG_SIDX
ON G_BASE_VOIE.TA_SAUVEGARDE_SEUIL_LOG(GEOM)
INDEXTYPE IS MDSYS.SPATIAL_INDEX_V2
PARAMETERS('sdo_indx_dims=2, layer_gtype=POINT, tablespace=G_ADT_INDX, work_tablespace=DATA_TEMP');

-- 6. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_SEUIL_LOG
ADD CONSTRAINT TA_SAUVEGARDE_SEUIL_LOG_FID_TYPE_ACTION_FK 
FOREIGN KEY (fid_type_action)
REFERENCES G_GEO.TA_SAUVEGARDE_LIBELLE(objectid);

ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_SEUIL_LOG
ADD CONSTRAINT TA_SAUVEGARDE_SEUIL_LOG_FID_PNOM_FK
FOREIGN KEY (fid_pnom)
REFERENCES G_BASE_VOIE.TA_SAUVEGARDE_agent(numero_agent);

-- 7. Création des index sur les clés étrangères et autres
CREATE INDEX TA_SAUVEGARDE_SEUIL_LOG_FID_SEUIL_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_SEUIL_LOG(fid_seuil)
    TABLESPACE G_ADT_INDX;
    
CREATE INDEX TA_SAUVEGARDE_SEUIL_LOG_FID_TYPE_ACTION_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_SEUIL_LOG(fid_type_action)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_SEUIL_LOG_FID_PNOM_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_SEUIL_LOG(fid_pnom)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_SEUIL_LOG_CODE_INSEE_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_SEUIL_LOG(code_insee)
    TABLESPACE G_ADT_INDX;

-- 8. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_SAUVEGARDE_SEUIL_LOG TO G_ADMIN_SIG;

/

/*
La table TA_SAUVEGARDE_INFOS_SEUIL regroupe le détail des seuils de la base voie.
*/

-- 1. Création de la table TA_SAUVEGARDE_INFOS_SEUIL
CREATE TABLE G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL AS 
SELECT *
FROM
    G_BASE_VOIE.TA_INFOS_SEUIL;

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL IS 'Table de sauvegarde - source créée le 17/05/2022 - contenant le détail des seuils, c''est-à-dire les numéros de seuil, de parcelles et les compléments de numéro de seuil. Cela permet d''associer un ou plusieurs seuils à un et un seul point géométrique au besoin.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL.objectid IS 'Clé primaire auto-incrémentée de la table.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL.numero_seuil IS 'Numéro de seuil.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL.numero_parcelle IS 'Numéro de parcelle issu du cadastre.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL.complement_numero_seuil IS 'Complément du numéro de seuil. Exemple : 1 bis';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL.date_saisie IS 'Date de saisie des informations du seuil (par défaut la date du jour).';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL.date_modification IS 'Date de modification des informations du seuil (par défaut la date du jour).';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL.fid_seuil IS 'Clé étrangère vers la table TA_SAUVEGARDE_SEUIL, permettant d''affecter une géométrie à un ou plusieurs seuils, dans le cas où plusieurs se superposent sur le même point.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL.fid_pnom_saisie IS 'Clé étrangère vers la table TA_SAUVEGARDE_AGENT permettant de récupérer le pnom de l''agent ayant créé les informations d''un seuil.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL.fid_pnom_modification IS 'Clé étrangère vers la table TA_SAUVEGARDE_AGENT permettant de récupérer le pnom de l''agent ayant modifié les informations d''un seuil.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL 
ADD CONSTRAINT TA_SAUVEGARDE_INFOS_SEUIL_PK 
PRIMARY KEY("OBJECTID") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL
ADD CONSTRAINT TA_SAUVEGARDE_INFOS_SEUIL_FID_SEUIL_FK 
FOREIGN KEY (fid_seuil)
REFERENCES G_BASE_VOIE.TA_SAUVEGARDE_seuil(objectid);

ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL
ADD CONSTRAINT TA_SAUVEGARDE_INFOS_SEUIL_FID_PNOM_SAISIE_FK 
FOREIGN KEY (fid_pnom_saisie)
REFERENCES G_BASE_VOIE.TA_SAUVEGARDE_agent(numero_agent);

ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL
ADD CONSTRAINT TA_SAUVEGARDE_INFOS_SEUIL_FID_PNOM_MODIFICATION_FK
FOREIGN KEY (fid_pnom_modification)
REFERENCES G_BASE_VOIE.TA_SAUVEGARDE_agent(numero_agent);

-- 5. Création des index sur les clés étrangères et autres champs
CREATE INDEX TA_SAUVEGARDE_INFOS_SEUIL_FID_SEUIL_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL(fid_seuil)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_INFOS_SEUIL_FID_PNOM_SAISIE_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL(fid_pnom_saisie)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_INFOS_SEUIL_FID_PNOM_MODIFICATION_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL(fid_pnom_modification)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_INFOS_SEUIL_NUMERO_SEUIL_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL(numero_seuil)
    TABLESPACE G_ADT_INDX;

-- 6. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL TO G_ADMIN_SIG;

/

/*
La table TA_SAUVEGARDE_INFOS_SEUIL_LOG regroupe toutes les évlutions des objets présents dans la table TA_SAUVEGARDE_INFOS_SEUIL de la base voie.
*/

-- 1. Création de la table TA_SAUVEGARDE_INFOS_SEUIL_LOG
CREATE TABLE G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL_LOG AS 
SELECT *
FROM
    G_BASE_VOIE.TA_INFOS_SEUIL_LOG;

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL_LOG IS 'Table de sauvegarde - source créée le 17/05/2022 - de log permettant d''enregistrer toutes les évlutions des objets présents dans la table TA_SAUVEGARDE_INFOS_SEUIL.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL_LOG.objectid IS 'Clé primaire auto-incrémentée de la table.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL_LOG.numero_seuil IS 'Numéro de seuil.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL_LOG.numero_parcelle IS 'Numéro de parcelle issu du cadastre.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL_LOG.complement_numero_seuil IS 'Complément du numéro de seuil. Exemple : 1 bis';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL_LOG.date_action IS 'Date de chaque action effectuée sur les objets de la table TA_SAUVEGARDE_INFOS_SEUILS.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL_LOG.fid_infos_seuil IS 'Identifiant du seuil dans la table TA_SAUVEGARDE_INFOS_SEUIL.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL_LOG.fid_seuil IS 'Identifiant de la table TA_SAUVEGARDE_SEUIL, permettant d''affecter une géométrie à un ou plusieurs seuils, dans le cas où plusieurs se superposent sur le même point.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL_LOG.fid_type_action IS 'Clé étrangère vers la table TA_SAUVEGARDE_LIBELLE permettant de catégoriser les actions effectuées sur la table TA_SAUVEGARDE_INFOS_SEUIL.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL_LOG.fid_pnom IS 'Clé étrangère vers la table TA_SAUVEGARDE_AGENT permettant de récupérer le pnom de l''agent ayant créé, modifié ou supprimé des données dans TA_SAUVEGARDE_INFOS_SEUIL.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL_LOG 
ADD CONSTRAINT TA_SAUVEGARDE_INFOS_SEUIL_LOG_PK 
PRIMARY KEY("OBJECTID") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL_LOG
ADD CONSTRAINT TA_SAUVEGARDE_INFOS_SEUIL_LOG_FID_TYPE_ACTION_FK 
FOREIGN KEY (fid_type_action)
REFERENCES G_GEO.TA_SAUVEGARDE_LIBELLE(objectid);

ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL_LOG
ADD CONSTRAINT TA_SAUVEGARDE_INFOS_SEUIL_LOG_FID_PNOM_FK
FOREIGN KEY (fid_pnom)
REFERENCES G_BASE_VOIE.TA_SAUVEGARDE_agent(numero_agent);

-- 5. Création des index sur les clés étrangères et les autres champs
CREATE INDEX TA_SAUVEGARDE_INFOS_SEUIL_LOG_FID_TYPE_ACTION_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL_LOG(fid_type_action)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_INFOS_SEUIL_LOG_FID_PNOM_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL_LOG(fid_pnom)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_INFOS_SEUIL_LOG_FID_INFOS_SEUIL_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL_LOG(fid_infos_seuil)
    TABLESPACE G_ADT_INDX;

-- 6. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_SAUVEGARDE_INFOS_SEUIL_LOG TO G_ADMIN_SIG;

/

/*
La table TA_SAUVEGARDE_POINT_INTERET regroupe toutes les géométries des point d''intérêts de la base voie.
*/

-- 1. Création de la table TA_SAUVEGARDE_POINT_INTERET
CREATE TABLE G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET AS 
SELECT *
FROM
    G_BASE_VOIE.TA_POINT_INTERET;

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET IS 'Table de sauvegarde - source créée le 17/05/2022 - regroupant toutes les géométries des points d''intérêt de type mairie ou mairie de quartier. Ancienne table : ILTALPU.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET.objectid IS 'Clé primaire auto-incrémentée de la table identifiant chaque point d''intérêt. Cette pk remplace l''ancien identifiant cnumlpu.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET.geom IS 'Géométrie de type point de chaque point d''intérêt présent dans la table.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET.date_saisie IS 'Date de saisie du point d''intérêt (par défaut il s''agit de la date du jour).';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET.date_modification IS 'Dernière date de modification du point d''intérêt (par défaut il s''agit de la date du jour).';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET.fid_pnom_saisie IS 'Clé étrangère vers la table TA_SAUVEGARDE_AGENT permettant de récupérer le pnom de l''agent ayant créé un point d''intérêt.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET.fid_pnom_modification IS 'Clé étrangère vers la table TA_SAUVEGARDE_AGENT permettant de récupérer le pnom de l''agent ayant modifié un point d''intérêt.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET.temp_idpoi IS 'Champ temporaire permettant de stocker l''identifiant de chaque POI et de faire la migration. A l''issue de cette dernière, ce champ doit être supprimé.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET 
ADD CONSTRAINT TA_SAUVEGARDE_POINT_INTERET_PK 
PRIMARY KEY("OBJECTID") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des métadonnées spatiales
INSERT INTO USER_SDO_GEOM_METADATA(
    TABLE_NAME, 
    COLUMN_NAME, 
    DIMINFO, 
    SRID
)
VALUES(
    'TA_SAUVEGARDE_POINT_INTERET',
    'geom',
    SDO_DIM_ARRAY(SDO_DIM_ELEMENT('X', 684540, 719822.2, 0.005),SDO_DIM_ELEMENT('Y', 7044212, 7078072, 0.005)), 
    2154
);

-- 5. Création de l'index spatial sur le champ geom
CREATE INDEX TA_SAUVEGARDE_POINT_INTERET_SIDX
ON G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET(GEOM)
INDEXTYPE IS MDSYS.SPATIAL_INDEX
PARAMETERS('sdo_indx_dims=2, layer_gtype=POINT, tablespace=G_ADT_INDX, work_tablespace=DATA_TEMP');

-- 6. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET
ADD CONSTRAINT TA_SAUVEGARDE_POINT_INTERET_FID_PNOM_SAISIE_FK
FOREIGN KEY (fid_pnom_saisie)
REFERENCES G_BASE_VOIE.TA_SAUVEGARDE_AGENT(numero_agent);

ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET
ADD CONSTRAINT TA_SAUVEGARDE_POINT_INTERET_FID_PNOM_MODIFICATION_FK
FOREIGN KEY (fid_pnom_modification)
REFERENCES G_BASE_VOIE.TA_SAUVEGARDE_AGENT(numero_agent);

-- 7. Création des index sur les clés étrangères et autres
CREATE INDEX TA_SAUVEGARDE_POINT_INTERET_FID_PNOM_SAISIE_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET(fid_pnom_saisie)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_POINT_INTERET_FID_PNOM_MODIFICATION_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET(fid_pnom_modification)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_POINT_INTERET_CODE_INSEE_IDX
ON G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET(GET_CODE_INSEE_CONTAIN_POINT('TA_SAUVEGARDE_POINT_INTERET', geom))
TABLESPACE G_ADT_INDX;

-- 8. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET TO G_ADMIN_SIG;

/

/*
La table TA_SAUVEGARDE_POINT_INTERET_LOG  permet d''avoir l''historique de toutes les évolutions des seuils de la base voie.
*/

-- 1. Création de la table TA_SAUVEGARDE_POINT_INTERET_LOG
CREATE TABLE G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET_LOG AS 
SELECT *
FROM
    G_BASE_VOIE.TA_POINT_INTERET_LOG;

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET_LOG IS 'Table de sauvegarde - source créée le 17/05/2022 - de log de la table TA_SAUVEGARDE_POINT_INTERET permettant d''avoir l''historique de toutes les évolutions des POI.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET_LOG.objectid IS 'Clé primaire auto-incrémentée de la table.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET_LOG.geom IS 'Géométrie de type point de chaque objet de la table.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET_LOG.fid_point_interet IS 'Identifiant de la table TA_SAUVEGARDE_POINT_INTERET permettant de savoir sur quel POI les actions ont été entreprises.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_SEUIL_LOG.code_insee IS 'Champ permettant d''associer à chaque POI le code insee de la commune dans laquelle il se trouve (issue de la table G_REFERENTIEL.MEL_COMMUNES).';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET_LOG.date_action IS 'Date de création, modification ou suppression d''un POI.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET_LOG.fid_type_action IS 'Clé étrangère vers la table TA_SAUVEGARDE_LIBELLE permettant de savoir quelle action a été effectuée sur le POI.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET_LOG.fid_pnom IS 'Clé étrangère vers la table TA_SAUVEGARDE_AGENT permettant d''associer le pnom d''un agent au POI qu''il a créé, modifié ou supprimé.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET_LOG 
ADD CONSTRAINT TA_SAUVEGARDE_POINT_INTERET_LOG_PK 
PRIMARY KEY("OBJECTID") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des métadonnées spatiales
INSERT INTO USER_SDO_GEOM_METADATA(
    TABLE_NAME, 
    COLUMN_NAME, 
    DIMINFO, 
    SRID
)
VALUES(
    'TA_SAUVEGARDE_POINT_INTERET_LOG',
    'geom',
    SDO_DIM_ARRAY(SDO_DIM_ELEMENT('X', 684540, 719822.2, 0.005),SDO_DIM_ELEMENT('Y', 7044212, 7078072, 0.005)), 
    2154
);

-- 5. Création de l'index spatial sur le champ geom
CREATE INDEX TA_SAUVEGARDE_POINT_INTERET_LOG_SIDX
ON G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET_LOG(GEOM)
INDEXTYPE IS MDSYS.SPATIAL_INDEX
PARAMETERS('sdo_indx_dims=2, layer_gtype=POINT, tablespace=G_ADT_INDX, work_tablespace=DATA_TEMP');

-- 6. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET_LOG
ADD CONSTRAINT TA_SAUVEGARDE_POINT_INTERET_LOG_FID_TYPE_ACTION_FK 
FOREIGN KEY (fid_type_action)
REFERENCES G_GEO.TA_SAUVEGARDE_LIBELLE(objectid);

ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET_LOG
ADD CONSTRAINT TA_SAUVEGARDE_POINT_INTERET_LOG_FID_PNOM_FK
FOREIGN KEY (fid_pnom)
REFERENCES G_BASE_VOIE.TA_SAUVEGARDE_agent(numero_agent);

-- 7. Création des index sur les clés étrangères et autres champs
CREATE INDEX TA_SAUVEGARDE_POINT_INTERET_LOG_fid_point_interet_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET_LOG(fid_point_interet)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_POINT_INTERET_LOG_FID_TYPE_ACTION_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET_LOG(fid_type_action)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_POINT_INTERET_LOG_FID_PNOM_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET_LOG(fid_pnom)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_POINT_INTERET_LOG_CODE_INSEE_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET_LOG(code_insee)
    TABLESPACE G_ADT_INDX;

-- 8. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET_LOG TO G_ADMIN_SIG;

/

/*
La table TA_SAUVEGARDE_INFOS_POINT_INTERET regroupe tous les point d''intérêts de la base voie.
*/

-- 1. Création de la table TA_SAUVEGARDE_INFOS_POINT_INTERET
CREATE TABLE G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET AS 
SELECT *
FROM
    G_BASE_VOIE.TA_INFOS_POINT_INTERET;

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET IS 'Table de sauvegarde - source créée le 17/05/2022 - contenant les informations de tous les points d''intérêts que nous gérons, c''est-à-dire les mairies et les mairies annexes. Ancienne table : ILTALPU.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET.objectid IS 'Clé primaire auto-incrémentée de la table identifiant chaque point d''intérêt. Cette pk remplace l''ancien identifiant cnumlpu.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET.nom IS 'Nom du Point d''intérêt correspondant au champ CLIBLPU de l''ancienne table ILTALPU.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET.complement_infos IS 'Complément d''informations du point d''intérêt.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET.date_saisie IS 'Date de saisie du point d''intérêt (par défaut il s''agit de la date du jour).';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET.date_modification IS 'Dernière date de modification du point d''intérêt (par défaut il s''agit de la date du jour).';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET.fid_libelle IS 'Clé étrangère vers la table TA_SAUVEGARDE_AGENT permettant de récupérer le pnom de l''agent ayant créé un point d''intérêt.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET.fid_point_interet IS 'Clé étrangère vers la table TA_SAUVEGARDE_POINT_INTERET permettant d''associer un POI à sa géométrie.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET.fid_pnom_saisie IS 'Clé étrangère vers la table TA_SAUVEGARDE_AGENT permettant de récupérer le pnom de l''agent ayant créé un point d''intérêt.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET.fid_pnom_modification IS 'Clé étrangère vers la table TA_SAUVEGARDE_AGENT permettant de récupérer le pnom de l''agent ayant modifié un point d''intérêt.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET 
ADD CONSTRAINT TA_SAUVEGARDE_INFOS_POINT_INTERET_PK 
PRIMARY KEY("OBJECTID") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 6. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET
ADD CONSTRAINT TA_SAUVEGARDE_INFOS_POINT_INTERET_FID_PNOM_SAISIE_FK
FOREIGN KEY (fid_pnom_saisie)
REFERENCES G_BASE_VOIE.TA_SAUVEGARDE_AGENT(numero_agent);

ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET
ADD CONSTRAINT TA_SAUVEGARDE_INFOS_POINT_INTERET_FID_PNOM_MODIFICATION_FK
FOREIGN KEY (fid_pnom_modification)
REFERENCES G_BASE_VOIE.TA_SAUVEGARDE_AGENT(numero_agent);

ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET
ADD CONSTRAINT TA_SAUVEGARDE_INFOS_POINT_INTERET_FID_LIBELLE_FK
FOREIGN KEY (fid_libelle)
REFERENCES G_GEO.TA_SAUVEGARDE_LIBELLE(objectid);

ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET
ADD CONSTRAINT TA_SAUVEGARDE_INFOS_POINT_INTERET_FID_POINT_INTERET_FK
FOREIGN KEY (fid_point_interet)
REFERENCES G_BASE_VOIE.TA_SAUVEGARDE_POINT_INTERET(objectid);

-- 7. Création des index sur les clés étrangères
CREATE INDEX TA_SAUVEGARDE_INFOS_POINT_INTERET_FID_PNOM_SAISIE_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET(fid_pnom_saisie)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_INFOS_POINT_INTERET_FID_PNOM_MODIFICATION_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET(fid_pnom_modification)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_INFOS_POINT_INTERET_FID_LIBELLE_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET(fid_libelle)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_INFOS_POINT_INTERET_FID_INFOS_POINT_INTERET_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET(fid_point_interet)
    TABLESPACE G_ADT_INDX;

-- 8. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET TO G_ADMIN_SIG;

/

/*
La table TA_SAUVEGARDE_INFOS_POINT_INTERET_LOG  permet d''avoir l''historique de toutes les évolutions des seuils de la base voie.
*/

-- 1. Création de la table TA_SAUVEGARDE_INFOS_POINT_INTERET_LOG
CREATE TABLE G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET_LOG AS 
SELECT *
FROM
    G_BASE_VOIE.TA_INFOS_POINT_INTERET_LOG;

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET_LOG IS 'Table de sauvegarde - source créée le 17/05/2022 - d''historisation des actions effectuées sur les POI de la base voie.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET_LOG.objectid IS 'Clé primaire auto-incrémentée de la table.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET_LOG.complement_infos IS 'Complément d''informations du point d''intérêt.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET_LOG.nom IS 'Nom du point d''intérêt correspondant au champ CLIBLPU de l''ancienne table ILTALPU.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET_LOG.date_action IS 'Date de création, modification ou suppression d''un POI.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET_LOG.fid_infos_point_interet IS 'Identifiant de la table TA_SAUVEGARDE_INFOS_POINT_INTERET permettant de savoir sur quel POI les actions ont été entreprises.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET_LOG.fid_point_interet IS 'Identifiant de la table TA_SAUVEGARDE_POINT_INTERET permettant de relier la géométrie du point d''intérêt (TA_SAUVEGARDE_POINT_INTERET) à ses informations.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET_LOG.fid_libelle IS 'Identifiant de la table TA_SAUVEGARDE_LIBELLE permettant de connaître le type de chaque POI (point d''intérêt).';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET_LOG.fid_type_action IS 'Clé étrangère vers la table TA_SAUVEGARDE_LIBELLE permettant de savoir quelle action a été effectuée sur le POI.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET_LOG.fid_pnom IS 'Clé étrangère vers la table TA_SAUVEGARDE_AGENT permettant d''associer le pnom d''un agent au POI qu''il a créé, modifié ou supprimé.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET_LOG 
ADD CONSTRAINT TA_SAUVEGARDE_INFOS_POINT_INTERET_LOG_PK 
PRIMARY KEY("OBJECTID") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET_LOG
ADD CONSTRAINT TA_SAUVEGARDE_INFOS_POINT_INTERET_LOG_FID_TYPE_ACTION_FK 
FOREIGN KEY (fid_type_action)
REFERENCES G_GEO.TA_SAUVEGARDE_LIBELLE(objectid);

ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET_LOG
ADD CONSTRAINT TA_SAUVEGARDE_INFOS_POINT_INTERET_LOG_FID_PNOM_FK
FOREIGN KEY (fid_pnom)
REFERENCES G_BASE_VOIE.TA_SAUVEGARDE_agent(numero_agent);

-- 5. Création des index sur les clés étrangères et autres champs
CREATE INDEX TA_SAUVEGARDE_INFOS_POINT_INTERET_LOG_FID_INFOS_POINT_INTERET_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET_LOG(fid_infos_point_interet)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_INFOS_POINT_INTERET_LOG_FID_POINT_INTERET_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET_LOG(fid_point_interet)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_INFOS_POINT_INTERET_LOG_FID_TYPE_ACTION_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET_LOG(fid_type_action)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_INFOS_POINT_INTERET_LOG_FID_PNOM_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET_LOG(fid_pnom)
    TABLESPACE G_ADT_INDX;

-- 6. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_SAUVEGARDE_INFOS_POINT_INTERET_LOG TO G_ADMIN_SIG;

/

/*
La table TA_SAUVEGARDE_RELATION_TRONCON_SEUIL fait la relation entre les tronçons de la table TA_SAUVEGARDE_TRONCON et les seuils de la table TA_SAUVEGARDE_SEUIl qui s''y rattachent dans la base voie.
*/

-- 1. Création de la table TA_SAUVEGARDE_RELATION_TRONCON_SEUIL
CREATE TABLE G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_SEUIL AS 
SELECT *
FROM
    G_BASE_VOIE.TA_RELATION_TRONCON_SEUIL;

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_SEUIL IS 'Table pivot de sauvegarde - source créée le 17/05/2022 - faisant la relation entre les tronçons de la table TA_SAUVEGARDE_TRONCON et les seuils de la table TA_SAUVEGARDE_SEUIl qui s''y rattachent. Ancienne table : ILTASIT.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_SEUIL.fid_troncon IS 'Clé primaire et étrangère vers la table TA_SAUVEGARDE_TRONCON permettant d''asocier un tronçons aux seuils.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_SEUIL.fid_seuil IS 'Clé primaire et clé étrangère vers la table TA_SAUVEGARDE_SEUIL permettant d''associer un ou plusieurs seuils à un tronçon.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_SEUIL 
ADD CONSTRAINT TA_SAUVEGARDE_RELATION_TRONCON_SEUIL_PK 
PRIMARY KEY("FID_TRONCON", "FID_SEUIL") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_SEUIL
ADD CONSTRAINT TA_SAUVEGARDE_RELATION_TRONCON_SEUIL_FID_TRONCON_FK 
FOREIGN KEY (fid_troncon)
REFERENCES G_BASE_VOIE.TA_SAUVEGARDE_TRONCON(objectid);

ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_SEUIL
ADD CONSTRAINT TA_SAUVEGARDE_RELATION_TRONCON_SEUIL_FID_SEUIL_FK
FOREIGN KEY (fid_seuil)
REFERENCES G_BASE_VOIE.TA_SAUVEGARDE_SEUIL(objectid);

-- 5. Création des index sur les clés étrangères
CREATE INDEX TA_SAUVEGARDE_RELATION_TRONCON_SEUIL_FID_TRONCON_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_SEUIL(fid_troncon)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_RELATION_TRONCON_SEUIL_FID_SEUIL_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_SEUIL(fid_seuil)
    TABLESPACE G_ADT_INDX;

-- 6. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_SEUIL TO G_ADMIN_SIG;

/

/*
La table TA_SAUVEGARDE_RELATION_TRONCON_VOIE regroupant tous les types et états permettant de catégoriser les objets de la base voie.
*/

-- 1. Création de la table TA_SAUVEGARDE_RELATION_TRONCON_VOIE
CREATE TABLE G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE AS 
SELECT *
FROM
    G_BASE_VOIE.TA_RELATION_TRONCON_VOIE;

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE IS 'Table pivot de sauvegarde - source créée le 17/05/2022 - permettant d''associer les tronçons de la table TA_SAUVEGARDE_TRONCON à leur voie présente dans TA_SAUVEGARDE_VOIE. Ancienne table : VOIECVT.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE.objectid IS 'Clé primaire auto-incrémentée de la table.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE.sens IS 'Code permettant de connaître le sens du tronçon. Ancien champ : CCODSTR. A préciser avec Marie-Hélène, car les valeurs ne sont pas compréhensibles sans documentation.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE.ordre_troncon IS 'Ordre dans lequel les tronçons se positionnent afin de contituer la voie. 1 est égal au début de la voie et 1 + n est égal au tronçon suivant.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE.fid_voie IS 'Clé étrangère vers la table TA_SAUVEGARDE_VOIE permettant d''associer une voie à un ou plusieurs tronçons. Ancien champ : CCOMVOI.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE.fid_troncon IS 'Clé étrangère vers la table TA_SAUVEGARDE_TRONCON permettant d''associer un ou plusieurs tronçons à une voie. Ancien champ : CNUMTRC.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE.date_saisie IS 'Date de saisie de la relation troncon/voie en base (par défaut la date du jour).';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE.date_modification IS 'Date de la dernière modification de la relation troncon/voie en base (par défaut la date du jour).';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE.fid_pnom_saisie IS 'Clé étrangère vers la table TA_SAUVEGARDE_AGENT permettant de récupérer le pnom de l''agent ayant créé la relation.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE.fid_pnom_modification IS 'Clé étrangère vers la table TA_SAUVEGARDE_AGENT permettant de récupérer le pnom de l''agent ayant modifié la relation.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE 
ADD CONSTRAINT TA_SAUVEGARDE_RELATION_TRONCON_VOIE_PK 
PRIMARY KEY("OBJECTID") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE
ADD CONSTRAINT TA_SAUVEGARDE_RELATION_TRONCON_VOIE_FID_VOIE_FK
FOREIGN KEY (fid_voie)
REFERENCES G_BASE_VOIE.TA_SAUVEGARDE_voie(objectid);

ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE
ADD CONSTRAINT TA_SAUVEGARDE_RELATION_TRONCON_VOIE_FID_TRONCON_FK
FOREIGN KEY (fid_troncon)
REFERENCES G_BASE_VOIE.TA_SAUVEGARDE_troncon(objectid);

-- 5. Création des index sur les clés étrangères
CREATE INDEX TA_SAUVEGARDE_RELATION_TRONCON_VOIE_FID_VOIE_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE(fid_voie)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_RELATION_TRONCON_VOIE_FID_TRONCON_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE(fid_troncon)
    TABLESPACE G_ADT_INDX;

-- 6. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE TO G_ADMIN_SIG;

/

/*
La table TA_SAUVEGARDE_RELATION_TRONCON_VOIE_LOG regroupant tous les types et états permettant de catégoriser les objets de la base voie.
*/

-- 1. Création de la table TA_SAUVEGARDE_RELATION_TRONCON_VOIE_LOG
CREATE TABLE G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE_LOG AS 
SELECT *
FROM
    G_BASE_VOIE.TA_RELATION_TRONCON_VOIE_LOG;

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE_LOG IS 'Table de log de sauvegarde - source créée le 17/05/2022 - enregistrant l''évolution des associations voies / tronçons.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE_LOG.objectid IS 'Clé primaire auto-incrémentée de la table.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE_LOG.sens IS 'Code permettant de connaître le sens du tronçon. Ancien champ : CCODSTR Il s''agit du sens de codage du tronçon qui suit l''ordre de numération des seuils.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE_LOG.ordre_troncon IS 'Ordre dans lequel les tronçons se positionnent afin de contituer la voie. 1 est égal au début de la voie et 1 + n est égal au tronçon suivant.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE_LOG.date_action IS 'Date de création, modification ou suppression de la voie avec ce tronçon.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE_LOG.fid_relation_troncon_voie IS 'Clé étrangère vers la table TA_SAUVEGARDE_RELATION_TRONCON_VOIE permettant d''identifier les relations tronçon/voies.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE_LOG.fid_voie IS 'Identifiant des voies permettant d''associer une voie à un ou plusieurs tronçons. Ancien champ : CCOMVOI.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE_LOG.fid_troncon IS 'Identifiant des tronçons permettant d''associer un ou plusieurs tronçons à une voie. Ancien champ : CNUMTRC.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE_LOG.fid_type_action IS 'Clé étrangère vers la table TA_SAUVEGARDE_LIBELLE permettant de savoir quelle action a été effectuée sur l''association tronçon / voie.';
COMMENT ON COLUMN G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE_LOG.fid_pnom IS 'Clé étrangère vers la table TA_SAUVEGARDE_AGENT permettant d''associer le pnom d''un agent à l''association voie / tronçon qu''il a créé, modifié ou supprimé.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE_LOG 
ADD CONSTRAINT TA_SAUVEGARDE_RELATION_TRONCON_VOIE_LOG_PK 
PRIMARY KEY("OBJECTID") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE_LOG
ADD CONSTRAINT TA_SAUVEGARDE_RELATION_TRONCON_VOIE_LOG_FID_TYPE_ACTION_FK
FOREIGN KEY (fid_type_action)
REFERENCES G_GEO.TA_SAUVEGARDE_LIBELLE(objectid);

ALTER TABLE G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE_LOG
ADD CONSTRAINT TA_SAUVEGARDE_RELATION_TRONCON_VOIE_LOG_FID_PNOM_FK
FOREIGN KEY (fid_pnom)
REFERENCES G_BASE_VOIE.TA_SAUVEGARDE_agent(numero_agent);

-- 5. Création des index sur les clés étrangères et autre
CREATE INDEX TA_SAUVEGARDE_RELATION_TRONCON_VOIE_LOG_FID_RELATION_TRONCON_VOIE_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE_LOG(fid_relation_troncon_voie)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_RELATION_TRONCON_VOIE_LOG_FID_TYPE_ACTION_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE_LOG(fid_type_action)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_SAUVEGARDE_RELATION_TRONCON_VOIE_LOG_FID_PNOM_IDX ON G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE_LOG(fid_pnom)
    TABLESPACE G_ADT_INDX;

-- 6. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_SAUVEGARDE_RELATION_TRONCON_VOIE_LOG TO G_ADMIN_SIG;

/

