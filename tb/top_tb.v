module top_tb;
reg clk;
reg reset;
wire [31:0] pc;
wire [31:0] instr;
wire [6:0] op;
wire [2:0] funct3;
wire [6:0] funct7;
wire [4:0] rs1;
wire [4:0] rs2;
wire [4:0] rd;
wire WE3;
wire [2:0] aluctrl;
wire [31:0] RD1;
wire [31:0] RD2;
wire [31:0] srcb; // Output of mux_srcb
wire [31:0] read_data; // Output from data memory
wire [31:0] pc_plus_4; // Output from pc_inc
wire [1:0] result_src; // Control signal for result_mux
wire [31:0] mux_output; // Output from result_mux, which is the data to write back to register file
wire [31:0] result; // Output from ALU


single_cycle_top uut(
    .clk(clk),
    .reset(reset),
    .pc(pc),
    .instr(instr),
    .op(op),
    .funct3(funct3),
    .funct7(funct7),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .WE3(WE3),
    .aluctrl(aluctrl),
    .RD1(RD1),
    .RD2(RD2),
    .result(result),
    .srcb(srcb),
    .read_data(read_data),
    .pc_plus_4(pc_plus_4),
    .result_src(result_src),
    .mux_output(mux_output)
);
initial begin
    $dumpfile("top_tb.vcd");
    $dumpvars(0, top_tb);
end
///////////////beq test////////////////////////
initial begin
$monitor("time=%0t | PC=%0d | instr=%h | x1=%0d | x7=%0d | imm=%0d | result=%0d | zero=%b | branch=%b | pc_src=%b",
         $time,
         pc,
         instr,
         uut.reg_file.registers[1],
         uut.reg_file.registers[7],
         uut.imm_ext,
         uut.result,
         uut.zero,
         uut.branch,
         uut.pc_src);
end

// initial begin
//     $monitor(
//     "T=%0t PC=%h INSTR=%h rs1=%d rs2=%d rd=%d RD1=%d RD2=%d ALUCTRL=%b RESULT=%d SRCB=%d READ_DATA=%d RESULT_SRC=%b WE3=%b PC_PLUS_4=%h",
//     $time,
//     pc,
//     instr,
//     rs1,
//     rs2,
//     rd,
//     RD1,
//     RD2,
//     aluctrl,
//     result,
//     srcb,
//     read_data,
//     result_src,
//     WE3,
//     pc_plus_4
//     );
// end




initial begin
    clk = 0;
    reset = 1;
    #10 reset = 0; // release reset after 10 time units
end
always #5 clk = ~clk; // clock with period of 10 time 
initial begin
    #100 $finish; // end simulation after 100 time units
end
endmodule