#@include "oplist.awk"
#@include "init.awk"

BEGIN	{

	init_regs(regs)
	init_oplist(oplist)
	init_opcodes(op_cs)
	init_funccodes(func_cs)

	i = 0

	while (getline > 0) {
		if (NF > 0)
			if (match($0, /.*:/)) {
				l = length($1)
				brs[substr($1, 1, l-1)] = i  
			} else {
#comments
				i++
				commands[i] = $0
			}

	}

	for (i in commands) {
		$0 = commands[i]
		
		if ($1 in op_cs){
			command = command $1 ","
		}
		else 
			print "unknown operation:", $0
		
		for (j = 2; j <= NF; j++ )
			command = command $j
		
		FS_old = FS
		FS = ","
		$0 = command
		command = ""

		for (j = 1; j <= NF; j++) {
			if ($j in brs) {
				if (oplist[$1] ~ "pc_addr")
					offset = brs[$j] - i
				else
					offset = brs[$j] 

				command = command offset ","
			} else
				command = command $j ","
		}
		commands[i] = command
		command = ""
		FS = FS_old
	}
}

END	{
	FS = ","
	for (a in commands) {
		print commands[a] > "commands.txt"
		$0 = commands[a]
		if ($1 in oplist) {
			
			operation = oplist[$1]
			out = @operation($0, regs, op_cs, func_cs)
			printf "%8X\n", out  | "sed 's/ /0/g'" 
		} else
			print "unknown"

	}

}
