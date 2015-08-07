library("XML")

parse_xml_dump <- function (input, output) {
  data1 = xmlParse (input)
  gen_frame <- function(n) {
    # getting the fields
    title = xmlValue(xmlElementsByTagName(xmlParent(n),"title")[[1]])
    timestamp = xmlValue(xmlElementsByTagName(n,"timestamp")[[1]])
    if(length(xmlElementsByTagName(n,"contributor"))>0){
      contributor = xmlElementsByTagName(n,"contributor")[[1]]
      
      
      if (length(xmlElementsByTagName(contributor,"username"))==0){
        contributorRef = xmlValue(xmlElementsByTagName(contributor,"ip")[[1]]) 
      }
      else {
        contributorRef = xmlValue(xmlElementsByTagName(contributor,"username")[[1]])
      }
    }
    else {
      contributorRef = NA 
    }
    data.frame(title=title, timestamp =timestamp , contributor = contributorRef)
  }
  
  f <- Reduce(rbind,xpathApply(data1, "//x:revision",fun=gen_frame,namespaces=c(x="http://www.mediawiki.org/xml/export-0.10/")))
  
  write.table(f, file = output, append = FALSE, quote = TRUE, sep = "^",eol = "\n", na = "NA", dec = ".", row.names = FALSE, col.names = TRUE, qmethod = c("escape", "double"),fileEncoding = "")
}

parse_xml_dump ("enwikivoyage-20150702-stub-meta-history.xml.gz", "parse_enwikivoyage-20150702-stub-meta-history.csv")
#parse_xml_dump ("extract.xml", "parse_extract.csv")
