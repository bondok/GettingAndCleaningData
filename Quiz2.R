getQuiz2GithubToken <- function(){
  ##create variable to hold my application key and secret
  myapp <- oauth_app("github",
                     key = "a252bbc45a2718fe8d01",
                     secret = "7ccad47d6147e25cb41ac64a16136256d531e539")
  
  ##get token from github
  token <- oauth2.0_token(oauth_endpoints("github"), myapp)
  
  ##Set CURL options and return the token. 
  config(token = token)
}

getCreationDate <- function(repoName){
  ##Load httr library
  library(httr)
  
  ##Get the repos for jtleek 
  req <- GET("https://api.github.com/users/jtleek/repos", getQuiz2GithubToken())
  
  ##convert all request errors to R errors
  stop_for_status(req)
  
  ##extract response content
  cont <- content(req)
  
  ##loop through response to find the required repo
  for (i in 1:length(cont)){
    if(cont[[i]]$name==repoName){
      created_at <- cont[[i]]$created_at
      break
    }
  }
  if (exists("created_at"))
    created_at
  else
    "repo not found"
}


getNumberOfLines <- function(u, lineIndex){
  con = url(u)
  nchar(readLines(con)[lineIndex])
}
