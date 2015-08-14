library('XML')

startElmt = function(name, attr,...) {
  if(name=="title"){is.title<<-T}
}

endElmt = function(name, attr,...) {
  if(name=="title"){is.title<<-F}
  if(name=="revision"){
    print ("revision")
    output <<- rbind(output,data.frame(title=title))    
  }
}

getText = function(content,...){
  # unlockBinding("title", .GlobalEnv)
  if(is.title==T){ title <<- content }
}


env = new.env()
environment(startElmt) = env
environment(endElmt) = env
environment(getText) = env
 
assign("is.title",F,env)
assign("title","",env)
assign("output",data.frame(title=character()),env)

xmlEventParse("extract.xml", handlers = list(startElement=startElmt, endElement=endElmt, text=getText))
