# Conception du Jeu du Pendu

## Description du jeu

Le **jeu du pendu** est un jeu de devinettes où le joueur doit deviner un mot secret lettre par lettre.

### Règles du jeu

1. Un mot secret est choisi aléatoirement dans une liste prédéfinie
2. Le mot est affiché avec des tirets représentant chaque lettre
3. Le joueur propose une lettre à chaque tour
4. Si la lettre est dans le mot, elle est révélée à toutes ses positions
5. Si la lettre n'est pas dans le mot, le joueur perd une vie (erreur)
6. Le joueur a un nombre limité d'erreurs (généralement 6)
7. Le joueur gagne s'il devine toutes les lettres avant d'épuiser ses vies
8. Le joueur perd s'il fait trop d'erreurs

### Exemple de partie

```
Mot secret : PYTHON

Tour 1 : _ _ _ _ _ _
Joueur propose : E
→ Lettre incorrecte ! Erreurs : 1/6

Tour 2 : _ _ _ _ _ _
Joueur propose : P
→ Bonne lettre !
État : P _ _ _ _ _

Tour 3 : P _ _ _ _ _
Joueur propose : Y
→ Bonne lettre !
État : P Y _ _ _ _

Tour 4 : P Y _ _ _ _
Joueur propose : T
→ Bonne lettre !
État : P Y T _ _ _

... et ainsi de suite jusqu'à la victoire ou la défaite
```


## Architecture fonctionnelle

Le jeu est décomposé en plusieurs fonctions indépendantes et réutilisables :

### Fonctions principales

1. **choisir_mot()** : Sélection du mot secret
2. **initialiser_jeu()** : Initialisation de l'état du jeu
3. **afficher_etat()** : Affichage de l'état actuel
4. **tester_lettre()** : Validation d'une lettre
5. **verifier_victoire()** : Vérification de la condition de victoire
6. **afficher_pendu()** : Affichage visuel du pendu
7. **jouer()** : Fonction principale orchestrant le jeu


## Pseudo-code détaillé

### Fonction 1 : choisir_mot()

```
FONCTION choisir_mot()
  """
  Choisit un mot aléatoirement dans une liste prédéfinie.
  
  Paramètres:
    Aucun
  
  Retourne:
    chaîne: le mot choisi (en minuscules)
  """
  
  liste_mots ← ["python", "algorithme", "fonction", "variable", 
                "boucle", "condition", "iteration", "module"]
  
  index_aleatoire ← nombre_aleatoire(0, longueur(liste_mots) - 1)
  mot ← liste_mots[index_aleatoire]
  
  RETOURNER mot
FIN FONCTION
```

**Caractéristiques :**
- Pure function : ❌ (utilise l'aléatoire)
- Side effects : ❌
- Testabilité : moyenne (dépend de l'aléatoire)


### Fonction 2 : initialiser_jeu()

```
FONCTION initialiser_jeu()
  """
  Initialise l'état du jeu avec les valeurs de départ.
  
  Paramètres:
    Aucun
  
  Retourne:
    dictionnaire: état initial du jeu contenant:
      - mot: le mot secret
      - lettres_trouvees: liste vide
      - lettres_essayees: liste vide
      - erreurs: 0
      - erreurs_max: 6
      - terminé: FAUX
      - victoire: FAUX
  """
  
  etat ← {
    "mot": choisir_mot(),
    "lettres_trouvees": [],
    "lettres_essayees": [],
    "erreurs": 0,
    "erreurs_max": 6,
    "terminé": FAUX,
    "victoire": FAUX
  }
  
  RETOURNER etat
FIN FONCTION
```

**Caractéristiques :**
- Pure function : ❌ (appelle choisir_mot)
- Side effects : ❌
- Testabilité : moyenne


### Fonction 3 : afficher_etat(mot, lettres_trouvees)

```
FONCTION afficher_etat(mot, lettres_trouvees)
  """
  Affiche l'état actuel du mot avec les lettres trouvées et des tirets.
  
  Paramètres:
    mot (chaîne): le mot secret
    lettres_trouvees (liste): lettres déjà trouvées
  
  Retourne:
    chaîne: représentation du mot avec lettres et tirets
  
  Exemple:
    mot = "python", lettres_trouvees = ["p", "t", "h"]
    Retourne: "p _ t h _ _"
  """
  
  affichage ← ""
  
  POUR chaque lettre dans mot FAIRE
    SI lettre DANS lettres_trouvees ALORS
      affichage ← affichage + lettre + " "
    SINON
      affichage ← affichage + "_ "
    FIN SI
  FIN POUR
  
  RETOURNER affichage
FIN FONCTION
```

**Caractéristiques :**
- Pure function : ✅
- Side effects : ❌
- Testabilité : excellente


### Fonction 4 : tester_lettre(mot, lettre, lettres_trouvees)

```
FONCTION tester_lettre(mot, lettre, lettres_trouvees)
  """
  Teste si une lettre est présente dans le mot.
  Si oui, l'ajoute aux lettres trouvées.
  
  Paramètres:
    mot (chaîne): le mot secret
    lettre (chaîne): la lettre proposée par le joueur
    lettres_trouvees (liste): lettres déjà trouvées (modifié)
  
  Retourne:
    booléen: VRAI si la lettre est dans le mot, FAUX sinon
  """
  
  lettre ← mettre_en_minuscule(lettre)
  
  SI lettre DANS mot ALORS
    -- Ajouter toutes les occurrences aux lettres trouvées
    POUR chaque caractere dans mot FAIRE
      SI caractere = lettre ET caractere NON DANS lettres_trouvees ALORS
        AJOUTER caractere À lettres_trouvees
      FIN SI
    FIN POUR
    RETOURNER VRAI
  SINON
    RETOURNER FAUX
  FIN SI
FIN FONCTION
```

**Caractéristiques :**
- Pure function : ❌ (modifie lettres_trouvees)
- Side effects : ✅ (modifie la liste en paramètre)
- Testabilité : bonne


### Fonction 5 : verifier_victoire(mot, lettres_trouvees)

```
FONCTION verifier_victoire(mot, lettres_trouvees)
  """
  Vérifie si le joueur a trouvé toutes les lettres du mot.
  
  Paramètres:
    mot (chaîne): le mot secret
    lettres_trouvees (liste): lettres déjà trouvées
  
  Retourne:
    booléen: VRAI si toutes les lettres sont trouvées, FAUX sinon
  """
  
  lettres_uniques_mot ← ensemble_unique(mot)
  
  POUR chaque lettre dans lettres_uniques_mot FAIRE
    SI lettre NON DANS lettres_trouvees ALORS
      RETOURNER FAUX
    FIN SI
  FIN POUR
  
  RETOURNER VRAI
FIN FONCTION
```

**Caractéristiques :**
- Pure function : ✅
- Side effects : ❌
- Testabilité : excellente


### Fonction 6 : afficher_pendu(erreurs)

```
FONCTION afficher_pendu(erreurs)
  """
  Affiche une représentation visuelle ASCII du pendu selon le nombre d'erreurs.
  
  Paramètres:
    erreurs (entier): nombre d'erreurs commises (0 à 6)
  
  Retourne:
    Aucune (affichage uniquement)
  """
  
  dessins ← [
    -- 0 erreur
    """
       ------
       |    |
       |
       |
       |
       |
    --------
    """,
    
    -- 1 erreur (tête)
    """
       ------
       |    |
       |    O
       |
       |
       |
    --------
    """,
    
    -- 2 erreurs (corps)
    """
       ------
       |    |
       |    O
       |    |
       |
       |
    --------
    """,
    
    -- 3 erreurs (bras gauche)
    """
       ------
       |    |
       |    O
       |   /|
       |
       |
    --------
    """,
    
    -- 4 erreurs (bras droit)
    """
       ------
       |    |
       |    O
       |   /|\\
       |
       |
    --------
    """,
    
    -- 5 erreurs (jambe gauche)
    """
       ------
       |    |
       |    O
       |   /|\\
       |   /
       |
    --------
    """,
    
    -- 6 erreurs (jambe droite - perdu)
    """
       ------
       |    |
       |    O
       |   /|\\
       |   / \\
       |
    --------
    """
  ]
  
  AFFICHER dessins[erreurs]
FIN FONCTION
```

**Caractéristiques :**
- Pure function : ❌ (affichage)
- Side effects : ✅ (affichage console)
- Testabilité : faible (side effect visuel)


### Fonction 7 : jouer() - Fonction principale

```
FONCTION jouer()
  """
  Fonction principale du jeu.
  Gère la boucle de jeu et coordonne toutes les autres fonctions.
  
  Paramètres:
    Aucun
  
  Retourne:
    Aucune
  """
  
  -- Initialisation
  etat ← initialiser_jeu()
  mot ← etat["mot"]
  lettres_trouvees ← etat["lettres_trouvees"]
  lettres_essayees ← etat["lettres_essayees"]
  erreurs ← etat["erreurs"]
  erreurs_max ← etat["erreurs_max"]
  
  -- Message de bienvenue
  AFFICHER "==================================="
  AFFICHER "    BIENVENUE AU JEU DU PENDU     "
  AFFICHER "==================================="
  AFFICHER ""
  AFFICHER "Vous avez", erreurs_max, "essais pour deviner le mot."
  AFFICHER ""
  
  -- Boucle principale du jeu
  TANT QUE erreurs < erreurs_max FAIRE
    -- Affichage de l'état
    AFFICHER "-----------------------------------"
    afficher_pendu(erreurs)
    AFFICHER ""
    AFFICHER "Mot à deviner :", afficher_etat(mot, lettres_trouvees)
    AFFICHER "Erreurs :", erreurs, "/", erreurs_max
    AFFICHER "Lettres essayées :", lettres_essayees
    AFFICHER ""
    
    -- Demander une lettre au joueur
    AFFICHER "Proposez une lettre : "
    lettre ← LIRE entrée_utilisateur()
    lettre ← mettre_en_minuscule(lettre)
    
    -- Validation de l'entrée
    SI longueur(lettre) ≠ 1 OU NON est_lettre(lettre) ALORS
      AFFICHER "⚠ Veuillez entrer une seule lettre valide."
      CONTINUER
    FIN SI
    
    -- Vérifier si la lettre a déjà été essayée
    SI lettre DANS lettres_essayees ALORS
      AFFICHER "⚠ Vous avez déjà essayé cette lettre."
      CONTINUER
    FIN SI
    
    -- Ajouter la lettre aux lettres essayées
    AJOUTER lettre À lettres_essayees
    
    -- Tester la lettre
    resultat ← tester_lettre(mot, lettre, lettres_trouvees)
    
    SI resultat = VRAI ALORS
      AFFICHER "✓ Bonne lettre !"
    SINON
      erreurs ← erreurs + 1
      AFFICHER "✗ Lettre incorrecte !"
    FIN SI
    
    AFFICHER ""
    
    -- Vérifier la condition de victoire
    SI verifier_victoire(mot, lettres_trouvees) ALORS
      AFFICHER "==================================="
      AFFICHER "   🎉 FÉLICITATIONS ! 🎉          "
      AFFICHER "   Vous avez gagné !              "
      AFFICHER "==================================="
      AFFICHER ""
      AFFICHER "Le mot était :", mot
      AFFICHER "Nombre d'erreurs :", erreurs, "/", erreurs_max
      RETOURNER
    FIN SI
  FIN TANT QUE
  
  -- Défaite (sortie de boucle = trop d'erreurs)
  afficher_pendu(erreurs)
  AFFICHER ""
  AFFICHER "==================================="
  AFFICHER "      💀 PERDU ! 💀               "
  AFFICHER "==================================="
  AFFICHER ""
  AFFICHER "Le mot était :", mot
FIN FONCTION
```

**Caractéristiques :**
- Pure function : ❌
- Side effects : ✅ (I/O utilisateur, affichages)
- Testabilité : faible (nombreux side effects)


## Diagramme fonctionnel

```
┌─────────────────────────────────────────────────────────┐
│                    jouer()                               │
│         (Fonction principale - Orchestration)            │
└──────────────────────┬──────────────────────────────────┘
                       │
                       │
         ┌─────────────┼─────────────┐
         │             │             │
         ▼             ▼             ▼
┌────────────────┐ ┌────────────────┐ ┌────────────────┐
│ initialiser_   │ │  afficher_     │ │  afficher_     │
│    jeu()       │ │   pendu()      │ │   etat()       │
└───────┬────────┘ └────────────────┘ └────────────────┘
        │                                   Pure ✓
        │                                   
        ▼                                   
┌────────────────┐
│  choisir_      │
│    mot()       │
└────────────────┘


         ┌─────────────┼─────────────┐
         │             │             │
         ▼             ▼             ▼
┌────────────────┐ ┌────────────────┐ ┌────────────────┐
│  tester_       │ │  verifier_     │ │  (validation   │
│   lettre()     │ │   victoire()   │ │   entrées)     │
└────────────────┘ └────────────────┘ └────────────────┘
   Side effect        Pure ✓            Pure ✓
   (modifie liste)
```

### Légende

- **Pure ✓** : Fonction pure sans effets de bord
- **Side effect** : Fonction avec effets de bord (modification d'état, I/O)


## Relations entre fonctions

```
jouer()
│
├─► initialiser_jeu()
│   └─► choisir_mot()
│
├─► afficher_pendu(erreurs)
│
├─► afficher_etat(mot, lettres_trouvees)  [Pure]
│
├─► tester_lettre(mot, lettre, lettres_trouvees)  [Modifie état]
│
└─► verifier_victoire(mot, lettres_trouvees)  [Pure]
```


## État du jeu

L'état du jeu est représenté par les variables suivantes :

```
{
  "mot": chaîne,                    -- Le mot secret
  "lettres_trouvees": liste,        -- Lettres correctement devinées
  "lettres_essayees": liste,        -- Toutes les lettres essayées
  "erreurs": entier,                -- Nombre d'erreurs commises
  "erreurs_max": entier,            -- Nombre maximum d'erreurs (6)
  "terminé": booléen,               -- Jeu terminé ?
  "victoire": booléen               -- Victoire ou défaite ?
}
```


## Cas d'usage

### Cas 1 : Victoire

```
Initialisation: mot = "python", erreurs_max = 6
Tour 1: 'p' → ✓ État: "p _ _ _ _ _"
Tour 2: 'y' → ✓ État: "p y _ _ _ _"
Tour 3: 't' → ✓ État: "p y t _ _ _"
Tour 4: 'h' → ✓ État: "p y t h _ _"
Tour 5: 'o' → ✓ État: "p y t h o _"
Tour 6: 'n' → ✓ État: "p y t h o n"
Résultat: VICTOIRE (6 tours, 0 erreurs)
```


### Cas 2 : Défaite

```
Initialisation: mot = "python", erreurs_max = 6
Tour 1: 'a' → ✗ Erreurs: 1/6
Tour 2: 'e' → ✗ Erreurs: 2/6
Tour 3: 'i' → ✗ Erreurs: 3/6
Tour 4: 'u' → ✗ Erreurs: 4/6
Tour 5: 's' → ✗ Erreurs: 5/6
Tour 6: 'r' → ✗ Erreurs: 6/6
Résultat: DÉFAITE (6 erreurs atteintes)
```


### Cas 3 : Victoire avec erreurs

```
Initialisation: mot = "code", erreurs_max = 6
Tour 1: 'a' → ✗ Erreurs: 1/6
Tour 2: 'c' → ✓ État: "c _ _ _"
Tour 3: 'b' → ✗ Erreurs: 2/6
Tour 4: 'o' → ✓ État: "c o _ _"
Tour 5: 'd' → ✓ État: "c o d _"
Tour 6: 'e' → ✓ État: "c o d e"
Résultat: VICTOIRE (6 tours, 2 erreurs)
```


## Extensions possibles

### Version simple (minimale)
- Mot secret prédéfini
- Pas de graphisme
- Messages texte basiques

### Version avancée
- Choix de difficulté (mots courts/longs)
- Catégories de mots (animaux, informatique, etc.)
- Sauvegarde des scores
- Affichage graphique amélioré
- Timer pour limiter le temps de réflexion
- Mode multijoueur


## Avantages de cette conception

### Modularité
✅ Chaque fonction a une responsabilité unique
✅ Les fonctions peuvent être testées indépendamment
✅ Facile d'ajouter de nouvelles fonctionnalités

### Réutilisabilité
✅ `afficher_etat()` peut être utilisée ailleurs
✅ `verifier_victoire()` est une fonction pure facilement portable

### Testabilité
✅ Les fonctions pures sont faciles à tester
✅ Les fonctions avec side effects sont isolées
✅ Possibilité de créer des tests unitaires

### Lisibilité
✅ Noms de fonctions explicites
✅ Pseudo-code clair et commenté
✅ Docstrings complètes


## Implémentation recommandée

Pour l'implémentation en Python (session S6), suivez cet ordre :

1. **Phase 1** : Implémenter les fonctions pures
   - `afficher_etat()`
   - `verifier_victoire()`

2. **Phase 2** : Implémenter les fonctions utilitaires
   - `choisir_mot()`
   - `initialiser_jeu()`

3. **Phase 3** : Implémenter les fonctions avec side effects
   - `tester_lettre()`
   - `afficher_pendu()`

4. **Phase 4** : Implémenter la boucle principale
   - `jouer()`

5. **Phase 5** : Ajouter les améliorations
   - Validation des entrées
   - Gestion d'erreurs
   - Messages utilisateur
   - Sauvegarde des scores (JSON)


## Conclusion

Cette conception modulaire du jeu du pendu démontre :

- La décomposition d'un problème en sous-problèmes
- L'importance des fonctions réutilisables
- La distinction entre fonctions pures et fonctions avec effets de bord
- L'utilité de la documentation (docstrings)

Ce design servira de base pour l'implémentation en Python lors de la session S6.
