`timescale 1ns / 1ps
// 16 bit floating point multiplier

module flop_mul(flp_a, flp_b, sign, exponent, prod);
input [15:0] flp_a ;
input [15:0] flp_b ;
output reg sign ;
output [9:0] prod  ;
reg [21:0] x;
output reg [4:0] exponent;
assign prod = x[20:11];
always@ * 
    begin
        if (flp_a==0||flp_b==0) 
            begin 
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
                    end 
           end
    end

endmodule
