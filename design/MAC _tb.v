module MAC_tb();

  reg [7:0] x,w;
  reg clk = 0;
  reg rst = 0;

  wire [15:0] out;

  MAC dut( .x(x), .w(w), .clk(clk), .rst(rst), .out(out) );

  defparam dut.N = 8;

  always #5 clk = ~clk;

  initial
    begin
      #2; rst = 1;
      #5; rst = 0;

      #0;  x = 8'd5; w = 8'd2;
      #10; x = 8'd3; w = 8'd4;
      #10; x = 8'd7; w = 8'd9;
      #10; x = 8'd8; w = 8'd6;
      #10; x = 8'd0; w = 8'd0;

      #10 $finish();
    end

  initial
    begin
      $monitor("clk = %b, x = %d; w = %d, out = %d", clk, x, w, out );
      $dumpfile("dump.vcd");
      $dumpvars;
    end

endmodule
