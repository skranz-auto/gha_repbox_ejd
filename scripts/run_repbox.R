# This script will be run by a repbox analysis docker container
# Author: Sebastian Kranz

cat("\n\nREPBOX ANALYSIS START\n")

source("~/scripts/download_oi.R")

source("~/scripts/extract_7z.R")
extract.all.7z()


suppressPackageStartupMessages(library(devtools))
suppressPackageStartupMessages(devtools::load_all("/root/ExtractSciTab"))
suppressPackageStartupMessages(devtools::load_all("/root/repboxStata"))
suppressPackageStartupMessages(devtools::load_all("/root/repboxMain"))

# Writen files can be changed and read by all users
# So different containers can access them
Sys.umask("000")

project.dir = "~/projects/project"

zip.file = list.files("~/zip",glob2rx("*.zip"), full.names=TRUE)
#pdf.file = list.files("~/pdf",glob2rx("*.pdf"), full.names=TRUE)
pdf.file = NULL

start.time = Sys.time()
cat(paste0("\nAnalysis starts at ", start.time," (UTC)\n"))

stata.opts = repbox.stata.opts(report.inside.program = TRUE,all.do.timeout = 60*60*10,timeout = 60*60*10, comment.out.install = TRUE)

init.repbox.project(project.dir,sup.zip=zip.file, pdf.files = pdf.file)

update.repbox.project(project.dir,run.lang = "stata", make.matching = FALSE,make.report.html = FALSE, make.html=FALSE, make.ejd.html=TRUE, make.rstudio.html = FALSE, stata.opts = stata.opts)

slimify.solved.project(project.dir, max.log.mb = 0, max.cmd.mb = 0,max.stata.res.mb = 10, keep.org.code = TRUE)


system("chmod -R 777 /root/projects")

# Store results as encrypted 7z
cat("\nStore results as 7z")
dir.create("/root/output")
key = Sys.getenv("REPBOX_PKG_KEY")
to.7z("/root/projects/project","/root/output/project.7z",password = key)

cat(paste0("\nAnalysis finished after ", round(difftime(Sys.time(),start.time, units="mins"),1)," minutes.\n"))

cat("\nCPU INFO START\n\n")
system("cat /proc/cpuinfo")
cat("\nCPU INFO END\n\n")

cat("\nMEMORY INFO START\n\n")
system("cat /proc/meminfo")
cat("\nMEMORY INFO END\n\n")


cat("\n\nREPBOX ANALYSIS END\n")

