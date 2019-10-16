require(googlesheets)
gs_auth(new_user=T)

sheetdir = gs_ls()

tester = gs_key('1uMPb0YdaZ6Vy7Aim21YMNfMzUCy8L-Zeon8zVhcXGjU')

tester2=gs_read(tester)
