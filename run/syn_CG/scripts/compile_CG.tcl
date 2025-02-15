# these can be also set in .synopsys_dc.setup file in working directory
# always keep the asterisk in link_library
source scripts/lec/synopsys_formality/common.tcl

set target_library  {/home/dkits/FreePDK45/NangateOpenCellLibrary_PDKv1_3_v2010_12/Front_End/db/NLDM/NangateOpenCellLibrary_typical.db }
set link_library    {* /home/dkits/FreePDK45/NangateOpenCellLibrary_PDKv1_3_v2010_12/Front_End/db/NLDM/NangateOpenCellLibrary_typical.db  }

set_clock_gating_enable true
set compile_clock_gating_through_hierarchy true
set_clock_gating_style -sequential_cell latch -control_point before
compile_ultra

analyze -library WORK -format sverilog " \
rtl/include/cv32e40p_apu_core_pkg.sv \
rtl/include/cv32e40p_pkg.sv \
rtl/vendor/pulp_platform_fpnew/src/fpnew_pkg.sv \
rtl/cv32e40p_alu.sv \
rtl/cv32e40p_alu_div.sv \
rtl/cv32e40p_aligner.sv \
rtl/cv32e40p_compressed_decoder.sv \
rtl/cv32e40p_controller.sv \
rtl/cv32e40p_cs_registers.sv \
rtl/cv32e40p_decoder.sv \
rtl/cv32e40p_int_controller.sv \
rtl/cv32e40p_ex_stage.sv \
rtl/cv32e40p_fifo.sv \
rtl/cv32e40p_hwloop_regs.sv \
rtl/cv32e40p_id_stage.sv \
rtl/cv32e40p_if_stage.sv \
rtl/cv32e40p_load_store_unit.sv \
rtl/cv32e40p_mult.sv \
rtl/cv32e40p_prefetch_buffer.sv \
rtl/cv32e40p_prefetch_controller.sv \
rtl/cv32e40p_obi_interface.sv \
rtl/cv32e40p_core.sv \
rtl/cv32e40p_apu_disp.sv \
rtl/cv32e40p_popcnt.sv \
rtl/cv32e40p_ff_one.sv \
rtl/cv32e40p_sleep_unit.sv \
rtl/cv32e40p_register_file_latch.sv \
"

elaborate ${DESIGN_NAME} -library WORK
link
check_design
source -echo -verbose constraints/cv32e40p_core.sdc
compile -exact_map


report_timing > ${REPORT_CG}/${DESIGN_NAME}_timing_reports.log
report_qor > ${REPORT_CG}/${DESIGN_NAME}_qor_reports.log
report_area -hierarchy  > ${REPORT_CG}/${DESIGN_NAME}_area_reports.log
report_power -hierarchy > ${REPORT_CG}/${DESIGN_NAME}_power_reports.log
report_clock_gating -nosplit> ${REPORT_CG}/${DESIGN_NAME}_CG_reports.log

change_names -rule sverilog
write -hierarchy -format verilog -output ${REPORT_CG}/${DESIGN_NAME}_netlist.v
write -hierarchy -format ddc  -output ${REPORT_CG}/${DESIGN_NAME}_compiled.ddc

write_sdc -nosplit ${REPORT_CG}/${DCRM_FINAL_SDC_OUTPUT_FILE}
write_sdf ${REPORT_CG}/${DCRM_DCT_FINAL_SDF_OUTPUT_FILE}
saif_map -type ptpx -write_map ${REPORT_CG}/${DESIGN_NAME}.mapped.SAIF.namemap


exit