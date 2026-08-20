module and_pc_src(
    input zero,
    input branch,
    output pc_src
);

assign pc_src = zero & branch;
endmodule
