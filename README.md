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
