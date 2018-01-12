#geht unter 2.7
import math
def eigenstand(h, d, p):
  if d < 100000:
    E1 = math.log(float(h)/float(8848), 2) + math.log(float(d)/float(100000), 2) + math.log(float(p)/float(h), 2)
    E = -(E1/3)
  else:
    E1 = math.log(float(h)/float(8848), 2) + math.log(float(p)/float(h), 2)
    E = -(E1/3)
  return(E)
  

#geht unter 3.*
import math
def eigenstand(h, d, p):
  if d < 100000:
    E1 = math.log(h/8848, 2) + math.log(d/100000, 2) + math.log(p/h, 2)
    E = -(E1/3)
  else:
    E1 = math.log(h/8848, 2) + math.log((p/h), 2)
    E = -(E1/3)
  return(E)
  
  
##### oder   auch 2.*
from __future__ import division
import math
def eigenstand(h, d, p):
  if d < 100000:
    E1 = math.log(h/8848, 2) + math.log(d/100000, 2) + math.log(p/h, 2)
    E = -(E1/3)
  else:
    E1 = math.log(h/8848, 2) + math.log((p/h), 2)
    E = -(E1/3)
  return(E)
  
eigenstand(2500, 25000, 1200)
h = 2500
d = 25000
p = 1200