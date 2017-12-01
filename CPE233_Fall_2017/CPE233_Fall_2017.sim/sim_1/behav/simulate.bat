@echo off
set xv_path=C:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xsim tb_RAT_wrapper_behav -key {Behavioral:sim_1:Functional:tb_RAT_wrapper} -tclbatch tb_RAT_wrapper.tcl -view C:/Users/afergu06/Documents/GitHub/RAT_MCU/CPE233_Fall_2017/RAT_wrapper_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
