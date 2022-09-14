/*
SEQ_TEMP_C_TRONCON_OBJECTID : création de la séquence d'auto-incrémentation de la clé primaire de la table TEMP_C_TRONCON
*/

CREATE SEQUENCE SEQ_TEMP_C_TRONCON_OBJECTID START WITH 1 INCREMENT BY 1;

/

/*
La table TEMP_C_AGENT - du projet C de correction de la latéralité des voies - liste les pnoms de tous les agents ayant travaillés et qui travaillent encore pour la base voie.
*/

-- 1. Création de la table TEMP_C_AGENT
CREATE TABLE G_BASE_VOIE.TEMP_C_AGENT(
    numero_agent NUMBER(38,0) NOT NULL,
    pnom VARCHAR2(50) NOT NULL,
    validite NUMBER(1) NOT NULL
);

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TEMP_C_AGENT IS 'Table temporaire - du projet C de correction de la latéralité des voies - listant les pnoms de tous les agents ayant travaillés et qui travaillent encore pour la base voie.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_AGENT.numero_agent IS 'Numéro d''agent présent sur la carte de chaque agent.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_AGENT.pnom IS 'Pnom de l''agent, c''est-à-dire la concaténation de l''initiale de son prénom et de son nom entier.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_AGENT.validite IS 'Validité de l''agent, c''est-à-dire que ce champ permet de savoir si l''agent continue de travailler dans/pour la base voie ou non : 1 = oui ; 0 = non.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TEMP_C_AGENT 
ADD CONSTRAINT TEMP_C_AGENT_PK 
PRIMARY KEY("NUMERO_AGENT") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TEMP_C_AGENT TO G_ADMIN_SIG;

/

/*
La table TEMP_C_LIBELLE - du projet C de correction de la latéralité des voies - liste les types et états permettant de catégoriser les objets de la base voie.
*/

-- 1. Création de la table TEMP_C_LIBELLE
CREATE TABLE G_BASE_VOIE.TEMP_C_LIBELLE(
    objectid NUMBER(38,0) GENERATED BY DEFAULT AS IDENTITY,
    libelle_court VARCHAR2(100 BYTE),
    libelle_long VARCHAR2(4000 BYTE)
);

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TEMP_C_LIBELLE IS 'Table - du projet C de correction de la latéralité des voies - listant les types et états permettant de catégoriser les objets de la base voie.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_LIBELLE.objectid IS 'Clé primaire auto-incrémentée de la table.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_LIBELLE.libelle_court IS 'Valeur courte pouvant être prise par un libellé de la nomenclature de la base voie.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_LIBELLE.libelle_long IS 'Valeur longue pouvant être prise par un libellé de la nomenclature de la base voie.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TEMP_C_LIBELLE 
ADD CONSTRAINT TEMP_C_LIBELLE_PK 
PRIMARY KEY("OBJECTID") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 7. Création des index sur les clés étrangères et autres
CREATE INDEX TEMP_C_LIBELLE_LIBELLE_COURT_IDX ON G_BASE_VOIE.TEMP_C_LIBELLE(libelle_court)
    TABLESPACE G_ADT_INDX;

-- 8. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TEMP_C_LIBELLE TO G_ADMIN_SIG;

/

/*
La table TEMP_C_TYPE_VOIE - du projet C de correction de la latéralité des voies - regroupe tous les types de voies de la base voie tels que les avenues, boulevards, rues, senteir, etc.
*/

-- 1. Création de la table TEMP_C_TYPE_VOIE
CREATE TABLE G_BASE_VOIE.TEMP_C_TYPE_VOIE(
    objectid NUMBER(38,0) GENERATED BY DEFAULT AS IDENTITY,
    code_type_voie CHAR(4) NULL,
    libelle VARCHAR2(100) NULL   
);

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TEMP_C_TYPE_VOIE IS 'Table - du projet C de correction de la latéralité des voies - rassemblant tous les types de voies présents dans la base voie. Ancienne table : TYPEVOIE.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_TYPE_VOIE.objectid IS 'Clé primaire auto-incrémentée de la table.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_TYPE_VOIE.code_type_voie IS 'Code des types de voie présents dans la base voie. Ce champ remplace le champ CCODTVO.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_TYPE_VOIE.libelle IS 'Libellé des types de voie. Exemple : Boulevard, avenue, reu, sentier, etc.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TEMP_C_TYPE_VOIE 
ADD CONSTRAINT TEMP_C_TYPE_VOIE_PK 
PRIMARY KEY("OBJECTID") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 5. Création des index
CREATE INDEX TEMP_C_TYPE_VOIE_CODE_TYPE_VOIE_IDX ON G_BASE_VOIE.TEMP_C_TYPE_VOIE(code_type_voie)
    TABLESPACE G_ADT_INDX;

-- 6. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TEMP_C_TYPE_VOIE TO G_ADMIN_SIG;

/

/*
La table TEMP_C_VOIE_PHYSIQUE - du projet C de correction de la latéralité des voies - rassemblant les identifiant de toutes les voies PHYSIQUES.
En opposition aux voies administratives : une voie physique peut correspondre à deux voies administratives si elle appartient à deux communes différentes 
et une ou plusieurs voies physiques peuvent appartenir à une et une seule voie administrative.
*/

-- 1. Création de la table TEMP_C_VOIE_PHYSIQUE
CREATE TABLE G_BASE_VOIE.TEMP_C_VOIE_PHYSIQUE(
    objectid NUMBER(38,0) GENERATED BY DEFAULT AS IDENTITY
);

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TEMP_C_VOIE_PHYSIQUE IS 'Table - du projet C de correction de la latéralité des voies - rassemblant les identifiant de toutes les voies PHYSIQUES (en opposition aux voies administratives : une voie physique peut correspondre à deux voies administratives si elle appartient à deux communes différentes et une ou plusieurs voies physiques peuvent appartenir à une et une seule voie administrative).';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_VOIE_PHYSIQUE.objectid IS 'Clé primaire auto-incrémentée de la table (ses identifiants ne reprennent PAS ceux de VOIEVOI).';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TEMP_C_VOIE_PHYSIQUE 
ADD CONSTRAINT TEMP_C_VOIE_PHYSIQUE_PK 
PRIMARY KEY("OBJECTID") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 6. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TEMP_C_VOIE_PHYSIQUE TO G_ADMIN_SIG;

/

/*
La table TEMP_C_VOIE_ADMINISTRATIVE - du projet C de correction de la latéralité des voies - rassemblant les informations de chaque voie et notamment leurs libellés et leur latéralité : une voie physique peut avoir deux noms différents (à gauche et à droite) si elle traverse deux communes différentes.
*/

-- 1. Création de la table TEMP_C_VOIE_ADMINISTRATIVE
CREATE TABLE G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE(
    objectid NUMBER(38,0) GENERATED BY DEFAULT AS IDENTITY,
    genre_voie VARCHAR2(50 BYTE),
    libelle_voie VARCHAR2(1000 BYTE),
    complement_nom_voie VARCHAR2(200),
    fid_lateralite NUMBER(38,0),
    code_insee VARCHAR2(5),
    date_saisie DATE,
    date_modification DATE,
    fid_pnom_saisie NUMBER(38,0),
    fid_pnom_modification NUMBER(38,0),
--    fid_voie_physique NUMBER(38,0),
    fid_type_voie NUMBER(38,0)
);

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE IS 'Table - du projet C de correction de la latéralité des voies - rassemblant les informations de chaque voie et notamment leurs libellés et leur latéralité : une voie physique peut avoir deux noms différents (à gauche et à droite) si elle traverse deux communes différentes.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE.objectid IS 'Clé primaire auto-incrémentée de la table. Elle remplace l''ancien identifiant ccomvoie.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE.genre_voie IS 'Genre du nom de la voie (féminin, masculin, neutre, etc).';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE.libelle_voie IS 'Nom de voie.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE.complement_nom_voie IS 'Complément de nom de voie.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE.code_insee IS 'Code insee de la voie "administrative".';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE.date_saisie IS 'Date de création du libellé de voie.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE.date_modification IS 'Date de modification du libellé de voie.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE.fid_pnom_saisie IS 'Clé étrangère vers la table TEMP_C_AGENT indiquant le pnom de l''agent créateur du libellé de voie.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE.fid_pnom_modification IS 'Clé étrangère vers la table TEMP_C_AGENT indiquant le pnom de l''agent éditeur du libellé de voie.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE.fid_type_voie IS 'Clé étrangère vers la table TEMP_C_TYPE_VOIE permettant d''associer une voie à un type de voie.';
--COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE.fid_voie_physique IS 'Clé étrangère vers la table TA_VOIE permettant d''affecter un ou plusieurs noms à une voie physique.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE.fid_lateralite IS 'Clé étrangère vers la table TA_LIBELLE permettant de récupérer la latéralité de la voie. En limite de commune le côté gauche de la voie physique peut appartenir à la commune A et le côté droit à la comune B, tandis qu''au sein de la commune la voie physique appartient à une et une seule commune et est donc affectée à une et une seule voie administrative. Cette distinction se fait grâce à ce champ.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE 
ADD CONSTRAINT TEMP_C_VOIE_ADMINISTRATIVE_PK 
PRIMARY KEY("OBJECTID") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE
ADD CONSTRAINT TEMP_C_VOIE_ADMINISTRATIVE_FID_LATERALITE_FK
FOREIGN KEY (fid_lateralite)
REFERENCES G_BASE_VOIE.TEMP_B_LIBELLE(objectid);
/*
ALTER TABLE G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE
ADD CONSTRAINT TEMP_C_VOIE_ADMINISTRATIVE_FID_VOIE_PHYSIQUE_FK
FOREIGN KEY (fid_voie_physique)
REFERENCES G_BASE_VOIE.TEMP_B_VOIE_PHYSIQUE(objectid);
*/
ALTER TABLE G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE
ADD CONSTRAINT TEMP_C_VOIE_ADMINISTRATIVE_FID_TYPE_VOIE_FK
FOREIGN KEY (fid_type_voie)
REFERENCES G_BASE_VOIE.TEMP_C_TYPE_VOIE(objectid);

ALTER TABLE G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE
ADD CONSTRAINT TEMP_C_VOIE_ADMINISTRATIVE_FID_PNOM_SAISIE_FK
FOREIGN KEY (fid_pnom_saisie)
REFERENCES G_BASE_VOIE.TEMP_C_AGENT(numero_agent);

ALTER TABLE G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE
ADD CONSTRAINT TEMP_C_VOIE_ADMINISTRATIVE_FID_PNOM_MODIFICATION_FK
FOREIGN KEY (fid_pnom_modification)
REFERENCES G_BASE_VOIE.TEMP_C_AGENT(numero_agent);

-- 4. Création des index sur les clés étrangères et autres   
CREATE INDEX TEMP_C_VOIE_ADMINISTRATIVE_LIBELLE_VOIE_IDX ON G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE(libelle_voie)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TEMP_C_VOIE_ADMINISTRATIVE_COMPLEMENT_NOM_VOIE_IDX ON G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE(complement_nom_voie)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TEMP_C_VOIE_ADMINISTRATIVE_CODE_INSEE_IDX ON G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE(code_insee)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TEMP_C_VOIE_ADMINISTRATIVE_FID_LATERALITE_IDX ON G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE(fid_lateralite)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TEMP_C_VOIE_ADMINISTRATIVE_FID_PNOM_SAISIE_IDX ON G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE(fid_pnom_saisie)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TEMP_C_VOIE_ADMINISTRATIVE_FID_PNOM_MODIFICATION_IDX ON G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE(fid_pnom_modification)
    TABLESPACE G_ADT_INDX;
/*
CREATE INDEX TEMP_C_VOIE_ADMINISTRATIVE_FID_VOIE_PHYSIQUE_IDX ON G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE(fid_voie_physique)
    TABLESPACE G_ADT_INDX;
*/
CREATE INDEX TEMP_C_VOIE_ADMINISTRATIVE_FID_TYPE_VOIE_IDX ON G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE(fid_type_voie)
    TABLESPACE G_ADT_INDX;

-- 5. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE TO G_ADMIN_SIG;

/

/*
La table TEMP_C_TRONCON - du projet C de correction de la latéralité des voies - regroupe tous les tronçons de la base voie.
*/

-- 1. Création de la table TEMP_C_TRONCON
CREATE TABLE G_BASE_VOIE.TEMP_C_TRONCON(
    objectid NUMBER(38,0),
    geom SDO_GEOMETRY NULL,
    date_saisie DATE DEFAULT sysdate NULL,
    date_modification DATE DEFAULT sysdate NULL,
    fid_pnom_saisie NUMBER(38,0) NULL,
    fid_pnom_modification NUMBER(38,0) NULL,
    fid_etat NUMBER(38,0) NULL
);

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TEMP_C_TRONCON IS 'Table - du projet C de correction de la latéralité des voies - contenant les tronçons de la base voie.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_TRONCON.objectid IS 'Clé primaire de la table identifiant chaque tronçon. Cette pk est auto-incrémentée et remplace l''ancien identifiant cnumtrc.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_TRONCON.geom IS 'Géométrie de type ligne simple de chaque tronçon.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_TRONCON.date_saisie IS 'date de saisie du tronçon (par défaut la date du jour).';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_TRONCON.date_modification IS 'Dernière date de modification du tronçon (par défaut la date du jour).';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_TRONCON.fid_pnom_saisie IS 'Clé étrangère vers la table TEMP_C_AGENT permettant de récupérer le pnom de l''agent ayant créé un tronçon.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_TRONCON.fid_pnom_modification IS 'Clé étrangère vers la table TEMP_C_AGENT permettant de récupérer le pnom de l''agent ayant modifié un tronçon.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_TRONCON.fid_etat IS 'Etat d''avancement des corrections : en erreur, corrigé, correct.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TEMP_C_TRONCON 
ADD CONSTRAINT TEMP_C_TRONCON_PK 
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
    'TEMP_C_TRONCON',
    'GEOM',
    SDO_DIM_ARRAY(SDO_DIM_ELEMENT('X', 684540, 719822.2, 0.005),SDO_DIM_ELEMENT('Y', 7044212, 7078072, 0.005)), 
    2154
);

-- 5. Création de l'index spatial sur le champ geom
CREATE INDEX TEMP_C_TRONCON_SIDX
ON G_BASE_VOIE.TEMP_C_TRONCON(GEOM)
INDEXTYPE IS MDSYS.SPATIAL_INDEX
PARAMETERS('sdo_indx_dims=2, layer_gtype=LINE, tablespace=G_ADT_INDX, work_tablespace=DATA_TEMP');

-- 6. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TEMP_C_TRONCON
ADD CONSTRAINT TEMP_C_TRONCON_FID_PNOM_SAISIE_FK 
FOREIGN KEY (fid_pnom_saisie)
REFERENCES G_BASE_VOIE.TEMP_C_AGENT(numero_agent);

ALTER TABLE G_BASE_VOIE.TEMP_C_TRONCON
ADD CONSTRAINT TEMP_C_TRONCON_FID_PNOM_MODIFICATION_FK
FOREIGN KEY (fid_pnom_modification)
REFERENCES G_BASE_VOIE.TEMP_C_AGENT(numero_agent);

ALTER TABLE G_BASE_VOIE.TEMP_C_TRONCON
ADD CONSTRAINT TEMP_C_TRONCON_FID_ETAT_FK
FOREIGN KEY (fid_etat)
REFERENCES G_BASE_VOIE.TEMP_C_LIBELLE(objectid);

-- 7. Création des index sur les clés étrangères et autres
CREATE INDEX TEMP_C_TRONCON_FID_PNOM_SAISIE_IDX ON G_BASE_VOIE.TEMP_C_TRONCON(fid_pnom_saisie)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TEMP_C_TRONCON_FID_PNOM_MODIFICATION_IDX ON G_BASE_VOIE.TEMP_C_TRONCON(fid_pnom_modification)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TEMP_C_TRONCON_FID_ETAT_IDX ON G_BASE_VOIE.TEMP_C_TRONCON(fid_etat)
    TABLESPACE G_ADT_INDX;

-- Cet index dispose d'une fonction permettant d'accélérer la récupération du code INSEE de la commune d'appartenance du tronçon. 
-- Il créé également un champ virtuel dans lequel on peut aller chercher ce code INSEE.
CREATE INDEX TEMP_C_TRONCON_CODE_INSEE_IDX
ON G_BASE_VOIE.TEMP_C_TRONCON(GET_CODE_INSEE_TRONCON('TEMP_C_TRONCON', geom))
TABLESPACE G_ADT_INDX;

-- 8. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TEMP_C_TRONCON TO G_ADMIN_SIG;

/

/*
La table TEMP_C_RELATION_TRONCON_VOIE_PHYSIQUE - du projet C de correction de la latéralité des voies - permet d''associer les tronçons de la table TEMP_C_TRONCON à leur voie présente dans TEMP_C_VOIE_PHYSIQUE. 
Il s''agit ici d''une table temporaire qui sert à faire la transition vers une relation tronçon 1.1 / 1.n voie physique.
*/

-- 1. Création de la table TEMP_C_RELATION_TRONCON_VOIE_PHYSIQUE
CREATE TABLE G_BASE_VOIE.TEMP_C_RELATION_TRONCON_VOIE_PHYSIQUE(
    objectid NUMBER(38,0) GENERATED BY DEFAULT AS IDENTITY,
    sens CHAR(1) NULL,
    fid_voie_physique NUMBER(38,0) NOT NULL,
    fid_troncon NUMBER(38,0) NOT NULL
);

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TEMP_C_RELATION_TRONCON_VOIE_PHYSIQUE IS 'Table pivot - du projet C de correction de la latéralité des voies - permettant d''associer les tronçons de la table TEMP_C_TRONCON à leur voie présente dans TEMP_C_VOIE_PHYSIQUE. Il s''agit ici d''une table temporaire qui sert à faire la transition vers une relation tronçon 1.1 / 1.n voie physique.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_RELATION_TRONCON_VOIE_PHYSIQUE.objectid IS 'Clé primaire auto-incrémentée de la table.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_RELATION_TRONCON_VOIE_PHYSIQUE.sens IS 'Code permettant de connaître le sens de saisie du tronçon par rapport au sens de la voie.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_RELATION_TRONCON_VOIE_PHYSIQUE.fid_voie_physique IS 'Clé étrangère vers la table TEMP_C_VOIE_PHYSIQUE permettant d''associer une voie à un ou plusieurs tronçons. Ancien champ : CCOMVOI.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_RELATION_TRONCON_VOIE_PHYSIQUE.fid_troncon IS 'Clé étrangère vers la table TEMP_C_TRONCON permettant d''associer un ou plusieurs tronçons à une voie. Ancien champ : CNUMTRC.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TEMP_C_RELATION_TRONCON_VOIE_PHYSIQUE 
ADD CONSTRAINT TEMP_C_RELATION_TRONCON_VOIE_PHYSIQUE_PK 
PRIMARY KEY("OBJECTID") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TEMP_C_RELATION_TRONCON_VOIE_PHYSIQUE
ADD CONSTRAINT TEMP_C_RELATION_TRONCON_VOIE_PHYSIQUE_FID_VOIE_PHYSIQUE_FK
FOREIGN KEY (fid_voie_physique)
REFERENCES G_BASE_VOIE.TEMP_C_VOIE_PHYSIQUE(objectid);

ALTER TABLE G_BASE_VOIE.TEMP_C_RELATION_TRONCON_VOIE_PHYSIQUE
ADD CONSTRAINT TEMP_C_RELATION_TRONCON_VOIE_PHYSIQUE_FID_TRONCON_FK
FOREIGN KEY (fid_troncon)
REFERENCES G_BASE_VOIE.TEMP_C_TRONCON(objectid);

-- 5. Création des index sur les clés étrangères
CREATE INDEX TEMP_C_RELATION_TRONCON_VOIE_PHYSIQUE_fid_voie_physique_PHYSIQUE_IDX ON G_BASE_VOIE.TEMP_C_RELATION_TRONCON_VOIE_PHYSIQUE(fid_voie_physique)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TEMP_C_RELATION_TRONCON_VOIE_PHYSIQUE_FID_TRONCON_IDX ON G_BASE_VOIE.TEMP_C_RELATION_TRONCON_VOIE_PHYSIQUE(fid_troncon)
    TABLESPACE G_ADT_INDX;

-- 6. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TEMP_C_RELATION_TRONCON_VOIE_PHYSIQUE TO G_ADMIN_SIG;

/

/*
La table TEMP_C_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE - du projet C de correction de la latéralité des voies - permet d''associer une ou plusieurs voies physiques à une ou plusieurs voies administratives.
*/

-- 1. Création de la table TEMP_C_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE
CREATE TABLE G_BASE_VOIE.TEMP_C_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE(
    objectid NUMBER(38,0) GENERATED BY DEFAULT AS IDENTITY,
    fid_voie_physique NUMBER(38,0) NOT NULL,
    fid_voie_administrative NUMBER(38,0) NOT NULL
);

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TEMP_C_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE IS 'Table pivot - du projet C de correction de la latéralité des voies - permettant d''associer une ou plusieurs voies physiques à une ou plusieurs voies administratives.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE.objectid IS 'Clé primaire auto-incrémentée de la table.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE.fid_voie_physique IS 'Clé étrangère vers la table TEMP_C_VOIE_PHYSIQUE permettant d''associer une ou plusieurs voies physiques à une ou plusieurs administratives.';
COMMENT ON COLUMN G_BASE_VOIE.TEMP_C_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE.fid_voie_administrative IS 'Clé étrangère vers la table TEMP_C_VOIE_ADMINISTRATIVE permettant d''associer une ou plusieurs voies administratives à une ou plusieurs voies physiques.';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TEMP_C_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE 
ADD CONSTRAINT TEMP_C_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_PK 
PRIMARY KEY("OBJECTID") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TEMP_C_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE
ADD CONSTRAINT TEMP_C_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_FID_VOIE_PHYSIQUE_FK
FOREIGN KEY (fid_voie_physique)
REFERENCES G_BASE_VOIE.TEMP_C_VOIE_PHYSIQUE(objectid);

ALTER TABLE G_BASE_VOIE.TEMP_C_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE
ADD CONSTRAINT TEMP_C_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_FID_VOIE_ADMINISTRATIVE_FK
FOREIGN KEY (fid_voie_administrative)
REFERENCES G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE(objectid);

-- 5. Création des index sur les clés étrangères
CREATE INDEX TEMP_C_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_FID_VOIE_PHYSIQUE_IDX ON G_BASE_VOIE.TEMP_C_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE(fid_voie_physique)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TEMP_C_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE_FID_VOIE_ADMINISTRATIVE_IDX ON G_BASE_VOIE.TEMP_C_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE(fid_voie_administrative)
    TABLESPACE G_ADT_INDX;

-- 6. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TEMP_C_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE TO G_ADMIN_SIG;

/


/*
Déclencheur permettant de récupérer dans la table TEMP_C_LIBELLE, les dates de création/modification des entités ainsi que le pnom de l'agent les ayant effectués.
*/

CREATE OR REPLACE TRIGGER G_BASE_VOIE.B_IUX_TEMP_C_TRONCON_DATE_PNOM
BEFORE INSERT OR UPDATE ON G_BASE_VOIE.TEMP_C_TRONCON
FOR EACH ROW
DECLARE
    username VARCHAR2(100);
    v_id_agent NUMBER(38,0);
    v_id_etat NUMBER(38,0);
BEGIN
    -- Sélection du pnom
    SELECT sys_context('USERENV','OS_USER') into username from dual;

    -- Sélection de l'id du pnom correspondant dans la table TEMP_AGENT
    SELECT numero_agent INTO v_id_agent FROM G_BASE_VOIE.TEMP_C_AGENT WHERE pnom = username;

    -- Sélection du libellé caractérisant une nouvelle entité
    SELECT objectid INTO v_id_etat FROM G_BASE_VOIE.TEMP_C_LIBELLE WHERE UPPER(libelle_court) = UPPER('nouvelle entité');

    -- En cas d'insertion on insère la FK du pnom de l'agent, ayant créé le tronçon, présent dans TEMP_AGENT. 
    IF INSERTING THEN 
        :new.objectid := SEQ_TEMP_C_TRONCON_OBJECTID.NEXTVAL;
        :new.fid_pnom_saisie := v_id_agent;
        :new.date_saisie := TO_DATE(sysdate, 'dd/mm/yy');
        :new.fid_pnom_modification := v_id_agent;
        :new.date_modification := TO_DATE(sysdate, 'dd/mm/yy');    
        :new.fid_etat := v_id_etat;
    ELSE
        -- En cas de mise à jour on édite le champ date_modification avec la date du jour et le champ fid_pnom_modification avec la FK du pnom de l'agent, ayant modifié le tronçon, présent dans TEMP_AGENT.
        IF UPDATING THEN 
             :new.date_modification := TO_DATE(sysdate, 'dd/mm/yy');
             :new.fid_pnom_modification := v_id_agent;
        END IF;
    END IF;

    EXCEPTION
        WHEN OTHERS THEN
            mail.sendmail('bjacq@lillemetropole.fr',SQLERRM,'ERREUR TRIGGER - G_BASE_VOIE.B_IUX_TEMP_C_TRONCON_DATE_PNOM','bjacq@lillemetropole.fr');
END;

/

-- Désactivation des contraintes et des index des tables de correction des tronçons disposant d'erreurs de topologie.
-- Désactivation des contraintes
ALTER TABLE G_BASE_VOIE.TEMP_C_TRONCON DISABLE CONSTRAINT TEMP_C_TRONCON_FID_PNOM_SAISIE_FK;
ALTER TABLE G_BASE_VOIE.TEMP_C_TRONCON DISABLE CONSTRAINT TEMP_C_TRONCON_FID_PNOM_MODIFICATION_FK;
ALTER TABLE G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE DISABLE CONSTRAINT TEMP_C_VOIE_ADMINISTRATIVE_FID_TYPE_VOIE_FK;
ALTER TABLE G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE DISABLE CONSTRAINT TEMP_C_VOIE_ADMINISTRATIVE_FID_PNOM_SAISIE_FK;
ALTER TABLE G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE DISABLE CONSTRAINT TEMP_C_VOIE_ADMINISTRATIVE_FID_PNOM_MODIFICATION_FK;

-- Suppression des index
DROP INDEX TEMP_C_TRONCON_FID_PNOM_SAISIE_IDX;
DROP INDEX TEMP_C_TRONCON_FID_PNOM_MODIFICATION_IDX;
DROP INDEX TEMP_C_VOIE_ADMINISTRATIVE_LIBELLE_VOIE_IDX;
DROP INDEX TEMP_C_VOIE_ADMINISTRATIVE_COMPLEMENT_NOM_VOIE_IDX;
DROP INDEX TEMP_C_VOIE_ADMINISTRATIVE_CODE_INSEE_IDX;
DROP INDEX TEMP_C_VOIE_ADMINISTRATIVE_FID_LATERALITE_IDX;
DROP INDEX TEMP_C_VOIE_ADMINISTRATIVE_FID_PNOM_SAISIE_IDX;
DROP INDEX TEMP_C_VOIE_ADMINISTRATIVE_FID_PNOM_MODIFICATION_IDX;
DROP INDEX TEMP_C_VOIE_ADMINISTRATIVE_FID_TYPE_VOIE_IDX;

-- Désactivation des triggers
ALTER TRIGGER B_IUX_TEMP_C_TRONCON_DATE_PNOM DISABLE;

/

