# degresSavard

###### _Code utilisé pour le [robot](https://twitter.com/degressavard) tweetant à toutes les heures l'«indice total de météo pondéré», une blague météorologique de [Fred Savard](https://fr.wikipedia.org/wiki/Fr%C3%A9d%C3%A9ric_Savard), d'où l'appellation «degrés Savard»_.

:sunny: :cloud: :snowflake:

Une fois l'heure, le script commence par quérir la température des 20 villes se trouvant sur la [liste des conditions actuelles](https://meteo.gc.ca/canada_f.html) du service météo d'Environnement et Ressources naturelles Canada.
Il retranche la température la plus élevée et la température la plus basse, puis fait la somme des 18 valeurs restantes, ce qui donne l'«indice total de météo pondéré», où la température actuelle au Canada en degrés Savard.

J'ai d'abord rédigé le script en python. En fait, tout cet exercice, en plus d'être un hommage au travail de Fred Savard et de toute l'équipe de [La soirée en (encore) jeune](http://ici.radio-canada.ca/emissions/La_soiree_est_encore_jeune/2015-2016/emissions.asp), était aussi un exercice pour me remettre au python. Voici ce premier script: **meteo.py**

