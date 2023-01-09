`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//By: Basant Loay Abdalla
//////////////////////////////////////////////////////////////////////////////////
// THIS MODULE FOR CALCULATING Xn value 
// as X = X * (2-D*X)
/////////////////////////////////////////////////////////////////////////////////
module XnCalculation(D,X,Xn);
localparam [15:0] two= 16'b0100000000000000; // value of 2
input[15:0]D;
input[15:0]X;
output[15:0]Xn;
wire [15:0] term1;
wire [15:0] term2;
wire [15:0] term3;
wire [15:0] x1;
assign x1=X;
flop_mul mul1(.flp_a(D),.flp_b(X),.sign(term1[15]),.exponent(term1[14:10]),.prod(term1[9:0]));
         
assign term2[15]= !term1[15];
assign term2[14:0]= term1[14:0];

flop_add addition3(.A_FP(two),.B_FP(term2),.out(term3));
flop_mul mul2(.flp_a(x1),.flp_b(term3),.sign(Xn[15]),.exponent(Xn[14:10]),.prod(Xn[9:0]));                
endmodule
