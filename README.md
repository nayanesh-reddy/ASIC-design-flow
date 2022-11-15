# ASIC Design Flow

Application Specific Integrated Circuit (ASIC) design flow is a mature and silicon-proven IC design process which includes various steps like design conceptualization, chip optimization, logical/physical implementation, and design validation and verification.

 - Lets Design a Digital ASIC with opensource EDA tools using only the web browser.
 - Example design: Basic MAC unit
 
## Basic MAC unit
Multiply and accumulations(MAC) are fundamental operations for domain-specific accelerator with AI applications ranging from filtering to convolutional neural networks(CNN). MAC unit is also a fundamental block in the computing devices, especially Digital Signal Processor (DSP). MAC unit performs multiplication and accumulation process. Basic MAC unit consists of multiplier, adder, and accumulator.

### Architecture
![image](https://user-images.githubusercontent.com/84563214/198866526-1f8e2293-02e3-47d5-9618-b0b13552ec1d.png)

### Verilog Design
  ```verilog
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
  ```      
### Verilog Testbench
  ```verilog
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
   ```
 
 
 
### Simulation results (EDA Playground)
- Under Tools & Simulators select "Aldec Riviera Pro 2022.04" , use can edit the Complie Oprions, Run Options and Run Time but here I'm leaving it as default and check the "Open EPWave after run" box to get the waveform.
    - [MAC_unit - EDA Playground link](https://www.edaplayground.com/x/PLT4)

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
   - OpenLane is an automated RTL to GDSII flow based on several components including [OpenROAD](https://github.com/The-OpenROAD-Project/OpenROAD), Yosys, Magic, Netgen, CVC, SPEF-Extractor, KLayout and a number of custom scripts for design exploration and optimization. It also provides a number of custom scripts for design exploration, optimization and ECO.
   
  - #### OpenLane Flow
     ![image](https://user-images.githubusercontent.com/84563214/199187645-24ab1133-4c14-4b89-a7ad-18d847ec96e6.png)
     - [Detailed OpenLane Flow](https://github.com/nayanesh-reddy/MAC-unit/blob/main/OpenLane_Flow.txt)
   
  - #### Notebook - openlane_RTL_to_GDS - [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/drive/18xQSQTZbF0fUeNgo7oNFzP2c7e_gB4zG?usp=sharing)

    - This Notebook is used to run a logic design through the [OpenLane](https://github.com/The-OpenROAD-Project/OpenLane/) GDS to RTL flow targeting the [open source SKY130 PDK](https://github.com/google/skywater-pdk/).
    - *This notebook can also convert the GDS file into multiple STL files (one for each layer in GDS) for rendering it in 3D*
 
  - #### MAC-unit Layout (without the interconnects)
    - Download the SVG file [MAC.svg](https://user-images.githubusercontent.com/84563214/199174378-92f12115-6ba5-41ad-8e46-02e345d9c33d.svg)
    - MAC.png
    ![MAC](https://user-images.githubusercontent.com/84563214/199175384-477f0794-c015-4ddc-9403-99cf52ab692e.png)




### 3D Render of GDS in Blender
 - Watch Video for info : [Zero To ASIC Course - Maximo shows how to make beautiful GDS renders with Blender](https://www.youtube.com/watch?v=gBjQI3GrBHU&t=711s&ab_channel=ZeroToASICCourse)
 - [Download Blender](https://www.blender.org/download/)
    
 - #### MAC-unit GDS 3D Render in Blender
     - [MAC GDS Render Blender File - Google Drive link](https://drive.google.com/file/d/1bgxw2hEb1UtcrC1CS8LCxaCyaqCcOWeA/view?usp=share_link)
     - Top View
        ![MAC_gds_render_3](https://user-images.githubusercontent.com/84563214/199178547-4a7c77b4-d1c3-4e32-8bc8-c15ea7fa47c4.png)
        
    - View from bottom-right
        ![MAC_gds_render_2](https://user-images.githubusercontent.com/84563214/199174476-c11c5923-3496-4a7f-bc13-652d7efb7555.png)

      - *Note : The MAC.png is the 180 degree clockwise rotated version of MAC.svg to match the GDS 3D Render image*

&nbsp;

### 3D Render of GDS in Colab
<p float="left">
  <img src="https://user-images.githubusercontent.com/84563214/201965560-8fb2a940-6533-4a0a-a225-d7928a6fed79.png" width=40% height=40% />
  <img src="https://user-images.githubusercontent.com/84563214/201967747-fbff2f75-d9a8-4a99-baf5-6a6f7b69d977.png" width=57% height=40% /> 
</p>
