# Projet Analytic Engineer (Localbike)

## 1. Définir les axes d’analyse 

- Avoir une meilleure vision des ventes quotidiennes par magasins
- Mieux comprendre les clients de localbike
- Etudier la performance des produits vendus par Localbike

## 2. Modélisation des données 

Le projet est organisé selon les 3 couches suivantes :
   
### 2.1 Couche Staging

 ####  *2.1.1 Objectif*   

- Permet de formatter/normaliser le format des données issues du systeme  transactionnel de localbike et renommer eventuellement les variables
        
 ####  *2.1.2 Caracteristiques*   

- Organisation des fichiers par source
- Les fichiers sont nommés comme suit : *stg_[source]__[entity]s.sql* 
- Pas de jointure a ce niveau. Choix ici de cast explicite.
         
### 2.2 Couche Intermediate

 #### *2.2.1 Objectif*   
- Permet de faire de faires des transformations metiers intermediaire. Permet de factoriser et harmoniser les transformations pour les couches suivantes
       
#### *2.2.2 Caracteristiques* 
- Les fichiers sont nommés comme suit :  [entity]s_[verb]s.sql
- Dans le cadre du projet 3 types de tranfo :
-**joined** : Permet de denormaliser les données (kimball) en les mettant a plat autour d'un concept metier. 
-**enriched** : Realisation de calaculs. AJoute des informations qui pourrant etre utiles a plusieurs analyses
-**summary** : Aggrege les données a un niveau de granularité spécifique pour que la couche suivante 
     
### 2.3 Couche Mart
            
 #### *2.3.1 Objectif*       
-  Permet de preparer les données pour le reporting en effectuant un focus sur un metier / axe d'analyse
       
 #### *2.3.2 Caracteristiques*         
- Materialisation des données sous forme de table
- Possede un niveau de granualrite specifique et une periodicité de rafraichissement
- Ajout de colonnes d'audit (macro dediée) 
             

## 3. Implémentation des tests et documentation 

 #### *3.1 Tests* 
     
- Test systematique des identifiants uniques pour toutes couches.
- Ajout de biblioteques tierces (dbt_utils / dbt_expectations) pour des tests plus avancés
        
 #### *3.2 Documentation* 

- Documentation exhaustive des variables sur la couche staging.
- Documentation des apports/caracteristique des couches intermediate et mart via fichier .md

## 4 . Centralisation du parametrage

 #### *4.1 dbt_project* 
- Definition de la materialisation des differentes couches et des tags associés à chaque couche
- Centralisation des variables (NA/UK/ND). Entendu pour generation du claendrier dynamique

 #### *4.2 github.yml*          
- Définition du **code owner**.
- Template pour les **pull requests**.


## 5. Visualisation et partage 