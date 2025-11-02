{% docs mrt_customer_profile %}

- **Modele mrt_customer_profile**

- **Description** :

- Ce modele a une matérisalisation de type table (cf.dbt_project.yml)
- Ce modele regroupe les métriques liées au client.
- Sert à analyser le comportement des clients : commandes, retards, quantités, segments.


- **Colonnes principales** :
- ** nb_orders **: Nombre total de commandes par client.
- first_order : Date de la première commande du client.
- last_order : Date de la dernière commande du client.
- max_quantity_in_order : Quantité maximale commandée dans une seule commande.
- max_diff_products_in_order : Nombre maximum de produits différents dans une seule commande.
- nb_orders_shipped : Nombre de commandes expédiées.
- nb_orders_not_shipped : Nombre de commandes non expédiées.
- total_quantity_shipped : Quantité totale expédiée.
- total_quantity_not_shipped : Quantité totale non expédiée.
- max_shipped_quantity : Quantité maximale expédiée dans une seule commande.
- max_not_shipped_quantity : Quantité maximale non expédiée dans une seule commande.
- nb_on_time_orders : Nombre de commandes livrées à temps.
- nb_late_orders : Nombre de commandes en retard.
- nb_shipped_on_time_orders : Nombre de commandes expédiées à temps.
- nb_shipped_late_orders : Nombre de commandes expédiées en retard.
- lifetime_days : Nombre de jours depuis la première commande du client.
- avg_delay_between_shipped_orders : Délai moyen entre les commandes expédiées.
- customer_segment : Segment client calculé (NEW / OLD / RECURRENT) en fonction du nombre de commandes et de leur ancienneté.

- **Description** :
- Les valeurs nulles indiquent qu’aucune donnée n’est disponible.

{% enddocs %}