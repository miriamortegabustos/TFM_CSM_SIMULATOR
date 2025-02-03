-makelib ies_lib/xilinx_vip -sv \
  "/mnt/sda1/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
  "/mnt/sda1/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
  "/mnt/sda1/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
  "/mnt/sda1/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
  "/mnt/sda1/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
  "/mnt/sda1/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
  "/mnt/sda1/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
  "/mnt/sda1/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
  "/mnt/sda1/tools/Xilinx/Vivado/2019.1/data/xilinx_vip/hdl/rst_vip_if.sv" \
-endlib
-makelib ies_lib/xil_defaultlib -sv \
  "/tools/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "/tools/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
  "/tools/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "/mnt/sda1/tools/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/MarsZX2/ipshared/4783/hdl/SysId_v1_0_S00_AXI.vhd" \
  "../../../bd/MarsZX2/ipshared/4783/hdl/SysId_v1_0.vhd" \
  "../../../bd/MarsZX2/ip/MarsZX2_SysId_0_0_2/sim/MarsZX2_SysId_0_0.vhd" \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/3995/hdl/clock_system.vhd" \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/3995/hdl/dvi_encoder.vhd" \
  "../../../bd/MarsZX2/ipshared/3995/src/serdes_ddr.vhd" \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/3995/hdl/tmds_encoder.vhd" \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/3995/hdl/Video_IO_2_HDMI_TMDS_v1_0.vhd" \
  "../../../bd/MarsZX2/ip/MarsZX2_Video_IO_2_HDMI_TMDS_0_0_2/sim/MarsZX2_Video_IO_2_HDMI_TMDS_0_0.vhd" \
-endlib
-makelib ies_lib/generic_baseblocks_v2_1_0 \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/axi_infrastructure_v1_1_0 \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \
-endlib
-makelib ies_lib/axi_register_slice_v2_1_19 \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/4d88/hdl/axi_register_slice_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/fifo_generator_v13_2_4 \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/1f5a/simulation/fifo_generator_vlog_beh.v" \
-endlib
-makelib ies_lib/fifo_generator_v13_2_4 \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/1f5a/hdl/fifo_generator_v13_2_rfs.vhd" \
-endlib
-makelib ies_lib/fifo_generator_v13_2_4 \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/1f5a/hdl/fifo_generator_v13_2_rfs.v" \
-endlib
-makelib ies_lib/axi_data_fifo_v2_1_18 \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/5b9c/hdl/axi_data_fifo_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/axi_crossbar_v2_1_20 \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ace7/hdl/axi_crossbar_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/MarsZX2/ip/MarsZX2_xbar_0_2/sim/MarsZX2_xbar_0.v" \
-endlib
-makelib ies_lib/lib_cdc_v1_0_2 \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \
-endlib
-makelib ies_lib/lib_pkg_v1_0_2 \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/0513/hdl/lib_pkg_v1_0_rfs.vhd" \
-endlib
-makelib ies_lib/lib_fifo_v1_0_13 \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/4dac/hdl/lib_fifo_v1_0_rfs.vhd" \
-endlib
-makelib ies_lib/blk_mem_gen_v8_4_3 \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c001/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib ies_lib/lib_bmg_v1_0_12 \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/7268/hdl/lib_bmg_v1_0_rfs.vhd" \
-endlib
-makelib ies_lib/lib_srl_fifo_v1_0_2 \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/51ce/hdl/lib_srl_fifo_v1_0_rfs.vhd" \
-endlib
-makelib ies_lib/axi_datamover_v5_1_21 \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/e644/hdl/axi_datamover_v5_1_vh_rfs.vhd" \
-endlib
-makelib ies_lib/axi_vdma_v6_3_7 \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl/axi_vdma_v6_3_rfs.v" \
-endlib
-makelib ies_lib/axi_vdma_v6_3_7 \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/ec9e/hdl/axi_vdma_v6_3_rfs.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/MarsZX2/ip/MarsZX2_axi_vdma_0_0_2/sim/MarsZX2_axi_vdma_0_0.vhd" \
  "../../../bd/MarsZX2/ipshared/4908/src/axis_fb_conv_v1_0.vhd" \
  "../../../bd/MarsZX2/ip/MarsZX2_axis_fb_conv_0_0_2/sim/MarsZX2_axis_fb_conv_0_0.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/MarsZX2/ip/MarsZX2_clk_wiz_1_0/MarsZX2_clk_wiz_1_0_clk_wiz.v" \
  "../../../bd/MarsZX2/ip/MarsZX2_clk_wiz_1_0/MarsZX2_clk_wiz_1_0.v" \
-endlib
-makelib ies_lib/proc_sys_reset_v5_0_13 \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8842/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/MarsZX2/ip/MarsZX2_proc_sys_reset_0_0_2/sim/MarsZX2_proc_sys_reset_0_0.vhd" \
-endlib
-makelib ies_lib/axi_vip_v1_1_5 -sv \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/d4a8/hdl/axi_vip_v1_1_vl_rfs.sv" \
-endlib
-makelib ies_lib/processing_system7_vip_v1_0_7 -sv \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/8c62/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/MarsZX2/ip/MarsZX2_processing_system7_0_0_2/sim/MarsZX2_processing_system7_0_0.v" \
-endlib
-makelib ies_lib/axi_lite_ipif_v3_0_4 \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/v_tc_v6_1_13 \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/a92c/hdl/v_tc_v6_1_vh_rfs.vhd" \
-endlib
-makelib ies_lib/v_vid_in_axi4s_v4_0_9 \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/b2aa/hdl/v_vid_in_axi4s_v4_0_vl_rfs.v" \
-endlib
-makelib ies_lib/v_axi4s_vid_out_v4_0_10 \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/a87e/hdl/v_axi4s_vid_out_v4_0_vl_rfs.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/MarsZX2/ip/MarsZX2_v_axi4s_vid_out_0_0_2/sim/MarsZX2_v_axi4s_vid_out_0_0.v" \
-endlib
-makelib ies_lib/xlconcat_v2_1_3 \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/442e/hdl/xlconcat_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/MarsZX2/ip/MarsZX2_xlconcat_0_0_2/sim/MarsZX2_xlconcat_0_0.v" \
-endlib
-makelib ies_lib/xlconstant_v1_1_6 \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/66e7/hdl/xlconstant_v1_1_vl_rfs.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/MarsZX2/ip/MarsZX2_xlconstant0_1_0_2/sim/MarsZX2_xlconstant0_1_0.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
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
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/MarsZX2/ip/MarsZX2_clk_wiz_0_0_1/MarsZX2_clk_wiz_0_0_clk_wiz.v" \
  "../../../bd/MarsZX2/ip/MarsZX2_clk_wiz_0_0_1/MarsZX2_clk_wiz_0_0.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/MarsZX2/ip/MarsZX2_v_tc_0_0_1/sim/MarsZX2_v_tc_0_0.vhd" \
  "../../../bd/MarsZX2/ipshared/e4b5/hdl/fan_pwm_v1_0_S00_AXI.vhd" \
  "../../../bd/MarsZX2/ipshared/e4b5/hdl/fan_pwm_v1_0.vhd" \
  "../../../bd/MarsZX2/ip/MarsZX2_fan_pwm_0_0/sim/MarsZX2_fan_pwm_0_0.vhd" \
-endlib
-makelib ies_lib/axi_protocol_converter_v2_1_19 \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/c83a/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
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
-endlib
-makelib ies_lib/axi_mmu_v2_1_17 \
  "../../../../PL3232.srcs/sources_1/bd/MarsZX2/ipshared/b5b8/hdl/axi_mmu_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/MarsZX2/ip/MarsZX2_s00_mmu_0/sim/MarsZX2_s00_mmu_0.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/MarsZX2/sim/MarsZX2.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

