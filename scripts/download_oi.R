library(reticulate)

setwd('/root/scripts')

# Just a test
#cat("\nTest python and reticulate...\n")
#reticulate::source_python("hello.py")
#hello_py()

cat("\nDownload repository...")
reticulate::source_python("download_oicpsr.py")

# These parameters must be passed
login_password = Sys.getenv("OI_PASSWORD")
login_email = Sys.getenv("OI_EMAIL")

outfile = ""
outdir = '/home/rstudio/selenium/python_oi'

config = yaml::yaml.load_file("../repbox_config.yml")
repo_id = config$repo_id

download_oicpsr(repo_id,login_email,login_password,outfile=paste0(repo_id,".zip"),outdir = "/root/zip")

