module or_pc_src(
    input and_pc_src,
    input jump,
    output branch_taken
);

    assign branch_taken= (and_pc_src | jump);

endmodule