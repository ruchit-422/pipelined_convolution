`timescale 1ps / 1fs
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.02.2023 15:21:45
// Design Name: 
// Module Name: Stage_1_tb
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

module pipelined_conv_tb();
logic [7:0] pixel_r,pixel_g,pixel_b;
logic clk,reset;
logic stage1_en;
logic [12:0] conv_out;
logic conv_end, stage5_en;
pipelined_conv m0(stage1_en, clk, reset, pixel_r, pixel_g, pixel_b, conv_out, conv_end,stage5_en);

initial begin
clk=1'b0;
forever begin
#1 clk=~clk;
end end

integer file;
integer g;
initial begin 
    file=$fopen("D:/Vivado/pixel_values.txt", "r");    
    while (!$feof(file)) begin
      #2
      g=$fscanf(file,"%d %d %d\n",pixel_r,pixel_g,pixel_b);
    end
    g=0;
    stage1_en=0;
    #12;
    $finish;
    $fclose(file);
  end

//integer file1;
//initial begin
//file1 = $fopen("D:/Vivado/output_values.txt", "w");
//$fwrite(file1,"%d\n",$signed(conv_out));
//$fclose(file1);
//end


integer i, k; 
integer file1;
initial begin
    i=0;
    #2062
    // Write final values to a text file
    if (stage5_en) begin //when 5th stage starts it's output is stored in text file
    #1
    file1=$fopen("D:/Vivado/result_values.txt", "w"); //writing data in text file(path to be specified according to local machine)
    while (i<532240 ) begin // (N-2)*(N-2) elements needs to be stored
      #2
      i=i+1;
      $fwrite(file1,"%d\n",$signed(conv_out));
    end
    k=0;
    $fclose(file1);
  end end


initial 
begin
reset=1'b0;
#2
reset=1'b1;
stage1_en=1'b1;
end



endmodule