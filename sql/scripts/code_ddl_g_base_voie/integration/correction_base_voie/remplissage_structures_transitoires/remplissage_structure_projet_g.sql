-- Insertion des pnoms des agents
INSERT INTO G_BASE_VOIE.TEMP_G_AGENT(numero_agent, pnom, validite)
    SELECT numero_agent, pnom, validite FROM TEMP_F_AGENT;
-- Résultat : 5 lignes insérées.

-- Insertion des types de voie
MERGE INTO G_BASE_VOIE.TEMP_G_TYPE_VOIE a
    USING(
        SELECT
            objectid,
            code_type_voie,
            libelle
        FROM
            G_BASE_VOIE.TEMP_F_TYPE_VOIE
    )t
    ON(a.code_type_voie = t.code_type_voie AND a.libelle = t.libelle)
WHEN NOT MATCHED THEN
    INSERT(a.objectid, a.code_type_voie, a.libelle)
    VALUES(t.objectid, t.code_type_voie, t.libelle);
-- Résultat : 57 lignes fusionnées.

-- Insertion des valeurs de latéralité des voies dans TEMP_G_LIBELLE
INSERT INTO G_BASE_VOIE.TEMP_G_LIBELLE(objectid, libelle_court, libelle_long)
SELECT
    objectid,
    libelle_court,
    libelle_long
FROM
    G_BASE_VOIE.TEMP_F_LIBELLE
WHERE
    libelle_court IN('droit', 'gauche', 'les deux côtés');

-- Résultat : 2 lignes fusionnées

-- Insertion des tronçons
MERGE INTO G_BASE_VOIE.TEMP_G_TRONCON a
    USING(
        SELECT
            a.objectid, 
            a.geom, 
            a.date_saisie, 
            a.date_modification, 
            a.fid_pnom_saisie, 
            a.fid_pnom_modification,
            a.fid_voie_physique
        FROM
          G_BASE_VOIE.TEMP_F_TRONCON a
    )t
ON(a.objectid = t.objectid)
WHEN NOT MATCHED THEN
    INSERT(a.objectid, a.geom, a.date_saisie, a.date_modification, a.fid_pnom_saisie, a.fid_pnom_modification, a.fid_voie_physique)
    VALUES(t.objectid, t.geom, t.date_saisie, t.date_modification, t.fid_pnom_saisie, t.fid_pnom_modification, t.fid_voie_physique);
-- Résultat : 50 427 lignes fusionnées.

-- Insertion des voies physiques
MERGE INTO G_BASE_VOIE.TEMP_G_VOIE_PHYSIQUE a
    USING(
            SELECT
                a.objectid
            FROM
              G_BASE_VOIE.TEMP_F_VOIE_PHYSIQUE a
        )t
ON(a.objectid = t.objectid)
WHEN NOT MATCHED THEN
    INSERT(a.objectid)
    VALUES(t.objectid);
-- Résultat : 22 939  lignes fusionnées.

-- Insertion des relations voies physiques / voies administratives
MERGE INTO G_BASE_VOIE.TEMP_G_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE a
    USING(
        SELECT
            a.fid_voie_administrative,
            a.fid_voie_physique
        FROM
            G_BASE_VOIE.TEMP_F_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE a
    )t
ON(a.fid_voie_administrative = t.fid_voie_administrative AND a.fid_voie_physique = t.fid_voie_physique)
WHEN NOT MATCHED THEN
    INSERT(a.fid_voie_administrative, a.fid_voie_physique)
    VALUES(t.fid_voie_administrative, t.fid_voie_physique);
-- Résultat : 23 651 lignes fusionnées.

-- Insertion des voies administratives
MERGE INTO G_BASE_VOIE.TEMP_G_VOIE_ADMINISTRATIVE a
    USING(
        SELECT
            a.OBJECTID,
            a.GENRE_VOIE,
            a.LIBELLE_VOIE,
            a.COMPLEMENT_NOM_VOIE,
            a.FID_LATERALITE,
            a.CODE_INSEE,
            a.DATE_SAISIE,
            a.DATE_MODIFICATION,
            a.FID_PNOM_SAISIE,
            a.FID_PNOM_MODIFICATION,
            a.FID_TYPE_VOIE
        FROM
            G_BASE_VOIE.TEMP_F_VOIE_ADMINISTRATIVE a
    )t
ON(a.objectid = t.objectid AND a.fid_type_voie = t.fid_type_voie)
WHEN NOT MATCHED THEN
    INSERT(a.objectid, a.libelle_voie, a.complement_nom_voie, a.code_insee, a.fid_type_voie, a.date_saisie, a.date_modification, a.fid_pnom_saisie, a.fid_pnom_modification, a.fid_lateralite)
    VALUES(t.objectid, t.libelle_voie, t.complement_nom_voie, t.code_insee, t.fid_type_voie, t.date_saisie, t.date_modification, t.fid_pnom_saisie, t.fid_pnom_modification, t.fid_lateralite);
COMMIT;
-- Résultat : 22 165 lignes fusionnées.

/

