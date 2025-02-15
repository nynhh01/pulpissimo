# these can be also set in .synopsys_dc.setup file in working directory
# always keep the asterisk in link_library
source scripts/lec/synopsys_formality/common.tcl

set target_library  {/home/dkits/FreePDK45/NangateOpenCellLibrary_PDKv1_3_v2010_12/Front_End/db/NLDM/NangateOpenCellLibrary_typical.db }
set link_library    {* /home/dkits/FreePDK45/NangateOpenCellLibrary_PDKv1_3_v2010_12/Front_End/db/NLDM/NangateOpenCellLibrary_typical.db  }

# Lấy danh sách tất cả các file package include/*.sv 
set files [glob -nocomplain rtl/include/*.sv]
# Kết hợp danh sách file thành chuỗi cho lệnh analyze
set file_list [join $files " "]

##################
# Lấy danh sách tất cả các file RTL .sv 
set file_rtls [glob -nocomplain rtl/*.sv]
# Kết hợp danh sách file thành chuỗi cho lệnh analyze
set file_list_rtl [join $file_rtls " "]
#######################
#Lấy các file rtl/vendor/pulp_platform_common_cells
# set file_common_cell_svh rtl/vendor/pulp_platform_common_cells/include/common_cells/assertions.svh
# set file_common_cell_src [glob -nocomplain rtl/vendor/pulp_platform_common_cells/src/*.sv]
# set file_common_cell_src_deper [glob -nocomplain rtl/vendor/pulp_platform_common_cells/src/deprecated/*.sv]
#



###################################
set files_fnew [glob -nocomplain rtl/vendor/pulp_platform_fpnew/src/fpnew_pkg.sv]
#



set combined_files "$files_fnew $file_list $file_list_rtl "

analyze -library WORK -format sverilog " \
$combined_files  \

"

elaborate ${DESIGN_NAME} -library WORK
link
check_design
source -echo -verbose constraints/cv32e40p_core.sdc
compile -exact_map

report_timing > scripts/lec/reports_syn/results/${DESIGN_NAME}_timing_reports.log
report_qor > scripts/lec/reports_syn/results/${DESIGN_NAME}_qor_reports.log
report_area -hierarchy  > scripts/lec/reports_syn/results/${DESIGN_NAME}_area_reports.log
report_power -hierarchy > scripts/lec/reports_syn/results/${DESIGN_NAME}_power_reports.log

change_names -rule sverilog
write -hierarchy -format verilog -output scripts/lec/reports_syn/results/${DESIGN_NAME}_netlist.v
write -hierarchy -format ddc  -output scripts/lec/reports_syn/results/${DESIGN_NAME}_compiled.ddc

exit