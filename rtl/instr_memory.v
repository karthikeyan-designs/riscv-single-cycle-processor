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
         $readmemh("programs/b_type_test.hex",mem);
        
    end

endmodule   