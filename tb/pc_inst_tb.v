module pc_inst_tb;
reg clk;
reg reset;
wire [31:0] instr;
wire [31:0] pc; 

single_cycle_top uut (
    .clk(clk),
    .reset(reset),
    .pc(pc),
    .instr(instr)
);

initial begin 
    $dumpfile("pcinst.vcd");
    $dumpvars(0,pc_inst_tb);
end 
initial begin

$monitor("Time: %0t | PC: %h | Instr: %h", $time, pc, instr);   
end

initial begin
    clk=0; // Initialize clock
    forever #5 clk = ~clk; // Generate a clock signal with a period of 10 time units
end
initial begin 
    reset = 1;
    #10; // Wait for 10 time units
    reset = 0; // Release reset
    #100; // Wait for 100 time units to observe multiple instructions
    $finish; // End simulation
end
endmodule
