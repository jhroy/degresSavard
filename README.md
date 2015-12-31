# degresSavard

##### _Code utilisé pour le [robot](https://twitter.com/degressavard) tweetant à toutes les heures l'«indice total de météo pondéré», une blague météorologique de [Fred Savard](https://fr.wikipedia.org/wiki/Fr%C3%A9d%C3%A9ric_Savard), d'où l'appellation «degrés Savard»_.

:sunny: :cloud: :snowflake:

Une fois l'heure, le script commence par quérir la température des 20 villes se trouvant sur la [liste des conditions actuelles](https://meteo.gc.ca/canada_f.html) du service météo d'Environnement et Ressources naturelles Canada.
Il retranche la température la plus élevée et la température la plus basse, puis fait la somme des 18 valeurs restantes, ce qui donne l'**indice total de météo pondéré**, où la température actuelle au Canada en degrés Savard.

**meteo.py**
- J'ai d'abord rédigé le script en python. En fait, le but de cet exercice, en plus d'être un hommage au travail de Fred Savard et de toute l'équipe de [La soirée en (encore) jeune](http://ici.radio-canada.ca/emissions/La_soiree_est_encore_jeune/2015-2016/emissions.asp), était aussi de me remettre au python. J'ai cependant eu beaucoup de difficulté à faire rouler ce script à toutes les heures sur mon serveur logeant sur un vieil ordi fonctionnant avec Mac OS X Snow Leopard... J'ai donc tout réécrit en ruby.

**meteo.rb**
- Ce script fait la même chose que son petit frère en python à une exception près: il ajoute, aléatoirement, les points de fusion ou d'ébullition de différents éléments et composés organiques ou d'autres températures importantes. Il peut également ajouter un message à portée environnementale, car [si on recule dans le temps](http://climat.meteo.gc.ca/index_f.html), l'indice total de météo pondéré peut permettre de mesurer le réchauffement des températures au Canada.

###_Les degrés Savard comme indice du changement climatique_

Les données homogénéisées qui ont servi à [ce billet de blogue](http://jhroy.ca/2015/12/les-degres-savard-comme-indice-du-rechauffement-climatique-au-canada/) faisant l'exercice de calculer les degrés Savard depuis le plus longtemps possible afin de voir dans quelle mesure ils pouvaient être indicatifs du changement climatique au Canada ont été recueillies sur [ce site FTP](ftp://ccrp.tor.ec.gc.ca/pub/EC_data/AHCCD_daily/). Je les ai traitées avec trois scripts, puis organisées en un fichier CSV que je partage ici et qui s'appelle **donneesHomogeneises_1946-2011.csv**
