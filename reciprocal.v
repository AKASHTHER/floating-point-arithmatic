`timescale 1ns / 1ps
module reciprocal(numerator,divisor,reciprocal1);
localparam size = 16;
localparam constant1 = 16'b0100000110100101;//48/17;
localparam constant2 = 32'b1011111110000111;//-32/17;
input [15:0] numerator;
input [15:0] divisor;
output [15:0] reciprocal1;
wire [15:0] D;
wire [15:0] numerator1;
wire [15:0] divisor1;
wire sign;
wire [15:0] x0;
wire [15:0] xi1;
wire [15:0] xi2;
wire [15:0] xi3;
wire [15:0] xi4;
wire [15:0] xi5;
wire [15:0] xi6;
wire [15:0] x0add;

assign sign = numerator[15] ^ divisor[15];
assign numerator1[15] = 1'b0;
assign divisor1[15] = 1'b0;
assign numerator1 [14:10]= numerator[14:10]-1-divisor[14:10]+15;
assign divisor1[14:10]=5'b01110;//14 biased
assign numerator1[9:0]=numerator[9:0];
assign divisor1[9:0]=divisor[9:0];
assign D=divisor1; 

// calculate Xo through 48/17-32/17 *divisor1              
flop_mul mulD(.flp_a(divisor1),.flp_b(constant2),.sign(x0[15]),.exponent(x0[14:10]),.prod(x0[9:0]));
     
flop_add additionX0(.A_FP(constant1),.B_FP(x0),.out(x0add)); 

// calculate Xn from first 4 terms of  X = X * (2-D*X)              
XnCalculation firstterm(.D(D),.X(x0add),.Xn(xi1));

XnCalculation secondterm(.D(D),.X(xi1),.Xn(xi2));

XnCalculation thirdterm(.D(D),.X(xi2),.Xn(xi3)); 
  
XnCalculation forthterm(.D(D),.X(xi3),.Xn(xi4));  

//  calculate multiply of Numerator with Xn value                                                        
flop_mul mulNumeratorDivisor(.flp_a(xi4),.flp_b(numerator1),.sign(reciprocal1[15]),.exponent(reciprocal1[14:10]),.prod(reciprocal1[9:0])); 
 
endmodule
