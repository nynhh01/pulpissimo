#############################################
# SYNTHESIS NO CLOCK GATING
# make syn
#############################################
syn: clean_syn
	dc_shell -f syn/scripts/dc.tcl 2>&1 | tee syn/reports_syn/log/run.log
	rm -rf *.pvk *.svf *.mr *.syn *.pvl 
.PHONY: clean_syn

clean_syn:
	rm -rf syn/reports_syn/results
	rm -rf syn/reports_syn/log/run.log

#############################################
# SYNTHESIS WITH CLOCK GATING (add variable environment USE_CG=1)
# make syn_CG USE_CG=1
#############################################
syn_CG: clean_syn_CG
	dc_shell -f syn/scripts/dc.tcl 2>&1 | tee syn/reports_syn/log/run_CG.log
	rm -rf *.pvk *.svf *.mr *.syn *.pvl 
.PHONY: clean_syn_CG

clean_syn_CG:
	rm -rf syn/reports_syn/results_CG
	rm -rf syn/reports_syn/log/run_CG.log

#############################################
# Power Estimate
# make estimate
#############################################
	
clean_estimate:
	rm -rf scripts/lec/reports_estimate/log/estimate.log
	rm -rf scripts/lec/reports_estimate/results/*.report

estimate: clean_estimate
	pt_shell -f ptpx/scripts_pt/pt.tcl 2>&1 | tee ptpx/reports_pt/log/estimate.log




