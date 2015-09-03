# this function do the joining and provides as result a data frame containig all revision done on cities

revisions_on_cities<-function(input,optdCities,wikipediaWikidata,wikivoyageWikidata,output){
  
  #reading the wikivoyage revision history.  
  data_frame<-read.table(input,sep="," ,na.strings = "NA",col.names=c("title","timestamp","contributor"))
  
  #Url encoding for titles as short_url. Short_url will be used for doing join
  data_frame$short_url<-sapply(data_frame$title,function(x) {URLencode(gsub(" ","_",x))})
  
  #reading the file extracted from OPTD
  citiesByName<-read.table(optd_cities,sep="^",col.names=c("IATA code","City name","Type of location","wikipedia url redirection"))
  citiesByName$short_url <- substr (citiesByName[,4],30,1000000L)
  
  #reading the files extracted form wikidata_sitelinks
  wikipedia_wikidata<-read.table(wikipediaWikidata,sep=" ") 
  wikivoyage_wikidata<-read.table(wikivoyageWikidata,sep="^")
  
  # First join between OPTD and wikipedia_wikidata
  optd_wd<-merge(citiesByName[citiesByName$short_url!="",],wikipedia_wikidata,by.x="short_url",by.y="V1",all.x = TRUE) 
  names(optd_wd)<-c("short_url","IATA code","city name","type of location","wikipedia url redirection","wikidata reference")
  
  # Second join between the optd_wd and wikivoyage_wikidata 
  optd_wv<-merge(optd_wd,wikivoyage_wikidata,by.x="wikidata reference",by.y="V2",all.x=TRUE) 
  write.table(optd_wv, file="optd_wv.csv", sep ="^")
  
  #Last join betwwen optd_wv et data_frame 
  cities1=merge(optd_wv,data_frame,by.x="V1",by.y="short_url")
  
  
  # drop double column from cities   
  to_drop <- c("short_url","City.name", "city name","V1")
  cities<-cities1[,!(names(cities1) %in% to_drop)]
  names(cities)<-c("wikidata reference","short url","IATA code","type of location", "wikipedia url redirection","timestamp","contributor")


  write.table(cities, file=output, sep ="^")

}

revisions_on_cities("parse_enwikivoyage-20150702-stub-meta-history_split.csv","citiesByNames1.csv","wikipedia_wikidata.csv","wikivoyage_wikidata.csv","wikivoyage_cities_history.csv")




