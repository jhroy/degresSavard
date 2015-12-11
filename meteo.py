# -*- coding: utf-8 -*-
# ©2015 Jean-Hugues Roy. GNU GPL v3.

import urllib2
import string
import csv
from bs4 import BeautifulSoup
import requests
import locale
import time
import datetime
import tweepy

codes = {
	"Calgary" : "ab-52",
	"Charlottetown" : "pe-5",
	"Edmonton" : "ab-50",
	"Fredericton" : "nb-29",
	"Halifax" : "ns-19",
	"Iqaluit" : "nu-21",
	"Montréal" : "qc-147",
	"Ottawa" : "on-118",
	"Prince George" : "bc-79",
	"Québec" : "qc-133",
	"Regina" : "sk-32",
	"Saskatoon" : "sk-40",
	"St. John's" : "nl-24",
	"Thunder Bay" : "on-100",
	"Toronto" : "on-143",
	"Vancouver" : "bc-74",
	"Victoria" : "bc-85",
	"Whitehorse" : "yt-16",
	"Winnipeg" : "mb-38",
	"Yellowknife" : "nt-24"
}

fred = []

locale.setlocale(locale.LC_ALL, '')
now = datetime.datetime.now()

jour = now.day
mois = time.strftime("%b")
annee = now.year
heure = time.strftime("%Hh%M")

print "Nous sommes le %s %s %s" % (jour,mois,annee)
print "Il est %s " % heure

url1 = "https://meteo.gc.ca/city/pages/"
url2 = "_metric_f.html"

for ville in codes:
	url = "%s%s%s" % (url1,codes[ville],url2)
	print "Le code de %s est %s" % (ville,url)
	x = requests.get(url,verify=False)
	page = BeautifulSoup(x.text,"html.parser")
	temp = page.find("div",id="wxo-conditiondetails").find("dd",class_="wxo-metric-hide").findNext("dd",class_="wxo-metric-hide").findNext("dd",class_="wxo-metric-hide").text.strip()[:-2]
	temp = float(string.replace(temp,",","."))
	print temp
	fred.append(temp)
	if min(fred) == temp:
		villeMin = ville
	if max(fred) == temp:
		villeMax = ville

valMin = str(min(fred))
valMin = string.replace(valMin,".",",")
fred.remove(min(fred))

valMax = str(max(fred))
valMax = string.replace(valMax,".",",")
fred.remove(max(fred))

moy = str(round(sum(fred)/len(fred)))
moy = string.replace(moy,".",",")

fred = str(sum(fred))
fred = string.replace(fred,".",",")

tweet = "Il fait %s°S au Canada\n\nValeurs extrêmes retranchées:\nmin: %s°C à %s\nmax: %s°C à %s\n@lasoiree" % (fred,valMin,villeMin,valMax,villeMax)
print tweet
print len(tweet)

cleCons = 'IqualuitMonAmour'
secretCons = 'VoirSaskatoonEtMourir'
cleAcces = 'HalifaxeMoiDoncCa'
secretAcces = 'SiJavaisLesAilesDunAngeJePartiraisPourQuebec'
auth = tweepy.OAuthHandler(cleCons, secretCons)
auth.set_access_token(cleAcces, secretAcces)
pouet = tweepy.API(auth)

pouet.update_status(status=tweet)
