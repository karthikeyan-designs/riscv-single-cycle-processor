module extender(
    input signed [11:0] imm,
    input [1:0] immsrc,
    output reg signed [31:0] imm_ext

);

always @(*) begin
    case (immsrc)
        2'b00: imm_ext = {{20{imm[11]}}, imm}; // I-type
        2'b01: imm_ext = {{20{imm[11]}}, imm}; // S-type (same as I-type)
        2'b10: imm_ext = {{20{imm[11]}}, imm}; // B-type (same as I-type)
        default: imm_ext = 32'b0; // Default case
    endcase
end
endmodule
