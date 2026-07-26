module pc_inc(
    input [31:0] pc,
    output [31:0] pc_plus_4
);
assign pc_plus_4 = pc + 4; // Increment PC by 4 for the next instruction
endmodule