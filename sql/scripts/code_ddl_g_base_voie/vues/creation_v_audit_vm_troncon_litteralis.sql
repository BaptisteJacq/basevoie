/*
Création de la vue V_AUDIT_VM_TRONCON_LITTERALIS vérifiant si la VM contient des erreurs (ces erreurs correspondent à celles des rapport d''analyse de SOGELINK). 
*/
/*
DROP VIEW G_BASE_VOIE.V_AUDIT_VM_TRONCON_LITTERALIS;
*/
-- 1. Création de la vue
CREATE OR REPLACE FORCE VIEW G_BASE_VOIE.V_AUDIT_VM_TRONCON_LITTERALIS(
    objectid,
    type_erreur,
    nombre,
    CONSTRAINT "V_AUDIT_VM_TRONCON_LITTERALIS_PK" PRIMARY KEY ("OBJECTID") DISABLE
) 
AS
    WITH
        C_1 AS(
            -- Identification des classements ne correspondant pas à ceux du format LITTERALIS
            SELECT
                'Classement inconnu' AS type_erreur,
                COUNT(objectid) AS nombre
            FROM
                G_BASE_VOIE.VM_TRONCON_LITTERALIS_2023
            WHERE
                classement NOT IN('RN', 'RD', 'A', 'VC', 'VF', 'CR', 'VP')
            UNION ALL
            -- Identification des codes INSEE absents de la MEL
            SELECT
                'Code INSEE absent du fichier des communes de la MEL 95' AS type_erreur,
                COUNT(objectid) AS nombre
            FROM
                G_BASE_VOIE.VM_TRONCON_LITTERALIS_2023
            WHERE
                (
                    code_insee_g NOT IN(SELECT TRIM(code_insee) FROM G_REFERENTIEL.MEL_COMMUNE)
                    OR code_insee_d NOT IN(SELECT TRIM(code_insee) FROM G_REFERENTIEL.MEL_COMMUNE)
                )
                AND (
                        code_insee_g NOT IN('59355', '59298')
                        OR code_insee_d NOT IN('59355', '59298')
                    )
            UNION ALL
            -- Identification des codes INSEE des communes associées dans les champs code_insee_g et code_insee_d
            SELECT
                'Présence du code INSEE d''une commune associée' AS type_erreur,
                COUNT(a.objectid) AS nombre
            FROM
                G_BASE_VOIE.VM_TRONCON_LITTERALIS_2023 a
            WHERE
                a.code_insee_g = '59355'
                OR a.code_insee_d = '59298'
        )
        
        SELECT
            rownum AS objectid,
            a.type_erreur,
            a.nombre
        FROM
            C_1 a
;

-- 2. Création des commentaires
COMMENT ON TABLE G_BASE_VOIE.V_AUDIT_VM_TRONCON_LITTERALIS IS 'Vue faisant l''audit de la VM VM_TRONCON_LITTERALIS permettant de savoir si elle est diffusable ou si elle contient des erreurs.';
COMMENT ON COLUMN G_BASE_VOIE.V_AUDIT_VM_TRONCON_LITTERALIS.objectid IS 'Clé primaire de la VM.';
COMMENT ON COLUMN G_BASE_VOIE.V_AUDIT_VM_TRONCON_LITTERALIS.type_erreur IS 'Type d''erreur.';
COMMENT ON COLUMN G_BASE_VOIE.V_AUDIT_VM_TRONCON_LITTERALIS.nombre IS 'Nombre d''entités concernées par l''erreur.';

-- 3. Affectation du droit de sélection sur les objets de la table aux administrateurs
GRANT SELECT ON G_BASE_VOIE.V_AUDIT_VM_TRONCON_LITTERALIS TO G_ADMIN_SIG;

/
