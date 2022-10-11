/*
Contexte :
 Un tron�on est, dans la structure du projet B, affect� � deux voies physiques car il se situe en limite de commune. Il appartient donc � la voie de la commune A et � celle de la commune B.
Il est donc impossible qu'un tron�on soit affect� � plus de deux voies physiques, sauf erreur de saisie.

Objectif :
Passer d'une structure o� un tron�on est affect�s � une ou plusieurs voies physiques, chacune d'elle affect�e � une et une seule voie administrative
� une structure o� un tron�on est affect� � une et une seule voie physique, pouvant �tre affect�e � une ou plusieurs voies administratives 
*/
  
DELETE FROM G_BASE_VOIE.TEMP_C_TRANSIT_TRONCON_VOIE_PHYSIQUE;
COMMIT;

-- Insertion dans une table transitoire des tron�ons (affect�s � deux voies) et de l'identifiant minimum des voies auxquelles ils sont affect�s
INSERT INTO G_BASE_VOIE.TEMP_C_TRANSIT_TRONCON_VOIE_PHYSIQUE(id_troncon, old_id_voie_physique)
        SELECT
            a.id_troncon,
            MIN(a.id_voie_physique) AS id_voie_physique
        FROM
            G_BASE_VOIE.VM_TEMP_C_TRONCON_AFFECTE_PLUSIEURS_VOIES a
        GROUP BY
            a.id_troncon;
-- R�sultat : 837 lignes fusionn�es.

-- Cr�ation d'un nouvel identifiant de voie physique pour chaque ancienne voie physique pr�sente dans TEMP_C_TRANSIT_TRONCON_VOIE_PHYSIQUE et mise � jour du  champ old_id_voie_physique en cons�quence.
-- Objectif : cr�er de nouveaux identifiants de voie
MERGE INTO G_BASE_VOIE.TEMP_C_TRANSIT_TRONCON_VOIE_PHYSIQUE a
    USING(
        WITH
            C_1 AS(
                SELECT DISTINCT
                    old_id_voie_physique
                FROM
                    G_BASE_VOIE.TEMP_C_TRANSIT_TRONCON_VOIE_PHYSIQUE
            ),
            
            C_2 AS(
                SELECT
                    MAX(objectid) AS max_id_voie_physique
                FROM
                    G_BASE_VOIE.TEMP_C_VOIE_PHYSIQUE
            )
            
            SELECT
                a.old_id_voie_physique,
                b.max_id_voie_physique + rownum AS new_id_voie_physique
            FROM
                C_1 a,
                C_2 b
    )t
ON(a.old_id_voie_physique = t.old_id_voie_physique)
WHEN MATCHED THEN
    UPDATE SET a.new_id_voie_physique = t.new_id_voie_physique;
-- R�sultat : 837 lignes fusionn�es.

-- Insertion des nouveaux identifiants de voie physique dans la table des voies physiques
MERGE INTO G_BASE_VOIE.TEMP_C_VOIE_PHYSIQUE a
    USING(
        SELECT DISTINCT
            new_id_voie_physique
        FROM
            G_BASE_VOIE.TEMP_C_TRANSIT_TRONCON_VOIE_PHYSIQUE
    )t
ON(a.objectid = t.new_id_voie_physique)
WHEN NOT MATCHED THEN
INSERT(a.objectid)
VALUES(t.new_id_voie_physique);
-- R�sultat : 306 lignes fusionn�es.
    
-- Mise � jour du champ new_id_voie_physique de la table TEMP_C_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE pour raccorder les voies administratives aux nouvelles voies physiques
MERGE INTO G_BASE_VOIE.TEMP_C_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE a
    USING(
        WITH
            C_1 AS(
                SELECT DISTINCT
                    d.fid_voie_physique AS old_id_voie_physique,
                    a.new_id_voie_physique,
                    e.objectid AS id_voie_administrative
                FROM
                    G_BASE_VOIE.TEMP_C_TRANSIT_TRONCON_VOIE_PHYSIQUE a
                    INNER JOIN G_BASE_VOIE.TEMP_C_RELATION_TRONCON_VOIE_PHYSIQUE b ON b.fid_troncon = a.id_troncon
                    INNER JOIN G_BASE_VOIE.TEMP_C_VOIE_PHYSIQUE c ON c.objectid = b.fid_voie_physique
                    INNER JOIN  G_BASE_VOIE.TEMP_C_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE d ON d.fid_voie_physique = c.objectid
                    INNER JOIN G_BASE_VOIE.TEMP_C_VOIE_ADMINISTRATIVE e ON e.objectid = d.fid_voie_administrative
        ),
        
        C_2 AS(
            SELECT
                old_id_voie_physique
            FROM
                C_1
            GROUP BY
                old_id_voie_physique
            HAVING
                COUNT(old_id_voie_physique) > 1
        )
        
        SELECT
            a.*
        FROM
            C_1 a
        WHERE
            a.old_id_voie_physique NOT IN(SELECT old_id_voie_physique FROM C_2)
    )t
ON(a.fid_voie_physique = t.old_id_voie_physique AND a.fid_voie_administrative = t.id_voie_administrative)
WHEN MATCHED THEN
    UPDATE SET a.new_id_voie_physique = t.new_id_voie_physique;
-- R�sultat : 559 lignes fusionn�es.

-- Mise � jour du champ fid_voie_physique de la table TEMP_C_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE
MERGE INTO G_BASE_VOIE.TEMP_C_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE a
    USING(
        WITH
            C_1 AS(
                SELECT
                    new_id_voie_physique
                FROM
                    G_BASE_VOIE.TEMP_C_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE
                GROUP BY
                    new_id_voie_physique
                HAVING
                    COUNT(new_id_voie_physique) > 1
            )
            
            SELECT
                a.old_id_voie_physique,
                a.new_id_voie_physique
            FROM
                G_BASE_VOIE.TEMP_C_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE a
            WHERE
                a.new_id_voie_physique IN(SELECT new_id_voie_physique FROM C_1)
    )t
ON (a.old_id_voie_physique = t.old_id_voie_physique AND a.new_id_voie_physique = t.new_id_voie_physique)
WHEN MATCHED THEN
    UPDATE SET a.fid_voie_physique = t.new_id_voie_physique;
-- R�sultat : 483 lignes fusionn�es
    
-- Mise � jour de la table TEMP_C_RELATION_TRONCON_VOIE_PHYSIQUE
MERGE INTO G_BASE_VOIE.TEMP_C_RELATION_TRONCON_VOIE_PHYSIQUE a
    USING(
        SELECT DISTINCT
            a.id_troncon,
            c.old_id_voie_physique,
            a.new_id_voie_physique
        FROM
            G_BASE_VOIE.TEMP_C_TRANSIT_TRONCON_VOIE_PHYSIQUE a
            INNER JOIN G_BASE_VOIE.TEMP_C_RELATION_TRONCON_VOIE_PHYSIQUE b ON b.fid_voie_physique = a.old_id_voie_physique
            INNER JOIN G_BASE_VOIE.TEMP_C_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE c ON c.fid_voie_physique = a.new_id_voie_physique
    )t
ON (a.fid_troncon = t.id_troncon AND a.old_id_voie_physique = t.old_id_voie_physique)
WHEN MATCHED THEN
    UPDATE SET a.fid_voie_physique = t.new_id_voie_physique;
-- R�sultat : 1�244 lignes fusionn�es

-- Suppression des relations tron�ons/voie physique en trop
DELETE FROM G_BASE_VOIE.TEMP_C_RELATION_TRONCON_VOIE_PHYSIQUE
WHERE
    objectid IN(
        WITH
            C_1 AS(
                SELECT
                    fid_troncon
                FROM
                    G_BASE_VOIE.TEMP_C_RELATION_TRONCON_VOIE_PHYSIQUE
                GROUP BY
                    fid_troncon
                HAVING
                    COUNT(fid_troncon) > 1
            ),
            
            C_2 AS(
                SELECT 
                    MAX(a.objectid) AS objectid,
                    a.fid_troncon
                FROM
                    G_BASE_VOIE.TEMP_C_RELATION_TRONCON_VOIE_PHYSIQUE a
                    INNER JOIN C_1 b ON b.fid_troncon = a.fid_troncon
                GROUP BY
                    a.fid_troncon
            )
            
            SELECT
                objectid
            FROM
                C_2
    );
-- R�sultat : 837 relations supprim�es

-- Remise en place de relations voies physiques/administrative manquantes
MERGE INTO G_BASE_VOIE.TEMP_C_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE a
    USING(
        SELECT DISTINCT
            c.objectid AS id_voie_physique
        FROM
            G_BASE_VOIE.TEMP_C_TRONCON a
            INNER JOIN G_BASE_VOIE.TEMP_C_RELATION_TRONCON_VOIE_PHYSIQUE b ON b.fid_troncon = a.objectid
            INNER JOIN G_BASE_VOIE.TEMP_C_VOIE_PHYSIQUE c ON c.objectid = b.fid_voie_physique
        WHERE
            c.objectid NOT IN(SELECT fid_voie_physique FROM G_BASE_VOIE.TEMP_C_RELATION_VOIE_PHYSIQUE_ADMINISTRATIVE)
    )t
ON(a.fid_voie_physique = t.id_voie_physique AND a.fid_voie_administrative = t.id_voie_physique)
WHEN NOT MATCHED THEN
    INSERT(a.fid_voie_physique, a.fid_voie_administrative)
    VALUES(t.id_voie_physique, t.id_voie_physique);
-- R�sultat : 347 lignes fusionn�es

/


