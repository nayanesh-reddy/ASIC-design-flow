# MAC unit

Multiply and accumulations(MAC) are fundamental operations for domain-specific accelerator with AI applications ranging from filtering to convolutional neural networks(CNN). MAC unit is also a fundamental block in the computing devices, especially Digital Signal Processor (DSP). MAC unit performs multiplication and accumulation process. Basic MAC unit consists of multiplier, adder, and accumulator.

## Basic MAC unit 
### Architecture
![image](https://user-images.githubusercontent.com/84563214/198866526-1f8e2293-02e3-47d5-9618-b0b13552ec1d.png)

### Verilog Design

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
      
### Verilog Testbench

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
    
### Simulation results (EDA Playground)
- Under Tools & Simulators select "Aldec Riviera Pro 2022.04" , use can edit the Complie Oprions, Run Options and Run Time but here I'm leaving it as default and check the "Open EPWave after run" box to get the waveform.
    - MAC_unit - EDA Playground link : https://www.edaplayground.com/x/PLT4

![image](https://user-images.githubusercontent.com/84563214/198867512-905e62b4-f7f0-4bd9-a1b6-831a0c2d41cc.png)

  - ### Waveform (EDA Playground)
    - #### Radix : Binary
      ![image](https://user-images.githubusercontent.com/84563214/198867565-a326dd26-d86f-404d-b08d-c271b7615f8a.png)
    
    - #### Radix : Hex    
      ![image](https://user-images.githubusercontent.com/84563214/198867658-aa461b80-3205-423b-af28-f3b224e758e8.png)

### RTL Synthesis (EDA Playgroud)
- Under Tools & Simulators select "Yosys 0.9.0" , under Synthesis options drop down leave all boxes uncheck and check the "Show diagram after run" box.
- #### RTL Netlist
    ![image](https://user-images.githubusercontent.com/84563214/198868542-89905fcd-89e3-4e79-8780-6e65e2e28cfd.png)

- Using "a" and "b" instead of "x" and "w" to get more pleasing netlist image (but interms of RTL netlist both above and below netlist are same)
    ![image](https://user-images.githubusercontent.com/84563214/198868797-6f3c77ce-d8a4-4b0c-a5ec-a90d53066f38.png)

### RTL to GDSII flow (Openlane)
[![image](https://user-images.githubusercontent.com/84563214/199168621-fe6336f2-00cb-4488-a8bb-8fb32b5047c3.png)](https://colab.research.google.com/github/chipsalliance/silicon-notebooks/blob/main/digital-inverter-openlane.ipynb)

