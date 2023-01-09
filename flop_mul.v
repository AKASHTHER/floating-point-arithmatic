`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2022 10:56:38 AM
// Design Name: 
// Module Name: flop_mul
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


// 16 bit floating point multiplier

module flop_mul(flp_a, flp_b, sign, exponent, prod);
input [15:0] flp_a ;
input [15:0] flp_b ;
output reg sign ;
//output [7:0] exponent  ;
output [9:0] prod  ;
reg [21:0] x;
output reg [4:0] exponent;
assign prod = x[20:11];
always@ * 
    begin
        if (flp_a==0||flp_b==0) 
            begin 
               // exp_unbiased= flp_a[1:8]+flp_b[1:8]-254+1;
               sign=0;
               x=0;
               exponent=0;
            end     
        else 
           begin
             sign = flp_a[15]^flp_b[15];
             x = {1'b1,flp_a[9:0]}*{1'b1,flp_b[9:0]};
             exponent = flp_a[14:10]+flp_b[14:10]-15+1;
             if( x[21] == 0 ) // since x will be of 10*2 = 20 bits
                 begin
                     x = x <<1;
                     exponent = exponent - 1;
                    //exp_unbiased=exp_unbiased-1;
                 end 
            // for(int i=0;i<32;i++)
           end
    end

endmodule