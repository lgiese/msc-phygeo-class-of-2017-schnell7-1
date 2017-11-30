def sort2a(x):
    if len(x) > 1:
        tmpx = x[:]
        tmpgr = []
        tmpkl = []
        tmpmi = []
        f = 0
        for i in range(len(tmpx)):
            print(tmpx[0] <= tmpx[i])
            if tmpx[0] < tmpx[i]:
                tmpgr.append(tmpx[0+i])
            elif tmpx[0] == tmpx[i]:
                tmpmi.append(tmpx[0+i])
                f = f+1
            else:
                tmpkl.append(tmpx[0+i])
                f = f+1
    tmpvorne = tmpkl[:]
    tmphinten = tmpgr[:]
    while len(tmpkl) > 1:
        tmpvorne = sort2a(tmpvorne)    
        tmphinten = sort2a(tmphinten)        
    tmpxr = tmpvorne + tmpmi + tmphinten
    return(tmpxr)




