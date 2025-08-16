#program to generate 6-bit input sequence and 3-bit expected output sequence from the data in table
#function to convert height,weight,type into 6-bit and 3-bit sequences respectively
def encoder_function(height, weight, kind):
    value = "" #empty string to store the encoded bits
    #conditions for encoding height: range is 105 to 120 cm for 6-year olds
    #encode unique 3-bits for every 2.5cm
    if height <= 105.0:
        ht_bits = "000"
    elif height > 105.0 and height <= 107.5:
        ht_bits = "001"
    elif height > 107.5 and height <= 110.0:
        ht_bits = "010"
    elif height > 110.0 and height <= 112.5:
        ht_bits = "011"
    elif height > 112.5 and height <= 115.0:
        ht_bits = "100"
    elif height > 115.0 and height <= 117.5:
        ht_bits = "101"
    elif height > 117.5 and height <= 120.0:
        ht_bits = "110"
    elif height > 120.0:
        ht_bits = "111"
    else: #if anything else is entered, throws error
        ht_bits = "xxx"
    #conditions for encoding weight: range is 17 to 26 kg for 6-year olds
    #encoded unique 3-bits for every 1.5kg
    if weight <= 17.0:
        wt_bits = "000"
    elif weight > 17.0 and weight <= 18.5:
        wt_bits = "001"
    elif weight > 18.5 and weight <= 20.0:
        wt_bits = "010"
    elif weight > 20.0 and weight <= 21.5:
        wt_bits = "011"
    elif weight > 21.5 and weight <= 23.0:
        wt_bits = "100"
    elif weight > 23.0 and weight <= 24.5:
        wt_bits = "101"
    elif weight > 24.5 and weight <= 26.0:
        wt_bits = "110"
    elif weight > 26.0:
        wt_bits = "111"
    else: #if anything else is entered, throws error
        wt_bits = "xxx"
    #conditions for encoding expected output: overweight, underweight or perfect
    if kind == "Over":
        kind_bits = "100"
    elif kind == "Perfect":
        kind_bits = "010"
    elif kind == "Under":
        kind_bits = "001"
    else: #if anything else is entered, throws error
        kind_bits = "000"
    value = ht_bits + wt_bits + kind_bits #final value is the concatenation of these bits
    return value

#main function which does all the things given
#defining the files here
input_file = "1_training_data_table.txt"
output_file_1 = "3_training_inputs.mem"
output_file_2 = "3_training_exp_outputs.mem"
sequences = [] #this stores all sequences in list
expects = [] #this sores all expects in list
with open(input_file, "r") as file: #opening the table text file in read mode
    lines = file.readlines() #extract all the lines in the file
    for line in lines[2:]:  #skipping lines like height,weight,kind headings (refer to the file)
        parts = line.strip().split("|") #extract the numerical values from the table
        if len(parts) >= 5: #extract height, weight, kind seperately
            try:
                height = float(parts[1].strip()) #extract float value of height without any spaces
                weight = float(parts[2].strip()) #extract float value of weight without any spaces
                kind = str(parts[3].strip()) #extract kind as a string without any spaces
                result = encoder_function(height, weight, kind) #encode function is called
                sequences.append(result[:6]) #add height,weight to the list of sequences
                expects.append(result[6:]) #add kind to the list of expects
            except ValueError: #if there are any useless lines existing
                continue  #skip those invalid lines
with open(output_file_1, "w") as file: #write sequences to a mem file
    for seq in sequences: #iterate over each sequence in the list
        file.write(seq + "\n") #write into the mem file
with open(output_file_2, "w") as file: #write expects to a mem file
    for exp in expects: #iterate over each sequence in the list
        file.write(exp + "\n") #write into the mem file
print(f"Sequences saved to {output_file_1} and {output_file_2} respectively")
