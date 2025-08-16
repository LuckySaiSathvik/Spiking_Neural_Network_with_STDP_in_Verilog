#program to plot the no. of matched outputs vs. the no. of iterations and save it into image file
import matplotlib.pyplot as plt #this will import the plotting module
vcd_file = '6_result_training.vcd' #vcd file given
image_file = '8_training_accuracy_plot.jpg' #image file given
signal_mapping = {} #maps the signals from vcd file
current_values = {} #stores the current values based on the variable name and timestamp
recorded_data = [] #stores the particular "match" and "i" variables' data
with open(vcd_file, "r") as file: #reading the given vcd file
    #loop for mapping the variable names and codes (only variable definitions)
    for line in file: #iterating through every line
        line = line.strip() #removing spaces in the front and back only
        if line.startswith("$var"): #in vcd file, these lines contain details of variable
            parts = line.split() #seperate the code, datatype, name, size into list
            if len(parts) > 4: #this is obvious if the line describes variable
                signal_code = parts[3] #this identifies the unique variable; also called code
                variable_name = parts[4] #take the variable name
                signal_mapping[signal_code] = variable_name #store variable name with code
        elif "$enddefinitions" in line: #this line says all variables have been defined
            break #stop the loop at this moment and exit it
    #loop for reading the values based on the time change
    current_time = 0 #consider initial time is zero; used to store timestamps
    for line in file: #iterating through every line
        line = line.strip() #removing spaces in the front and back only
        if line.startswith('#'): #this will detect the timestamps of the vcd file
            current_time = int(line[1:]) #extracts the timestamp
        elif line and not line.startswith('$'): #single-bit values condition
            if line[0] in ['0','1']: #this means the line should have binary value to be stored
                value = int(line[0]) #store the single-bit value as integer
                signal_code = line[1:] #store the signal code
            elif line.startswith('b'): #multi-bit values conditton
                parts = line.split() #divide the line based onto spaces into the values and code 
                value = int(parts[0][1:], 2) #store the multi-bit binary value as integer
                signal_code = parts[1][-1] #store the signal code
            else: #if the line satisfies none of the conditions
                continue #get back to the start of loop (next iteration)
            variable_name = signal_mapping.get(signal_code, None) #get the variable name from code
            if variable_name: #if the variable name exists
                current_values[variable_name] = value #store the values based on variable name
            #only record "match", "i" and "j" variables
            if "match" in current_values and "i" in current_values and "j" in current_values: 
                if current_values["j"] == 48: #append data in this condition
                    i_val = current_values["i"] #store all values corresponding to "i"
                    match_val = current_values["match"] #store all values corresponding to "match"
                    recorded_data.append((i_val, match_val)) #add the values into the list
unique_data = {} #this dictionary is used to store only unique values
final_data = [] #this list is used to store the final values
for i_val, match_val in recorded_data: #only if both values of "i" & "match" are in recorded data
    unique_data[i_val] = match_val  #overwrite if i appears again; so only unique values exist
for items in unique_data.items():
    iterations = 217 - items[0] #this is the first item i.e. key
    if(iterations == -4294967078): #this will collect the final iteration's value of matches
        iterations = 220 #taking this so that the plot points will be all beside each other 
    matches = items[1] #this is the second item i.e. value
    final_data.append((iterations, matches)) #add the values into the list
sorted_final_data = sorted(final_data, key=lambda x: x[0]) #sort the data based on iteration no.
accuracy = 100 * sorted_final_data[-1][-1] // 50 #calculate the accuracy based on no. of matches
iterations = [] #empty list to store values of iterations
matches = [] #empty list to store values of no. of matches corresponding to iteration 
for values in sorted_final_data: #iterate the data collected and sorted
    iterations.append(values[0]) #extract the iteration value
    matches.append(values[1]) #extract the no. of matches for that iteration
for (x,y) in zip(iterations,matches): #for every point in the combined list of iterations & matches
    if x%4 == 0 and y != 0: #only taking multiple-of-4 iterations and non-zero iterations
        plt.plot(x, y, marker=".", color="green") #mark point as green dot and add it's coordinates
        plt.text(x+0.5, y-0.5, f"({x},{y})", fontsize=6, ha="left", va="bottom", zorder=10)
#title and labels of the plot
plt.title('Matched Outputs vs Iterations in Training')
plt.xlabel('Iteration Number')
plt.ylabel('No. of Matches')
plt.grid(True) #add grid to the plot so that it looks neat
plt.tight_layout() #automatically adjust parameters to fit in the figure size
plt.savefig(image_file, dpi=300) #save the plot to this image file
print(f"Final no. of matches (training) = {sorted_final_data[-1][-1]} / 50") #print no. of matches
print(f"Training Accuracy = {accuracy}%") #print the training accuracy
print(f"Saved the plot into {image_file}; please check it.") #finish message
