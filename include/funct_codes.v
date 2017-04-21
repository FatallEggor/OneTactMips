//opcodes

`define RTYPE_OP	6'b000000

`define LW_OP		6'b100011
`define SW_OP		6'b101011

`define ADDI_OP		6'b001000
`define ANDI_OP		6'b001100
`define ORI_OP		6'b001101
`define LUI_OP		6'b001111

`define BEQ_OP		6'b000100
`define BNE_OP		6'b000101
`define J_OP		6'b000010
`define JAL_OP		6'b000011
`define SLTI_OP		6'b001010

`define MULT_OP		6'b011000
`define DIV_OP		6'b011010

//funct
//logical
`define AND_F		6'b100100
`define OR_F		6'b100101
`define XOR_F		6'b100110
`define NOR_F		6'b100111
`define SLT_F		6'b101010
`define NAND_F		6'b101011

`define SLL_F		6'b000000
`define SRL_F		6'b000010

//arithmetic
`define ADD_F		6'b100000
`define ADDU_F		6'b100001
`define SUBTR_F		6'b100010

//branches
`define JR_F		6'b001000

