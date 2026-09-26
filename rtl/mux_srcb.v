module mux_srcb(
    input [31:0] RD2,
    input  [31:0] imm_ext,
    input  alusrc,
    output reg  [31:0] srcb
);
always @(*) begin
    case (alusrc)
    1'b0: srcb=RD2; // R-type instructions use register data
    1'b1: srcb=imm_ext; // I-type instructions use immediate value

    default: srcb=32'b0; // Default case
    endcase
end
endmodule