# TP Flutter – Consommer une API REST avec MVVM

## Questions de vérification

### 1. Pourquoi utiliser un factory constructor ?
Le **factory constructor** permet de créer un objet à partir de données externes, comme du JSON, de manière propre et structurée. En effet, il permet de désérialiser les données et de les transformer en instances d'une classe. Cela permet de centraliser la logique de création des objets dans un seul endroit, rendant le code plus lisible et maintenable.

### 2. Pourquoi utiliser `notifyListeners()` ?
La méthode **`notifyListeners()`** est utilisée dans le **ViewModel** pour notifier toutes les vues (UI) qu'une mise à jour des données a eu lieu. Elle permet de dire à l'application qu'il faut reconstruire la vue avec les nouvelles données. Cela est essentiel pour l'actualisation dynamique de l'interface utilisateur lorsqu'il y a des changements d'état, comme la récupération ou l'ajout de produits.

### 3. Que se passe-t-il si on oublie `notifyListeners()` ?
Si on oublie d'appeler **`notifyListeners()`**, les vues qui écoutent le **ViewModel** ne seront pas informées des changements d'état, et donc, l'interface ne sera pas mise à jour avec les nouvelles données. Cela peut entraîner des incohérences dans l'affichage de l'UI, car les vues ne réagiront pas aux changements de données en temps réel.

### 4. Quelle est la responsabilité du ViewModel dans MVVM ?
Le **ViewModel** dans l'architecture MVVM est responsable de :
- Gérer la logique métier et l'état de l'application (ex : gestion du chargement, des erreurs, des données).
- Exposer des **méthodes** que la **vue** peut appeler pour effectuer des actions sur les données (comme récupérer des produits, ajouter, modifier ou supprimer un produit).
- Agir comme **intermédiaire** entre le modèle (données) et la vue (UI). Il prépare les données pour l'affichage et gère la logique sans que la vue ait à se soucier des détails de l'accès aux données.

---

## Fonctionnalités supplémentaires ajoutées

Au-delà des fonctionnalités demandées dans le TP, plusieurs autres fonctionnalités ont été ajoutées à l'application :

### 1. **Création de produit (POST)**
   - Un formulaire permet à l'utilisateur d'ajouter un produit à la liste via une requête **POST** à l'API.
   - Lors de l'ajout, les informations du produit sont envoyées à l'API, et le produit est ajouté à la liste dans l'UI.

### 2. **Modification de produit (PUT)**
   - Chaque produit a une option pour le modifier. Lorsqu'un utilisateur sélectionne **modifier**, un formulaire similaire à l'ajout de produit est affiché, avec les données existantes pré-remplies.
   - Les modifications sont envoyées à l'API via une requête **PUT**, et l'élément dans la liste est mis à jour.

### 3. **Suppression de produit (DELETE)**
   - L'utilisateur peut supprimer un produit en appuyant sur l'icône de suppression dans la liste des produits.
   - La suppression est effectuée via une requête **DELETE** à l'API, et le produit est retiré de la liste à l'écran.

### 4. **Recherche de produits**
   - Un champ de recherche permet à l'utilisateur de filtrer les produits par titre.
   - Lorsqu'un utilisateur entre du texte dans la barre de recherche, la liste des produits est mise à jour en temps réel pour ne montrer que les produits correspondant au texte recherché.

### 5. **Tri des produits**
   - L'utilisateur peut trier les produits en fonction de leur prix (croissant/décroissant) via un bouton de tri dans l'UI.
   - Cela permet à l'utilisateur de choisir un ordre d'affichage qui lui convient.

### 6. **Favoris**
   - L'utilisateur peut marquer certains produits comme favoris. Un bouton en forme d'étoile permet de sélectionner un produit comme favori.
   - Une liste séparée des produits favoris est affichée, et la sélection est stockée localement (en utilisant, par exemple, `shared_preferences` ou un état dans le `ViewModel`).

---

## Structure des fichiers

Voici une brève explication de la structure des fichiers utilisés dans le projet :

### 1. **`product.dart`** (Model)
   - Ce fichier contient la définition de la classe **Product**, qui représente un produit dans l'application.
   - Il comprend un **factory constructor** pour convertir les données JSON reçues de l'API en objets **Product**.

### 2. **`api_service.dart`** (Service)
   - Ce fichier gère les appels HTTP vers l'API pour récupérer, ajouter, modifier et supprimer des produits.
   - Il contient des méthodes comme `fetchProducts()`, `addProduct()`, `updateProduct()`, et `deleteProduct()` pour interagir avec l'API.

### 3. **`product_view_model.dart`** (ViewModel)
   - Ce fichier contient la logique de gestion de l'état de l'application. Il expose une liste de produits et un état de chargement.
   - Le **ViewModel** appelle les services API, gère les données, et notifie les vues des changements d'état via **`notifyListeners()`**.
   - Il expose des méthodes comme `fetchProducts()`, `addProduct()`, `updateProduct()`, et `deleteProduct()` pour la vue.

### 4. **`product_list_screen.dart`** (View)
   - Ce fichier représente la **vue principale** où tous les produits sont affichés dans une liste.
   - Il utilise **`Consumer<ProductViewModel>`** pour afficher la liste des produits et réagir aux changements d'état du **ViewModel**.
   - Il inclut aussi des boutons pour ajouter, modifier et supprimer des produits, ainsi que la possibilité de rechercher et trier les produits.

### 5. **`product_form_screen.dart`** (View)
   - Ce fichier contient le formulaire pour **ajouter ou modifier un produit**.
   - Lorsqu'un produit est modifié, les données existantes sont pré-remplies dans le formulaire.

### 6. **`product_detail_screen.dart`** (View)
   - Ce fichier affiche les détails d'un produit lorsqu'il est sélectionné dans la liste.
   - Il présente l'image, le titre, le prix et une description fictive du produit.
   