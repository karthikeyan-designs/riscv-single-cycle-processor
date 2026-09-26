module data_mem(
    input clk,
    input [31:0] addr, // alu result
    input [31:0] write_data, // RD2 from register file
    input memwrite,
    output reg [31:0] read_data );
reg [31:0] memory  [0:255]; 
always@(posedge clk) begin
    if(memwrite) begin
        memory[addr[7:0]]<=write_data; // Write data to memory at the specified address
    end
    
end
always@(*) begin
    read_data=memory[addr[7:0]]; // Output the data read from memory
end 

/// initializing data memory for the load word
initial begin 
    memory[108]=32'd10;
    memory[120]=32'd7;
end
endmodule
