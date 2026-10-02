module single_cycle_top(
    input clk,
    input reset,
   
  
    output [31:0] instr, // testing

    output [6:0] op,
    output [2:0] funct3,
    output [6:0] funct7,
    output [4:0] rs1,
    output [4:0] rs2,
    output [4:0] rd,
    output WE3, //write enable for register file
    output [2:0] aluctrl,
    output [31:0] RD1,
    output [31:0] RD2,
    output [31:0] srcb, // output of mux_srcb
    output [31:0] read_data, // output from data memory
    output [31:0] pc_plus_4, // output from pc_inc
    output [1:0] result_src, // control signal for result_mux
    output [31:0] result,
    output [31:0] pc,
    output zero, // output from ALU
    output [31:0] mux_output // output from result_mux, which is the data to write back to register file
);
wire [31:0] PC_target;
wire pc_src;


wire memwrite; // control signal for memory write
wire regwrite; // control signal for register write
wire [31:0] pc_next;
wire [1:0] aluop;
//wire [31:0] WD3; // write data for register file

wire [1:0] immsrc; // control signal for immediate source
wire alusrc; // control signal for ALU source
wire signed  [31:0] imm_ext; // output from extender
wire [31:0] RD2; // output from register file
wire [31:0] PC_NEXT; // output from pc_mux

wire signed [11:0] imm_s;
wire signed [12:0] imm_b;
wire signed [20:0] imm_j;
wire branch; // control signal for branch instructions
wire jump; // jump for jal 
wire branch_taken; 

pc program_counter(
    .clk(clk),
    .reset(reset),
    .pc_next(pc_next),
    .pc(pc)
);
pc_inc pc_incrementer(
    .pc(pc),
    .pc_plus_4(pc_plus_4)
);
pc_target dut_pc_target(
    .pc(pc),
    .imm_ext(imm_ext),
    .PC_target(PC_target)

);
pc_mux pc_mux_unit(
    .pc_plus_4(pc_plus_4),
    .PC_target(PC_target),
    .pc_src(branch_taken),
    .PC_NEXT(pc_next)
);
instr_memory instr_mem(
    .pc_addr(pc), 
    .instr(instr)
);
register_file reg_file(
    .clk(clk),
    .A1(rs1),
    .A2(rs2),
    .A3(rd),
    .WE3(WE3),
    .WD3(mux_output), // Output from result_mux
    .RD1(RD1),
    .RD2(RD2)
);
main_decoder main_dec(
    .op(op),
    .regwrite(WE3),
    .immsrc(immsrc),
    .alusrc(alusrc),
    .result_src(result_src),
    .memwrite(memwrite),
    .branch(branch),
    .jump(jump),
    .aluop(aluop)
);
alu_decoder alu_dec(
    .op(op),
    .funct3(funct3),
    .funct7(funct7),
    .aluop(aluop),
    .aluctrl(aluctrl)
);

alu alu_unit(
    .a(RD1),
    .b(srcb), // Output from mux_srcb
    .aluctrl(aluctrl),
    .zero(zero),//
    .result(result)
);
and_pc_src and_pc(
    .zero(zero), // Output from ALU (not connected in this snippet)
    .branch(branch), // Check if instruction is a branch
    .pc_src(pc_src)
);

or_pc_src or_pc(
    .and_pc_src(pc_src),
    .jump(jump),
    .branch_taken(branch_taken)
);
extender imm_extender_uut(
    .imm_i(instr[31:20]), // Immediate for I-type instructions
    .imm_s(imm_s), // Immediate for S-type instructions
    .immsrc(immsrc),
    .imm_b(imm_b), // Immediate for B-type instructions
    .imm_j(imm_j), // Immediate for J-type instructions
    .imm_ext(imm_ext)
);
mux_srcb mux_srcb_unit(
    .RD2(RD2),
    .imm_ext(imm_ext), // Output from extender (not connected in this snippet)
    .alusrc(alusrc), // Control signal to select between RD2 and imm_ext 
    .srcb(srcb) // Output of the mux 
);
data_mem data_memory(
    .clk(clk),
    .addr(result), // Address for memory access (output from ALU)
    .write_data(RD2), // Data to write to memory (RD2 from register file)
    .memwrite(memwrite), // Control signal for memory write
    .read_data(read_data) // Data read from memory
);
result_mux write_back_mux(
    .result(result), // ALU result
    .read_data(read_data), // Data read from memory
    .pc_plus_4(pc_plus_4), // Next PC value
    .result_src(result_src), // Control signal to select between ALU result and memory data
    .mux_output(mux_output) // Output of the mux, which is the data to write back to register file
);


assign imm_s = {instr[31:25], instr[11:7]};
assign imm_b ={instr[31],instr[7],instr[30:25],instr[11:8],1'b0}; // B-type immediate
assign imm_j = {
    instr[31],
    instr[19:12],
    instr[20],
    instr[30:21],
    1'b0
};

assign op = instr[6:0];
assign funct3 = instr[14:12];
assign funct7 = instr[31:25];
assign rs1 = instr[19:15];
assign rs2 = instr[24:20];
assign rd = instr[11:7];
endmodule