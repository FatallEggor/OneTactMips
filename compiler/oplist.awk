function rtype(command, regs, op_cs, func_cs){
	$0 = command
	
	op_c = lshift(op_cs[$1], 26)
	#printf "op_c %X\n", op_c
	rs = lshift(regs[$3], 21)
	#printf "rs %s\t%X\t%X\n", $3, regs[$3], rs
	rt = lshift(regs[$4], 16)
	#printf "rt %X\n", rt
	rd = lshift(regs[$2], 11)
	#printf "rd %X\n", rd
	shamt = 0 
	#printf "shamt %X\n", shamt
	func_c = func_cs[$1]
	#printf "func_c %X\n", func_c

	out = or(op_c, rs, rt, rd, shamt, func_c)
	return out
}

function shift(command, regs, op_cs, func_cs){
	$0 = command
	
	op_c = lshift(op_cs[$1], 26)
	#printf "op_c %X\n", op_c
	rs = 0
	#printf "rs %s\t%X\t%X\n", $3, regs[$3], rs
	rt = lshift(regs[$3], 16)
	#printf "rt %X\n", rt
	rd = lshift(regs[$2], 11)
	#printf "rd %X\n", rd
	shamt = lshift(strtonum($4), 6)
	#printf "shamt %X\n", shamt
	func_c = func_cs[$1]
	#printf "func_c %X\n", func_c

	out = or(op_c, rs, rt, rd, shamt, func_c)
	return out
}

function sh_imm(command, regs, op_cs, func_cs){
	$0 = command
	
	op_c = lshift(op_cs[$1], 26)
#	printf "op_c %X\n", op_c
	rs = 0
#	printf "rs %s\t%X\t%X\n", $3, regs[$3], rs
	rt = lshift(regs[$2], 16)
#	printf "rt %X\n", rt
	imm_arg = strtonum($3)
	#printf "imm_ard %X\n", imm_arg

	out = or(op_c, rs, rt, imm_arg)
	return out
}

function imm(command, regs, op_cs, func_cs){
	$0 = command
	
	op_c = lshift(op_cs[$1], 26)
#	printf "op_c %X\n", op_c
	rs = lshift(regs[$2], 21)
#	printf "rs %s\t%X\t%X\n", $3, regs[$3], rs
	rt = lshift(regs[$3], 16)
#	printf "rt %X\n", rt
	imm_arg = strtonum($4)
#	printf "imm_ard %X\n", imm_arg

	out = or(op_c, rs, rt, imm_arg)
	return out
}

function pc_addr(command, regs, op_cs, func_cs){
	$0 = command

	op_c = lshift(op_cs[$1], 26)
#	printf "op_c %X\n", op_c
	rs = lshift(regs[$2], 21)
#	printf "rs %s\t%X\t%X\n", $3, regs[$3], rs
	rt = lshift(regs[$3], 16)
#	printf "rt %X\n", rt
	imm_arg = strtonum($4)
#	printf "imm_ard %X\n", imm_arg

	out = or(op_c, rs, rt, imm_arg)
	return out
}

function imm_addr(command, regs, op_cs, func_cs){
	$0 = command

	op_c = lshift(op_cs[$1], 26)
#	printf "op_c %X\n", op_c
	imm_arg = strtonum($2)
#	printf "imm_ard %X\n", imm_arg

	out = or(op_c, imm_arg)

	return out
}

function bs_addr(command, regs, op_cs, func_cs){
	
	$0 = command
	
	op_c = lshift(op_cs[$1], 26)
#	printf "op_c %X\n", op_c
	rt = lshift(regs[$2], 16)
#	printf "rt %X\t%s\n",rt , $2
	FS_old = FS
	FS = "("
	$0 = $3
	imm_arg = strtonum($1)
#	printf "imm_arg %X\t%s\n", imm_arg, $1

	FS = ")"
	$0 = $2
	rs = lshift(regs[$1], 21)
#	printf "rs %X\t%s\n", rs, $1
	out = or(op_c, rs, rt, imm_arg)

	FS = FS_old
	return out
}
