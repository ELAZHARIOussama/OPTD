# assign("is.title",T,.GlobalEnv,inherits =T)
# assign("title","",.GlobalEnv,inherits =T)
# assign("output",data.frame(title=character()),.GlobalEnv,inherits =T)

startElmt = function(name, attr,...) {
  if(name=="title"){is.title<<-T}
}

endElmt = function(name, attr,...) {
  if(name=="title"){is.title<<-F}
  if(name=="revision"){
    print ("revision")
    output <- rbind(output,data.frame(title=title))
    #print(paste("output size",length(output)))
    #print(paste("output title",title))
    
  }
}

getText = function(content,...){
  # unlockBinding("title", .GlobalEnv)
  if(is.title<<-T){ title <<- title }
}


env = new.env()
environment(startElmt) = env
environment(endElmt) = env
environment(getText) = env
env$pages = pages
env$n = 0
 
assign("is.title",F,pos=env)
assign("title","",pos=env)
assign("output",data.frame(title=character()),pos=env)

#environment(startElmt) = .GlobalEnv
#environment(endElmt) = .GlobalEnv
#environment(getText) = .GlobalEnv


z <- xmlEventParse("extract.xml", handlers = list(startElement=startElmt, endElement=endElmt, text=getText))
