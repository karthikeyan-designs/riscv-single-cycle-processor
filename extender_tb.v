module extender_tb;
    reg signed [11:0] imm;
    reg [1:0] immsrc;
    wire signed [31:0] imm_ext;

    extender uut (
        .imm(imm),
        .immsrc(immsrc),
        .imm_ext(imm_ext)
    );
initial begin
    $dumpfile("ext_tb.vcd");
    $dumpvars(0,extender_tb);
end

initial begin
    // +1
    imm = 12'sh001;
    immsrc = 2'b00;
    #10;

    // +2
    imm = 12'sh002;
    immsrc = 2'b00;
    #10;

    // -2
    imm = 12'shFFE;
    immsrc = 2'b00;
    #10;
    #10  $finish;
end
endmodule
