module extender(
    input signed [11:0] imm_i,
    input signed [11:0] imm_s,
    input signed [12:0] imm_b,
    input signed [20:0] imm_j,
    input [1:0] immsrc,
    output reg signed [31:0] imm_ext
);

always @(*) begin
    case (immsrc)

        2'b00: imm_ext = {{20{imm_i[11]}}, imm_i}; // I-type

        2'b01: imm_ext = {{20{imm_s[11]}}, imm_s}; // S-type

        2'b10: imm_ext = {{19{imm_i[11]}}, imm_b}; // B-type - temporary

        2'b11: imm_ext= {{11{imm_j[20]}},imm_j};   //Jal Jtype 
        
        default: imm_ext = 32'b0;
    
    endcase
end

endmodule