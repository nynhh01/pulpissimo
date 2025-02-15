#################################################################################
# PrimeTime Reference Methodology Script
# Script: pt.tcl
# Version: M-2019.03-SP3 
################################################################################

##################################################################
#    Source common and pt_setup.tcl File                         #
##################################################################

source common/common.tcl

set target_library  {/home/dkits/FreePDK45/NangateOpenCellLibrary_PDKv1_3_v2010_12/Front_End/db/NLDM/NangateOpenCellLibrary_typical.db }
set link_library    {* /home/dkits/FreePDK45/NangateOpenCellLibrary_PDKv1_3_v2010_12/Front_End/db/NLDM/NangateOpenCellLibrary_typical.db  }

set ACTIVITY_FILE "ptpx/scripts_pt/simulation.saif"



##################################################################
#    Search Path, Library and Operating Condition Section        #
##################################################################

  
set power_enable_analysis true 
set power_enable_multi_rail_analysis true 
# set power_analysis_mode time_based 
set power_analysis_mode averaged

set report_default_significant_digits 3 ;
set sh_source_uses_search_path true ;
set search_path ". $search_path" ;


##################################################################
#    Netlist Reading Section                                     #
##################################################################
# set link_path "* $link_path"
read_verilog $REPORT_SYN/cv32e40p_core_netlist.v

current_design $DESIGN_NAME 
link

file mkdir ptpx/reports_pt/results
##################################################################
#    Back Annotation Section                                     #
##################################################################
# if { [info exists PARASITIC_PATHS] && [info exists PARASITIC_FILES] } {
# foreach para_path $PARASITIC_PATHS para_file $PARASITIC_FILES {
#    if {[string compare $para_path $DESIGN_NAME] == 0} {
#       read_parasitics $para_file 
#    } else {
#       read_parasitics -path $para_path $para_file 
#    }
# }
# }



##################################################################
#    Reading Constraints Section                                 #
##################################################################

source -echo -verbose $REPORT_SYN/cv32e40p_core_SDC_OUTPUT_FILE.sdc


##TAG COMMENt: set eco_report_unfixed_reason_max_endpoints for ECO timing(M-2017.06-SP2)



##################################################################
#    Update_timing and check_timing Section                      #
##################################################################

update_timing -full
check_timing -verbose > $REPORT_POWER/${DESIGN_NAME}_check_timing.report



##################################################################
#   Writing an Reduced Resource ECO design                       #
##################################################################
# PrimeTime has the capability to write out an ECO design which 
# is a smaller version of the orginal design ECO can be performed
# with fewer compute resources.
#
# Writes an ECO design  that  preserves  the  specified  violation
# types  compared to those in the original design. You can specify
#  one or more of the following violation types:
#              o setup - Preserves setup timing results.
#              o hold - Preserves hold timing results.
#              o max_transistion - Preserves max_transition results.
#              o max_capacitance - Preserves max_capacitance results.
#              o max_fanout - Preserves max_fanout results.
#              o noise - Preserves noise results.
#              o timing - Preserves setup and hold timing results.
#              o drc  -  Preserves  max_transition,  max_capacitance,  
#                and max fanout results.
# There is also capability to write out specific endpoints with
# the -endpoints options.
#
# In DMSA analyis the RRECO design is written out relative to all
# scenarios enabled for analysis.
# 
# To create a RRECO design the user should perform the following 
# command and include violations types which the user is interested
# in fixing, for example for setup and hold.
# 
# write_eco_design  -type {setup hold} my_RRECO_design
#
# Once the RRECO design is created, the user then would invoke 
# PrimeTIme ECO in a seperate session and access the appropriate
# resourses and then read in the RRECO to perform the ECO
# 
# set_host_options ....
# start_hosts
# read_eco_design my_RRECO_design
# fix_eco...
#
# For more details please see man pages for write_eco_design
# and read_eco design.

##################################################################
#    Report_timing Section                                       #
##################################################################
report_global_timing > $REPORT_POWER/${DESIGN_NAME}_report_global_timing.report
# report_clock -skew -attribute > $REPORT_POWER/${DESIGN_NAME}_report_clock.report 
report_analysis_coverage > $REPORT_POWER/${DESIGN_NAME}_report_analysis_coverage.report
report_timing -slack_lesser_than 0.0 -delay min_max -nosplit -input -net  > $REPORT_POWER/${DESIGN_NAME}_report_timing.report


##################################################################  
#    Power Switching Activity Annotation Section                 #  
##################################################################  
#read_vcd $ACTIVITY_FILE -strip_path $STRIP_PATH         
read_saif $ACTIVITY_FILE         
report_switching_activity -list_not_annotated           

##################################################################
#    Power Analysis Section                                      #
##################################################################

## set power analysis options                                   
# set_power_analysis_options -waveform_format fsdb -waveform_output $REPORT_POWER/wave
# set_power_analysis_options -waveform_output $REPORT_POWER/wave

## run power analysis
check_power   > $REPORT_POWER/${DESIGN_NAME}_check_power.report
update_power  

## report_power
report_power -hier -verbose > $REPORT_POWER/${DESIGN_NAME}_report_power.report
# report_power > $REPORT_POWER/${DESIGN_NAME}_report_power.report

# # Clock Gating & Vth Group Reporting Section
# report_clock_gate_savings  

# Set Vth attribute for each library if not set already
foreach_in_collection l [get_libs] {
        if {[get_attribute [get_lib $l] default_threshold_voltage_group] == ""} {
                set lname [get_object_name [get_lib $l]]
                set_user_attribute [get_lib $l] default_threshold_voltage_group $lname -class lib
        }
}
report_power -threshold_voltage_group > $REPORT_POWER/${DESIGN_NAME}_pwr.per_lib_leakage
report_threshold_voltage_group > $REPORT_POWER/${DESIGN_NAME}_pwr.per_volt_threshold_group


exit










