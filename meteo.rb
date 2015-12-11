# #!/usr/bin/env ruby
# # ©2015 Jean-Hugues Roy. GNU GPL v3.

require "open-uri"
require "nokogiri"
require "twitter"
require "csv"

def mois(mo)
	case mo
	when 1
		m = "janv"
	when 2
		m = "fév"
	when 3
		m = "mars"
	when 4
		m = "avr"
	when 5
		m = "mai"
	when 6
		m = "juin"
	when 7
		m = "juil"
	when 8
		m = "août"
	when 9
		m = "sep"
	when 10
		m = "oct"
	when 11
		m = "nov"
	when 12
		m = "déc"
	end
	return m
end


codes = {
	"Calgary" => "ab-52",
	"Charlottetown" => "pe-5",
	"Edmonton" => "ab-50",
	"Fredericton" => "nb-29",
	"Halifax" => "ns-19",
	"Iqaluit" => "nu-21",
	"Montréal" => "qc-147",
	"Ottawa" => "on-118",
	"Prince George" => "bc-79",
	"Québec" => "qc-133",
	"Regina" => "sk-32",
	"Saskatoon" => "sk-40",
	"St. John's" => "nl-24",
	"Thunder Bay" => "on-100",
	"Toronto" => "on-143",
	"Vancouver" => "bc-74",
	"Victoria" => "bc-85",
	"Whitehorse" => "yt-16",
	"Winnipeg" => "mb-38",
	"Yellowknife" => "nt-24"
}

fred = []
savard = 0
url1 = "https://meteo.gc.ca/city/pages/"
url2 = "_metric_f.html"
villeMin = ""
villeMax = ""

points2 = "points2.csv"
points3 = "points3.csv"

# Lecture de deux fichiers contenant les températures de fusion et d'ébullition de différents éléments et composés organiques, afin de les ajouter aléatoirement aux tweets, question d'agrément

p2 = CSV.open(points2).to_a
p3 = CSV.open(points3).to_a

h = Time.now

puts "Nous sommes le #{h.day} #{mois(h.month)} #{h.year}"
puts "="*50

codes.each do |ville,code|
	t = {}
	url = "#{url1}#{code}#{url2}"
	p = Nokogiri::HTML(open(url))
	n = 0
	temp = 0
	p.css("dt").each do |item|
		if item.text == "Température :"
			# puts item.next_element.text.strip
			temp = item.next_element.text.strip
			temp = temp[0..-3].gsub(",",".").to_f
			puts "Il fait #{temp} à #{ville}"
		end
	end
	fred.push temp
	if fred.min == temp
		villeMin = ville
	end
	if fred.max == temp
		villeMax = ville
	end
end

puts "="*50

valMin = fred.min.to_s.gsub(".",",")
valMax = fred.max.to_s.gsub(".",",")
puts "min = #{valMin} à #{villeMin}"
puts "max = #{valMax} à #{villeMax}"
puts fred.inspect
minimum = fred.index(fred.min)
fred.delete_at(minimum)
maximum = fred.index(fred.max)
fred.delete_at(maximum)
puts fred.inspect
fred.each do |t|
	savard += t
end

mess = ""

p2.each do |cas1|
	if cas1[2].to_i < (savard + 2) && cas1[2].to_i > (savard - 2)
		z = rand(2).round(0)
		puts "z = #{z}"
		if z == 0
			mess = "#{cas1[0]} #{cas1[1]} à #{cas1[2]}°C"
			puts mess
		end
	end
end

if mess == ""
	x = rand(20).round(0)
	puts "x = #{x}"
	if x == 7
		y = rand(5).round(0)
		puts "y = #{y}"
		case y
		when 0
		mess = "2015 a été trop chaude"
		when 1
		mess = "Limitez réchauff à 2°C"
		when 2
		mess = "On n'a qu'1 Terre"
		when 3
		mess = "Transportez-vous en commun"
		when 4
		mess = "Réduisez votre empreinte carbone"
		end
	elsif x == 11
		i = rand(p3.size).round(0)
		puts "i = #{i}"
		mess = "#{p3[i][0]} #{p3[i][1]} à #{p3[i][2]}°C"
		puts mess
	end
end

puts "Tautal: #{savard.round(1).to_s.gsub(".",",")}"
puts "-"*50

tweet = "À #{h.hour}h, le #{h.day} #{mois(h.month)} #{h.year}\nIl fait #{savard.round(1).to_s.gsub('.',',')}°S au Canada\n#{mess}\nExtrêmes retranchés:\nmin: #{valMin}°C à #{villeMin}\nmax: #{valMax}°C à #{villeMax}"
puts "Le tweet fait #{tweet.size} caractères"
puts "-"*50

if tweet.size > 140
	tweet = tweet = "À #{h.hour}h, le #{h.day} #{mois(h.month)} #{h.year}\nIl fait #{savard.round(1).to_s.gsub('.',',')}°S au Canada\n\nExtrêmes retranchés:\nmin: #{valMin}°C à #{villeMin}\nmax: #{valMax}°C à #{villeMax}"
end
puts tweet

twit = Twitter::REST::Client.new do |config|
  config.consumer_key        = "IqualuitMonAmour"
  config.consumer_secret     = "VoirSaskatoonEtMourir"
  config.access_token        = "HalifaxeMoiDoncCa"
  config.access_token_secret = "SiJavaisLesAilesDunAngeJePartiraisPourQuebec"
end

# twit.update(tweet)
