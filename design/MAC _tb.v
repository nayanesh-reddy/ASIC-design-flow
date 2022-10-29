module MAC_tb();
  
  reg [7:0] a,b;
  reg clk = 0;
  reg rst = 0;
  
  wire [15:0] out;
  
  MAC dut( .a(a), .b(b), .clk(clk), .rst(rst), .out(out) );
  
  always #5 clk = ~clk;
  
  initial
    begin
      #2; rst = 1;
      #5; rst = 0;
      
      #0; a = 8'd5; b = 8'd2;
      #10; a = 8'd3; b = 8'd4;
      #10; a = 8'd7; b = 8'd9;
      #10; a = 8'd8; b = 8'd6;
      #10; a = 8'd0; b = 8'd0;
      
      #10 $finish();
    end
  
  initial
    begin
      $monitor("clk = %b, a = %d; b = %d, out = %d", clk, a, b, out );
      $dumpfile("dump.vcd");
      $dumpvars;
    end
  
endmodule