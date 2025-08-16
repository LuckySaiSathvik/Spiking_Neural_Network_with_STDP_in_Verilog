`timescale 1ps / 1ps//time unit and precision of 1 picosecond each
//final training neural network module consisting of 3 layers
//input layer, hidden layer and output layer
module overall_neural_network_training(
	//clock and reset
	input clock, 
	input reset,
	//6 inputs to the network
	input inp_1,
	input inp_2,
	input inp_3,
	input inp_4,
	input inp_5,
	input inp_6,
	//3 decoded outputs to the network
	output outp_1,
	output outp_2,
	output outp_3
);
	//6 hidden layer input-outputs
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
	//weight and change-of-weight variables; total = 54 + 54 = 108
	//input layer to hidden layer weights; total = 36; assigning 12-bit signed initial weights
	//hidden layer to output layer weights; total = 18; assigning 12-bit signed initial weights
	reg signed [11:0] wt_h_11 = - 12'sd23;
	reg signed [11:0] wt_h_12 = + 12'sd14;
	reg signed [11:0] wt_h_13 = - 12'sd36;
	reg signed [11:0] wt_h_14 = + 12'sd23;
	reg signed [11:0] wt_h_15 = - 12'sd10;
	reg signed [11:0] wt_h_16 = + 12'sd25;
	reg signed [11:0] wt_h_21 = + 12'sd32;
	reg signed [11:0] wt_h_22 = - 12'sd15;
	reg signed [11:0] wt_h_23 = + 12'sd18;
	reg signed [11:0] wt_h_24 = - 12'sd37;
	reg signed [11:0] wt_h_25 = - 12'sd27;
	reg signed [11:0] wt_h_26 = + 12'sd12;
	reg signed [11:0] wt_h_31 = - 12'sd22;
	reg signed [11:0] wt_h_32 = + 12'sd21;
	reg signed [11:0] wt_h_33 = - 12'sd21;
	reg signed [11:0] wt_h_34 = + 12'sd16;
	reg signed [11:0] wt_h_35 = - 12'sd13;
	reg signed [11:0] wt_h_36 = + 12'sd8;
	reg signed [11:0] wt_h_41 = + 12'sd19;
	reg signed [11:0] wt_h_42 = - 12'sd25;
	reg signed [11:0] wt_h_43 = + 12'sd31;
	reg signed [11:0] wt_h_44 = + 12'sd33;
	reg signed [11:0] wt_h_45 = - 12'sd15;
	reg signed [11:0] wt_h_46 = + 12'sd29;
	reg signed [11:0] wt_h_51 = - 12'sd5;
	reg signed [11:0] wt_h_52 = + 12'sd21;
	reg signed [11:0] wt_h_53 = - 12'sd19;
	reg signed [11:0] wt_h_54 = + 12'sd3;
	reg signed [11:0] wt_h_55 = - 12'sd15;
	reg signed [11:0] wt_h_56 = + 12'sd19;
	reg signed [11:0] wt_h_61 = - 12'sd31;
	reg signed [11:0] wt_h_62 = + 12'sd28;
	reg signed [11:0] wt_h_63 = - 12'sd12;
	reg signed [11:0] wt_h_64 = + 12'sd37;
	reg signed [11:0] wt_h_65 = - 12'sd22;
	reg signed [11:0] wt_h_66 = + 12'sd5;
	reg signed [11:0] wt_o_11 = - 12'sd11;
	reg signed [11:0] wt_o_12 = - 12'sd30;
	reg signed [11:0] wt_o_13 = + 12'sd27;
	reg signed [11:0] wt_o_14 = + 12'sd20;
	reg signed [11:0] wt_o_15 = - 12'sd19;
	reg signed [11:0] wt_o_16 = + 12'sd2;
	reg signed [11:0] wt_o_21 = - 12'sd28;
	reg signed [11:0] wt_o_22 = + 12'sd34;
	reg signed [11:0] wt_o_23 = + 12'sd6;
	reg signed [11:0] wt_o_24 = - 12'sd30;
	reg signed [11:0] wt_o_25 = - 12'sd3;
	reg signed [11:0] wt_o_26 = + 12'sd16;
	reg signed [11:0] wt_o_31 = - 12'sd30;
	reg signed [11:0] wt_o_32 = + 12'sd25;
	reg signed [11:0] wt_o_33 = - 12'sd29;
	reg signed [11:0] wt_o_34 = + 12'sd35;
	reg signed [11:0] wt_o_35 = - 12'sd10;
	reg signed [11:0] wt_o_36 = + 12'sd5;
	//input layer to hidden layer weight change variables; total = 36
	//hidden layer to output layer weight change variables; total = 18
	wire signed [11:0] dwt_h_11;
	wire signed [11:0] dwt_h_12;
	wire signed [11:0] dwt_h_13;
	wire signed [11:0] dwt_h_14;
	wire signed [11:0] dwt_h_15;
	wire signed [11:0] dwt_h_16;
	wire signed [11:0] dwt_h_21;
	wire signed [11:0] dwt_h_22;
	wire signed [11:0] dwt_h_23;
	wire signed [11:0] dwt_h_24;
	wire signed [11:0] dwt_h_25;
	wire signed [11:0] dwt_h_26;
	wire signed [11:0] dwt_h_31;
	wire signed [11:0] dwt_h_32;
	wire signed [11:0] dwt_h_33;
	wire signed [11:0] dwt_h_34;
	wire signed [11:0] dwt_h_35;
	wire signed [11:0] dwt_h_36;
	wire signed [11:0] dwt_h_41;
	wire signed [11:0] dwt_h_42;
	wire signed [11:0] dwt_h_43;
	wire signed [11:0] dwt_h_44;
	wire signed [11:0] dwt_h_45;
	wire signed [11:0] dwt_h_46;
	wire signed [11:0] dwt_h_51;
	wire signed [11:0] dwt_h_52;
	wire signed [11:0] dwt_h_53;
	wire signed [11:0] dwt_h_54;
	wire signed [11:0] dwt_h_55;
	wire signed [11:0] dwt_h_56;
	wire signed [11:0] dwt_h_61;
	wire signed [11:0] dwt_h_62;
	wire signed [11:0] dwt_h_63;
	wire signed [11:0] dwt_h_64;
	wire signed [11:0] dwt_h_65;
	wire signed [11:0] dwt_h_66;
	wire signed [11:0] dwt_o_11;
	wire signed [11:0] dwt_o_12;
	wire signed [11:0] dwt_o_13;
	wire signed [11:0] dwt_o_14;
	wire signed [11:0] dwt_o_15;
	wire signed [11:0] dwt_o_16;
	wire signed [11:0] dwt_o_21;
	wire signed [11:0] dwt_o_22;
	wire signed [11:0] dwt_o_23;
	wire signed [11:0] dwt_o_24;
	wire signed [11:0] dwt_o_25;
	wire signed [11:0] dwt_o_26;
	wire signed [11:0] dwt_o_31;
	wire signed [11:0] dwt_o_32;
	wire signed [11:0] dwt_o_33;
	wire signed [11:0] dwt_o_34;
	wire signed [11:0] dwt_o_35;
	wire signed [11:0] dwt_o_36;
	//1st hidden layer neuron
	spiking_neuron H1(
		.clock(clock),.reset(reset),
		.in1(inp_1),.in2(inp_2),.in3(inp_3),
		.in4(inp_4),.in5(inp_5),.in6(inp_6),
		.wt1(wt_h_11),.wt2(wt_h_12),.wt3(wt_h_13),
		.wt4(wt_h_14),.wt5(wt_h_15),.wt6(wt_h_16),
		.out(h_1)
	);
	//learning for wt_h_11
	stdp_learning LH11(
		.clock(clock),.reset(reset),
		.in_neuron(inp_1),.out_neuron(h_1),
		.delta_weight(dwt_h_11)
	);
	//learning for wt_h_12
	stdp_learning LH12(
		.clock(clock),.reset(reset),
		.in_neuron(inp_2),.out_neuron(h_1),
		.delta_weight(dwt_h_12)
	);
	//learning for wt_h_13
	stdp_learning LH13(
		.clock(clock),.reset(reset),
		.in_neuron(inp_3),.out_neuron(h_1),
		.delta_weight(dwt_h_13)
	);
	//learning for wt_h_14
	stdp_learning LH14(
		.clock(clock),.reset(reset),
		.in_neuron(inp_4),.out_neuron(h_1),
		.delta_weight(dwt_h_14)
	);
	//learning for wt_h_15
	stdp_learning LH15(
		.clock(clock),.reset(reset),
		.in_neuron(inp_5),.out_neuron(h_1),
		.delta_weight(dwt_h_15)
	);
	//learning for wt_h_16
	stdp_learning LH16(
		.clock(clock),.reset(reset),
		.in_neuron(inp_6),.out_neuron(h_1),
		.delta_weight(dwt_h_16)
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
	//learning for wt_h_21
	stdp_learning LH21(
		.clock(clock),.reset(reset),
		.in_neuron(inp_1),.out_neuron(h_2),
		.delta_weight(dwt_h_21)
	);
	//learning for wt_h_22
	stdp_learning LH22(
		.clock(clock),.reset(reset),
		.in_neuron(inp_2),.out_neuron(h_2),
		.delta_weight(dwt_h_22)
	);
	//learning for wt_h_23
	stdp_learning LH23(
		.clock(clock),.reset(reset),
		.in_neuron(inp_3),.out_neuron(h_2),
		.delta_weight(dwt_h_23)
	);
	//learning for wt_h_24
	stdp_learning LH24(
		.clock(clock),.reset(reset),
		.in_neuron(inp_4),.out_neuron(h_2),
		.delta_weight(dwt_h_24)
	);
	//learning for wt_h_25
	stdp_learning LH25(
		.clock(clock),.reset(reset),
		.in_neuron(inp_5),.out_neuron(h_2),
		.delta_weight(dwt_h_25)
	);
	//learning for wt_h_26
	stdp_learning LH26(
		.clock(clock),.reset(reset),
		.in_neuron(inp_6),.out_neuron(h_2),
		.delta_weight(dwt_h_26)
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
	//learning for wt_h_31
	stdp_learning LH31(
		.clock(clock),.reset(reset),
		.in_neuron(inp_1),.out_neuron(h_3),
		.delta_weight(dwt_h_31)
	);
	//learning for wt_h_32
	stdp_learning LH32(
		.clock(clock),.reset(reset),
		.in_neuron(inp_2),.out_neuron(h_3),
		.delta_weight(dwt_h_32)
	);
	//learning for wt_h_33
	stdp_learning LH33(
		.clock(clock),.reset(reset),
		.in_neuron(inp_3),.out_neuron(h_3),
		.delta_weight(dwt_h_33)
	);
	//learning for wt_h_34
	stdp_learning LH34(
		.clock(clock),.reset(reset),
		.in_neuron(inp_4),.out_neuron(h_3),
		.delta_weight(dwt_h_34)
	);
	//learning for wt_h_35
	stdp_learning LH35(
		.clock(clock),.reset(reset),
		.in_neuron(inp_5),.out_neuron(h_3),
		.delta_weight(dwt_h_35)
	);
	//learning for wt_h_36
	stdp_learning LH36(
		.clock(clock),.reset(reset),
		.in_neuron(inp_6),.out_neuron(h_3),
		.delta_weight(dwt_h_36)
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
	//learning for wt_h_41
	stdp_learning LH41(
		.clock(clock),.reset(reset),
		.in_neuron(inp_1),.out_neuron(h_4),
		.delta_weight(dwt_h_41)
	);
	//learning for wt_h_42
	stdp_learning LH42(
		.clock(clock),.reset(reset),
		.in_neuron(inp_2),.out_neuron(h_4),
		.delta_weight(dwt_h_42)
	);
	//learning for wt_h_43
	stdp_learning LH43(
		.clock(clock),.reset(reset),
		.in_neuron(inp_3),.out_neuron(h_4),
		.delta_weight(dwt_h_43)
	);
	//learning for wt_h_44
	stdp_learning LH44(
		.clock(clock),.reset(reset),
		.in_neuron(inp_4),.out_neuron(h_4),
		.delta_weight(dwt_h_44)
	);
	//learning for wt_h_45
	stdp_learning LH45(
		.clock(clock),.reset(reset),
		.in_neuron(inp_5),.out_neuron(h_4),
		.delta_weight(dwt_h_45)
	);
	//learning for wt_h_46
	stdp_learning LH46(
		.clock(clock),.reset(reset),
		.in_neuron(inp_6),.out_neuron(h_4),
		.delta_weight(dwt_h_46)
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
	//learning for wt_h_51
	stdp_learning LH51(
		.clock(clock),.reset(reset),
		.in_neuron(inp_1),.out_neuron(h_5),
		.delta_weight(dwt_h_51)
	);
	//learning for wt_h_52
	stdp_learning LH52(
		.clock(clock),.reset(reset),
		.in_neuron(inp_2),.out_neuron(h_5),
		.delta_weight(dwt_h_52)
	);
	//learning for wt_h_53
	stdp_learning LH53(
		.clock(clock),.reset(reset),
		.in_neuron(inp_3),.out_neuron(h_5),
		.delta_weight(dwt_h_53)
	);
	//learning for wt_h_54
	stdp_learning LH54(
		.clock(clock),.reset(reset),
		.in_neuron(inp_4),.out_neuron(h_5),
		.delta_weight(dwt_h_54)
	);
	//learning for wt_h_55
	stdp_learning LH55(
		.clock(clock),.reset(reset),
		.in_neuron(inp_5),.out_neuron(h_5),
		.delta_weight(dwt_h_55)
	);
	//learning for wt_h_56
	stdp_learning LH56(
		.clock(clock),.reset(reset),
		.in_neuron(inp_6),.out_neuron(h_5),
		.delta_weight(dwt_h_56)
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
	//learning for wt_h_61
	stdp_learning LH61(
		.clock(clock),.reset(reset),
		.in_neuron(inp_1),.out_neuron(h_6),
		.delta_weight(dwt_h_61)
	);
	//learning for wt_h_62
	stdp_learning LH62(
		.clock(clock),.reset(reset),
		.in_neuron(inp_2),.out_neuron(h_6),
		.delta_weight(dwt_h_62)
	);
	//learning for wt_h_63
	stdp_learning LH63(
		.clock(clock),.reset(reset),
		.in_neuron(inp_3),.out_neuron(h_6),
		.delta_weight(dwt_h_63)
	);
	//learning for wt_h_64
	stdp_learning LH64(
		.clock(clock),.reset(reset),
		.in_neuron(inp_4),.out_neuron(h_6),
		.delta_weight(dwt_h_64)
	);
	//learning for wt_h_65
	stdp_learning LH65(
		.clock(clock),.reset(reset),
		.in_neuron(inp_5),.out_neuron(h_6),
		.delta_weight(dwt_h_65)
	);
	//learning for wt_h_66
	stdp_learning LH66(
		.clock(clock),.reset(reset),
		.in_neuron(inp_6),.out_neuron(h_6),
		.delta_weight(dwt_h_66)
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
	//learning for wt_o_11
	stdp_learning LO11(
		.clock(clock),.reset(reset),
		.in_neuron(h_1),.out_neuron(act_outp_1),
		.delta_weight(dwt_o_11)
	);
	//learning for wt_o_12
	stdp_learning LO12(
		.clock(clock),.reset(reset),
		.in_neuron(h_2),.out_neuron(act_outp_1),
		.delta_weight(dwt_o_12)
	);
	//learning for wt_o_13
	stdp_learning LO13(
		.clock(clock),.reset(reset),
		.in_neuron(h_3),.out_neuron(act_outp_1),
		.delta_weight(dwt_o_13)
	);
	//learning for wt_o_14
	stdp_learning LO14(
		.clock(clock),.reset(reset),
		.in_neuron(h_4),.out_neuron(act_outp_1),
		.delta_weight(dwt_o_14)
	);
	//learning for wt_o_15
	stdp_learning LO15(
		.clock(clock),.reset(reset),
		.in_neuron(h_5),.out_neuron(act_outp_1),
		.delta_weight(dwt_o_15)
	);
	//learning for wt_o_16
	stdp_learning LO16(
		.clock(clock),.reset(reset),
		.in_neuron(h_6),.out_neuron(act_outp_1),
		.delta_weight(dwt_o_16)
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
	//learning for wt_o_21
	stdp_learning LO21(
		.clock(clock),.reset(reset),
		.in_neuron(h_1),.out_neuron(act_outp_2),
		.delta_weight(dwt_o_21)
	);
	//learning for wt_o_22
	stdp_learning LO22(
		.clock(clock),.reset(reset),
		.in_neuron(h_2),.out_neuron(act_outp_2),
		.delta_weight(dwt_o_22)
	);
	//learning for wt_o_23
	stdp_learning LO23(
		.clock(clock),.reset(reset),
		.in_neuron(h_3),.out_neuron(act_outp_2),
		.delta_weight(dwt_o_23)
	);
	//learning for wt_o_24
	stdp_learning LO24(
		.clock(clock),.reset(reset),
		.in_neuron(h_4),.out_neuron(act_outp_2),
		.delta_weight(dwt_o_24)
	);
	//learning for wt_o_25
	stdp_learning LO25(
		.clock(clock),.reset(reset),
		.in_neuron(h_5),.out_neuron(act_outp_2),
		.delta_weight(dwt_o_25)
	);
	//learning for wt_o_26
	stdp_learning LO26(
		.clock(clock),.reset(reset),
		.in_neuron(h_6),.out_neuron(act_outp_2),
		.delta_weight(dwt_o_26)
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
	//learning for wt_o_31
	stdp_learning LO31(
		.clock(clock),.reset(reset),
		.in_neuron(h_1),.out_neuron(act_outp_3),
		.delta_weight(dwt_o_31)
	);
	//learning for wt_o_32
	stdp_learning LO32(
		.clock(clock),.reset(reset),
		.in_neuron(h_2),.out_neuron(act_outp_3),
		.delta_weight(dwt_o_32)
	);
	//learning for wt_o_33
	stdp_learning LO33(
		.clock(clock),.reset(reset),
		.in_neuron(h_3),.out_neuron(act_outp_3),
		.delta_weight(dwt_o_33)
	);
	//learning for wt_o_34
	stdp_learning LO34(
		.clock(clock),.reset(reset),
		.in_neuron(h_4),.out_neuron(act_outp_3),
		.delta_weight(dwt_o_34)
	);
	//learning for wt_o_35
	stdp_learning LO35(
		.clock(clock),.reset(reset),
		.in_neuron(h_5),.out_neuron(act_outp_3),
		.delta_weight(dwt_o_35)
	);
	//learning for wt_o_36
	stdp_learning LO36(
		.clock(clock),.reset(reset),
		.in_neuron(h_6),.out_neuron(act_outp_3),
		.delta_weight(dwt_o_36)
	);
	//decoder logic to deduce output from the actual output to improve further iterations
	always@(posedge clock)//decode the outputs in positive clock edge
		begin
			casex({act_outp_1,act_outp_2,act_outp_3})//this section is to decode the output 
				3'b1xx: {fin_outp_1,fin_outp_2,fin_outp_3} = 3'b100;//100,101,110,111 are all 100
				3'b01x: {fin_outp_1,fin_outp_2,fin_outp_3} = 3'b010;//010,011 are all 010 
				3'b001: {fin_outp_1,fin_outp_2,fin_outp_3} = 3'b001;//001,000 are all 001
				default: {fin_outp_1,fin_outp_2,fin_outp_3} = 3'b000;//by default this is 000
			endcase
		end
	//update in negative edge so there's change calculated in positive edge
	always@(negedge clock)//continuously running block for updating weights
		begin
			//hidden layer weights update
			//output layer weights update
			wt_h_11 = (wt_h_11 + dwt_h_11);
			wt_h_12 = (wt_h_12 + dwt_h_12);
			wt_h_13 = (wt_h_13 + dwt_h_13);
			wt_h_14 = (wt_h_14 + dwt_h_14);
			wt_h_15 = (wt_h_15 + dwt_h_15);
			wt_h_16 = (wt_h_16 + dwt_h_16);
			wt_h_21 = (wt_h_21 + dwt_h_21);
			wt_h_22 = (wt_h_22 + dwt_h_22);
			wt_h_23 = (wt_h_23 + dwt_h_23);
			wt_h_24 = (wt_h_24 + dwt_h_24);
			wt_h_25 = (wt_h_25 + dwt_h_25);
			wt_h_26 = (wt_h_26 + dwt_h_26);
			wt_h_31 = (wt_h_31 + dwt_h_31);
			wt_h_32 = (wt_h_32 + dwt_h_32);
			wt_h_33 = (wt_h_33 + dwt_h_33);
			wt_h_34 = (wt_h_34 + dwt_h_34);
			wt_h_35 = (wt_h_35 + dwt_h_35);
			wt_h_36 = (wt_h_36 + dwt_h_36);
			wt_h_41 = (wt_h_41 + dwt_h_41);
			wt_h_42 = (wt_h_42 + dwt_h_42);
			wt_h_43 = (wt_h_43 + dwt_h_43);
			wt_h_44 = (wt_h_44 + dwt_h_44);
			wt_h_45 = (wt_h_45 + dwt_h_45);
			wt_h_46 = (wt_h_46 + dwt_h_46);
			wt_h_51 = (wt_h_51 + dwt_h_51);
			wt_h_52 = (wt_h_52 + dwt_h_52);
			wt_h_53 = (wt_h_53 + dwt_h_53);
			wt_h_54 = (wt_h_54 + dwt_h_54);
			wt_h_55 = (wt_h_55 + dwt_h_55);
			wt_h_56 = (wt_h_56 + dwt_h_56);
			wt_h_61 = (wt_h_61 + dwt_h_61);
			wt_h_62 = (wt_h_62 + dwt_h_62);
			wt_h_63 = (wt_h_63 + dwt_h_63);
			wt_h_64 = (wt_h_64 + dwt_h_64);
			wt_h_65 = (wt_h_65 + dwt_h_65);
			wt_h_66 = (wt_h_66 + dwt_h_66);
			wt_o_11 = (wt_o_11 + dwt_o_11);
			wt_o_12 = (wt_o_12 + dwt_o_12);
			wt_o_13 = (wt_o_13 + dwt_o_13);
			wt_o_14 = (wt_o_14 + dwt_o_14);
			wt_o_15 = (wt_o_15 + dwt_o_15);
			wt_o_16 = (wt_o_16 + dwt_o_16);
			wt_o_21 = (wt_o_21 + dwt_o_21);
			wt_o_22 = (wt_o_22 + dwt_o_22);
			wt_o_23 = (wt_o_23 + dwt_o_23);
			wt_o_24 = (wt_o_24 + dwt_o_24);
			wt_o_25 = (wt_o_25 + dwt_o_25);
			wt_o_26 = (wt_o_26 + dwt_o_26);
			wt_o_31 = (wt_o_31 + dwt_o_31);
			wt_o_32 = (wt_o_32 + dwt_o_32);
			wt_o_33 = (wt_o_33 + dwt_o_33);
			wt_o_34 = (wt_o_34 + dwt_o_34);
			wt_o_35 = (wt_o_35 + dwt_o_35);
			wt_o_36 = (wt_o_36 + dwt_o_36);
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
					V_memb_now = 20'd0;//resetting the present membrane potential
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
							V_memb_now = 20'd0;//resetting the present membrane potential
							V_memb_prev = V_rest;//resetting the prev. membrane potential
						end
					else
						begin
							//according to spiking neuron condition
							out_final = 1'b0;//output will not be triggered							
							V_memb_prev = V_memb_now;//updating prev. membrane potential as present
							V_memb_now = 20'd0;//resetting the present membrane potential
						end
				end
		end
	assign out = out_final;//converting reg to wire
endmodule
//stdp learning algorithm working module for hidden layer
module stdp_learning(
	input clock,//clock decides the movement
	input reset,//asynchronous reset
	input in_neuron,//neuron input for that corresponding weight
	input out_neuron,//neuron output for that corresponding weight
	output signed [11:0] delta_weight
);
	reg signed [11:0] delta_weight_reg;//to assign inside always block
	reg signed [11:0] A_pluss = + 12'sd1;//long term potentiation value (positive weight update)
	reg signed [11:0] A_minus = - 12'sd2;//long term depression value (negative weight update)
	reg signed [11:0] A_maxi = + 12'sd3;//max weight update at once; if both synapses exist
	reg [11:0] thres_pluss = 12'd3;//potentiation threshold for positive weight update
	reg [11:0] thres_minus = 12'd2;//depression threshold for negative weight update
	//considering t_pluss = + 12'sd2 and t_minus = - 12'sd2 so that right shifts can be used
	reg [11:0] count_pluss_now;//present pre synaptic counter for positive weight update
	reg [11:0] count_minus_now;//present post synaptic counter for negative weight update
	reg [11:0] count_pluss_prev = 12'd0;//previous pre synaptic counter for positive weight update
	reg [11:0] count_minus_prev = 12'd0;//previous post synaptic counter for negative weight update
	always@(posedge clock or posedge reset)//continuously running block
		begin
			if(reset == 1'b1)//reset condition
				begin
					delta_weight_reg = 12'd0;//no weight updation
					count_pluss_now = count_pluss_prev;//retain present pre synaptic counter
					count_minus_now = count_minus_prev;//retain present post synaptic counter
					count_pluss_prev = 12'd0;//reset the previous pre synaptic counter
					count_minus_prev = 12'd0;//reset the previous post synaptic counter
				end
			else
				begin
					if(in_neuron == 1'b0 && out_neuron == 1'b0)//no synapses exist
						begin
							delta_weight_reg = 12'd0;//no weight updation
							//increment present pre synaptic counter
							//increment present postsynaptic counter
							count_pluss_now = count_pluss_prev + 12'd1;
							count_minus_now = count_minus_prev + 12'd1;
							count_pluss_prev = count_pluss_now;//save pre synaptic timestamp
							count_minus_prev = count_minus_now;//save postsynaptic timestamp
						end
					else if(in_neuron == 1'b0 && out_neuron == 1'b1)//presynaptic condition
						begin
							//increment present pre synaptic counter
							count_pluss_now = count_pluss_prev + 12'd1;
							if(count_pluss_now <= thres_pluss)//long term potentiation condition
								begin
									//positive weight update
									delta_weight_reg = A_pluss * (12'd1 - (count_pluss_now >>> 1));
									count_pluss_prev = count_pluss_now;//save pre synaptic timestamp
									count_minus_prev = count_minus_now;//save postsynaptic timestamp
								end
							else//short term potentiation condition
								begin
									delta_weight_reg = 12'd0;//no weight updation
									count_pluss_prev = count_pluss_now;//save pre synaptic timestamp
									count_minus_prev = count_minus_now;//save postsynaptic timestamp
								end
						end
					else if(in_neuron == 1'b1 && out_neuron == 1'b0)//postsynaptic condition
						begin
							//incerement present postsynaptic counter
							count_minus_now = count_minus_prev + 12'd1;
							if(count_minus_now <= thres_minus)//long term depression condition
								begin
									//negative weight update
									delta_weight_reg = A_minus * (12'd1 + (count_minus_now >>> 1));
									count_pluss_prev = count_pluss_now;//save pre synaptic timestamp
									count_minus_prev = count_minus_now;//save postsynaptic timestamp
								end
							else//short term depression condition
								begin
									delta_weight_reg = 12'd0;//no weight updation
									count_pluss_prev = count_pluss_now;//save pre synaptic timestamp
									count_minus_prev = count_minus_now;//save postsynaptic timestamp
								end
						end
					else if(in_neuron == 1'b1 && out_neuron == 1'b1)//both synapses exist
						begin
							delta_weight_reg = A_maxi;//maximum weight updation
							count_pluss_now = count_pluss_prev;//retain present pre synaptic counter
							count_minus_now = count_minus_prev;//retain present postsynaptic counter
							count_pluss_prev = 12'd0;//reset the previous pre synaptic counter
							count_minus_prev = 12'd0;//reset the previous post synaptic counter
						end
					else//if any unknowns exist
						begin
							delta_weight_reg = 12'd0;//no weight updation
							count_pluss_now = count_pluss_prev;//retain present pre synaptic counter
							count_minus_now = count_minus_prev;//retain present postsynaptic counter
							count_pluss_prev = 12'd0;//reset the previous pre synaptic counter
							count_minus_prev = 12'd0;//reset the previous post synaptic counter
						end
				end
		end
	assign delta_weight = delta_weight_reg;//converting reg into wire
endmodule
