# Copyright (c) 2018 Jyothi Krishna V.S., Rupesh Nasre, Shankar Balachandran, IIT Madras.
# This file is a part of the project CES, licensed under the MIT license.
# See LICENSE.md for the full text of the license.
# 
# The above notice shall be included in all copies or substantial 
# portions of this file.
from os import listdir
from os.path import isfile, join
import sys
import csv

def outp(mypath, filen, total, n, b, bn, num):
    inputfile = mypath + "/" + filen
    lit = 0
    big = 0
    with open(inputfile) as fp:
        for line in fp:
            fc = line.split(" ")
            if "Instructions" in line:
                total[num][bn][3] = long(fc[len(fc) -1]) 
            if "percentage" in line:
               # print line
               # print fc
                total[num][bn][4] = float(fc[len(fc) -1])
            elif "Elapsed " in line:
              #  print line
              #  print fc
                total[num][bn][5] = float(fc[len(fc) -2])
            elif "scheduled" in line:
                core = int(fc[len(fc) -3])
                if core < n-b:
                    lit = lit + int(fc[len(fc)-1])
                else:
                    big = big + int(fc[len(fc) -1])
    fp.close()

    if n != b:
        total[num][bn][6] = lit/(n-b)
        total[num][bn][9] = float(big)/lit 
    if b != 0:
        total[num][bn][7] = big/b
    total[num][bn][8] = ((float)(lit)/(lit+big)) * (100)
     

        
    
def prof(mypath, filen, total, n, b, bn, num):
    tot = 0
    big = 0
    lit = 0
    peaklit= 0
    peakbig = 0
    peaktot = 0
    samples = 0
    samplespersecond = 10    
    inputfile = mypath + "/" + filen
    i = 0
    with open(inputfile) as fp:
        for line in fp:
            i = i+1;
            fc = line.split(",")
            if(len(fc)>3 and i > 2):
                tot = tot + float(fc[len(fc)-1])
                big = big + float(fc[len(fc)-4])
                lit = lit + float(fc[len(fc)-5])
                samples = samples +1;
                if peaklit < float(fc[len(fc)-5]):
                    peaklit = float(fc[len(fc)-5])
                if peakbig < float(fc[len(fc)-4]):
                    peakbig = float(fc[len(fc)-4])
                if peaktot < float(fc[len(fc)-1]):
                    peaktot = float(fc[len(fc)-1])
    fp.close()
    if samples == 0:
        print "error samples 0 " + filen
        sys.exit()
    totAvg = tot/samples
    bigAvg = big/samples
    litAvg = lit/samples    
    if b == 0:
        totAvg = totAvg - bigAvg
        bigAvg = 0
    if b == 2:
        totAvg = totAvg - 1.1
        bigAvg = bigAvg - 1.1
    if n == b:
        totAvg = totAvg - litAvg
        litAvg = 0
    print peaklit, peakbig, peaktot
    total[num][bn][10] = litAvg
    total[num][bn][11] = bigAvg
    total[num][bn][12] = totAvg
    total[num][bn][13] = peaklit
    total[num][bn][14] = peakbig
    total[num][bn][15] = peaktot



def run():
    mypath="./readingscritical"
    bna = ["r01","r02","r03","r05","r07","r09","cr1","1.5","cr2","cr5","r10","r15","r20","r25","r30","r35"]
    csvfile="critical.csv"
    onlyfiles = [f for f in listdir(mypath) if isfile(join(mypath, f))]
    total = [[[ 0 for j in xrange (20)]for i in xrange (72)] for k in xrange(20) ]
    benchmarks = []
    for filen in onlyfiles:
        br = filen[:-4]
        num = int(br[-1:])
        br = br[:-2]
        profstr =  br[-4:]
        if profstr == "prof":
            br = br[:-5]
           # print  mypath + "/" +filen  
           # print br
           # print num
            b = int(br[-1:])
            n = int(br[-3:-2])
            bn = 0
            if n == 4 and b == 0: 
                mul = 0
            elif n == 4 and b == 4:
                mul = 1
            elif n == 6 and b == 2:
                mul = 2
            elif n == 8 and b == 4:
                mul = 3
            else:
                print "error in values of na and b ", n, b
                sys.exit(0)
            for bnv in bna:
                if bnv == br[-7:-4]:
                    break
                else:
                    bn = bn + 1
            if bn == len(bna):
                print "error no bna " + br
                sys.exit()
            bn = (mul * len(bna))  + bn
           # print bn
            prof(mypath, filen, total, n, b, bn, num)
          #  prof(mypath)
        else:
           # print br
           # print num
           # print  mypath + "/" +filen  
            b = int(br[-1:])
            n = int(br[-3:-2])
            bn = 0
            for bnv in bna:
                if bnv == br[-7:-4]:
                    break
                else:
                    bn = bn + 1
            if n == 4 and b == 0: 
                mul = 0
            elif n == 4 and b == 4:
                mul = 1
            elif n == 6 and b == 2:
                mul = 2
            elif n == 8 and b == 4:
                mul = 3
            else:
                print "error in values of na and b ", n, b
                sys.exit(0)
   
            if bn == len(bna):
                print "error no bna " + br
                sys.exit()
            bn = (mul * len(bna))  + bn
            total[num][bn][0] = br
            total[num][bn][1] = n
            total[num][bn][2] = b
            outp(mypath, filen, total, n, b, bn, num)
    
    bnsize= 4 * len(bna)

    for bni in range(bnsize):
        count = 0
        time5 = 0
        lit6 = 0
        big7 = 0
        perlit8 = 0
        speedbig9 = 0
        litp10 = 0
        bigp11 = 0
        totp12 = 0
        litpp13 = 0
        bigpp14 = 0
        totpp15 = 0
        lite16 = 0
        bige17 = 0
        tote18 = 0

        for num in range(1,6):
            if total[num][bni][0] != '0' :
                count = count + 1
                time5 = time5 + total[num][bni][5]
                lit6 = lit6 + total[num][bni][6]
                big7 = big7 + total[num][bni][7]
                perlit8 = perlit8 + total[num][bni][8]
                speedbig9 = speedbig9 + total[num][bni][9]
                litp10 = litp10 + total[num][bni][10]
                bigp11 = bigp11 + total[num][bni][11]
                totp12 = totp12 + total[num][bni][12]
                litpp13 = litpp13 + total[num][bni][13]
                bigpp14 = bigpp14 + total[num][bni][14]
                totpp15 = totpp15 + total[num][bni][15]
                lite16 = lite16 + (total[num][bni][5] * total[num][bni][10])
                bige17 = bige17 + (total[num][bni][5] * total[num][bni][11])
                tote18 = tote18 + (total[num][bni][5] * total[num][bni][12])
        total[6][bni][0]  = total[1][bni][0]
        total[6][bni][1]  = total[1][bni][1]
        total[6][bni][2]  = total[1][bni][2]
        total[6][bni][3]  = total[1][bni][3]
        total[6][bni][4]  = total[1][bni][4]
        total[6][bni][5]  = time5/count 
        total[6][bni][6]  = lit6/count
        total[6][bni][7]  = big7/count
        total[6][bni][8]  = perlit8/count
        total[6][bni][9]  = speedbig9/count
        total[6][bni][10]  = litp10/count
        total[6][bni][11] = bigp11/count
        total[6][bni][12] = totp12/count
        total[6][bni][13] = litpp13/count
        total[6][bni][14] = bigpp14/count
        total[6][bni][15] = totpp15/count
        total[6][bni][16] = lite16/count
        total[6][bni][17] = bige17/count
        total[6][bni][18] = tote18/count
#    print total[6]
    with open(csvfile, "w") as output:
        writer = csv.writer(output, lineterminator='\n')
        writer.writerows(total[6])
    return


if __name__ == '__main__':
    run()
