-- =============================================================================
-- SQL 101 – Fiche 09 : CTE – Common Table Expressions (WITH)
-- =============================================================================
-- Objectifs :
--   • Comprendre la syntaxe WITH … AS (…)
--   • CTE simple pour améliorer la lisibilité
--   • Enchaîner plusieurs CTE
--   • CTE récursive (RECURSIVE)
--   • Différences entre CTE et sous-requête dans FROM
-- =============================================================================
-- 💡 Une CTE est un bloc nommé défini avant la requête principale avec WITH.
--    Elle se comporte comme une table temporaire, visible uniquement
--    dans la requête courante.
-- =============================================================================


-- -----------------------------------------------------------------------------
-- 1. Syntaxe de base – CTE simple
--    WITH nom_cte AS ( SELECT … )
--    SELECT … FROM nom_cte;
-- -----------------------------------------------------------------------------
-- Calculer la moyenne de chaque élève, puis afficher ceux au-dessus de 12
WITH moyennes_eleves AS (
    SELECT
        eleve_id,
        ROUND(AVG(note), 2) AS moyenne
    FROM notes
    GROUP BY eleve_id
)
SELECT
    e.nom,
    e.prenom,
    m.moyenne
FROM moyennes_eleves m
JOIN eleves e ON e.id = m.eleve_id
WHERE m.moyenne >= 12
ORDER BY m.moyenne DESC
LIMIT 15;


-- -----------------------------------------------------------------------------
-- 2. CTE pour remplacer une sous-requête dans FROM
--    Même résultat qu'une table dérivée, mais plus lisible.
-- -----------------------------------------------------------------------------
-- Nombre d'absences par élève (uniquement ceux avec plus de 3 absences)
WITH absences_par_eleve AS (
    SELECT
        eleve_id,
        COUNT(*) AS nb_absences
    FROM absences
    GROUP BY eleve_id
)
SELECT
    e.nom,
    e.prenom,
    a.nb_absences
FROM absences_par_eleve a
JOIN eleves e ON e.id = a.eleve_id
WHERE a.nb_absences > 3
ORDER BY a.nb_absences DESC
LIMIT 10;


-- -----------------------------------------------------------------------------
-- 3. Enchaîner plusieurs CTE
--    On sépare chaque bloc par une virgule.
--    Chaque CTE peut référencer les CTE définies avant elle.
-- -----------------------------------------------------------------------------
-- Étape 1 : moyenne par élève par matière
-- Étape 2 : élèves en difficulté (moyenne < 10 dans au moins une matière)
-- Étape 3 : affichage final avec le nom de la matière
WITH moyennes_par_matiere AS (
    SELECT
        n.eleve_id,
        ev.matiere_id,
        ROUND(AVG(n.note), 2) AS moy
    FROM notes n
    JOIN evaluations ev ON ev.id = n.evaluation_id
    GROUP BY n.eleve_id, ev.matiere_id
),
eleves_en_difficulte AS (
    SELECT DISTINCT eleve_id
    FROM moyennes_par_matiere
    WHERE moy < 10
),
details_difficultes AS (
    SELECT
        m.eleve_id,
        mat.nom        AS matiere,
        m.moy          AS moyenne_matiere
    FROM moyennes_par_matiere m
    JOIN matieres mat ON mat.id = m.matiere_id
    WHERE m.moy < 10
      AND m.eleve_id IN (SELECT eleve_id FROM eleves_en_difficulte)
)
SELECT
    e.nom,
    e.prenom,
    d.matiere,
    d.moyenne_matiere
FROM details_difficultes d
JOIN eleves e ON e.id = d.eleve_id
ORDER BY e.nom, d.moyenne_matiere
LIMIT 20;


-- -----------------------------------------------------------------------------
-- 4. CTE pour pré-agréger et simplifier une requête complexe
-- -----------------------------------------------------------------------------
-- Classement des classes par moyenne générale
WITH notes_par_classe AS (
    SELECT
        c.id           AS classe_id,
        c.nom          AS classe,
        ec.nom         AS ecole,
        AVG(n.note)    AS moyenne_classe
    FROM notes n
    JOIN inscriptions i ON i.eleve_id = n.eleve_id
    JOIN classes      c ON c.id = i.classe_id
    JOIN ecoles       ec ON ec.id = c.ecole_id
    GROUP BY c.id, c.nom, ec.nom
)
SELECT
    classe,
    ecole,
    ROUND(moyenne_classe, 2) AS moyenne,
    RANK() OVER (ORDER BY moyenne_classe DESC) AS classement
FROM notes_par_classe
ORDER BY classement
LIMIT 10;


-- -----------------------------------------------------------------------------
-- 5. CTE réutilisée plusieurs fois dans la même requête
--    Une CTE peut être référencée plusieurs fois sans la réécrire.
-- -----------------------------------------------------------------------------
-- Comparer la moyenne de chaque élève à la meilleure et pire moyenne globale
WITH stats_eleves AS (
    SELECT
        eleve_id,
        ROUND(AVG(note), 2) AS moyenne
    FROM notes
    GROUP BY eleve_id
)
SELECT
    e.nom,
    e.prenom,
    s.moyenne,
    (SELECT MAX(moyenne) FROM stats_eleves) AS meilleure_moy,
    (SELECT MIN(moyenne) FROM stats_eleves) AS pire_moy,
    ROUND(s.moyenne - (SELECT AVG(moyenne) FROM stats_eleves), 2) AS ecart_a_la_moy_generale
FROM stats_eleves s
JOIN eleves e ON e.id = s.eleve_id
ORDER BY s.moyenne DESC
LIMIT 10;


-- -----------------------------------------------------------------------------
-- 6. CTE récursive (RECURSIVE)
--    Permet d'écrire des requêtes hiérarchiques ou itératives.
--    Syntaxe : WITH RECURSIVE nom_cte AS (
--                  -- ancre (cas de base)
--                  UNION ALL
--                  -- partie récursive (référence la CTE elle-même)
--              )
-- -----------------------------------------------------------------------------
-- Générer une suite de nombres de 1 à 10
WITH RECURSIVE serie AS (
    SELECT 1 AS n          -- ancre
    UNION ALL
    SELECT n + 1           -- partie récursive
    FROM serie
    WHERE n < 10           -- condition d'arrêt
)
SELECT n FROM serie;

-- Générer les dates d'une année scolaire semaine par semaine
WITH RECURSIVE semaines AS (
    SELECT
        date_debut                            AS semaine,
        date_fin                              AS fin_annee
    FROM annees_scolaires
    WHERE libelle = '2022-2023'               -- ancre : première semaine
    LIMIT 1
    UNION ALL
    SELECT
        semaine + INTERVAL '7 days',
        fin_annee
    FROM semaines
    WHERE semaine + INTERVAL '7 days' <= fin_annee  -- condition d'arrêt
)
SELECT semaine::date AS debut_semaine FROM semaines;


-- -----------------------------------------------------------------------------
-- 7. CTE vs sous-requête dans FROM – comparaison
-- -----------------------------------------------------------------------------
-- Les deux requêtes ci-dessous produisent le même résultat.
-- La CTE est souvent préférée pour sa lisibilité.

-- Version sous-requête dans FROM :
SELECT e.nom, e.prenom, sub.moyenne
FROM eleves e
JOIN (
    SELECT eleve_id, ROUND(AVG(note), 2) AS moyenne
    FROM notes
    GROUP BY eleve_id
) sub ON sub.eleve_id = e.id
WHERE sub.moyenne > 15
ORDER BY sub.moyenne DESC;

-- Version CTE équivalente :
WITH moyennes AS (
    SELECT eleve_id, ROUND(AVG(note), 2) AS moyenne
    FROM notes
    GROUP BY eleve_id
)
SELECT e.nom, e.prenom, m.moyenne
FROM moyennes m
JOIN eleves e ON e.id = m.eleve_id
WHERE m.moyenne > 15
ORDER BY m.moyenne DESC;
