module alu_tb;

reg  [31:0] a;
reg  [31:0] b;
reg  [2:0]  aluctrl;
wire [31:0] result;

alu dut(
    .a(a),
    .b(b),
    .aluctrl(aluctrl),
    .result(result)
);

initial begin
    $dumpfile("alu_tb.vcd");
    $dumpvars(0, alu_tb);

    $monitor("T=%0t ALUCTRL=%b A=%h B=%h RESULT=%h",
              $time, aluctrl, a, b, result);

    // ADD
    a = 32'd10;
    b = 32'd5;
    aluctrl = 3'b000;
    #10;

    // SUB
    aluctrl = 3'b001;
    #10;

    // AND
    a = 32'hF0F0F0F0;
    b = 32'h0F0F0F0F;
    aluctrl = 3'b010;
    #10;

    // OR
    aluctrl = 3'b011;
    #10;

    // SLL (4 << 2 = 16)
    a = 32'd4;
    b = 32'd2;
    aluctrl = 3'b100;
    #10;

    // SRL (16 >> 2 = 4)
    a = 32'd16;
    b = 32'd2;
    aluctrl = 3'b101;
    #10;

    // SRA (-16 >>> 2 = -4)
    a = -32'd16;
    b = 32'd2;
    aluctrl = 3'b110;
    #10;

    // XOR
    a = 32'hAA55AA55;
    b = 32'hFFFF0000;
    aluctrl = 3'b111;
    #10;

    $finish;
end

endmodule