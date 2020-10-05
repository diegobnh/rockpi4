# Copyright (c) 2018 Jyothi Krishna V.S., Rupesh Nasre, Shankar Balachandran, IIT Madras.
# This file is a part of the project CES, licensed under the MIT license.
# See LICENSE.md for the full text of the license.
# 
# The above notice shall be included in all copies or substantial 
# portions of this file.
import sys
import sys, getopt

def main(argv):
   inputfile = ''
   samplespersecond= 1
   try:
      opts, args = getopt.getopt(argv,"hi:s:",["ifile=","sam="])
   except getopt.GetoptError:
      print 'test.py -i <inputfile> -s <outputfile>'
      sys.exit(2)
   for opt, arg in opts:
      if opt == '-h':
         print 'test.py -i <inputfile> -s <outputfile>'
         sys.exit()
      elif opt in ("-i", "--ifile"):
         inputfile = arg
      elif opt in ("-s", "--sam"):
         samplespersecond = int(arg)
   print 'Input file is "', inputfile
 
   big = 0;
   lit = 0;
   tot = 0;
   i = 0;
   samples =0;
   print 'samples per second ',samplespersecond
   with open(inputfile) as fp:
      for line in fp:
         i = i+1;
         fc = line.split("|")
         if(len(fc)>1 and i > 2):
            tot += float(fc[len(fc)-1])
            big +=float(fc[len(fc)-4])
            lit +=float(fc[len(fc)-5])
            samples = samples +1;
   fp.close()
   print "Little core energy consumption" , (lit/samplespersecond)
   print "Big core Energy consumption" , (big/samplespersecond)
   print "Total system energy conspumtion" , (tot/samplespersecond)
   print "Total samples is" ,(samples)
if __name__ == "__main__":
   main(sys.argv[1:])
