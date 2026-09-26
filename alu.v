module alu(
    input [31:0] a,
    input [31:0] b,
    input [2:0] aluctrl,
    output zero,
    output reg [31:0] result
);
assign zero = (result == 32'b0); // used by PCSrc for branch instructions

always@(*) begin
case(aluctrl)
3'b000: result= a+b; // add
3'b001: result=a-b;//sub
3'b010: result=a&b;//and
3'b011: result=a|b;//or
3'b100: result= a<<b[4:0]; // SLL, shift left logical
3'b101: result= a>>b[4:0]; // SRL, shift right logical
3'b110: result= $signed(a) >>> b[4:0]; // SRA, shift right arithmetic
3'b111: result=a^b; //xor

default: result=0; // default case
endcase
end
endmodule