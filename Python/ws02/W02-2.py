import pandas as pd

url = "http://www.cpc.ncep.noaa.gov/data/indices/oni.ascii.txt"

#help(pd.read_fwf)
oni = pd.read_fwf(url, widths = [5, 5, 7, 7])
oni.head()

# Aufgabe 1: Anzahl der weak, medium, strong und very strong Annomalien
#para el nino
vs=0
s=0
m=0
w=0
#para el nina
vsni=0
sni=0
mni=0
wni=0
for j in range(0,len(oni)):
    if oni['ANOM'][j] > 2:
        #print("verystrong")
        vs=vs+1
    elif oni['ANOM'][j] <= 1.9:
        #print("strong")
        s=s+1
    elif oni['ANOM'][j] <= 1.4:
        #print("medium")
        m=m+1
    elif oni['ANOM'][j] <= 0.9:
        #print("weak")
        w=w+1
    elif oni['ANOM'][j] < (-2):
        vsni=vsni+1
    elif oni['ANOM'][j] >= (-1.9):
        sni=sni+1
    elif oni['ANOM'][j] >= (-1.4):
        mni=mni+1
    elif oni['ANOM'][j] >= (-0.9):
        wni=wni+1
print("EL NINO : very strong:",vs,"strong:",s,"medium:",m,"weak:",w)
print( "EL NINA : very strong", vsni,"strong:",sni,"medium:",mni,"weak:",wni)
#Aufgabe 2: Anteil der schwachen el nino events

print((w*100)/(vs+s+m+w), "% der el nino events sind 'schwach' ")

# Aufgabe 3: dic erstellen mit elnina und elnino

events = {"weakNINA" : wni, "medNINA" : mni, "strongNINA" : sni, "vsNINA" : vsni, "weakNINO" : w, "medNINO" : m, "strongNINO" : s, "vsNINO" : vs}
print(events)
