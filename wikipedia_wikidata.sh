zcat wikidata-sitelinks.nt.gz | grep "https://en.wikipedia.org/wiki\>" > englishPages.rdf 
cat englishPages.rdf | awk -F" " '$2~/about/ {print $1"^"$3}' > englishPages1.rdf 
awk 'sub("^.{36}", "")' englishPages1.rdf > englishPages2.rdf ## pour enlever <http:https://en.wikipedia.org/wiki/ (nombre de caractere est 36 )
sed 's/http:\/\/www.wikidata.org\/entity/^/g' englishPages2.rdf > englishPages3.rdf   ## supprime http://www.wikipedia.org/entity/ 
sed -e 's/\^//g' englishPages3.rdf > englishPages4.rdf  ## supprime le  ^ 
sed -e 's/\///g' englishPages4.rdf > englishPages5.rdf  ## supprime le  / 
sed -e 's/>//g' englishPages5.rdf > englishPages6.rdf  ## supprime le  >
sed -e 's/<//g' englishPages6.rdf > wikipedia_wikidata.csv  ## supprime le  < 




