zcat wikidata-sitelinks.nt.gz | grep "http:https:\/\/en.wikivoyage.org\/wiki\>" > wikivoyage_englishpages.rdf 
cat wikivoyage_englishpages.rdf | awk -F" " '$2~/about/ {print $1"^"$3}' > wikivoyage_englishpages1.rdf 
awk 'sub("^.{37}", "")' wikivoyage_englishpages1.rdf | sed 's/http:\/\/www.wikidata.org\/entity/^/g' > wikivoyage_englishpages2.rdf ## pour enlever <http:https://en.wikivoyage.org/wiki/ (avec awk nombre de caractere est 37 ) et http://www.wikipedia.org/entity/ (avec sed ...)
sed -e 's/\^//g'| sed -e 's/\///g' | sed -e 's/>//g' | sed -e 's/<//g' wikivoyage_englishpages2.rdf > wikivoyage_wikidata.csv # supprime le /,<, > et le // 

