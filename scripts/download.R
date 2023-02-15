config = yaml::yaml.load_file("/root/repbox_config.yml")
repo_type = config$repo_type

cat("\nRepotype = ", repo_type,"\n")
if (repo_type == "zip_url") {
  url = config$url
  cat("\nDownload supplement from ", url,"\n")
  download.file(url, "/root/zip/supplement.zip")
} else if (repo_type == "oi") {
  source("~/scripts/download_oi.R")
}

