`timescale 1ps / 1ps//time unit and precision of 1 picosecond each
//final testing neural network module consisting of 3 layers including input
module overall_neural_network_testing(
	//clock and reset
	input clock,
	input reset,
	//6 inputs
	input inp_1,
	input inp_2,
	input inp_3,
	input inp_4,
	input inp_5,
	input inp_6,
	//3 outputs
	output outp_1,
	output outp_2,
	output outp_3
);
	//hidden layer input-outputs
	wire h_1;
	wire h_2;
	wire h_3;
	wire h_4;
	wire h_5;
	wire h_6;
	//3 actual outputs from the neurons; these are to be decoded
	wire act_outp_1;
	wire act_outp_2;
	wire act_outp_3;
	//3 final outputs from the decoder; taken so as to use inside always block
	reg fin_outp_1 = 1'b0;
	reg fin_outp_2 = 1'b0;
	reg fin_outp_3 = 1'b0;
	//memory-element based array to store some weights
	reg signed [11:0] weights_store [0:54];//55 storage elements because 1st one is zero in mem file
	//weight variables; total = 54
	//input layer to hidden layer weights; total = 36
	//hidden layer to output layer weights; total = 18
	reg signed [11:0] wt_h_11;
	reg signed [11:0] wt_h_12;
	reg signed [11:0] wt_h_13;
	reg signed [11:0] wt_h_14;
	reg signed [11:0] wt_h_15;
	reg signed [11:0] wt_h_16;
	reg signed [11:0] wt_h_21;
	reg signed [11:0] wt_h_22;
	reg signed [11:0] wt_h_23;
	reg signed [11:0] wt_h_24;
	reg signed [11:0] wt_h_25;
	reg signed [11:0] wt_h_26;
	reg signed [11:0] wt_h_31;
	reg signed [11:0] wt_h_32;
	reg signed [11:0] wt_h_33;
	reg signed [11:0] wt_h_34;
	reg signed [11:0] wt_h_35;
	reg signed [11:0] wt_h_36;
	reg signed [11:0] wt_h_41;
	reg signed [11:0] wt_h_42;
	reg signed [11:0] wt_h_43;
	reg signed [11:0] wt_h_44;
	reg signed [11:0] wt_h_45;
	reg signed [11:0] wt_h_46;
	reg signed [11:0] wt_h_51;
	reg signed [11:0] wt_h_52;
	reg signed [11:0] wt_h_53;
	reg signed [11:0] wt_h_54;
	reg signed [11:0] wt_h_55;
	reg signed [11:0] wt_h_56;
	reg signed [11:0] wt_h_61;
	reg signed [11:0] wt_h_62;
	reg signed [11:0] wt_h_63;
	reg signed [11:0] wt_h_64;
	reg signed [11:0] wt_h_65;
	reg signed [11:0] wt_h_66;
	reg signed [11:0] wt_o_11;
	reg signed [11:0] wt_o_12;
	reg signed [11:0] wt_o_13;
	reg signed [11:0] wt_o_14;
	reg signed [11:0] wt_o_15;
	reg signed [11:0] wt_o_16;
	reg signed [11:0] wt_o_21;
	reg signed [11:0] wt_o_22;
	reg signed [11:0] wt_o_23;
	reg signed [11:0] wt_o_24;
	reg signed [11:0] wt_o_25;
	reg signed [11:0] wt_o_26;
	reg signed [11:0] wt_o_31;
	reg signed [11:0] wt_o_32;
	reg signed [11:0] wt_o_33;
	reg signed [11:0] wt_o_34;
	reg signed [11:0] wt_o_35;
	reg signed [11:0] wt_o_36;
	initial//single-time running block
		begin
			//read mem file values to array as binary format
			$readmemb("8_trained_weights.mem",weights_store);
			//assign the weights based on comments in the mem file to the reg variables
			//taking weights from 1 to 54 since the first element in the mem file is zero
			//it ruins the testing process; so the 1st element is ignored
			wt_o_36 = weights_store[1];
			wt_o_35 = weights_store[2];
			wt_o_34 = weights_store[3];
			wt_o_33 = weights_store[4];
			wt_o_32 = weights_store[5];
			wt_o_31 = weights_store[6];
			wt_o_26 = weights_store[7];
			wt_o_25 = weights_store[8];
			wt_o_24 = weights_store[9];
			wt_o_23 = weights_store[10];
			wt_o_22 = weights_store[11];
			wt_o_21 = weights_store[12];
			wt_o_16 = weights_store[13];
			wt_o_15 = weights_store[14];
			wt_o_14 = weights_store[15];
			wt_o_13 = weights_store[16];
			wt_o_12 = weights_store[17];
			wt_o_11 = weights_store[18];
			wt_h_66 = weights_store[19];
			wt_h_65 = weights_store[20];
			wt_h_64 = weights_store[21];
			wt_h_63 = weights_store[22];
			wt_h_62 = weights_store[23];
			wt_h_61 = weights_store[24];
			wt_h_56 = weights_store[25];
			wt_h_55 = weights_store[26];
			wt_h_54 = weights_store[27];
			wt_h_53 = weights_store[28];
			wt_h_52 = weights_store[29];
			wt_h_51 = weights_store[30];
			wt_h_46 = weights_store[31];
			wt_h_45 = weights_store[32];
			wt_h_44 = weights_store[33];
			wt_h_43 = weights_store[34];
			wt_h_42 = weights_store[35];
			wt_h_41 = weights_store[36];
			wt_h_36 = weights_store[37];
			wt_h_35 = weights_store[38];
			wt_h_34 = weights_store[39];
			wt_h_33 = weights_store[40];
			wt_h_32 = weights_store[41];
			wt_h_31 = weights_store[42];
			wt_h_26 = weights_store[43];
			wt_h_25 = weights_store[44];
			wt_h_24 = weights_store[45];
			wt_h_23 = weights_store[46];
			wt_h_22 = weights_store[47];
			wt_h_21 = weights_store[48];
			wt_h_16 = weights_store[49];
			wt_h_15 = weights_store[50];
			wt_h_14 = weights_store[51];
			wt_h_13 = weights_store[52];
			wt_h_12 = weights_store[53];
			wt_h_11 = weights_store[54];
			//these weights will not be updated anymore since they're trained 
		end
	//1st hidden layer neuron
	spiking_neuron H1(
		.clock(clock),.reset(reset),
		.in1(inp_1),.in2(inp_2),.in3(inp_3),
		.in4(inp_4),.in5(inp_5),.in6(inp_6),
		.wt1(wt_h_11),.wt2(wt_h_12),.wt3(wt_h_13),
		.wt4(wt_h_14),.wt5(wt_h_15),.wt6(wt_h_16),
		.out(h_1)
	);
	//2nd hidden layer neuron
	spiking_neuron H2(
		.clock(clock),.reset(reset),
		.in1(inp_1),.in2(inp_2),.in3(inp_3),
		.in4(inp_4),.in5(inp_5),.in6(inp_6),
		.wt1(wt_h_21),.wt2(wt_h_22),.wt3(wt_h_23),
		.wt4(wt_h_24),.wt5(wt_h_25),.wt6(wt_h_26),
		.out(h_2)
	);
	//3rd hidden layer neuron
	spiking_neuron H3(
		.clock(clock),.reset(reset),
		.in1(inp_1),.in2(inp_2),.in3(inp_3),
		.in4(inp_4),.in5(inp_5),.in6(inp_6),
		.wt1(wt_h_31),.wt2(wt_h_32),.wt3(wt_h_33),
		.wt4(wt_h_34),.wt5(wt_h_35),.wt6(wt_h_36),
		.out(h_3)
	);
	//4th hidden layer neuron
	spiking_neuron H4(
		.clock(clock),.reset(reset),
		.in1(inp_1),.in2(inp_2),.in3(inp_3),
		.in4(inp_4),.in5(inp_5),.in6(inp_6),
		.wt1(wt_h_41),.wt2(wt_h_42),.wt3(wt_h_43),
		.wt4(wt_h_44),.wt5(wt_h_45),.wt6(wt_h_46),
		.out(h_4)
	);
	//5th hidden layer neuron
	spiking_neuron H5(
		.clock(clock),.reset(reset),
		.in1(inp_1),.in2(inp_2),.in3(inp_3),
		.in4(inp_4),.in5(inp_5),.in6(inp_6),
		.wt1(wt_h_51),.wt2(wt_h_52),.wt3(wt_h_53),
		.wt4(wt_h_54),.wt5(wt_h_55),.wt6(wt_h_56),
		.out(h_5)
	);
	//6th hidden layer neuron
	spiking_neuron H6(
		.clock(clock),.reset(reset),
		.in1(inp_1),.in2(inp_2),.in3(inp_3),
		.in4(inp_4),.in5(inp_5),.in6(inp_6),
		.wt1(wt_h_61),.wt2(wt_h_62),.wt3(wt_h_63),
		.wt4(wt_h_64),.wt5(wt_h_65),.wt6(wt_h_66),
		.out(h_6)
	);
	//1st output layer neuron
	spiking_neuron O1(
		.clock(clock),.reset(reset),
		.in1(h_1),.in2(h_2),.in3(h_3),
		.in4(h_4),.in5(h_5),.in6(h_6),
		.wt1(wt_o_11),.wt2(wt_o_12),.wt3(wt_o_13),
		.wt4(wt_o_14),.wt5(wt_o_15),.wt6(wt_o_16),
		.out(act_outp_1)
	);
	//2nd output layer neuron
	spiking_neuron O2(
		.clock(clock),.reset(reset),
		.in1(h_1),.in2(h_2),.in3(h_3),
		.in4(h_4),.in5(h_5),.in6(h_6),
		.wt1(wt_o_21),.wt2(wt_o_22),.wt3(wt_o_23),
		.wt4(wt_o_24),.wt5(wt_o_25),.wt6(wt_o_26),
		.out(act_outp_2)
	);
	//3rd output layer neuron
	spiking_neuron O3(
		.clock(clock),.reset(reset),
		.in1(h_1),.in2(h_2),.in3(h_3),
		.in4(h_4),.in5(h_5),.in6(h_6),
		.wt1(wt_o_31),.wt2(wt_o_32),.wt3(wt_o_33),
		.wt4(wt_o_34),.wt5(wt_o_35),.wt6(wt_o_36),
		.out(act_outp_3)
	);
	always@(posedge clock)//continuously running block
		begin
			//decoder logic to deduce output from the actual output to improve further iterations
			casex({act_outp_1,act_outp_2,act_outp_3})//this section is to decode the output 
				3'b1xx: {fin_outp_1,fin_outp_2,fin_outp_3} = 3'b100;//100,101,110,111 are all 100
				3'b01x: {fin_outp_1,fin_outp_2,fin_outp_3} = 3'b010;//010,011 are all 010 
				3'b001: {fin_outp_1,fin_outp_2,fin_outp_3} = 3'b001;//001 are all 001
				default: {fin_outp_1,fin_outp_2,fin_outp_3} = 3'b000;//by default this is 000
			endcase
		end
	assign {outp_1,outp_2,outp_3} = {fin_outp_1,fin_outp_2,fin_outp_3};//converting reg to wire
endmodule
//spiking neuron working module
module spiking_neuron(
	input clock,//clock decides the movement
	input reset,//asynchronous reset
	//this is 6-input neuron
	input in1,
	input in2,
	input in3,
	input in4,
	input in5,
	input in6,
	//6 different weights assigned
	input signed [11:0] wt1,
	input signed [11:0] wt2,
	input signed [11:0] wt3,
	input signed [11:0] wt4,
	input signed [11:0] wt5,
	input signed [11:0] wt6,
	//this is 1-output neuron
	output out
);
	//neuron potential values are all 10-bit signed integers
	reg signed [19:0] V_rest = + 20'sd10;//rest potential
	reg signed [19:0] V_thre = + 20'sd3700;//threshold potential
	reg signed [19:0] V_leak = - 20'sd3;//leak potential
	reg signed [19:0] wt_sum;//weighted sum variable
	//membrane potential will be updated each clock cycle and then output will be generated
	reg signed [19:0] V_memb_now;//membrane potential governs the spiking neuron
	reg signed [19:0] V_memb_prev = + 20'sd10;//1st prev. membrane potential is equal to V_rest
	reg out_final = 1'b0;//for assigning inside always block
	always@(posedge clock or posedge reset)//continuously running block
		begin
			if(reset == 1'b1)//reset condition
				begin
					V_memb_now = 10'd0;//resetting the present membrane potential
					V_memb_prev = V_rest;//resetting the prev. membrane potential
					out_final = 1'b0;//output will not be triggered
				end
			else
				begin
					//weighted sum calculation; 6-inputs and 6-weights
					wt_sum = (in1*wt1)+(in2*wt2)+(in3*wt3)+(in4*wt4)+(in5*wt5)+(in6*wt6);
					//present membrane potential calculation; depends on prev. membrane potential
					V_memb_now = V_memb_prev + wt_sum + V_leak;
					//applying the ReLU function in this way
					V_memb_now = (V_memb_now >= V_rest) ? V_memb_now : V_rest;
					if(V_memb_now >= V_thre)//output condition
						begin
							//according to spiking neuron condition
							out_final = 1'b1;//output will be triggered only in this case
							V_memb_now = 10'd0;//resetting the present membrane potential
							V_memb_prev = V_rest;//resetting the prev. membrane potential
						end
					else
						begin
							//according to spiking neuron condition
							out_final = 1'b0;//output will not be triggered							
							V_memb_prev = V_memb_now;//updating prev. membrane potential as present
							V_memb_now = 10'd0;//resetting the present membrane potential
						end
				end
		end
	assign out = out_final;//converting reg to wire
endmodule
