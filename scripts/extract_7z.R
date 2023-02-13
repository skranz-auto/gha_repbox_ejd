extract.all.7z = function() {
  cat("\nExtract R packages...")
  key = Sys.getenv("REPBOX_PKG_KEY")
  cat("\nkey = ", key)
  extract.7z("/root/", zip = "/root/pkgs/repboxMain.7z", password = key)
  extract.7z("/root/", zip = "/root/pkgs/repboxStata.7z", password = key)
  extract.7z("/root/", zip = "/root/pkgs/ExtractSciTab.7z", password = key)

  # Extract possibly compressed article PDF
  key = Sys.getenv("REPBOX_ARTICLE_KEY")
  zips = list.files("/root/pdf", glob2rx("*.7z"), full.names = TRUE)
  if (length(zips)>0) {
    zip = zips[1]
    extract.7z("/root/pdf", zip = zip, password = key)
  }

  # Extract possibly protected supplement
  # We currently assume that inside the 7z there is only a single zip
  zips = list.files("/root/zip", glob2rx("*.7z"), full.names = TRUE)
  if (length(zips)>0) {
    zip = zips[1]
    extract.7z("/root/zip", zip = zip, password = key)
  }

  cat(" done.\n")
}


to.7z = function(path, zip=paste0(basename(path),".7z"), password = NULL) {
  switch = ""
  if (!is.null(password)) {
    switch = paste0(" -p",password," ")
  }
  os =
  cmd = paste0('7z a ', zip, ' ', path,' ',  switch)
  cat(cmd)
  system(cmd)
}

extract.7z = function(path, zip=paste0(basename(path),".7z"), password = NULL) {
  setwd(path)
  switch = ""
  if (!is.null(password)) {
    switch = paste0(" -p",password," ")
  }
  cmd = paste0('7z x ', zip, ' -y ',  switch)
  cat("\n", cmd,"\n")
  system(cmd,ignore.stdout = TRUE)
}


to.7z = function(path, zip=paste0(basename(path),".7z"), password = NULL) {
  switch = ""
  if (!is.null(password)) {
    switch = paste0(" -p",password," ")
  }
  cmd = paste0('7z a ', zip, ' ', path,' ',  switch)
  cat(cmd)
  system(cmd)
}
