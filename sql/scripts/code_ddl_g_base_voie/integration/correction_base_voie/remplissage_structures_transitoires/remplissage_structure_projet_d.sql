-- Insertion des pnoms des agents
INSERT INTO G_BASE_VOIE.TEMP_D_AGENT(numero_agent, pnom, validite)
    SELECT numero_agent, pnom, validite FROM TEMP_AGENT;
-- Résultat : 5 lignes insérées.

-- Insertion des types de voie
MERGE INTO G_BASE_VOIE.TEMP_D_TYPE_VOIE a
    USING(
        SELECT
            CCODTVO AS code_type_voie,
            LITYVOIE AS libelle
        FROM
            G_BASE_VOIE.TEMP_TYPEVOIE
        WHERE
            LITYVOIE IS NOT NULL
    )t
    ON(a.code_type_voie = t.code_type_voie AND a.libelle = t.libelle)
WHEN NOT MATCHED THEN
    INSERT(a.code_type_voie, a.libelle)
    VALUES(t.code_type_voie, t.libelle);
-- Résultat : 57 lignes fusionnées.

-- Insertion des voies administratives matérialisées
INSERT INTO G_BASE_VOIE.TEMP_D_VOIE_ADMINISTRATIVE_PRINCIPALE(OBJECTID, FID_TYPE_VOIE, LIBELLE_VOIE, COMPLEMENT_NOM_VOIE, CODE_INSEE, DATE_SAISIE, DATE_MODIFICATION, FID_PNOM_SAISIE, FID_PNOM_MODIFICATION, GEOM)
SELECT
    f.objectid,
    f.fid_type_voie,
    TRIM(f.libelle_voie) AS libelle_voie,
    TRIM(f.complement_nom_voie) AS complement_nom_voie,
    f.code_insee,
    f.date_saisie,
    f.date_modification,
    f.fid_pnom_saisie,
    f.fid_pnom_modification,
    SDO_AGGR_UNION(
        SDOAGGRTYPE(b.geom, 0.005)
    ) AS geom
FROM
    G_BASE_VOIE.TEMP_C_TRONCON b
    INNER JOIN G_BASE_VOIE.TEMP_C_RELATION_TRONCON_VOIE_PHYSIQUE c ON c.fid_troncon = b.objectid
    INNER JOIN G_BASE_VOIE.TEMP_C_VOIE_PHYSIQUE d ON d.objectid = c.fid_voie_physique
    INNER JOIN G_BASE_VOIE.TEMP_C_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE e ON e.fid_voie_physique = d.objectid
    INNER JOIN G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE f ON f.objectid = e.fid_voie_administrative
    INNER JOIN G_BASE_VOIE.TEMP_C_LIBELLE h ON h.objectid = f.fid_lateralite
WHERE
    f.objectid NOT IN(SELECT fid_voie_secondaire FROM G_BASE_VOIE.TA_HIERARCHISATION_VOIE)
GROUP BY
    f.objectid,
    f.fid_type_voie,
    TRIM(f.libelle_voie),
    TRIM(f.complement_nom_voie),
    f.code_insee,
    f.date_saisie,
    f.date_modification,
    f.fid_pnom_saisie,
    f.fid_pnom_modification;
-- Résultat : 17 816 lignes insérées.

-- Insertion des libellés décrivant les états des objets du projet D
INSERT INTO G_BASE_VOIE.TEMP_D_LIBELLE(libelle_court, libelle_long)
SELECT
    'corrigé' AS libelle_court,
    'entité en erreur qui a été corrigé' AS libelle_long
FROM
    DUAL;
-- Résultat : 1 ligne insérée