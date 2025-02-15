# these can be also set in .synopsys_dc.setup file in working directory
# always keep the asterisk in link_library
source syn/scripts/setup/common_setup.tcl

set target_library  {/home/dkits/FreePDK45/NangateOpenCellLibrary_PDKv1_3_v2010_12/Front_End/db/NLDM/NangateOpenCellLibrary_typical.db }
set link_library    {* /home/dkits/FreePDK45/NangateOpenCellLibrary_PDKv1_3_v2010_12/Front_End/db/NLDM/NangateOpenCellLibrary_typical.db  }

analyze -library WORK -format sverilog " \
$RTL_DIR/include/cv32e40p_apu_core_pkg.sv \
$RTL_DIR/include/cv32e40p_pkg.sv \
$RTL_DIR/vendor/pulp_platform_fpnew/src/fpnew_pkg.sv \
$RTL_DIR/cv32e40p_alu.sv \
$RTL_DIR/cv32e40p_alu_div.sv \
$RTL_DIR/cv32e40p_aligner.sv \
$RTL_DIR/cv32e40p_compressed_decoder.sv \
$RTL_DIR/cv32e40p_controller.sv \
$RTL_DIR/cv32e40p_cs_registers.sv \
$RTL_DIR/cv32e40p_decoder.sv \
$RTL_DIR/cv32e40p_int_controller.sv \
$RTL_DIR/cv32e40p_ex_stage.sv \
$RTL_DIR/cv32e40p_fifo.sv \
$RTL_DIR/cv32e40p_hwloop_regs.sv \
$RTL_DIR/cv32e40p_id_stage.sv \
$RTL_DIR/cv32e40p_if_stage.sv \
$RTL_DIR/cv32e40p_load_store_unit.sv \
$RTL_DIR/cv32e40p_mult.sv \
$RTL_DIR/cv32e40p_prefetch_buffer.sv \
$RTL_DIR/cv32e40p_prefetch_controller.sv \
$RTL_DIR/cv32e40p_obi_interface.sv \
$RTL_DIR/cv32e40p_core.sv \
$RTL_DIR/cv32e40p_apu_disp.sv \
$RTL_DIR/cv32e40p_popcnt.sv \
$RTL_DIR/cv32e40p_ff_one.sv \
$RTL_DIR/cv32e40p_sleep_unit.sv \
$RTL_DIR/cv32e40p_register_file_latch.sv \
"

elaborate ${DESIGN_NAME} -library WORK
link
check_design
source -echo -verbose ${CONSTRAINTS_DIR}/cv32e40p_core.sdc
# compile -exact_map


if {$USE_CG == 1} {
    set_clock_gating_style -sequential_cell latch -control_point before 
    set compile_clock_gating_through_hierarchy true
}

set_dynamic_optimization true


if {$USE_CG == 1} {
    compile_ultra -incremental -gate_clock -scan
    file mkdir syn/reports_syn/results_CG
    report_timing -transition_time -nets -attributes -nosplit > ${REPORT_SYN_CG}/${DESIGN_NAME}_timing_reports.log
    report_qor > ${REPORT_SYN_CG}/${DESIGN_NAME}_qor_reports.log
    report_area -hierarchy  > ${REPORT_SYN_CG}/${DESIGN_NAME}_area_reports.log
    report_power -hierarchy > ${REPORT_SYN_CG}/${DESIGN_NAME}_power_reports.log
    report_clock_gating -multi_stage -nosplit > ${REPORT_SYN_CG}/${DESIGN_NAME}_CLOCK_GATES_REPORT.log

    change_names -rule sverilog
    write -hierarchy -format verilog -output ${REPORT_SYN_CG}/${DESIGN_NAME}_netlist.v
    write -hierarchy -format ddc  -output ${REPORT_SYN_CG}/${DESIGN_NAME}_compiled.ddc

    write_sdc -nosplit ${REPORT_SYN_CG}/${DESIGN_NAME}_SDC_OUTPUT_FILE.sdc
    write_sdf ${REPORT_SYN_CG}/${DESIGN_NAME}_SDF_OUTPUT_FILE.sdf
    saif_map -type ptpx -write_map ${REPORT_SYN_CG}/${DESIGN_NAME}.mapped.SAIF.namemap
} else {
    compile -exact_map
    file mkdir syn/reports_syn/results
    report_timing -transition_time -nets -attributes -nosplit > ${REPORT_SYN}/${DESIGN_NAME}_timing_reports.log
    report_qor > ${REPORT_SYN}/${DESIGN_NAME}_qor_reports.log
    report_area -hierarchy  > ${REPORT_SYN}/${DESIGN_NAME}_area_reports.log
    report_power -hierarchy > ${REPORT_SYN}/${DESIGN_NAME}_power_reports.log

    change_names -rule sverilog
    write -hierarchy -format verilog -output ${REPORT_SYN}/${DESIGN_NAME}_netlist.v
    write -hierarchy -format ddc  -output ${REPORT_SYN}/${DESIGN_NAME}_compiled.ddc

    write_sdc -nosplit ${REPORT_SYN}/${DESIGN_NAME}_SDC_OUTPUT_FILE.sdc
    write_sdf ${REPORT_SYN}/${DESIGN_NAME}_SDF_OUTPUT_FILE.sdf
    saif_map -type ptpx -write_map ${REPORT_SYN}/${DESIGN_NAME}.mapped.SAIF.namemap
}

exit