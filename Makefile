# Makefile for Xilinx Spartan-3A/AN ISE/Webpack toolkit
#
# This makefile simplifies a life of FPGA developer by reducing build
# configuration to the list of source files and top entity name. 
#
# Grigoriy A. Sitkarev, <sitkarev@unixkomi.ru>
#

project         = cpu
top-entity	= cpu
platform	= xc3s700an-fgg484
sources		= adder.v aludec.v alu.v contr.v cpu_tb.v cpu.v data_mem_tb.v maindec.v mux2to1.v PC.v pc_val_mux.v ram.v reg_file.v rom2.v sign_ext.v

# STOP EDITING HERE

project-file	= $(project).prj
constraint-file	= $(project).ucf

.PHONY: clean

all: $(project).ngc

bitstream: $(project).bit

# This rule generates project file from the list of sources.
$(project-file): $(sources)
	@echo "generating project file \`$(project-file)' from list of sources: $(sources)"
	@rm -rf $(project-file)
	@touch $(project-file)
	@for file in $(sources); do \
	  case `echo $${file} | sed -n -e 's|^.*\(\..*\)$$|\1|p'` in \
	  .vhd|.vhdl) \
	    type="vhdl" \
	    ;; \
	  .verilog|.v) \
	    type="verilog" \
	    ;; \
	  *) \
	    echo "warning: excluding unknown file type \`$${file}'"; \
	    type="" \
	    ;; \
	  esac; \
	  test -z $${type} || echo "$${type} work \"$${file}\"" >> $(project-file); \
	done

$(project).ngc: $(project-file)
	echo "run -ifn $(project-file) -top $(top-entity) -compileonly no \
	     -ofn $(project) -p $(platform) -opt_mode Speed -opt_level 1" | xst

$(project).ngd: $(project).ngc $(constraint-file)
	ngdbuild -dd _ngo -nt timestamp -uc $(constraint-file) -p $(platform) $< $@

$(project).ncd: $(project).ngd
	map -p $(platform) -detail -c 100 -ir off -pr off $<

$(project).pcf: $(project).ngd
	map -p $(platform) -detail -c 100 -ir off -pr off $<

$(project)-par.ncd: $(project).ncd
	par -w $< $@ $(project).pcf
	

$(project).bit: $(project)-par.ncd
	bitgen -w -g DebugBitstream:No -g Binary:no \
	  -g CRC:Enable -g Reset_on_err:No -g ConfigRate:25 \
	  -g ProgPin:PullUp -g DonePin:PullUp -g TckPin:PullUp \
	  -g TdiPin:PullUp -g TdoPin:PullUp -g TmsPin:PullUp \
	  -g UnusedPin:PullDown -g UserID:0xFFFFFFFF -g StartUpClk:CClk \
	  -g DONE_cycle:4 -g GTS_cycle:5 -g GWE_cycle:6 \
	  -g LCK_cycle:NoWait -g Security:None -g DonePipe:Yes \
	  -g DriveDone:No -g en_sw_gsr:No -g en_porb:Yes -g drive_awake:No \
	  -g sw_clk:Startupclk -g sw_gwe_cycle:5 -g sw_gts_cycle:4 \
	  $< $@ $(project).pcf
		
install-fpga: $(project).bit
	echo -n "setmode -bs\n"\
	"setcable -p auto\n"\
	"identify\n"\
	"assignfile -p 1 -file $(project).bit\n"\
	"program -p 1 -onlyFpga\n" | impact -batch

install-flash: $(project).bit
	echo -n "setmode -bs\n"\
	"setcable -p auto\n"\
	"identify\n"\
	"assignfile -p 1 -file $(project).bit\n"\
	"program -p 1 -e -v\n" | impact -batch

