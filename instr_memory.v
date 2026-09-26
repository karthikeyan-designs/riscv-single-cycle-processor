module instr_memory(
    input  [31:0] pc_addr,
    output [31:0] instr
);

    // Instruction memory (ROM)
    reg [31:0] mem [0:31];

    // Read instruction (combinational)
    assign instr = mem[pc_addr >> 2];

    // Initialize program
    initial begin
         $readmemh("beq_instr.hex",mem);
        //$readmemh("test1_RILW.hex", mem); // Load instructions from a hex file
        // $readmemh("R_type_instr.hex",mem);/// Rtype instructions
        // $readmemh("s_type_instructions.hex",mem);
        //    $readmemh("itype_instr.hex",mem);
    end

endmodule   