{% docs mrt_product_performance %}

- **Modele mrt_product_performance**

- **Description** :

- Ce modele a une matérisalisation de type table (cf.dbt_project.yml) auquel on ajoute des metadonnées (cf.macro)
- Ce modele regroupe les métriques liées au produit.
- Sert à analyser lla performance des produits

- **Colonnes principales** :

- *total_sales*  : Montant total des ventes pour chaque produit
- *total_quantity_sold* : Quantité totale vendue pour chaque produit
- *total_discount* : Somme des remises appliquées sur les produits
- *nb_stores_selling* : Nombre de magasins ayant vendu le produit
- *nb_sales* : Nombre total de ventes pour le produit
- *nb_day_with_sales* : Nombre de jours où le produit a été vendu
- *avg_sales_per_store* : Ventes moyennes par magasin pour le produit
- *avg_discount_rate* : Taux moyen de remise appliqué sur le produit
- *avg_discount_amount_per_order* : Montant moyen de remise par commande pour le produit

- **Granularité** :
La granularité ici est une ligne par produit

**Taux de Rafraichissement** :
Ce modéle est rafraichi toutes les semaines

{% enddocs %}
