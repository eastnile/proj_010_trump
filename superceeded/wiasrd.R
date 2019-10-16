link = "http://www.doleta.gov/performance/results/WIASRD/PY2008/PublicWIASRD2008.zip"
temp=tempfile()
download.file(link,temp)
data = read.csv(unz(temp,"PublicWIASRD2008.csv"),nrows = 1000)
