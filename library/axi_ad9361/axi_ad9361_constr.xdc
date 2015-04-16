set up_clk [get_clocks -of_objects [get_ports s_axi_aclk]]
set ad9361_clk [get_clocks -of_objects [get_ports clk]]

set_false_path \
	-from [get_cells -hier up_xfer_toggle_reg* -filter {primitive_subgroup == flop}] \
	-to [get_cells -hier d_xfer_toggle_m1_reg* -filter {primitive_subgroup == flop}]
set_false_path \
	-from [get_cells -hier d_xfer_toggle_reg* -filter {primitive_subgroup == flop}] \
	-to [get_cells -hier up_xfer_state_m1_reg* -filter {primitive_subgroup == flop}]
set_max_delay \
	-from [get_cells -hier up_xfer_data_reg* -filter {primitive_subgroup == flop}] \
	-to [get_cells -hier d_data_cntrl_reg* -filter {primitive_subgroup == flop}] \
	[get_property PERIOD $ad9361_clk]

set_false_path \
	-from [get_cells -hier d_xfer_toggle_reg* -filter {primitive_subgroup == flop}] \
	-to [get_cells -hier up_xfer_toggle_m1_reg* -filter {primitive_subgroup == flop}]
set_false_path \
	-from [get_cells -hier up_xfer_toggle_reg* -filter {primitive_subgroup == flop}] \
	-to [get_cells -hier d_xfer_state_m1_reg* -filter {primitive_subgroup == flop}]
set_max_delay \
	-from [get_cells -hier d_xfer_data_reg* -filter {primitive_subgroup == flop}] \
	-to [get_cells -hier up_data_status_reg* -filter {primitive_subgroup == flop}] \
	[get_property PERIOD $up_clk]

set_false_path \
	-from [get_cells -hier up_count_toggle_reg* -filter {primitive_subgroup == flop}] \
	-to [get_cells -hier d_count_toggle_m1_reg* -filter {primitive_subgroup == flop}]
set_false_path \
	-from [get_cells -hier d_count_toggle_reg* -filter {primitive_subgroup == flop}] \
	-to [get_cells -hier up_count_toggle_m1_reg* -filter {primitive_subgroup == flop}]
set_max_delay \
	-from [get_cells -hier d_count_hold_reg* -filter {primitive_subgroup == flop}] \
	-to [get_cells -hier up_d_count_reg* -filter {primitive_subgroup == flop}] \
	[get_property PERIOD $up_clk]

set_false_path \
	-to [get_pins -hier */PRE -filter {NAME =~ *i_*rst_reg*}]