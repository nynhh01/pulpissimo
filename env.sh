export PROJECT_DIR=`pwd`

export PULP_RISCV_GCC_TOOLCHAIN=/home/tools/riscv/pulp/pulp-gcc-2.5.0
export PATH=$PULP_RISCV_GCC_TOOLCHAIN/bin:$PATH
export PATH=/home/tools/mentor/questasim/2022.2/questasim/bin:$PATH
# export VSIM_PATH=${PROJECT_DIR}/sim
export PATH=$PATH:/usr/bin/python/
export PATH=/home/tools/xilinx/Vivado/2021.2/bin:$PATH

source /home/tools/mentor/env.sh
source /home/tools/synopsys/env.sh
source sw/pulp-runtime/configs/pulpissimo_cv32.sh

export RUN_DIR=${PROJECT_DIR}/run
export VSIM_PATH=${PROJECT_DIR}/build/questasim
export VSIM="vsim"

export USE_CG=$0
export POST_SYN=$0


