module result_mux(
    input [1:0] result_src,
    input [31:0] result, // Output from ALU 
    input [31:0] read_data, // Data read from memory
    input [31:0] pc_plus_4, // Next PC value
    output reg [31:0] mux_output
);

always @(*) begin
    case (result_src)
        2'b00: mux_output = result; // ALU result
        2'b01: mux_output = read_data; // Data from memory
        2'b10: mux_output = pc_plus_4; // Next PC value
        default: mux_output = 32'b0; // Default case
    endcase
end
endmodule
