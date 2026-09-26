module alu_ctrl_tb;
reg [2:0] funct3;
reg [6:0] funct7;
reg [6:0] op;
wire [1:0] aluop;
wire [2:0] aluctrl;
wire regwrite;
wire [1:0] immsrc;


main_decoder md(
    .op(op),
    .aluop(aluop),
    .immsrc(immsrc),
    .regwrite(regwrite)
);
alu_decoder ad(
    .funct3(funct3),
    .funct7(funct7),
    .op(op),
    .aluop(aluop),
    .aluctrl(aluctrl)
);
initial begin 
    $dumpfile("alu_ctrl.vcd");
    $dumpvars(0,alu_ctrl_tb);
end

initial begin
    $monitor("T=%0t | op=%b | funct3=%b | funct7=%b | aluop=%b | aluctrl=%b",
              $time, op, funct3, funct7, aluop, aluctrl);
end

initial begin
// Test R-type add
op = 7'b0110011; // R-type
funct3 = 3'b000; // add
funct7 = 7'b0000000; // add
#10;
// Test R-type sub
op = 7'b0110011; // R-type
funct3 = 3'b000; // sub
funct7 = 7'b0100000; // sub
#10;
// Test R-type and
op = 7'b0110011; // R-type
funct3 = 3'b111; // and
funct7 = 7'b0000000; // and
#10;
// Test R-type or
op = 7'b0110011; // R-type
funct3 = 3'b110; // or
funct7 = 7'b0000000; // or
#10;
// Test I-type addi
op = 7'b0010011; // I-type
funct3 = 3'b000; // addi
#10;
#20 $finish;
end
endmodule
