{% docs int_staffs_joined %}

# **Modele int_staffs_joined**

**Description** :

Modele de la couche intermediate. Ce Modele sert à denormaliser les données des employes.
Il s'agit donc ici de mettre a plat les informations liées aux employes . 
Notemment la relation reflexive avec le manager.
Cette agregation pourra etre ensuite etre reutilisée par les couches superieures

**Granularité** :

La granularité la plus fine ici est l'employé (avec son manager associé)
{% enddocs %}
