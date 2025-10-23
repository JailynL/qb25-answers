#!/usr/bin/env python3

#answer for Step 3.1: Visualize data in IGV
#The samples I think that derive from the wine strain are sample 24,27,31,62 and 63. 
#I say this because they have the most mismatches (colored bars)  to the reference genome in this region, which is lab dervied. 
sample_ids = ["A01_62", "A01_39", "A01_63", "A01_35", "A01_31","A01_27", "A01_24", "A01_23", "A01_11", "A01_09"]

with open("biallelic.vcf", "r") as INPUTfile, open("gt_long.txt", "w") as OUTPUTfile: #provding input and output text file for parce
    OUTPUTfile.write("sample_id\tchrom\tpos\tgenotype\n") #header of the new file
    for line in INPUTfile:
        if line.startswith("#"):
            continue 
        data = line.strip().split("\t")
        chrom = data[0] 
        pos = data[1]

        for i in range(len(sample_ids)):
            sample_data = data[9 + i] 
            genotype = sample_data.split(":")[0]

            if "0" in genotype:
                geno = "0"
            elif "1" in genotype:
                geno = "1"
            else:
                continue
            OUTPUTfile.write(sample_ids[i] + "\t" + chrom + "\t" + pos + "\t" + geno + "\n")

    