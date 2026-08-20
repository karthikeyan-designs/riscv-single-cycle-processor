module pc_mux(
    input [31:0] pc_plus_4,
    input [31:0] PC_target,
    input pc_src,
    output  [31:0] PC_NEXT
);
assign PC_NEXT= pc_src ? PC_target: pc_plus_4;
endmodule
