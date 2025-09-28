#!/usr/bin/env python3
file = "A01_01.sam"
#creating dictionary 
chromosome_count = {}
nm_count = {}

#process line by line 
with open(file) as sam:
    for line in sam:
        if line.startswith("@"): #skip if header line starts with @
            continue
        splitfields = line.strip().split("\t") #split by \t
        RANMEChrom = splitfields[2] #RNAME field
        if RANMEChrom not in chromosome_count: #changing the count number
            chromosome_count[RANMEChrom] = 1 #starts at 1
        else:
            chromosome_count[RANMEChrom] += 1 #else add one 
        for field in splitfields[11:]: #look line by line
            if field.startswith("NM:i:"): #look for NM:I tag 
                NM = int(field[5:]) #convert to int 
                if NM not in nm_count: #counting HOW MANY TIMES 
                    nm_count[NM] = 0
                nm_count[NM] += 1
                break 


print("chomosome counts:")
for RANMEChrom in chromosome_count:
    print(RANMEChrom,chromosome_count[RANMEChrom])

print("Mismatch counts (NM tag)")
for NM in sorted(nm_count.keys()): #sorted 
    print(NM, nm_count[NM])
