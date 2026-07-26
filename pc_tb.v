module pc_tb;
reg clk;
reg reset;
reg [31:0] pc_next;
wire [31:0] pc;

pc uut (
    .clk(clk),
    .reset(reset),
    .pc_next(pc_next),
    .pc(pc)
); 
initial begin 
    $dumpfile("pc_tb.vcd");
    $dumpvars(0,pc_tb);
end 
initial begin
    clk=0; // Initialize clock
    forever #5 clk = ~clk; // Generate a clock signal with a period of 10 time units
end
initial begin 
    reset = 1;
    pc_next = 32'h00000004; // Example next PC value
    #10; // Wait for 10 time units
    reset = 0; // Release reset
    #10; // Wait for 10 time units
    pc_next = 32'h00000008; // Update next PC value
    #10; // Wait for 10 time units
    $finish; // End simulation
end
endmodule
