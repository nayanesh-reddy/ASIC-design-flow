module MAC(a, b, out, rst, clk);
  
  input [7:0] a, b;
  input clk, rst;
  
  output reg [15:0] out;
  
  always @(posedge clk)
    begin
      if(rst)
        out <= 0;
      else
        out <= out + (a*b);
    end

endmodule
