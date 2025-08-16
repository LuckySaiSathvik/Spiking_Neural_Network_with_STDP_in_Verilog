**Spiking_Neural_Network_with_STDP_in_Verilog**

This project was on designing Spiking Neural Network (SNN) with Spike-Time Dependent Plasticity (STDP) learning algorithm; the design contains 6 input neurons in the input layer, 6 neurons in the only hidden layer and 3 output layer neurons. It is entirely coded in Verilog HDL while Python scripts are used for manipulating and/or representing the data; the SNN has Leaky-Integrate-and-Fire (LIF) neurons.

The SNN's task was to classify data of 6-year old kids as UnderWeight/PerfectWeight/OverWeight based on their heights and weights; the input to the SNN is an encoded version of given height and weight and the output from the SNN was one-hot encoded into the three categories mentioned above. My contribution to the project involves everything from designing the working of each neuron and overall network to data manipulation and representation.

There were 50 data samples provided for training in 217 iterations and another 15 data samples provided for testing; both generated from different random distributions; while the weights were 12-bit signed integers. The training accuracy was recorded 54% and the testing accuracy was recorded 46% upon simulation in Icarus Verilog and GTKWave.

**Steps to run it in your device terminal after cloning:**
(Keep Icarus Verilog and GTKWave installed)

1) Edit the files 1_training_data_table.txt and 9_testing_data_table.txt with your data samples (make sure the edited file has similar format as the original one)
2) During training:
   1) Run the command: **python3 2_training_inputs_maker.py** and wait till the files 3_training_inputs.mem and 3_training_exp_outputs.mem are updated.
   2) Then run the commands:
      **iverilog -o 5_train_wave 4_training_testbench.v** for syntax error checking;
      **vvp 5_train_wave** to generate the waveform vcd file; and
      **gtkwave 6_result_training.vcd** to view the waveform.
   3) After this, run the commands: (make sure you have matplotlib installed)
      **python3 7_training_plot_maker.py** to generate training accuracy plot; and
      **python3 7_weights_extractor.py** to extract weights for testing into 8_trained_weights.mem
3) During testing:
   1) Run the command: **python3 10_testing_inputs_maker.py** and wait till the files 11_testing_inputs.mem and 3_testing_exp_outputs.mem are updated.
   2) Then run the commands:
      **iverilog -o 13_test_wave 12_testing_testbench.v** for syntax error checking;
      **vvp 13_test_wave** to generate the waveform vcd file; and
      **gtkwave 14_result_testing.vcd** to view the waveform.

**Note:** Please don't change any other files after cloning this repo other than 1_training_data_table.txt and 9_testing_data_table.txt for best results. You can learn more theory from the report attached.

**Sai Sathvik G B**

Contributor
