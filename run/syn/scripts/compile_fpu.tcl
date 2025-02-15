# these can be also set in .synopsys_dc.setup file in working directory
# always keep the asterisk in link_library
source scripts/lec/synopsys_formality/common.tcl

set target_library  {/home/dkits/FreePDK45/NangateOpenCellLibrary_PDKv1_3_v2010_12/Front_End/db/NLDM/NangateOpenCellLibrary_typical.db }
set link_library    {* /home/dkits/FreePDK45/NangateOpenCellLibrary_PDKv1_3_v2010_12/Front_End/db/NLDM/NangateOpenCellLibrary_typical.db  }

analyze -library WORK -format sverilog " \

rtl/vendor/pulp_platform_common_cells/include/common_cells/registers.svh \
rtl/vendor/pulp_platform_common_cells/include/common_cells/assertions.svh \
rtl/vendor/pulp_platform_common_cells/src/binary_to_gray.sv \
rtl/vendor/pulp_platform_common_cells/src/cb_filter_pkg.sv \
rtl/vendor/pulp_platform_common_cells/src/cdc_2phase.sv \
rtl/vendor/pulp_platform_common_cells/src/cf_math_pkg.sv \
rtl/vendor/pulp_platform_common_cells/src/clk_div.sv \
rtl/vendor/pulp_platform_common_cells/src/delta_counter.sv \
rtl/vendor/pulp_platform_common_cells/src/ecc_pkg.sv \
rtl/vendor/pulp_platform_common_cells/src/edge_propagator_tx.sv \
rtl/vendor/pulp_platform_common_cells/src/exp_backoff.sv \
rtl/vendor/pulp_platform_common_cells/src/fifo_v3.sv \
rtl/vendor/pulp_platform_common_cells/src/gray_to_binary.sv \
rtl/vendor/pulp_platform_common_cells/src/isochronous_spill_register.sv \
rtl/vendor/pulp_platform_common_cells/src/lfsr.sv \
rtl/vendor/pulp_platform_common_cells/src/lfsr_16bit.sv \
rtl/vendor/pulp_platform_common_cells/src/lfsr_8bit.sv \
rtl/vendor/pulp_platform_common_cells/src/mv_filter.sv \
rtl/vendor/pulp_platform_common_cells/src/onehot_to_bin.sv \
rtl/vendor/pulp_platform_common_cells/src/plru_tree.sv \
rtl/vendor/pulp_platform_common_cells/src/popcount.sv \
rtl/vendor/pulp_platform_common_cells/src/rr_arb_tree.sv \
rtl/vendor/pulp_platform_common_cells/src/rstgen_bypass.sv \
rtl/vendor/pulp_platform_common_cells/src/serial_deglitch.sv \
rtl/vendor/pulp_platform_common_cells/src/shift_reg.sv \
rtl/vendor/pulp_platform_common_cells/src/spill_register.sv \
rtl/vendor/pulp_platform_common_cells/src/stream_demux.sv \
rtl/vendor/pulp_platform_common_cells/src/stream_filter.sv \
rtl/vendor/pulp_platform_common_cells/src/stream_fork.sv \
rtl/vendor/pulp_platform_common_cells/src/stream_intf.sv \
rtl/vendor/pulp_platform_common_cells/src/stream_join.sv \
rtl/vendor/pulp_platform_common_cells/src/stream_mux.sv \
rtl/vendor/pulp_platform_common_cells/src/sub_per_hash.sv \
rtl/vendor/pulp_platform_common_cells/src/sync.sv \
rtl/vendor/pulp_platform_common_cells/src/sync_wedge.sv \
rtl/vendor/pulp_platform_common_cells/src/unread.sv \
rtl/vendor/pulp_platform_common_cells/src/addr_decode.sv \
rtl/vendor/pulp_platform_common_cells/src/cb_filter.sv \
rtl/vendor/pulp_platform_common_cells/src/cdc_fifo_2phase.sv \
rtl/vendor/pulp_platform_common_cells/src/cdc_fifo_gray.sv \
rtl/vendor/pulp_platform_common_cells/src/counter.sv \
rtl/vendor/pulp_platform_common_cells/src/ecc_decode.sv \
rtl/vendor/pulp_platform_common_cells/src/ecc_encode.sv \
rtl/vendor/pulp_platform_common_cells/src/edge_detect.sv \
rtl/vendor/pulp_platform_common_cells/src/lzc.sv \
rtl/vendor/pulp_platform_common_cells/src/max_counter.sv \
rtl/vendor/pulp_platform_common_cells/src/rstgen.sv \
rtl/vendor/pulp_platform_common_cells/src/stream_delay.sv \
rtl/vendor/pulp_platform_common_cells/src/stream_fifo.sv \
rtl/vendor/pulp_platform_common_cells/src/stream_fork_dynamic.sv \
rtl/vendor/pulp_platform_common_cells/src/stream_xbar.sv \
rtl/vendor/pulp_platform_common_cells/src/fall_through_register.sv \
rtl/vendor/pulp_platform_common_cells/src/id_queue.sv \
rtl/vendor/pulp_platform_common_cells/src/stream_to_mem.sv \
rtl/vendor/pulp_platform_common_cells/src/stream_arbiter_flushable.sv \
rtl/vendor/pulp_platform_common_cells/src/stream_omega_net.sv \
rtl/vendor/pulp_platform_common_cells/src/stream_register.sv \
rtl/vendor/pulp_platform_common_cells/src/stream_arbiter.sv \
rtl/vendor/pulp_platform_common_cells/src/deprecated/clock_divider_counter.sv \
rtl/vendor/pulp_platform_common_cells/src/deprecated/find_first_one.sv \
rtl/vendor/pulp_platform_common_cells/src/deprecated/generic_LFSR_8bit.sv \
rtl/vendor/pulp_platform_common_cells/src/deprecated/generic_fifo.sv \
rtl/vendor/pulp_platform_common_cells/src/deprecated/prioarbiter.sv \
rtl/vendor/pulp_platform_common_cells/src/deprecated/pulp_sync.sv \
rtl/vendor/pulp_platform_common_cells/src/deprecated/pulp_sync_wedge.sv \
rtl/vendor/pulp_platform_common_cells/src/deprecated/rrarbiter.sv \
rtl/vendor/pulp_platform_common_cells/src/deprecated/clock_divider.sv \
rtl/vendor/pulp_platform_common_cells/src/deprecated/fifo_v2.sv \
rtl/vendor/pulp_platform_common_cells/src/deprecated/fifo_v1.sv \
rtl/vendor/pulp_platform_common_cells/src/edge_propagator.sv \
rtl/vendor/pulp_platform_common_cells/src/edge_propagator_rx.sv \

rtl/vendor/pulp_platform_fpu_div_sqrt_mvp/hdl/defs_div_sqrt_mvp.sv \
rtl/vendor/pulp_platform_fpu_div_sqrt_mvp/hdl/div_sqrt_mvp_wrapper.sv \
rtl/vendor/pulp_platform_fpu_div_sqrt_mvp/hdl/div_sqrt_top_mvp.sv \
rtl/vendor/pulp_platform_fpu_div_sqrt_mvp/hdl/control_mvp.sv \
rtl/vendor/pulp_platform_fpu_div_sqrt_mvp/hdl/iteration_div_sqrt_mvp.sv \
rtl/vendor/pulp_platform_fpu_div_sqrt_mvp/hdl/norm_div_sqrt_mvp.sv \
rtl/vendor/pulp_platform_fpu_div_sqrt_mvp/hdl/nrbd_nrsc_mvp.sv \
rtl/vendor/pulp_platform_fpu_div_sqrt_mvp/hdl/preprocess_mvp.sv \


rtl/vendor/pulp_platform_fpnew/src/fpnew_pkg.sv \
rtl/vendor/pulp_platform_fpnew/src/fpnew_cast_multi.sv \
rtl/vendor/pulp_platform_fpnew/src/fpnew_classifier.sv \
rtl/vendor/pulp_platform_fpnew/src/fpnew_divsqrt_multi.sv \
rtl/vendor/pulp_platform_fpnew/src/fpnew_fma.sv \
rtl/vendor/pulp_platform_fpnew/src/fpnew_fma_multi.sv \
rtl/vendor/pulp_platform_fpnew/src/fpnew_noncomp.sv \
rtl/vendor/pulp_platform_fpnew/src/fpnew_opgroup_block.sv \
rtl/vendor/pulp_platform_fpnew/src/fpnew_opgroup_fmt_slice.sv \
rtl/vendor/pulp_platform_fpnew/src/fpnew_opgroup_multifmt_slice.sv \
rtl/vendor/pulp_platform_fpnew/src/fpnew_rounding.sv \
rtl/vendor/pulp_platform_fpnew/src/fpnew_top.sv \

rtl/include/cv32e40p_apu_core_pkg.sv \
rtl/include/cv32e40p_pkg.sv \
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

bhv/cv32e40p_instr_trace.svh \
bhv/include/cv32e40p_tracer_pkg.sv \
bhv/cv32e40p_wrapper.sv \

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

write_sdc -nosplit ${REPORT}/${DCRM_FINAL_SDC_OUTPUT_FILE}
write_sdf ${REPORT}/${DCRM_DCT_FINAL_SDF_OUTPUT_FILE}
saif_map -type ptpx -write_map ${REPORT}/${DESIGN_NAME}.mapped.SAIF.namemap

exit