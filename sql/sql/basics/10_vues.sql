-- =============================================================================
-- SQL 101 – Fiche 10 : Vues (Views)
-- =============================================================================
-- Objectifs :
--   • Créer une vue avec CREATE VIEW
--   • Interroger une vue comme une table
--   • Modifier ou supprimer une vue
--   • Vues avec filtres et calculs
--   • Vue matérialisée (MATERIALIZED VIEW)
-- =============================================================================
-- 💡 Une vue est une requête SELECT sauvegardée sous un nom.
--    Elle ne stocke pas de données (sauf vue matérialisée) : chaque appel
--    ré-exécute la requête sous-jacente.
-- =============================================================================


-- =============================================================================
-- A. CRÉER ET UTILISER UNE VUE
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 1. Syntaxe de base – CREATE VIEW
--    CREATE VIEW nom_vue AS SELECT … ;
-- -----------------------------------------------------------------------------
-- Vue : informations complètes sur chaque élève avec son pays
CREATE VIEW v_eleves_pays AS
SELECT
    e.id,
    e.nom,
    e.prenom,
    e.genre,
    e.date_naissance,
    p.nom   AS pays_nationalite
FROM eleves e
LEFT JOIN pays p ON p.code_iso = e.nationalite;


-- Utiliser la vue comme une table ordinaire
SELECT * FROM v_eleves_pays LIMIT 10;

SELECT nom, prenom, pays_nationalite
FROM v_eleves_pays
WHERE genre = 'F'
ORDER BY nom
LIMIT 10;


-- -----------------------------------------------------------------------------
-- 2. Vue avec calculs et agrégats
-- -----------------------------------------------------------------------------
-- Vue : moyenne de chaque élève par matière et par trimestre
CREATE VIEW v_moyennes_eleves AS
SELECT
    e.id             AS eleve_id,
    e.nom            AS eleve_nom,
    e.prenom         AS eleve_prenom,
    m.nom            AS matiere,
    ev.trimestre,
    a.libelle        AS annee_scolaire,
    ROUND(AVG(n.note), 2) AS moyenne_matiere
FROM notes n
JOIN eleves          e   ON e.id   = n.eleve_id
JOIN evaluations     ev  ON ev.id  = n.evaluation_id
JOIN matieres        m   ON m.id   = ev.matiere_id
JOIN inscriptions    i   ON i.eleve_id = e.id
JOIN annees_scolaires a  ON a.id   = i.annee_scolaire_id
GROUP BY e.id, e.nom, e.prenom, m.nom, ev.trimestre, a.libelle;


-- Interroger la vue : top 10 en Mathématiques au trimestre 1
SELECT
    eleve_nom,
    eleve_prenom,
    annee_scolaire,
    ROUND(moyenne_matiere, 2) AS moy_maths
FROM v_moyennes_eleves
WHERE matiere    = 'Mathématiques'
  AND trimestre  = 1
ORDER BY moy_maths DESC
LIMIT 10;


-- -----------------------------------------------------------------------------
-- 3. Vue avec jointures multiples (tableau de bord)
-- -----------------------------------------------------------------------------
-- Vue : résumé des absences par élève et par année scolaire
CREATE VIEW v_absences_eleves AS
SELECT
    e.id             AS eleve_id,
    e.nom,
    e.prenom,
    a.libelle        AS annee_scolaire,
    COUNT(ab.id)     AS nb_absences,
    SUM(ab.date_fin - ab.date_debut + 1) AS total_jours_absents,
    COUNT(ab.id) FILTER (WHERE ab.justifiee = TRUE)  AS absences_justifiees,
    COUNT(ab.id) FILTER (WHERE ab.justifiee = FALSE) AS absences_non_justifiees
FROM eleves e
JOIN inscriptions    i  ON i.eleve_id = e.id
JOIN annees_scolaires a ON a.id = i.annee_scolaire_id
LEFT JOIN absences   ab ON ab.eleve_id = e.id
GROUP BY e.id, e.nom, e.prenom, a.libelle;


-- Élèves avec le plus d'absences non justifiées
SELECT nom, prenom, annee_scolaire, absences_non_justifiees
FROM v_absences_eleves
ORDER BY absences_non_justifiees DESC
LIMIT 10;


-- =============================================================================
-- B. MODIFIER ET SUPPRIMER UNE VUE
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 4. Remplacer une vue existante – CREATE OR REPLACE VIEW
--    Modifie la définition sans supprimer/recréer manuellement.
--    ⚠️  La nouvelle définition doit contenir les mêmes colonnes (même ordre
--    et même type) pour les colonnes déjà existantes.
-- -----------------------------------------------------------------------------
CREATE OR REPLACE VIEW v_eleves_pays AS
SELECT
    e.id,
    e.nom,
    e.prenom,
    e.genre,
    e.date_naissance,
    EXTRACT(YEAR FROM AGE(e.date_naissance)) AS age,  -- colonne ajoutée
    p.nom   AS pays_nationalite
FROM eleves e
LEFT JOIN pays p ON p.code_iso = e.nationalite;


-- -----------------------------------------------------------------------------
-- 5. Supprimer une vue
-- -----------------------------------------------------------------------------
-- DROP VIEW supprime la vue (pas les données de la table sous-jacente)
DROP VIEW IF EXISTS v_eleves_pays;

-- Recréer après suppression si nécessaire
CREATE VIEW v_eleves_pays AS
SELECT
    e.id,
    e.nom,
    e.prenom,
    e.genre,
    e.date_naissance,
    p.nom   AS pays_nationalite
FROM eleves e
LEFT JOIN pays p ON p.code_iso = e.nationalite;


-- =============================================================================
-- C. VUES FILTRÉES (vues partielles)
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 6. Vue sur un sous-ensemble de données
-- -----------------------------------------------------------------------------
-- Vue : uniquement les élèves de sexe masculin
CREATE VIEW v_eleves_garcons AS
SELECT id, nom, prenom, date_naissance
FROM eleves
WHERE genre = 'M';

-- Vue : notes insuffisantes (< 10)
CREATE VIEW v_notes_insuffisantes AS
SELECT
    n.eleve_id,
    e.nom || ' ' || e.prenom AS eleve,
    m.nom                    AS matiere,
    ev.trimestre,
    n.note
FROM notes n
JOIN eleves      e  ON e.id  = n.eleve_id
JOIN evaluations ev ON ev.id = n.evaluation_id
JOIN matieres    m  ON m.id  = ev.matiere_id
WHERE n.note < 10
ORDER BY n.note;

-- Utiliser la vue pour dénombrer les insuffisances par matière
SELECT matiere, COUNT(*) AS nb_notes_insuffisantes
FROM v_notes_insuffisantes
GROUP BY matiere
ORDER BY nb_notes_insuffisantes DESC;


-- =============================================================================
-- D. VUES MATÉRIALISÉES (MATERIALIZED VIEW)
-- =============================================================================
-- 💡 Contrairement à une vue classique, une vue matérialisée stocke
--    physiquement le résultat de la requête. Elle doit être rafraîchie
--    manuellement (REFRESH) pour refléter les nouvelles données.
--    Plus rapide en lecture, mais données potentiellement obsolètes.

-- -----------------------------------------------------------------------------
-- 7. Créer une vue matérialisée
-- -----------------------------------------------------------------------------
CREATE MATERIALIZED VIEW mv_stats_notes AS
SELECT
    m.nom            AS matiere,
    ev.trimestre,
    COUNT(n.id)      AS nb_notes,
    ROUND(AVG(n.note), 2)  AS moyenne,
    ROUND(MIN(n.note), 2)  AS note_min,
    ROUND(MAX(n.note), 2)  AS note_max
FROM notes n
JOIN evaluations ev ON ev.id = n.evaluation_id
JOIN matieres    m  ON m.id  = ev.matiere_id
GROUP BY m.nom, ev.trimestre
ORDER BY m.nom, ev.trimestre;


-- Interroger la vue matérialisée (très rapide, lit les données stockées)
SELECT * FROM mv_stats_notes;

-- -----------------------------------------------------------------------------
-- 8. Rafraîchir une vue matérialisée
--    À exécuter après chaque mise à jour significative des données source.
-- -----------------------------------------------------------------------------
REFRESH MATERIALIZED VIEW mv_stats_notes;

-- Rafraîchissement sans blocage en lecture (PostgreSQL 9.4+)
REFRESH MATERIALIZED VIEW CONCURRENTLY mv_stats_notes;

-- -----------------------------------------------------------------------------
-- 9. Supprimer une vue matérialisée
-- -----------------------------------------------------------------------------
DROP MATERIALIZED VIEW IF EXISTS mv_stats_notes;


-- =============================================================================
-- E. BONNES PRATIQUES
-- =============================================================================
-- • Préfixer les vues avec "v_" et les vues matérialisées avec "mv_"
--   pour les distinguer facilement des tables.
-- • Éviter les vues trop imbriquées (vue sur vue sur vue) : difficile
--   à maintenir et à optimiser.
-- • Utiliser les vues matérialisées pour les rapports lourds (tableaux
--   de bord, agrégats coûteux) exécutés fréquemment.
-- • Toujours utiliser CREATE OR REPLACE plutôt que DROP + CREATE
--   pour préserver les droits accordés sur la vue.
