function init_regs(regs)
{
		r = "$0 0x0 $at 0x1 $v0 0x2 $v1 0x3 $a0 0x4 $a1 0x5 $a2 0x6 $a3 0x7 $t0 0x8 $t1 0x9 $t2 0xA\
		$t3 0xB $t4 0xC $t5 0xD $t6 0xE $t7 0xF $s0 0x10  $s1 0x11 $s2 0x12 $s3 0x13 $s4 0x14 $s5\
		0x15 $s6 0x16 $s7 0x17 $t8 0x18 $t9 0x19 $k0 0x1A $sp 0x1B $ra 0x1C $us 0x1D $tcon 0x1E $tmr\
		0x1F"

		n = split (r, reg)
		for (i = 1; i <= n; i += 2) {
			regs[reg[i]] = strtonum(reg[i+1])
		}

}

function init_oplist(oplist)
{

	ops = "add rtype addu rtype sub rtype subu rtype and rtype or rtype xor rtype nor rtype slt rtype sll shift srl shift lw bs_addr sw bs_addr addi imm lui sh_imm  ori imm  slti imm andi imm j imm_addr jal imm_addr jr reg_addr beq pc_addr bne pc_addr"
	n = split (ops, opl)
	for (i = 1; i <= n; i += 2) {
		oplist[opl[i]] = opl[i+1]
	#	printf "%s\t%s\n", opl[i], oplist[opl[i]] 
	}

}

function init_opcodes(op_cs)
{
	ops = "add 0x0 addu 0x0 sub 0x0 subu 0x0 and 0x0 or 0x0 xor 0x0 nor 0x0 slt 0x0 sll 0x0 srl 0x0 lw 0x23 sw 0x2B addi 0x8 lui 0xF  ori 0xD  slti 0xA andi 0xc j 0x2 jal 0x3 jr 0x0 bne 0x5 beq 0x4"

	n = split (ops, opcs)
	for (i = 1; i <= n; i += 2) {
		op_cs[opcs[i]] = strtonum(opcs[i+1])
	}
}

function init_funccodes(func_cs)
{

	funcs = "add 0x20 addu 0x21 sub 0x22 subu 0x23 and 0x24 or 0x25 xor 0x26  nor 0x27 slt 0x2A sll 0x0 srl 0x2 jr 0x8"	
	n = split (funcs, funccs)
	for (i = 1; i <= n; i += 2) {
		func_cs[funccs[i]] = strtonum(funccs[i+1])
	}
}
