# S1 — Introduction à l’algorithmique & raisonnement

## Objectifs pédagogiques

À l’issue de cette séance, l’apprenant doit être capable de :

* Expliquer ce qu’est un algorithme et à quoi il sert.
* Identifier clairement les **entrées**, **sorties** et la **spécification** d’un problème.
* Raisonner de manière structurée avant toute implémentation.
* Écrire un algorithme simple en **pseudo-code algorithmique**.
* Traduire un raisonnement logique en étapes claires et ordonnées.


## Introduction — Qu’est-ce que l’algorithmique ?

### Définition

Un **algorithme** est une suite finie, ordonnée et non ambiguë d’instructions permettant de résoudre un problème.

Autrement dit :

> Un algorithme décrit *comment* passer d’une **entrée** à une **sortie**.

### Exemples du quotidien

* Une recette de cuisine (ingrédients → plat final)
* Les étapes pour retirer de l’argent à un distributeur
* La procédure pour classer des dossiers par ordre alphabétique

Dans tous les cas :

* il y a des données de départ,
* des règles à suivre,
* un résultat attendu.

## Notions fondamentales

### 1. Entrée

Les **entrées** sont les données fournies à l’algorithme.

Exemples :

* une liste de notes
* un seuil
* un tableau de nombres

### 2. Sortie

La **sortie** est le résultat produit par l’algorithme.

Exemples :

* une moyenne
* une valeur maximale
* un nombre d’éléments

### 3. Instance

Une **instance** est un cas concret des données d’entrée.

Exemple :

* Entrée générale : « une liste de notes »
* Instance : `[12, 15, 9, 18]`

### 4. Spécification

La **spécification** décrit précisément ce que l’algorithme doit faire, indépendamment de la manière dont il est écrit.

Elle répond à trois questions :

1. Quelles sont les entrées ?
2. Quelle est la sortie attendue ?
3. Quelles règles doivent être respectées ?

## Pseudo-code algorithmique

### Pourquoi le pseudo-code ?

Le **pseudo-code** permet de :

* décrire un algorithme sans dépendre d’un langage de programmation,
* se concentrer sur le raisonnement logique,
* communiquer une solution de manière claire et universelle.

Il ne respecte pas une syntaxe stricte, mais doit rester :

* lisible,
* structuré,
* non ambigu.

### Conventions utilisées dans ce cours

* `DEBUT` / `FIN` pour délimiter l’algorithme
* `SI ... ALORS ... FIN SI` pour les conditions
* `POUR ... FAIRE ... FIN POUR` pour les boucles
* `RETOURNER` pour la sortie
* `←` pour l’affectation


## Exemple guidé — Calculer une moyenne

### Spécification

* **Entrée** : une liste de nombres `notes`
* **Sortie** : la moyenne des valeurs de la liste
* **Règle** : si la liste est vide, retourner 0

### Pseudo-code

```
DEBUT
  SI longueur(notes) = 0 ALORS
    RETOURNER 0
  FIN SI

  somme ← 0

  POUR chaque valeur dans notes FAIRE
    somme ← somme + valeur
  FIN POUR

  moyenne ← somme / longueur(notes)
  RETOURNER moyenne
FIN
```


## Organigrammes (diagrammes de flux)

Un **organigramme** est une représentation graphique d’un algorithme.

### Symboles de base

* Ovale : début / fin
* Rectangle : instruction
* Losange : condition
* Flèche : enchaînement logique

Les organigrammes permettent de :

* visualiser le raisonnement,
* détecter plus facilement les erreurs logiques,
* expliquer un algorithme sans texte long.

> Dans cette séance, les organigrammes peuvent être dessinés à la main ou avec un outil (draw.io, paperboard, etc.).


## Exercices — Travail à rendre

### Consignes générales

Vous devez écrire **trois algorithmes en pseudo-code**.

Le rendu doit être :

* soit un fichier `algos_s1.md`,
* soit des images claires d’organigrammes.


### Exercice 1 — Moyenne d’une liste de notes

**Objectif** : calculer la moyenne d’une liste de notes numériques.

* Entrée : liste `notes`
* Sortie : moyenne
* Cas particulier : liste vide


### Exercice 2 — Valeur maximale et index

**Objectif** : trouver la plus grande valeur d’une liste et sa position.

* Entrée : liste `valeurs`
* Sortie : valeur maximale et son index
* Hypothèse : la liste contient au moins un élément


### Exercice 3 — Compter les valeurs supérieures à un seuil

**Objectif** : compter combien d’éléments d’une liste sont strictement supérieurs à un seuil donné.

* Entrée : liste `valeurs`, nombre `seuil`
* Sortie : nombre d’éléments > seuil


## Modèle de rédaction attendu (exemple)

```
-- Algorithme : Compter les éléments supérieurs à un seuil
DEBUT
  compteur ← 0

  POUR chaque valeur dans valeurs FAIRE
    SI valeur > seuil ALORS
      compteur ← compteur + 1
    FIN SI
  FIN POUR

  RETOURNER compteur
FIN
```


## Critères d’évaluation

* Exactitude logique de l’algorithme
* Clarté et structuration du pseudo-code
* Bonne identification des entrées et sorties
* Gestion correcte des cas simples (liste vide, initialisation)


## Conclusion de la séance

L’algorithmique est avant tout une **méthode de raisonnement**.

Avant de programmer, il est essentiel de :

* comprendre le problème,
* définir clairement les données,
* structurer la solution étape par étape.

Les prochaines séances s’appuieront sur ces bases pour introduire l’implémentation en langage de programmation.
