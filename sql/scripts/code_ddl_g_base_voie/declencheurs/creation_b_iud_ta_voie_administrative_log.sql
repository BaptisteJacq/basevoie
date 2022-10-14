/*
Déclencheur permettant de remplir la table de logs TA_VOIE_ADMINISTRATIVE_LOG dans laquelle sont enregistrés chaque insertion, 
modification et suppression des données de la table TA_VOIE_ADMINISTRATIVE avec leur date et le pnom de l'agent les ayant effectuées.
*/

CREATE OR REPLACE TRIGGER G_BASE_VOIE.B_IUD_TA_VOIE_ADMINISTRATIVE_LOG
BEFORE INSERT OR UPDATE OR DELETE ON G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE
FOR EACH ROW
DECLARE
    username VARCHAR2(100);
    v_id_agent NUMBER(38,0);
    v_id_insertion NUMBER(38,0);
    v_id_modification NUMBER(38,0);
    v_id_suppression NUMBER(38,0);
BEGIN
    -- Sélection du pnom
    SELECT sys_context('USERENV','OS_USER') into username from dual;

    -- Sélection de l'id du pnom correspondant dans la table TA_AGENT
    SELECT numero_agent INTO v_id_agent FROM G_BASE_VOIE.TA_AGENT WHERE pnom = username;

    -- Sélection des id des actions présentes dans la table TA_LIBELLE
    SELECT
        a.objectid INTO v_id_insertion
    FROM
        G_GEO.TA_LIBELLE a
        INNER JOIN G_GEO.TA_LIBELLE_LONG b ON b.objectid = a.fid_libelle_long
    WHERE
        b.valeur = 'insertion';

    SELECT
        a.objectid INTO v_id_modification
    FROM
        G_GEO.TA_LIBELLE a
        INNER JOIN G_GEO.TA_LIBELLE_LONG b ON b.objectid = a.fid_libelle_long
    WHERE
        b.valeur = 'édition';

    SELECT
        a.objectid INTO v_id_suppression
    FROM
        G_GEO.TA_LIBELLE a
        INNER JOIN G_GEO.TA_LIBELLE_LONG b ON b.objectid = a.fid_libelle_long
    WHERE
        b.valeur = 'suppression';

    IF INSERTING THEN -- En cas d'insertion on insère les valeurs de la table TA_VOIE_ADMINISTRATIVE_LOG, le numéro d'agent correspondant à l'utilisateur, la date de insertion et le type de modification.
        INSERT INTO G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG(id_voie_administrative, genre_voie, libelle_voie, complement_nom_voie, fid_lateralite, code_insee, commentaire, id_voie_supra_communale, date_action, fid_type_voie, fid_lateralite, fid_type_action, fid_pnom, fid_metadonnee)
            VALUES(
                :new.objectid,
                :new.genre_voie,
                :new.libelle_voie,
                :new.complement_nom_voie,
                :new.fid_lateralite,
                :new.code_insee,
                :new.commentaire,
                :new.id_voie_supra_communale,
                sysdate,
                :new.fid_type_voie,
                :new.fid_lateralite,
                v_id_insertion,
                v_id_agent,
                :new.fid_metadonnee
            );
    ELSE
        IF UPDATING THEN -- En cas de modification on insère les valeurs de la table TA_VOIE_ADMINISTRATIVE_LOG, le numéro d'agent correspondant à l'utilisateur, la date de modification et le type de modification.
        INSERT INTO G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG(id_voie_administrative, genre_voie, libelle_voie, complement_nom_voie, fid_lateralite, code_insee, commentaire, id_voie_supra_communale, date_action, fid_type_voie, fid_lateralite, fid_type_action, fid_pnom, fid_metadonnee)
            VALUES(
                :old.objectid,
                :old.genre_voie,
                :old.libelle_voie,
                :old.complement_nom_voie,
                :old.fid_lateralite,
                :old.code_insee,
                :old.commentaire,
                :old.id_voie_supra_communale,
                sysdate,
                :old.fid_type_voie,
                :old.fid_lateralite,
                v_id_modification,
                v_id_agent,
                :old.fid_metadonnee
            );
        END IF;
    END IF;
    IF DELETING THEN -- En cas de suppression on insère les valeurs de la table TA_VOIE_ADMINISTRATIVE_LOG, le numéro d'agent correspondant à l'utilisateur, la date de suppression et le type de modification.
    INSERT INTO G_BASE_VOIE.TA_VOIE_ADMINISTRATIVE_LOG(id_voie_administrative, genre_voie, libelle_voie, complement_nom_voie, fid_lateralite, code_insee, commentaire, id_voie_supra_communale, date_action, fid_type_voie, fid_lateralite, fid_type_action, fid_pnom, fid_metadonnee)
        VALUES(
            :old.objectid,
            :old.genre_voie,
            :old.libelle_voie,
            :old.complement_nom_voie,
            :old.fid_lateralite,
            :old.code_insee,
            :old.commentaire,
            :old.id_voie_supra_communale,
            sysdate,
            :old.fid_type_voie,
            :old.fid_lateralite,
            v_id_suppression,
            v_id_agent,
            :old.fid_metadonnee        
        );
    END IF;
    EXCEPTION
        WHEN OTHERS THEN
            mail.sendmail('bjacq@lillemetropole.fr',SQLERRM,'ERREUR TRIGGER - G_BASE_VOIE.B_IUD_TA_VOIE_ADMINISTRATIVE_LOG','bjacq@lillemetropole.fr');
END;

/

