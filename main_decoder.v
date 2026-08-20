        //////// MAIN DECODER ////////
        module main_decoder(
        input [6:0] op,
        output reg memwrite,
        output reg [1:0] result_src,
        output reg [1:0] immsrc,
        output reg [1:0] aluop,
        
        output reg regwrite,
        output reg alusrc
        );
        always@(*) begin
        case(op)
        7'b0110011: begin // R-type
        aluop=2'b10; // ALU control determined by funct3 and funct7
        immsrc=2'b00; // No immediate
        regwrite=1; // Write to register
        alusrc=1'b0; // ALU source is 0 for R-type
        memwrite=0; // No memory write for R-type
        result_src=2'b00; // ALU result is written back to register
        end

        7'b0010011: begin // I-type
        aluop=2'b10; // ALU control determined by 
        immsrc=2'b00; // Immediate from instruction
        regwrite=1; // Write to register
        alusrc=1'b1; // ALU source is immediate for I-type
        memwrite=0; // No memory write for I-type
        result_src=2'b00; // ALU result is written back to register
        end
        7'b0000011: begin // Load
        aluop=2'b00; // ALU performs addition for address calculation
        immsrc=2'b00; // Immediate from instruction
        regwrite=1; // Write loaded value to register
        alusrc=1'b1; // ALU source is immediate for Load instructions
        memwrite=0; // No memory write for Load instructions
        result_src=2'b01; // Load result is written back to register
        end
    
        default: begin
            aluop   = 2'b00;
            immsrc  = 2'b00;
            regwrite= 1'b0;
            alusrc= 1'b0;
            memwrite=0;
            result_src=2'b00;
        end

        endcase
        end
        endmodule

        /////// ALU DECODER ///////////
        module alu_decoder(
            input [2:0] funct3,
            input [6:0] funct7,
            input [6:0] op,
            input [1:0] aluop,
            output reg [2:0] aluctrl
        );

        always @(*) begin
    case (aluop)
        2'b00: aluctrl = 3'b000; // add (loads/stores)
        2'b01: aluctrl = 3'b001; // sub (branches)
        default: begin
            case (funct3)
                3'b000:
                    aluctrl = (funct7 == 7'b0100000) ? 3'b001 : 3'b000; // sub/add
                3'b001: aluctrl = 3'b100; // SLL / SLLI
                3'b010:  aluctrl = 3'b001; // SLT / SLTI (signed compare)
					 3'b011:  aluctrl = 3'b010; // SLTU / SLTIU (unsigned compare)
                3'b100: aluctrl = 3'b111; // XOR / XORI
                3'b101: begin
                    aluctrl = (funct7 == 7'b0100000) ? 3'b110 : 3'b101;  // SRL/SRLI vs SRA/SRAI
                end
                3'b110: aluctrl = 3'b011; // OR / ORI
                3'b111: aluctrl = 3'b010; // AND / ANDI
                default: aluctrl = 3'b000;
            endcase
        end
    endcase
end


endmodule






