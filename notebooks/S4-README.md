# S4 — Modularité, fonctions et bonnes pratiques

## Objectifs pédagogiques

À l'issue de cette séance, l'apprenant doit être capable de :

* Comprendre le concept de **fonction** et son utilité
* Créer des fonctions avec paramètres et valeurs de retour
* Distinguer **pure functions** et **side effects**
* Écrire des **docstrings** claires et informatives
* Gérer les erreurs de base avec **try/except**
* Décomposer un problème complexe en fonctions réutilisables
* Concevoir un algorithme en pseudo-code avant implémentation


## Introduction — Pourquoi les fonctions ?

Les **fonctions** sont des blocs de code réutilisables qui effectuent une tâche spécifique.

### Avantages des fonctions :

* **Réutilisabilité** : éviter la duplication de code
* **Modularité** : découper un problème complexe en sous-problèmes
* **Lisibilité** : donner un nom explicite à une opération
* **Testabilité** : tester chaque fonction indépendamment
* **Maintenabilité** : modifier une seule fois pour tous les usages


## 1. Anatomie d'une fonction

### 1.1 Structure générale

**En pseudo-code :**

```
FONCTION nom_fonction(paramètre1, paramètre2)
  -- Corps de la fonction
  RETOURNER résultat
FIN FONCTION
```

**Composants :**

1. **Nom** : identifiant de la fonction
2. **Paramètres** : données d'entrée (optionnels)
3. **Corps** : instructions à exécuter
4. **Valeur de retour** : résultat produit (optionnel)


### 1.2 Exemple simple — Calculer le carré d'un nombre

**Pseudo-code :**

```
FONCTION carre(nombre)
  resultat ← nombre * nombre
  RETOURNER resultat
FIN FONCTION

-- Utilisation
x ← 5
y ← carre(x)
AFFICHER y  -- Affiche 25
```


### 1.3 Fonction sans paramètres

```
FONCTION dire_bonjour()
  AFFICHER "Bonjour !"
FIN FONCTION

-- Utilisation
dire_bonjour()  -- Affiche "Bonjour !"
```


### 1.4 Fonction sans valeur de retour

Certaines fonctions effectuent des actions mais ne retournent pas de valeur.

```
FONCTION afficher_table_multiplication(nombre)
  POUR i DE 1 À 10 FAIRE
    AFFICHER nombre, "×", i, "=", nombre * i
  FIN POUR
FIN FONCTION
```


## 2. Paramètres et valeurs de retour

### 2.1 Paramètres multiples

```
FONCTION calculer_moyenne(a, b, c)
  somme ← a + b + c
  moyenne ← somme / 3
  RETOURNER moyenne
FIN FONCTION

-- Utilisation
resultat ← calculer_moyenne(12, 15, 18)
AFFICHER resultat  -- Affiche 15
```


### 2.2 Valeurs de retour multiples (concept)

Certains langages permettent de retourner plusieurs valeurs :

```
FONCTION diviser_avec_reste(dividende, diviseur)
  quotient ← dividende DIV diviseur
  reste ← dividende MOD diviseur
  RETOURNER quotient, reste
FIN FONCTION

-- Utilisation
q, r ← diviser_avec_reste(17, 5)
AFFICHER q  -- Affiche 3
AFFICHER r  -- Affiche 2
```


### 2.3 Paramètres par défaut (concept)

Certains paramètres peuvent avoir des valeurs par défaut :

```
FONCTION saluer(nom, titre = "Monsieur")
  AFFICHER titre, nom
FIN FONCTION

-- Utilisations possibles
saluer("Dupont")              -- Affiche "Monsieur Dupont"
saluer("Martin", "Madame")    -- Affiche "Madame Martin"
```


## 3. Pure functions vs Side effects

### 3.1 Pure functions (Fonctions pures)

Une **fonction pure** :

* Ne dépend que de ses paramètres
* Retourne toujours le même résultat pour les mêmes entrées
* N'a pas d'effet de bord (ne modifie rien en dehors de son scope)

**Exemple de fonction pure :**

```
FONCTION additionner(a, b)
  RETOURNER a + b
FIN FONCTION
```

✅ Cette fonction est pure car :
- Elle ne dépend que de `a` et `b`
- Elle ne modifie aucune variable externe
- Elle retourne toujours le même résultat pour les mêmes entrées


### 3.2 Side effects (Effets de bord)

Un **effet de bord** se produit quand une fonction modifie quelque chose en dehors de son scope :

* Modifier une variable globale
* Écrire dans un fichier
* Afficher à l'écran
* Modifier un paramètre mutable

**Exemple avec effet de bord :**

```
compteur ← 0  -- Variable globale

FONCTION incrementer()
  compteur ← compteur + 1  -- Modifie une variable externe
FIN FONCTION
```

❌ Cette fonction a un effet de bord car elle modifie `compteur` qui est externe.


### 3.3 Pourquoi préférer les fonctions pures ?

**Avantages :**

* Plus faciles à tester
* Plus faciles à comprendre
* Pas de dépendances cachées
* Peuvent être exécutées en parallèle sans risque

**Conseil :** Privilégier les fonctions pures quand c'est possible, isoler les effets de bord quand nécessaire.


## 4. Documentation avec docstrings

### 4.1 Qu'est-ce qu'une docstring ?

Une **docstring** est une chaîne de documentation qui décrit ce que fait une fonction.

**Format recommandé :**

```
FONCTION calculer_pgcd(a, b)
  """
  Calcule le Plus Grand Commun Diviseur de deux nombres.
  
  Paramètres:
    a (entier): premier nombre
    b (entier): second nombre
  
  Retourne:
    entier: le PGCD de a et b
  
  Exemple:
    calculer_pgcd(48, 18) retourne 6
  """
  
  -- Corps de la fonction
  ...
FIN FONCTION
```


### 4.2 Éléments d'une bonne docstring

1. **Description brève** : ce que fait la fonction (1 ligne)
2. **Paramètres** : nom, type, description
3. **Valeur de retour** : type et signification
4. **Exemples** : cas d'utilisation typiques
5. **Exceptions** (optionnel) : erreurs possibles


### 4.3 Exemple complet

```
FONCTION rechercher_element(liste, element)
  """
  Recherche un élément dans une liste.
  
  Paramètres:
    liste (list): la liste dans laquelle chercher
    element: l'élément à rechercher
  
  Retourne:
    entier: l'index de l'élément, ou -1 si non trouvé
  
  Exemple:
    rechercher_element([1, 2, 3, 4], 3) retourne 2
    rechercher_element([1, 2, 3, 4], 5) retourne -1
  """
  
  POUR i DE 0 À longueur(liste) - 1 FAIRE
    SI liste[i] = element ALORS
      RETOURNER i
    FIN SI
  FIN POUR
  
  RETOURNER -1
FIN FONCTION
```


## 5. Gestion d'erreur basique (try/except)

### 5.1 Concept d'exception

Une **exception** est une erreur qui se produit pendant l'exécution d'un programme.

**Exemples d'erreurs courantes :**

* Division par zéro
* Accès à un index inexistant dans une liste
* Conversion de type impossible
* Fichier introuvable


### 5.2 Structure try/except

**Forme générale :**

```
ESSAYER
  -- Code susceptible de générer une erreur
  instructions_risquées
ATTRAPER erreur
  -- Code à exécuter si une erreur se produit
  instructions_secours
FIN ESSAYER
```


### 5.3 Exemple — Division sécurisée

```
FONCTION diviser_securise(a, b)
  ESSAYER
    resultat ← a / b
    RETOURNER resultat
  ATTRAPER DivisionParZeroError
    AFFICHER "Erreur : division par zéro impossible"
    RETOURNER None
  FIN ESSAYER
FIN FONCTION

-- Utilisation
x ← diviser_securise(10, 2)   -- Retourne 5
y ← diviser_securise(10, 0)   -- Affiche erreur, retourne None
```


### 5.4 Exemple — Accès sécurisé à une liste

```
FONCTION obtenir_element(liste, index)
  ESSAYER
    element ← liste[index]
    RETOURNER element
  ATTRAPER IndexError
    AFFICHER "Erreur : index hors limites"
    RETOURNER None
  FIN ESSAYER
FIN FONCTION
```


### 5.5 Bloc finally (optionnel)

Le bloc `finally` s'exécute toujours, qu'il y ait une erreur ou non.

```
ESSAYER
  -- Code risqué
  ouvrir_fichier()
  lire_contenu()
ATTRAPER erreur
  -- Gérer l'erreur
  AFFICHER "Erreur de lecture"
FINALEMENT
  -- S'exécute toujours
  fermer_fichier()
FIN ESSAYER
```


## 6. Décomposition d'un problème

### 6.1 Principe de décomposition

Pour résoudre un problème complexe :

1. **Identifier** les sous-tâches distinctes
2. **Créer** une fonction pour chaque sous-tâche
3. **Combiner** les fonctions pour résoudre le problème global


### 6.2 Exemple — Calculer la moyenne d'une liste

**Décomposition :**

```
FONCTION calculer_somme(liste)
  somme ← 0
  POUR chaque nombre dans liste FAIRE
    somme ← somme + nombre
  FIN POUR
  RETOURNER somme
FIN FONCTION

FONCTION calculer_moyenne(liste)
  SI longueur(liste) = 0 ALORS
    RETOURNER 0
  FIN SI
  
  somme ← calculer_somme(liste)
  moyenne ← somme / longueur(liste)
  RETOURNER moyenne
FIN FONCTION

-- Utilisation
notes ← [12, 15, 18, 10, 14]
moy ← calculer_moyenne(notes)
AFFICHER moy  -- Affiche 13.8
```

✅ Avantages :
- `calculer_somme` peut être réutilisée ailleurs
- Chaque fonction a une responsabilité unique
- Plus facile à tester


### 6.3 Exemple — Validation d'un email

**Décomposition :**

```
FONCTION contient_arobase(email)
  RETOURNER "@" DANS email
FIN FONCTION

FONCTION contient_point(email)
  RETOURNER "." DANS email
FIN FONCTION

FONCTION est_email_valide(email)
  SI NON contient_arobase(email) ALORS
    RETOURNER FAUX
  FIN SI
  
  SI NON contient_point(email) ALORS
    RETOURNER FAUX
  FIN SI
  
  RETOURNER VRAI
FIN FONCTION

-- Utilisation
email1 ← "test@example.com"
email2 ← "invalide"

AFFICHER est_email_valide(email1)  -- VRAI
AFFICHER est_email_valide(email2)  -- FAUX
```


## Exercice — Conception du "Jeu du pendu"

### Objectif

Concevoir un jeu du pendu en **pseudo-code** et définir son **plan fonctionnel**.

### Description du jeu

Le jeu du pendu consiste à :

1. Choisir un mot secret aléatoirement
2. Le joueur devine le mot lettre par lettre
3. À chaque tentative, afficher l'état du mot (lettres devinées et tirets)
4. Compter les erreurs (lettres non présentes)
5. Le joueur gagne s'il devine le mot complet
6. Le joueur perd s'il fait trop d'erreurs (ex: 6 erreurs max)


### Fonctions à concevoir

Vous devez concevoir au minimum ces fonctions :

#### 1. `choisir_mot()`

```
FONCTION choisir_mot()
  """
  Choisit un mot aléatoirement dans une liste prédéfinie.
  
  Paramètres:
    Aucun
  
  Retourne:
    chaîne: le mot choisi (en minuscules)
  """
  
  liste_mots ← ["python", "algorithme", "fonction", "variable", "boucle"]
  mot ← choisir_aleatoirement(liste_mots)
  RETOURNER mot
FIN FONCTION
```


#### 2. `tester_lettre(mot, lettre, lettres_trouvees)`

```
FONCTION tester_lettre(mot, lettre, lettres_trouvees)
  """
  Teste si une lettre est présente dans le mot.
  
  Paramètres:
    mot (chaîne): le mot secret
    lettre (chaîne): la lettre proposée par le joueur
    lettres_trouvees (liste): lettres déjà trouvées
  
  Retourne:
    booléen: VRAI si la lettre est dans le mot, FAUX sinon
  """
  
  SI lettre DANS mot ALORS
    AJOUTER lettre À lettres_trouvees
    RETOURNER VRAI
  SINON
    RETOURNER FAUX
  FIN SI
FIN FONCTION
```


#### 3. `afficher_etat(mot, lettres_trouvees)`

```
FONCTION afficher_etat(mot, lettres_trouvees)
  """
  Affiche l'état actuel du mot avec lettres trouvées et tirets.
  
  Paramètres:
    mot (chaîne): le mot secret
    lettres_trouvees (liste): lettres déjà trouvées
  
  Retourne:
    Aucune (affichage uniquement)
  
  Exemple:
    mot = "python", lettres_trouvees = ["p", "t", "h"]
    Affiche: "p _ t h _ _"
  """
  
  affichage ← ""
  
  POUR chaque lettre dans mot FAIRE
    SI lettre DANS lettres_trouvees ALORS
      affichage ← affichage + lettre + " "
    SINON
      affichage ← affichage + "_ "
    FIN SI
  FIN POUR
  
  AFFICHER affichage
FIN FONCTION
```


#### 4. `verifier_victoire(mot, lettres_trouvees)`

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
  
  POUR chaque lettre dans mot FAIRE
    SI lettre NON DANS lettres_trouvees ALORS
      RETOURNER FAUX
    FIN SI
  FIN POUR
  
  RETOURNER VRAI
FIN FONCTION
```


#### 5. `jouer()` (fonction principale)

```
FONCTION jouer()
  """
  Fonction principale du jeu.
  Gère la boucle de jeu et coordonne toutes les autres fonctions.
  """
  
  -- Initialisation
  mot ← choisir_mot()
  lettres_trouvees ← []
  lettres_essayees ← []
  erreurs ← 0
  erreurs_max ← 6
  
  AFFICHER "Bienvenue au jeu du pendu !"
  
  -- Boucle de jeu
  TANT QUE erreurs < erreurs_max FAIRE
    -- Afficher l'état
    afficher_etat(mot, lettres_trouvees)
    AFFICHER "Erreurs:", erreurs, "/", erreurs_max
    
    -- Demander une lettre
    AFFICHER "Proposez une lettre:"
    lettre ← LIRE lettre_utilisateur()
    
    -- Vérifier si déjà essayée
    SI lettre DANS lettres_essayees ALORS
      AFFICHER "Vous avez déjà essayé cette lettre"
      CONTINUER
    FIN SI
    
    AJOUTER lettre À lettres_essayees
    
    -- Tester la lettre
    resultat ← tester_lettre(mot, lettre, lettres_trouvees)
    
    SI NON resultat ALORS
      erreurs ← erreurs + 1
      AFFICHER "Lettre incorrecte !"
    SINON
      AFFICHER "Bonne lettre !"
    FIN SI
    
    -- Vérifier victoire
    SI verifier_victoire(mot, lettres_trouvees) ALORS
      AFFICHER "Félicitations ! Vous avez gagné !"
      AFFICHER "Le mot était:", mot
      RETOURNER
    FIN SI
  FIN TANT QUE
  
  -- Défaite
  AFFICHER "Vous avez perdu !"
  AFFICHER "Le mot était:", mot
FIN FONCTION
```


### Diagramme fonctionnel

```
┌─────────────────┐
│   jouer()       │  ← Fonction principale
│   (boucle jeu)  │
└────────┬────────┘
         │
         ├──────────► choisir_mot()           : Initialisation
         │
         ├──────────► afficher_etat()         : Affichage
         │
         ├──────────► tester_lettre()         : Validation
         │
         └──────────► verifier_victoire()     : Condition de fin
```


## Livrables attendus

### Structure des fichiers

```
algorithmique/
  pgcd.py               (Algorithme d'Euclide avec docstring)
  merge.py              (Fusion de listes triées avec docstring)
  hangman_design.md     (Conception du jeu du pendu)
```


### Contenu de hangman_design.md

Votre fichier `hangman_design.md` doit contenir :

1. **Description du jeu** : règles et fonctionnement
2. **Liste des fonctions** : nom, paramètres, retour, description
3. **Pseudo-code complet** de chaque fonction
4. **Diagramme fonctionnel** montrant les relations entre fonctions
5. **Cas d'usage** : exemples de parties


### Format attendu pour pgcd.py et merge.py

```python
"""
Titre de l'algorithme

Description brève de ce que fait le script.
"""

def nom_fonction(parametres):
    """
    Description de la fonction.
    
    Args:
        param1 (type): description
        param2 (type): description
    
    Returns:
        type: description du retour
    
    Examples:
        >>> nom_fonction(val1, val2)
        resultat_attendu
    """
    # Implémentation
    pass


# Tests basiques
def test_nom_fonction():
    assert nom_fonction(test1) == resultat1
    assert nom_fonction(test2) == resultat2
    assert nom_fonction(test3) == resultat3
    print("✓ Tous les tests sont passés")


if __name__ == "__main__":
    test_nom_fonction()
```


## Critères d'évaluation

* **Clarté des fonctions** : noms explicites, responsabilité unique
* **Documentation** : docstrings complètes et informatives
* **Décomposition** : problème divisé en fonctions logiques
* **Pseudo-code** : respect des conventions, lisibilité
* **Gestion d'erreur** : try/except appropriés si nécessaire
* **Tests** : couverture de différents cas


## Conclusion de la séance

La modularité et les bonnes pratiques sont essentielles pour écrire du code de qualité.

Points clés à retenir :

* Les **fonctions** permettent de réutiliser du code et de le structurer
* Les **pure functions** sont préférables aux fonctions avec effets de bord
* Les **docstrings** documentent le code pour les autres développeurs
* La **gestion d'erreur** rend le code plus robuste
* La **décomposition** simplifie les problèmes complexes

La prochaine séance portera sur la syntaxe Python pour implémenter concrètement ces concepts.
