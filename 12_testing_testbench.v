`include "12_testing_design.v"//including the respective files needed
`timescale 1ps / 1ps//time unit and precision of 1 picosecond each
//testbench module for the neural network in the design file
module overall_neural_network_testing_tb;
	reg [5:0] input_seq [0:14];//stores the input sequences read from the mem file
	reg [2:0] exp_output_seq [0:14];//stores the expected output sequences read from the mem file
	//shift register based variables to erase visible delay between outputs; for easy comparison
	reg [2:0] shift_reg_1 = 3'd0;
	reg [2:0] shift_reg_2 = 3'd0;
	//clock and reset taken as reg
	reg clock;
	reg reset;
	//6 inputs taken as reg
	reg inp_1;
	reg inp_2;
	reg inp_3;
	reg inp_4;
	reg inp_5;
	reg inp_6;
	//3 expected outputs taken as reg
	reg exp_outp_1;
	reg exp_outp_2;
	reg exp_outp_3;
	//3 actual outputs taken as wire
	wire outp_1;
	wire outp_2;
	wire outp_3;
	integer j = 14;//loop variable for always block to push inputs
	integer match = 0;//martch value that compares expected and neuron outputs
	integer accuracy = 0;//testing accuracy; initially this value is zero
	//instantiation of the design file neural network
	overall_neural_network_testing NN_TEST(
		.clock(clock),.reset(reset),
		.inp_1(inp_1),.inp_2(inp_2),.inp_3(inp_3),
		.inp_4(inp_4),.inp_5(inp_5),.inp_6(inp_6),
		.outp_1(outp_1),.outp_2(outp_2),.outp_3(outp_3)
	);
	initial//single time running block
		begin
			//read mem files in binary format
			$readmemb("11_testing_inputs.mem",input_seq);
			$readmemb("11_testing_exp_outputs.mem",exp_output_seq);
			$dumpfile("14_result_testing.vcd");//dump outputs into vcd file
			$dumpvars;//dump all variables
			#750 $display("Final no. of matches (testing)= %2d / 15",match);//show final match value
			accuracy = 100 * match / 15;//calculate the testing accuracy 
			$display("Testing Accuracy = %2d %%",accuracy);//display the value of testing accuracy
			$finish;//end the simulation
		end
	initial//single time running block
		begin
			clock = 1'b1;//initially clock high
			reset = 1'b0;//initially reset low
			//initial inputs and expected outputs are given all zeros
			{inp_1,inp_2,inp_3,inp_4,inp_5,inp_6} = 6'd0;
			{exp_outp_1,exp_outp_2,exp_outp_3} = shift_reg_2;//main push
			shift_reg_2 = shift_reg_1;//intermediate push
			shift_reg_1 = 3'd0;//pushing all zeroes to the last shift register
		end
	always #20 clock = !clock;//clock period of 30 nanoseconds
	always@(posedge clock)//continuously running block
		begin
			if(j >= 0)//only if j exists
				begin
					{inp_1,inp_2,inp_3,inp_4,inp_5,inp_6} = input_seq[14 - j];//give inputs
					{exp_outp_1,exp_outp_2,exp_outp_3} = shift_reg_2;//main push
					shift_reg_2 = shift_reg_1;//intermediate push
					shift_reg_1 = exp_output_seq[14 - j];//pushing expected outputs
					j = j - 1;//decrement the input & exp_output sequence counter
				end
			else//when it comes to end of inputs
				begin
					//end of simulation
					{inp_1,inp_2,inp_3,inp_4,inp_5,inp_6} = 6'd0;//give all inputs zeroes
					//give all expected outputs zeroes after two clock edges
					{exp_outp_1,exp_outp_2,exp_outp_3} = shift_reg_2;//main push
					shift_reg_2 = shift_reg_1;//intermediate push
					shift_reg_1 = 3'd0;//pushing all zeroes to the last shift register
				end
		end
	always@(negedge clock)//matching always block; to work on negative edge
		begin
			if({outp_1,outp_2,outp_3} == shift_reg_2)//match condition
				if(shift_reg_2 != 3'b000)//so as to not count initial zeroes matched
					match = match + 1;//increment match if outputs same as expected
		end
endmodule
