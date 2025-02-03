vlib work
vlib riviera

vlib riviera/xilinx_vip
vlib riviera/xil_defaultlib
vlib riviera/xpm
vlib riviera/generic_baseblocks_v2_1_0
vlib riviera/axi_infrastructure_v1_1_0
vlib riviera/axi_register_slice_v2_1_19
vlib riviera/fifo_generator_v13_2_4
vlib riviera/axi_data_fifo_v2_1_18
vlib riviera/axi_crossbar_v2_1_20
vlib riviera/lib_cdc_v1_0_2
vlib riviera/lib_pkg_v1_0_2
vlib riviera/lib_fifo_v1_0_13
vlib riviera/blk_mem_gen_v8_4_3
vlib riviera/lib_bmg_v1_0_12
vlib riviera/lib_srl_fifo_v1_0_2
vlib riviera/axi_datamover_v5_1_21
vlib riviera/axi_vdma_v6_3_7
vlib riviera/proc_sys_reset_v5_0_13
vlib riviera/axi_vip_v1_1_5
vlib riviera/processing_system7_vip_v1_0_7
vlib riviera/axi_lite_ipif_v3_0_4
vlib riviera/v_tc_v6_1_13
vlib riviera/v_vid_in_axi4s_v4_0_9
vlib riviera/v_axi4s_vid_out_v4_0_10
vlib riviera/xlconcat_v2_1_3
vlib riviera/xlconstant_v1_1_6
vlib riviera/axi_protocol_converter_v2_1_19
vlib riviera/axi_mmu_v2_1_17

vmap xilinx_vip riviera/xilinx_vip
vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm
vmap generic_baseblocks_v2_1_0 riviera/generic_baseblocks_v2_1_0
vmap axi_infrastructure_v1_1_0 riviera/axi_infrastructure_v1_1_0
vmap axi_register_slice_v2_1_19 riviera/axi_register_slice_v2_1_19
vmap fifo_generator_v13_2_4 riviera/fifo_generator_v13_2_4
vmap axi_data_fifo_v2_1_18 riviera/axi_data_fifo_v2_1_18
vmap axi_crossbar_v2_1_20 riviera/axi_crossbar_v2_1_20
vmap lib_cdc_v1_0_2 riviera/lib_cdc_v1_0_2
vmap lib_pkg_v1_0_2 riviera/lib_pkg_v1_0_2
vmap lib_fifo_v1_0_13 riviera/lib_fifo_v1_0_13
vmap blk_mem_gen_v8_4_3 riviera/blk_mem_gen_v8_4_3
vmap lib_bmg_v1_0_12 riviera/lib_bmg_v1_0_12
vmap lib_srl_fifo_v1_0_2 riviera/lib_srl_fifo_v1_0_2
vmap axi_datamover_v5_1_21 riviera/axi_datamover_v5_1_21
vmap axi_vdma_v6_3_7 riviera/axi_vdma_v6_3_7
vmap proc_sys_reset_v5_0_13 riviera/proc_sys_reset_v5_0_13
vmap axi_vip_v1_1_5 riviera/axi_vip_v1_1_5
vmap processing_system7_vip_v1_0_7 riviera/processing_system7_vip_v1_0_7
vmap axi_lite_ipif_v3_0_4 riviera/axi_lite_ipif_v3_0_4
vmap v_tc_v6_1_13 riviera/v_tc_v6_1_13
vmap v_vid_in_axi4s_v4_0_9 riviera/v_vid_in_axi4s_v4_0_9
vmap v_axi4s_vid_out_v4_0_10 riviera/v_axi4s_vid_out_v4_0_10
vmap xlconcat_v2_1_3 riviera/xlconcat_v2_1_3
vmap xlconstant_v1_1_6 riviera/xlconstant_v1_1_6
vmap axi_protocol_converter_v2_1_19 riviera/axi_protocol_converter_v2_1_19
vmap axi_mmu_v2_1_17 riviera/axi_mmu_v2_1_17

vlog -work xilinx_vip  -sv2k12 "+incdir+/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"/mnt/sda1/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/mnt/sda1/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/mnt/sda1/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/mnt/sda1/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/mnt/sda1/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/mnt/sda1/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/mnt/sda1/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/mnt/sda1/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/mnt/sda1/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec67/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c923" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8c62/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ip/MarsZX2_processing_system7_0_0_2" "+incdir+/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"/tools/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/tools/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"/tools/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"/mnt/sda1/tools/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/MarsZX2/ipshared/4783/hdl/SysId_v1_0_S00_AXI.vhd" \
"../../../bd/MarsZX2/ipshared/4783/hdl/SysId_v1_0.vhd" \
"../../../bd/MarsZX2/ip/MarsZX2_SysId_0_0_2/sim/MarsZX2_SysId_0_0.vhd" \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/3995/hdl/clock_system.vhd" \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/3995/hdl/dvi_encoder.vhd" \
"../../../bd/MarsZX2/ipshared/3995/src/serdes_ddr.vhd" \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/3995/hdl/tmds_encoder.vhd" \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/3995/hdl/Video_IO_2_HDMI_TMDS_v1_0.vhd" \
"../../../bd/MarsZX2/ip/MarsZX2_Video_IO_2_HDMI_TMDS_0_0_2/sim/MarsZX2_Video_IO_2_HDMI_TMDS_0_0.vhd" \

vlog -work generic_baseblocks_v2_1_0  -v2k5 "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec67/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c923" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8c62/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ip/MarsZX2_processing_system7_0_0_2" "+incdir+/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_infrastructure_v1_1_0  -v2k5 "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec67/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c923" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8c62/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ip/MarsZX2_processing_system7_0_0_2" "+incdir+/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_19  -v2k5 "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec67/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c923" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8c62/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ip/MarsZX2_processing_system7_0_0_2" "+incdir+/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/4d88/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work fifo_generator_v13_2_4  -v2k5 "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec67/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c923" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8c62/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ip/MarsZX2_processing_system7_0_0_2" "+incdir+/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/1f5a/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_4 -93 \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/1f5a/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_4  -v2k5 "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec67/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c923" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8c62/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ip/MarsZX2_processing_system7_0_0_2" "+incdir+/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/1f5a/hdl/fifo_generator_v13_2_rfs.v" \

vlog -work axi_data_fifo_v2_1_18  -v2k5 "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec67/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c923" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8c62/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ip/MarsZX2_processing_system7_0_0_2" "+incdir+/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/5b9c/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_20  -v2k5 "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec67/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c923" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8c62/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ip/MarsZX2_processing_system7_0_0_2" "+incdir+/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ace7/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec67/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c923" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8c62/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ip/MarsZX2_processing_system7_0_0_2" "+incdir+/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../bd/MarsZX2/ip/MarsZX2_xbar_0_2/sim/MarsZX2_xbar_0.v" \

vcom -work lib_cdc_v1_0_2 -93 \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work lib_pkg_v1_0_2 -93 \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/0513/hdl/lib_pkg_v1_0_rfs.vhd" \

vcom -work lib_fifo_v1_0_13 -93 \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/4dac/hdl/lib_fifo_v1_0_rfs.vhd" \

vlog -work blk_mem_gen_v8_4_3  -v2k5 "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec67/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c923" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8c62/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ip/MarsZX2_processing_system7_0_0_2" "+incdir+/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c001/simulation/blk_mem_gen_v8_4.v" \

vcom -work lib_bmg_v1_0_12 -93 \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/7268/hdl/lib_bmg_v1_0_rfs.vhd" \

vcom -work lib_srl_fifo_v1_0_2 -93 \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/51ce/hdl/lib_srl_fifo_v1_0_rfs.vhd" \

vcom -work axi_datamover_v5_1_21 -93 \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/e644/hdl/axi_datamover_v5_1_vh_rfs.vhd" \

vlog -work axi_vdma_v6_3_7  -v2k5 "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec67/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c923" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8c62/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ip/MarsZX2_processing_system7_0_0_2" "+incdir+/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl/axi_vdma_v6_3_rfs.v" \

vcom -work axi_vdma_v6_3_7 -93 \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl/axi_vdma_v6_3_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/MarsZX2/ip/MarsZX2_axi_vdma_0_0_2/sim/MarsZX2_axi_vdma_0_0.vhd" \
"../../../bd/MarsZX2/ipshared/4908/src/axis_fb_conv_v1_0.vhd" \
"../../../bd/MarsZX2/ip/MarsZX2_axis_fb_conv_0_0_2/sim/MarsZX2_axis_fb_conv_0_0.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec67/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c923" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8c62/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ip/MarsZX2_processing_system7_0_0_2" "+incdir+/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../bd/MarsZX2/ip/MarsZX2_clk_wiz_1_0/MarsZX2_clk_wiz_1_0_clk_wiz.v" \
"../../../bd/MarsZX2/ip/MarsZX2_clk_wiz_1_0/MarsZX2_clk_wiz_1_0.v" \

vcom -work proc_sys_reset_v5_0_13 -93 \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8842/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/MarsZX2/ip/MarsZX2_proc_sys_reset_0_0_2/sim/MarsZX2_proc_sys_reset_0_0.vhd" \

vlog -work axi_vip_v1_1_5  -sv2k12 "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec67/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c923" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8c62/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ip/MarsZX2_processing_system7_0_0_2" "+incdir+/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/d4a8/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work processing_system7_vip_v1_0_7  -sv2k12 "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec67/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c923" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8c62/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ip/MarsZX2_processing_system7_0_0_2" "+incdir+/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8c62/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec67/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c923" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8c62/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ip/MarsZX2_processing_system7_0_0_2" "+incdir+/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../bd/MarsZX2/ip/MarsZX2_processing_system7_0_0_2/sim/MarsZX2_processing_system7_0_0.v" \

vcom -work axi_lite_ipif_v3_0_4 -93 \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work v_tc_v6_1_13 -93 \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/a92c/hdl/v_tc_v6_1_vh_rfs.vhd" \

vlog -work v_vid_in_axi4s_v4_0_9  -v2k5 "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec67/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c923" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8c62/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ip/MarsZX2_processing_system7_0_0_2" "+incdir+/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/b2aa/hdl/v_vid_in_axi4s_v4_0_vl_rfs.v" \

vlog -work v_axi4s_vid_out_v4_0_10  -v2k5 "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec67/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c923" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8c62/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ip/MarsZX2_processing_system7_0_0_2" "+incdir+/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/a87e/hdl/v_axi4s_vid_out_v4_0_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec67/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c923" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8c62/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ip/MarsZX2_processing_system7_0_0_2" "+incdir+/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../bd/MarsZX2/ip/MarsZX2_v_axi4s_vid_out_0_0_2/sim/MarsZX2_v_axi4s_vid_out_0_0.v" \

vlog -work xlconcat_v2_1_3  -v2k5 "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec67/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c923" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8c62/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ip/MarsZX2_processing_system7_0_0_2" "+incdir+/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/442e/hdl/xlconcat_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec67/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c923" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8c62/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ip/MarsZX2_processing_system7_0_0_2" "+incdir+/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../bd/MarsZX2/ip/MarsZX2_xlconcat_0_0_2/sim/MarsZX2_xlconcat_0_0.v" \

vlog -work xlconstant_v1_1_6  -v2k5 "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec67/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c923" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8c62/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ip/MarsZX2_processing_system7_0_0_2" "+incdir+/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/66e7/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec67/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c923" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8c62/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ip/MarsZX2_processing_system7_0_0_2" "+incdir+/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../bd/MarsZX2/ip/MarsZX2_xlconstant0_1_0_2/sim/MarsZX2_xlconstant0_1_0.v" \

vcom -work xil_defaultlib -93 \
"../../../bd/MarsZX2/ipshared/f14f/hdl/hwclock_v1_0_S00_AXI.vhd" \
"../../../bd/MarsZX2/ipshared/f14f/hdl/hwclock_v1_0.vhd" \
"../../../bd/MarsZX2/ip/MarsZX2_hwclock_0_0_2/sim/MarsZX2_hwclock_0_0.vhd" \
"../../../bd/MarsZX2/ipshared/15fd/src/ltc2358_pkg.vhd" \
"../../../bd/MarsZX2/ipshared/15fd/hdl/ltc2358_v1_0_S00_AXI.vhd" \
"../../../bd/MarsZX2/ipshared/15fd/src/ltc2358clx.vhd" \
"../../../bd/MarsZX2/ipshared/15fd/hdl/ltc2358_v1_0.vhd" \
"../../../bd/MarsZX2/ip/MarsZX2_ltc2358_0_0_2/sim/MarsZX2_ltc2358_0_0.vhd" \
"../../../bd/MarsZX2/ipshared/0c34/hdl/csm_sim_v1_0_S00_AXI.vhd" \
"../../../bd/MarsZX2/ipshared/0c34/src/sadm_det_csm.vhd" \
"../../../bd/MarsZX2/ipshared/0c34/hdl/csm_sim_v1_0.vhd" \
"../../../bd/MarsZX2/ip/MarsZX2_csm_sim_0_0_2/sim/MarsZX2_csm_sim_0_0.vhd" \
"../../../bd/MarsZX2/ipshared/7eeb/hdl/lld_load_v1_0_S00_AXI.vhd" \
"../../../bd/MarsZX2/ipshared/7eeb/hdl/lld_load_v1_0.vhd" \
"../../../bd/MarsZX2/ip/MarsZX2_lld_load_0_0_2/sim/MarsZX2_lld_load_0_0.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec67/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c923" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8c62/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ip/MarsZX2_processing_system7_0_0_2" "+incdir+/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../bd/MarsZX2/ip/MarsZX2_clk_wiz_0_0_1/MarsZX2_clk_wiz_0_0_clk_wiz.v" \
"../../../bd/MarsZX2/ip/MarsZX2_clk_wiz_0_0_1/MarsZX2_clk_wiz_0_0.v" \

vcom -work xil_defaultlib -93 \
"../../../bd/MarsZX2/ip/MarsZX2_v_tc_0_0_1/sim/MarsZX2_v_tc_0_0.vhd" \
"../../../bd/MarsZX2/ipshared/e4b5/hdl/fan_pwm_v1_0_S00_AXI.vhd" \
"../../../bd/MarsZX2/ipshared/e4b5/hdl/fan_pwm_v1_0.vhd" \
"../../../bd/MarsZX2/ip/MarsZX2_fan_pwm_0_0/sim/MarsZX2_fan_pwm_0_0.vhd" \

vlog -work axi_protocol_converter_v2_1_19  -v2k5 "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec67/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c923" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8c62/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ip/MarsZX2_processing_system7_0_0_2" "+incdir+/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c83a/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec67/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c923" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8c62/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ip/MarsZX2_processing_system7_0_0_2" "+incdir+/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../bd/MarsZX2/ip/MarsZX2_auto_pc_0_2/sim/MarsZX2_auto_pc_0.v" \
"../../../bd/MarsZX2/ip/MarsZX2_auto_pc_9/sim/MarsZX2_auto_pc_9.v" \
"../../../bd/MarsZX2/ip/MarsZX2_auto_pc_1_2/sim/MarsZX2_auto_pc_1.v" \
"../../../bd/MarsZX2/ip/MarsZX2_auto_pc_2_2/sim/MarsZX2_auto_pc_2.v" \
"../../../bd/MarsZX2/ip/MarsZX2_auto_pc_3_2/sim/MarsZX2_auto_pc_3.v" \
"../../../bd/MarsZX2/ip/MarsZX2_auto_pc_4_2/sim/MarsZX2_auto_pc_4.v" \
"../../../bd/MarsZX2/ip/MarsZX2_auto_pc_5_2/sim/MarsZX2_auto_pc_5.v" \
"../../../bd/MarsZX2/ip/MarsZX2_auto_pc_6_2/sim/MarsZX2_auto_pc_6.v" \
"../../../bd/MarsZX2/ip/MarsZX2_auto_pc_7_2/sim/MarsZX2_auto_pc_7.v" \
"../../../bd/MarsZX2/ip/MarsZX2_auto_pc_8_2/sim/MarsZX2_auto_pc_8.v" \

vlog -work axi_mmu_v2_1_17  -v2k5 "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec67/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c923" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8c62/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ip/MarsZX2_processing_system7_0_0_2" "+incdir+/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/b5b8/hdl/axi_mmu_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec67/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c923" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8c62/hdl" "+incdir+../../../../PL3232.srcs/sources_1/bd/MarsZX2/ip/MarsZX2_processing_system7_0_0_2" "+incdir+/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/include" \
"../../../bd/MarsZX2/ip/MarsZX2_s00_mmu_0/sim/MarsZX2_s00_mmu_0.v" \

vcom -work xil_defaultlib -93 \
"../../../bd/MarsZX2/sim/MarsZX2.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

