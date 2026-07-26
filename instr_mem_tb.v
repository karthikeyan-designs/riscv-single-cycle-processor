module instr_mem_tb;

reg [31:0] pc_addr;
wire [31:0] instr;

instr_memory dut(
    .pc_addr(pc_addr),
    .instr(instr)
);

initial begin
    $dumpfile("instr_mem_tb.vcd");
    $dumpvars(0, instr_mem_tb);
end

initial begin

    $display("Time\tPC Address\tInstruction");
    $monitor("%0t\t%h\t%h", $time, pc_addr, instr);

    pc_addr = 0;   // 00100093
    #10 pc_addr = 4; //01000113
    #10 pc_addr = 8; //00110733
    #10 pc_addr = 12; //401107b3
    #10 pc_addr = 16; //00116b33
    #10 pc_addr = 20;  //00117bb3
    #10 pc_addr = 24;   //00000013

    #20 $finish;
end

endmodule