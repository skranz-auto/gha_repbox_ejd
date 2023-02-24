config = yaml::yaml.load_file("/root/repbox_config.yml")

if (!is.null(config$comment)) {
  try(cat(paste0("\nComment: ", config$comment,"\n")))
}

repo_type = config$repo_type
options(timeout=60*60)

cat("\nRepotype = ", repo_type,"\n")
if (repo_type == "zip_url" | repo_type == "dv") {
  url = config$url
  cat("\nDownload supplement from ", url,"\n")
  options(timeout=60*60)
  download.file(url, "/root/zip/supplement.zip")
} else if (repo_type == "oi") {
  source("~/scripts/download_oi.R")
} else if (repo_type == "ze") {
  repo_id = config$repo_id
  cat("\nDownload Zenodo supplement ", repo_id,"\n")
  source("~/scripts/download_ze.R")
  options(timeout=60*60)
  download_zenodo_zip(repo_id, "/root/zip")
}

cat("\nResulting content of download folder: /root/zip\n")
print(list.files("/root/zip/"))
cat("\n")
