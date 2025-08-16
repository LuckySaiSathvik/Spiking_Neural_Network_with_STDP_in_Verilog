#program to extract final weights from the vcd file and store it into mem file
def extract_final_weights(vcd_file): #function to extract final weights
    weight_values = {} #stores the weights along with the variable name
    signal_mapping = {} #maps the signals from vcd file
    time_marker = None #for recognising the timestamp
    #for understanding the below content, open vcd file with text editor
    with open(vcd_file, "r") as file: #reading the given vcd file
        for line in file: #iterating through every line
            line = line.strip() #removing spaces in the front and back only
            if line.startswith("$var"): #in vcd file, these lines contain details of variable
                parts = line.split() #seperate the code, datatype, name, size into list
                if len(parts) > 4: #this is obvious if the line describes variable
                    signal_code = parts[3] #this identifies the unique variable; also called code
                    variable_name = parts[4] #take the variable name
                    if "wt_" in variable_name and "dwt_" not in variable_name:
                         #this will collect weight variables (wt_h_ and wt_o_); strictly not dwt's
                        signal_mapping[signal_code] = variable_name #store variable name with code
            elif line.startswith("#"): #this will detect the timestamps (last taken 500 in testbench)
                time_marker = int(line[1:]) #extracts the timestamp
            elif line and time_marker is not None: #extracting the values
                if line[0] == "b": #value-induced lines start with b
                    value, signal_code = line[1:].split() #takes the value and corresponding code
                else: #if not starting with b (some lines like this exist)
                    value = line[0] #collects the value 1-bit
                    signal_code = line[1:] #collects the code
                if signal_code in signal_mapping: #storing latest value for each weight
                    weight_values[signal_mapping[signal_code]] = value #value linked to variable
    return weight_values # return the weight names and values
#function to save the stored weight names and values into text file
def save_weights_to_file(weight_values):
    with open(WEIGHTS_MEM_PATH, "w") as mem_file:
    #opening weights.mem file in write mode
        for var, value in weight_values.items(): #iterates over the entire set of weights stored
            mem_file.write(value + "\n") #write value into the mem file
    print(f"Weights stored in {WEIGHTS_MEM_PATH}") #message to alert us that it's done

#main function which does all the things given
#defining the files here
VCD_FILE_PATH = "6_result_training.vcd"
WEIGHTS_MEM_PATH = "8_trained_weights.mem"
weight_values = extract_final_weights(VCD_FILE_PATH)
save_weights_to_file(weight_values)
