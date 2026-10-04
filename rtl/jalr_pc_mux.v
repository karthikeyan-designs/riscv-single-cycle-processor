module jalr_pc_mux(
    input  [31:0] jalr_target,
    input  [31:0] input_pc_next,
    input         jalr_en,
    output [31:0] final_pc
);

assign final_pc = (jalr_en) ? jalr_target : input_pc_next;

endmodule