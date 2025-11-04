{% docs mrt_orders_summary_daily %}

- **Modele mrt_orders_summary_daily**

- **Description** :

Ce modele a une matérisalisation de type table (cf.dbt_project.yml) auquel on ajoute des metadonnées (cf.macro)
Ce modele decrit les ventes par produit et magasin

- **Granularité** :

La granularité ici est une ligne par jour de l'année et magasin sur les deux années glissantes 

- **Periodicité de Rafraichissement** :

Ce modéle est rafraichi tout les jours

{% enddocs %}
