config = yaml::yaml.load_file("../repbox_config.yml")
repo_type = config$repo_type

if (repo_type == "zip_url") {
  url = config$url
  download.file(url, "/root/zip/supplement.zip")
} else if (repo_type == "oi") {
  source("~/scripts/download_oi.R")
}

