#!/usr/bin/env python3

#allele frequency 
with open ("AF.txt","w") as file: 
    for line in open ("biallelic.vcf"):
        if line.startswith('#'):
            continue
        fields = line.rstrip('\n').split('\t')
        allele = fields[7].split(";")
        for freq in allele:
            if freq.startswith("AF="):
                print(freq[3:])
                file.write(freq[3:] + "\n")

#Read Depth Distribution
with open ("DP.txt","w") as fileDP: 
    for line in open ("biallelic.vcf"):
        if line.startswith('#'):
            continue
        sample = line.rstrip('\n').split('\t')
        variant = sample[9:] #corresponding fields A0X and so on
        for depth in variant:
            splitdata = depth.split(":") #do not use conditional in this case, since we k.. 
            print(splitdata[2])  
            fileDP.write(splitdata[2] + "\n")
    


