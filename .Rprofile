# load ~/.Rprofile if it exists
if (length(setdiff(getOption('repos'), '@CRAN@')) == 0) {
  if (file.exists('~/.Rprofile')) sys.source('~/.Rprofile', environment())
}
if (length(setdiff(getOption('repos'), '@CRAN@')) == 0) {
  options(repos = 'https://cloud.r-project.org')
}
