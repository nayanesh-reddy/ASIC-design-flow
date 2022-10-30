module MAC(x, w, out, rst, clk);

  parameter N = 8;

  input [N-1:0] x, w;
  input clk, rst;

  output reg [2*N-1:0] out;

  always @(posedge clk)
    begin
      if(rst)
        out <= 0;
      else
        out <= out + (x*w);
    end

endmodule
