/*
La table TA_VOIE_ADMINISTRATIVE_LOG rassemblant les informations de chaque voie et notamment leurs libellés et leur latéralité : une voie physique peut avoir deux noms différents (à gauche et à droite) si elle traverse deux communes différentes.
*/

-- 1. Création de la table TA_VOIE_ADMINISTRATIVE_LOG
CREATE TABLE G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG(
    objectid NUMBER(38,0) GENERATED BY DEFAULT AS IDENTITY,
    id_voie_administrative NUMBER(38,0),
    genre_voie VARCHAR2(50 BYTE),
    libelle_voie VARCHAR2(1000 BYTE),
    complement_nom_voie VARCHAR2(200),
    id_lateralite NUMBER(38,0),
    code_insee VARCHAR2(5),
    id_voie_supra_communale NUMBER(38,0),
    hierarchisation VARCHAR2(50),
    commentaire VARCHAR2(4000 BYTE),
    date_action DATE,
    fid_type_action NUMBER(38,0),
    fid_pnom NUMBER(38,0),
    fid_type_voie NUMBER(38,0),
    fid_lateralite NUMBER(38,0),
    fid_metadonnee NUMBER(38,0)
);

-- 2. Création des commentaires sur la table et les champs
COMMENT ON TABLE G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG IS 'Table de log de la table TA_VOIE_ADMINISTRATIVE permettant d''avoir l''historique de toutes les évolutions des voies administratives.';
COMMENT ON COLUMN G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG.objectid IS 'Clé primaire auto-incrémentée de la table. Elle remplace l''ancien identifiant ccomvoie.';
COMMENT ON COLUMN G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG.id_voie_administrative IS 'Identifiant des voies administratives de la table TA_VOIE_ADMINISTRATIVE.';
COMMENT ON COLUMN G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG.genre_voie IS 'Genre du nom de la voie (féminin, masculin, neutre, etc).';
COMMENT ON COLUMN G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG.libelle_voie IS 'Nom de voie.';
COMMENT ON COLUMN G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG.complement_nom_voie IS 'Complément de nom de voie.';
COMMENT ON COLUMN G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG.code_insee IS 'Code insee de la voie "administrative".';
COMMENT ON COLUMN G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG.id_voie_supra_communale IS 'Identifiant des voies supra-communales auxquelles sont associées certaines voies administratives.';
COMMENT ON COLUMN G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG.commentaire IS 'Commentaire de chaque voie, à remplir si besoin, pour une précision ou pour les voies n''ayant pas encore de nom.';
COMMENT ON COLUMN G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG.date_action IS 'date de saisie, modification et suppression de la voie administrative.';
COMMENT ON COLUMN G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG.fid_type_action IS 'Clé étrangère vers la table TA_LIBELLE permettant de catégoriser le type d''action effectué sur les voies administratives.';
COMMENT ON COLUMN G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG.fid_pnom IS 'Clé étrangère vers la table TA_AGENT permettant d''associer le pnom d''un agent à la voie administrative qu''il a créé, modifié ou supprimé.';
COMMENT ON COLUMN G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG.fid_type_voie IS 'Clé étrangère vers la table TA_TYPE_VOIE permettant d''associer une voie à un type de voie.';
COMMENT ON COLUMN G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG.fid_lateralite IS 'Clé étrangère vers la table TA_LIBELLE permettant de récupérer la latéralité de la voie. En limite de commune le côté gauche de la voie physique peut appartenir à la commune A et le côté droit à la comune B, tandis qu''au sein de la commune la voie physique appartient à une et une seule commune et est donc affectée à une et une seule voie administrative. Cette distinction se fait grâce à ce champ.';
COMMENT ON COLUMN G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG.fid_metadonnee IS 'Clé étrangère vers la table G_GEO.TA_METADONNEE permettant de connaître la source des voies (MEL ou IGN).';

-- 3. Création de la clé primaire
ALTER TABLE G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG 
ADD CONSTRAINT TA_VOIE_ADMINISTRATIVE_LOG_PK 
PRIMARY KEY("OBJECTID") 
USING INDEX TABLESPACE "G_ADT_INDX";

-- 4. Création des clés étrangères
ALTER TABLE G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG
ADD CONSTRAINT TA_VOIE_ADMINISTRATIVE_LOG_FID_TYPE_VOIE_FK
FOREIGN KEY (fid_type_voie)
REFERENCES G_BASE_VOIE.TA_TYPE_VOIE(objectid);

ALTER TABLE G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG
ADD CONSTRAINT TA_VOIE_ADMINISTRATIVE_LOG_FID_LATERALITE_FK
FOREIGN KEY (fid_lateralite)
REFERENCES G_BASE_VOIE.TA_LIBELLE(objectid);

ALTER TABLE G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG
ADD CONSTRAINT TA_VOIE_ADMINISTRATIVE_LOG_FID_TYPE_ACTION_FK 
FOREIGN KEY (fid_type_action)
REFERENCES G_GEO.TA_LIBELLE(objectid);

ALTER TABLE G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG
ADD CONSTRAINT TA_VOIE_ADMINISTRATIVE_LOG_FID_PNOM_FK
FOREIGN KEY (fid_pnom)
REFERENCES G_BASE_VOIE.TA_AGENT(numero_agent);

ALTER TABLE G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG
ADD CONSTRAINT TA_VOIE_ADMINISTRATIVE_LOG_FID_METADONNEE_FK
FOREIGN KEY (fid_metadonnee)
REFERENCES G_GEO.TA_METADONNEE(objectid);

-- 4. Création des index sur les clés étrangères et autres   
CREATE INDEX TA_VOIE_ADMINISTRATIVE_LOG_LIBELLE_VOIE_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG(libelle_voie)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_VOIE_ADMINISTRATIVE_LOG_GENRE_VOIE_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG(genre_voie)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_VOIE_ADMINISTRATIVE_LOG_COMPLEMENT_NOM_VOIE_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG(complement_nom_voie)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_VOIE_ADMINISTRATIVE_LOG_CODE_INSEE_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG(code_insee)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_VOIE_ADMINISTRATIVE_LOG_ID_VOIE_SUPRA_COMMUNALE_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG(id_voie_supra_communale)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_VOIE_ADMINISTRATIVE_LOG_FID_LATERALITE_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG(fid_lateralite)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_VOIE_ADMINISTRATIVE_LOG_FID_TYPE_ACTION_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG(fid_type_action)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_VOIE_ADMINISTRATIVE_LOG_FID_PNOM_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG(fid_pnom)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_VOIE_ADMINISTRATIVE_LOG_FID_TYPE_VOIE_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG(fid_type_voie)
    TABLESPACE G_ADT_INDX;

CREATE INDEX TA_VOIE_ADMINISTRATIVE_LOG_FID_METADONNEE_IDX ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG(fid_metadonnee)
    TABLESPACE G_ADT_INDX;

-- 5. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG TO G_ADMIN_SIG;

/

