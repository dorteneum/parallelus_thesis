import numpy as np

file_name = '088_loci.txt'

f = open(file_name, "r")

#i = 0
filtered_out = []
l_buff = None
for l in f:
    
    if l.startswith('//'):
        print(l_buff)
        _cols = l_buff.split('     ')
        if len(_cols) != 2:
            print(_cols)
            sys.exit()
        _cols[1] = _cols[1].rstrip()
        loci_length = len(_cols[1])
        filtered_out.append(_cols[1] + "," + str(loci_length))
    
    #if i == 50:
    #    break
    #i+=1
    l_buff = l


with open("filtered_loci.txt", "w") as output:
    for row in filtered_out:
        output.write(str(row) + '\n')
