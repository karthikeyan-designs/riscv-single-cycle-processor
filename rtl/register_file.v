module register_file(
    input clk,
    input [4:0] A1, // read register 1 
    input [4:0] A2, // read register 2 
    input [4:0] A3, // write register 
    input  WE3,      // write enable
    input [31:0] WD3, // write data
    output reg [31:0] RD1, // read data 1
    output reg [31:0] RD2  // read data 2
);
reg [31:0] registers [31:0]; // 32 registers, each 32 bits wide
always@(posedge clk) begin
    
        if(WE3) begin
        
        if(A3 != 0) begin// register x0 is always 0
        registers[A3] <= WD3; // write data to register
        end
         end

   

  end
  // read data from registers
always@(*) begin

        RD1 = (A1 == 5'd0) ? 32'h0 : registers[A1]; // read data from register rs1
        RD2 = (A2 == 5'd0) ? 32'h0 : registers[A2]; // read data from register rs2

    end
    initial begin
    // for testing: initialize registers
    registers[0]=32'd0; // x0 = 0
    registers[1]=32'd0; // x1 = 1
    registers[2]=32'd100; // x2 = 2
    registers[3]=32'd0; // x3 = 3
    registers[4]=32'd7; // x4 = 4
    registers[12]=-32'sd1; // x12 = -1
    end


endmodule
