{% docs int_order_items_event_enriched %}

- **Modele int_order_items_event_enriched**

- **Description** :

Ce modele sert à denormaliser les données , et enrichir les données avec de nouvelles variables dérivées :

- **Order_item_total**: Montant total par ligne de commande
- **Order_item_discount**: Montant de la remise par ligne de commande
- **Order_item_without_discount**: Montant par ligne de commande en le tenant psas compte de la remise
- **Shipment_status**: Statut de l'envoi
- **Shipment_type**: Type de l'envoi (en retard ou non)

- **Granularité** :

La granularité la plus fine ici est la ligne de commande

{% enddocs %}