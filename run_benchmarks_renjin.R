
# adapted from: https://github.com/bedatadriven/activityinfo-R/blob/development/inst/ci-build.R
# ieuan clay
# may 2015

### run all benchmarks in genbench
# needs info about path and what size of data to run on
args <- commandArgs(trailingOnly = TRUE)
if (length(args) > 0) {
  NRUNS <- as.integer(args[1])
  cat(sprintf("Using %i runs per benchmark\n", NRUNS))
  
} else {
  NRUNS <- 1
  cat(sprintf("Using default number of runs (%i)\n", as.integer(NRUNS)))
}

# find and run all benchmark scripts
for (SCRIPT in rev(dir(file.path(getwd(), "code"), 
                       full.names = TRUE, recursive = TRUE, pattern = "\\.R$", 
                       ignore.case = TRUE))){
  # run benchmark script
  cat(timestamp(quiet = TRUE), "Running benchmark at ", SCRIPT,"\n")
  for (x in 1:NRUNS){
    cat(sprintf("\t>>>Run %i\n", x))
    # all scripts assume working dir is same as script
    # each script run in a fresh local environment
    try({source(SCRIPT, chdir = TRUE, local=new.env())})
  }
}

