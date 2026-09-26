module register_tb;
reg clk;
reg [4:0] A1;   
reg [4:0] A2;
reg [4:0] A3;   
reg WE3;
reg [31:0] WD3;
wire [31:0] RD1;
wire [31:0] RD2;    
register_file dut(
    .clk(clk),
    .A1(A1),
    .A2(A2),
    .A3(A3),
    .WE3(WE3),
    .WD3(WD3),
    .RD1(RD1),
    .RD2(RD2)
);
initial begin
    $dumpfile("register_tb.vcd");
    $dumpvars(0, register_tb);
end
initial begin
    $monitor("Time: %0t | A1: %b | A2: %b | A3: %b | WE3: %b | WD3: %h | RD1: %h | RD2: %h", 
             $time, A1, A2, A3, WE3, WD3, RD1, RD2);
end
always #5 clk=~clk; // clock generation

initial begin
    clk=0;
    A1=5'b00000; // read register x0
    A2=5'b00001; // read register x1
    A3=5'b00010; // write register x2
    WE3=1; // enable write
    WD3=32'h00000007; // write data 7 to register x2
    #10 WE3=0; // disable write
    #10 A1=5'b00010; // read register x2
    #10 A2=5'b00010; // read register x2
   
   
   
    #100 $finish;
end
endmodule