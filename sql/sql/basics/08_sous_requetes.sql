-- =============================================================================
-- SQL 101 – Fiche 08 : Sous-requêtes (Subqueries)
-- =============================================================================
-- Objectifs :
--   • Comprendre ce qu'est une sous-requête
--   • Sous-requête scalaire dans SELECT
--   • Sous-requête dans WHERE (=, IN, EXISTS)
--   • Sous-requête dans FROM (table dérivée)
--   • Sous-requêtes corrélées
-- =============================================================================
-- 💡 Une sous-requête est une requête SELECT imbriquée dans une autre requête.
--    Elle peut apparaître dans SELECT, FROM, WHERE ou HAVING.
-- =============================================================================


-- -----------------------------------------------------------------------------
-- 1. Sous-requête scalaire dans SELECT
--    Retourne une seule valeur (une ligne, une colonne) utilisée
--    comme colonne calculée dans le résultat principal.
-- -----------------------------------------------------------------------------
-- Afficher chaque note avec la moyenne globale de toutes les notes
SELECT
    eleve_id,
    note,
    (SELECT ROUND(AVG(note), 2) FROM notes) AS moyenne_globale,
    note - (SELECT ROUND(AVG(note), 2) FROM notes) AS ecart_a_la_moyenne
FROM notes
LIMIT 10;


-- -----------------------------------------------------------------------------
-- 2. Sous-requête dans WHERE avec = (valeur unique)
--    La sous-requête doit retourner exactement une valeur.
-- -----------------------------------------------------------------------------
-- Élèves dont la date de naissance est la plus ancienne (le plus âgé)
SELECT nom, prenom, date_naissance
FROM eleves
WHERE date_naissance = (SELECT MIN(date_naissance) FROM eleves);

-- Évaluation ayant la note maximale
SELECT eleve_id, note, evaluation_id
FROM notes
WHERE note = (SELECT MAX(note) FROM notes);


-- -----------------------------------------------------------------------------
-- 3. Sous-requête dans WHERE avec IN (liste de valeurs)
--    La sous-requête retourne une colonne de plusieurs valeurs.
-- -----------------------------------------------------------------------------
-- Élèves inscrits dans une école de type 'Public'
SELECT DISTINCT e.nom, e.prenom
FROM eleves e
JOIN inscriptions i ON i.eleve_id = e.id
JOIN classes c      ON c.id = i.classe_id
WHERE c.ecole_id IN (
    SELECT id
    FROM ecoles
    WHERE type_ecole = 'Public'
)
ORDER BY e.nom
LIMIT 15;

-- Matières ayant au moins une évaluation de type 'Examen'
SELECT nom AS matiere
FROM matieres
WHERE id IN (
    SELECT DISTINCT matiere_id
    FROM evaluations
    WHERE type_evaluation = 'Examen'
)
ORDER BY nom;


-- -----------------------------------------------------------------------------
-- 4. Sous-requête dans WHERE avec NOT IN
--    Élèves qui n'ont jamais eu d'absence
-- -----------------------------------------------------------------------------
SELECT nom, prenom
FROM eleves
WHERE id NOT IN (
    SELECT DISTINCT eleve_id
    FROM absences
)
ORDER BY nom
LIMIT 10;


-- -----------------------------------------------------------------------------
-- 5. Sous-requête dans WHERE avec EXISTS
--    EXISTS est vrai si la sous-requête retourne AU MOINS une ligne.
--    Souvent plus efficace que IN sur de grandes tables.
-- -----------------------------------------------------------------------------
-- Élèves ayant au moins une note supérieure à 18
SELECT nom, prenom
FROM eleves e
WHERE EXISTS (
    SELECT 1
    FROM notes n
    WHERE n.eleve_id = e.id
      AND n.note > 18
)
ORDER BY nom
LIMIT 10;

-- Évaluations pour lesquelles il existe au moins une note saisie
SELECT titre, type_evaluation, date_debut
FROM evaluations ev
WHERE EXISTS (
    SELECT 1
    FROM notes n
    WHERE n.evaluation_id = ev.id
)
ORDER BY date_debut
LIMIT 10;


-- -----------------------------------------------------------------------------
-- 6. Sous-requête dans WHERE avec NOT EXISTS
--    Évaluations sans aucune note saisie
-- -----------------------------------------------------------------------------
SELECT titre, type_evaluation, date_debut
FROM evaluations ev
WHERE NOT EXISTS (
    SELECT 1
    FROM notes n
    WHERE n.evaluation_id = ev.id
)
ORDER BY date_debut
LIMIT 10;


-- -----------------------------------------------------------------------------
-- 7. Sous-requête dans FROM (table dérivée / inline view)
--    La sous-requête est utilisée comme une table temporaire.
--    Elle doit obligatoirement avoir un alias.
-- -----------------------------------------------------------------------------
-- Moyenne par élève, puis filtrer ceux dont la moyenne dépasse 14
SELECT
    eleve_id,
    ROUND(moy, 2) AS moyenne
FROM (
    SELECT eleve_id, AVG(note) AS moy
    FROM notes
    GROUP BY eleve_id
) AS moyennes_par_eleve
WHERE moy > 14
ORDER BY moy DESC
LIMIT 10;

-- Nombre de notes par évaluation, puis ne garder que celles avec plus de 20 notes
SELECT
    evaluation_id,
    nb_notes
FROM (
    SELECT evaluation_id, COUNT(*) AS nb_notes
    FROM notes
    GROUP BY evaluation_id
) AS comptage
WHERE nb_notes > 20
ORDER BY nb_notes DESC;


-- -----------------------------------------------------------------------------
-- 8. Sous-requête corrélée
--    La sous-requête référence une colonne de la requête externe.
--    Elle est ré-exécutée pour chaque ligne de la requête externe.
-- -----------------------------------------------------------------------------
-- Pour chaque élève, afficher sa meilleure note
SELECT
    e.nom,
    e.prenom,
    (
        SELECT MAX(n.note)
        FROM notes n
        WHERE n.eleve_id = e.id
    ) AS meilleure_note
FROM eleves e
ORDER BY meilleure_note DESC NULLS LAST
LIMIT 10;

-- Élèves dont la moyenne est supérieure à la moyenne de leur classe
SELECT
    e.nom,
    e.prenom,
    i.classe_id,
    ROUND(AVG(n.note), 2) AS moyenne_eleve
FROM eleves e
JOIN inscriptions i ON i.eleve_id = e.id
JOIN notes n        ON n.eleve_id = e.id
GROUP BY e.id, e.nom, e.prenom, i.classe_id
HAVING AVG(n.note) > (
    SELECT AVG(n2.note)
    FROM notes n2
    JOIN inscriptions i2 ON i2.eleve_id = n2.eleve_id
    WHERE i2.classe_id = i.classe_id
)
ORDER BY moyenne_eleve DESC
LIMIT 15;


-- -----------------------------------------------------------------------------
-- 9. Sous-requête dans HAVING
--    Comparer un agrégat au résultat d'une sous-requête.
-- -----------------------------------------------------------------------------
-- Matières dont la moyenne des notes est supérieure à la moyenne générale
SELECT
    m.nom          AS matiere,
    ROUND(AVG(n.note), 2) AS moyenne_matiere
FROM notes n
JOIN evaluations ev ON ev.id = n.evaluation_id
JOIN matieres    m  ON m.id  = ev.matiere_id
GROUP BY m.id, m.nom
HAVING AVG(n.note) > (SELECT AVG(note) FROM notes)
ORDER BY moyenne_matiere DESC;
