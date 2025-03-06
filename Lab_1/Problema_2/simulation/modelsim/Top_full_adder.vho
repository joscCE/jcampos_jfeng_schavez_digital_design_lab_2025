-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"

-- DATE "03/05/2025 22:38:43"

-- 
-- Device: Altera 5CSXFC6D6F31C6 Package FBGA896
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	Top_full_adder IS
    PORT (
	a : IN std_logic_vector(3 DOWNTO 0);
	b : IN std_logic_vector(3 DOWNTO 0);
	cin : IN std_logic;
	seg0 : BUFFER std_logic_vector(7 DOWNTO 0);
	seg1 : BUFFER std_logic_vector(7 DOWNTO 0);
	cout : BUFFER std_logic
	);
END Top_full_adder;

-- Design Ports Information
-- seg0[0]	=>  Location: PIN_AD27,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: 2mA
-- seg0[1]	=>  Location: PIN_AH18,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: 2mA
-- seg0[2]	=>  Location: PIN_AG18,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: 2mA
-- seg0[3]	=>  Location: PIN_AH17,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: 2mA
-- seg0[4]	=>  Location: PIN_AG16,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: 2mA
-- seg0[5]	=>  Location: PIN_AG17,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: 2mA
-- seg0[6]	=>  Location: PIN_V18,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: 2mA
-- seg0[7]	=>  Location: PIN_W17,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: 2mA
-- seg1[0]	=>  Location: PIN_F15,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: 2mA
-- seg1[1]	=>  Location: PIN_V17,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: 2mA
-- seg1[2]	=>  Location: PIN_AE17,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: 2mA
-- seg1[3]	=>  Location: PIN_AE18,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: 2mA
-- seg1[4]	=>  Location: PIN_AD17,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: 2mA
-- seg1[5]	=>  Location: PIN_AE16,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: 2mA
-- seg1[6]	=>  Location: PIN_V16,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: 2mA
-- seg1[7]	=>  Location: PIN_AF16,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: 2mA
-- cout	=>  Location: PIN_AK24,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: 2mA
-- cin	=>  Location: PIN_Y18,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: Default
-- a[0]	=>  Location: PIN_AB30,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: Default
-- b[0]	=>  Location: PIN_AC28,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: Default
-- a[1]	=>  Location: PIN_Y27,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: Default
-- b[1]	=>  Location: PIN_AD30,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: Default
-- a[2]	=>  Location: PIN_AB28,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: Default
-- b[2]	=>  Location: PIN_AC29,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: Default
-- a[3]	=>  Location: PIN_AC30,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: Default
-- b[3]	=>  Location: PIN_AA30,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: Default


ARCHITECTURE structure OF Top_full_adder IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_a : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_b : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_cin : std_logic;
SIGNAL ww_seg0 : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_seg1 : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_cout : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \a[0]~input_o\ : std_logic;
SIGNAL \b[0]~input_o\ : std_logic;
SIGNAL \cin~input_o\ : std_logic;
SIGNAL \FA0|s~combout\ : std_logic;
SIGNAL \b[3]~input_o\ : std_logic;
SIGNAL \a[3]~input_o\ : std_logic;
SIGNAL \FA3|p~combout\ : std_logic;
SIGNAL \a[1]~input_o\ : std_logic;
SIGNAL \b[1]~input_o\ : std_logic;
SIGNAL \FA1|s~combout\ : std_logic;
SIGNAL \b[2]~input_o\ : std_logic;
SIGNAL \FA1|cout~combout\ : std_logic;
SIGNAL \a[2]~input_o\ : std_logic;
SIGNAL \decoder_inst|seg_decoder|seg0_internal[1]~0_combout\ : std_logic;
SIGNAL \decoder_inst|seg_decoder|seg0_internal[2]~1_combout\ : std_logic;
SIGNAL \decoder_inst|seg_decoder|seg0_internal[3]~2_combout\ : std_logic;
SIGNAL \decoder_inst|seg_decoder|seg0_internal[4]~3_combout\ : std_logic;
SIGNAL \decoder_inst|bdc_decoder|y1[0]~0_combout\ : std_logic;
SIGNAL \FA3|cout~combout\ : std_logic;
SIGNAL \decoder_inst|seg_decoder|seg0_internal\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \ALT_INV_b[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_a[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_b[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_a[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_b[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_a[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_b[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_a[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_cin~input_o\ : std_logic;
SIGNAL \decoder_inst|seg_decoder|ALT_INV_seg0_internal\ : std_logic_vector(7 DOWNTO 5);
SIGNAL \decoder_inst|seg_decoder|ALT_INV_seg0_internal[4]~3_combout\ : std_logic;
SIGNAL \decoder_inst|seg_decoder|ALT_INV_seg0_internal[3]~2_combout\ : std_logic;
SIGNAL \decoder_inst|seg_decoder|ALT_INV_seg0_internal[2]~1_combout\ : std_logic;
SIGNAL \decoder_inst|seg_decoder|ALT_INV_seg0_internal[1]~0_combout\ : std_logic;
SIGNAL \FA3|ALT_INV_p~combout\ : std_logic;
SIGNAL \FA1|ALT_INV_cout~combout\ : std_logic;
SIGNAL \FA1|ALT_INV_s~combout\ : std_logic;
SIGNAL \FA0|ALT_INV_s~combout\ : std_logic;

BEGIN

ww_a <= a;
ww_b <= b;
ww_cin <= cin;
seg0 <= ww_seg0;
seg1 <= ww_seg1;
cout <= ww_cout;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_b[3]~input_o\ <= NOT \b[3]~input_o\;
\ALT_INV_a[3]~input_o\ <= NOT \a[3]~input_o\;
\ALT_INV_b[2]~input_o\ <= NOT \b[2]~input_o\;
\ALT_INV_a[2]~input_o\ <= NOT \a[2]~input_o\;
\ALT_INV_b[1]~input_o\ <= NOT \b[1]~input_o\;
\ALT_INV_a[1]~input_o\ <= NOT \a[1]~input_o\;
\ALT_INV_b[0]~input_o\ <= NOT \b[0]~input_o\;
\ALT_INV_a[0]~input_o\ <= NOT \a[0]~input_o\;
\ALT_INV_cin~input_o\ <= NOT \cin~input_o\;
\decoder_inst|seg_decoder|ALT_INV_seg0_internal\(7) <= NOT \decoder_inst|seg_decoder|seg0_internal\(7);
\decoder_inst|seg_decoder|ALT_INV_seg0_internal\(6) <= NOT \decoder_inst|seg_decoder|seg0_internal\(6);
\decoder_inst|seg_decoder|ALT_INV_seg0_internal\(5) <= NOT \decoder_inst|seg_decoder|seg0_internal\(5);
\decoder_inst|seg_decoder|ALT_INV_seg0_internal[4]~3_combout\ <= NOT \decoder_inst|seg_decoder|seg0_internal[4]~3_combout\;
\decoder_inst|seg_decoder|ALT_INV_seg0_internal[3]~2_combout\ <= NOT \decoder_inst|seg_decoder|seg0_internal[3]~2_combout\;
\decoder_inst|seg_decoder|ALT_INV_seg0_internal[2]~1_combout\ <= NOT \decoder_inst|seg_decoder|seg0_internal[2]~1_combout\;
\decoder_inst|seg_decoder|ALT_INV_seg0_internal[1]~0_combout\ <= NOT \decoder_inst|seg_decoder|seg0_internal[1]~0_combout\;
\FA3|ALT_INV_p~combout\ <= NOT \FA3|p~combout\;
\FA1|ALT_INV_cout~combout\ <= NOT \FA1|cout~combout\;
\FA1|ALT_INV_s~combout\ <= NOT \FA1|s~combout\;
\FA0|ALT_INV_s~combout\ <= NOT \FA0|s~combout\;

-- Location: IOOBUF_X89_Y8_N56
\seg0[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => ww_seg0(0));

-- Location: IOOBUF_X56_Y0_N53
\seg0[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \decoder_inst|seg_decoder|ALT_INV_seg0_internal[1]~0_combout\,
	devoe => ww_devoe,
	o => ww_seg0(1));

-- Location: IOOBUF_X58_Y0_N76
\seg0[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \decoder_inst|seg_decoder|ALT_INV_seg0_internal[2]~1_combout\,
	devoe => ww_devoe,
	o => ww_seg0(2));

-- Location: IOOBUF_X56_Y0_N36
\seg0[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \decoder_inst|seg_decoder|ALT_INV_seg0_internal[3]~2_combout\,
	devoe => ww_devoe,
	o => ww_seg0(3));

-- Location: IOOBUF_X50_Y0_N76
\seg0[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \decoder_inst|seg_decoder|ALT_INV_seg0_internal[4]~3_combout\,
	devoe => ww_devoe,
	o => ww_seg0(4));

-- Location: IOOBUF_X50_Y0_N93
\seg0[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \decoder_inst|seg_decoder|ALT_INV_seg0_internal\(5),
	devoe => ww_devoe,
	o => ww_seg0(5));

-- Location: IOOBUF_X80_Y0_N2
\seg0[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \decoder_inst|seg_decoder|ALT_INV_seg0_internal\(6),
	devoe => ww_devoe,
	o => ww_seg0(6));

-- Location: IOOBUF_X60_Y0_N19
\seg0[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \decoder_inst|seg_decoder|ALT_INV_seg0_internal\(7),
	devoe => ww_devoe,
	o => ww_seg0(7));

-- Location: IOOBUF_X36_Y81_N2
\seg1[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => ww_seg1(0));

-- Location: IOOBUF_X60_Y0_N2
\seg1[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => ww_seg1(1));

-- Location: IOOBUF_X50_Y0_N42
\seg1[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \decoder_inst|bdc_decoder|y1[0]~0_combout\,
	devoe => ww_devoe,
	o => ww_seg1(2));

-- Location: IOOBUF_X66_Y0_N42
\seg1[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \decoder_inst|bdc_decoder|y1[0]~0_combout\,
	devoe => ww_devoe,
	o => ww_seg1(3));

-- Location: IOOBUF_X64_Y0_N19
\seg1[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \decoder_inst|bdc_decoder|y1[0]~0_combout\,
	devoe => ww_devoe,
	o => ww_seg1(4));

-- Location: IOOBUF_X52_Y0_N36
\seg1[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_seg1(5));

-- Location: IOOBUF_X52_Y0_N2
\seg1[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_seg1(6));

-- Location: IOOBUF_X52_Y0_N53
\seg1[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \decoder_inst|bdc_decoder|y1[0]~0_combout\,
	devoe => ww_devoe,
	o => ww_seg1(7));

-- Location: IOOBUF_X72_Y0_N53
\cout~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \FA3|cout~combout\,
	devoe => ww_devoe,
	o => ww_cout);

-- Location: IOIBUF_X89_Y21_N4
\a[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_a(0),
	o => \a[0]~input_o\);

-- Location: IOIBUF_X89_Y20_N78
\b[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_b(0),
	o => \b[0]~input_o\);

-- Location: IOIBUF_X72_Y0_N1
\cin~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_cin,
	o => \cin~input_o\);

-- Location: MLABCELL_X72_Y1_N0
\FA0|s\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA0|s~combout\ = ( \cin~input_o\ & ( !\a[0]~input_o\ $ (\b[0]~input_o\) ) ) # ( !\cin~input_o\ & ( !\a[0]~input_o\ $ (!\b[0]~input_o\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0110011001100110011001100110011010011001100110011001100110011001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_a[0]~input_o\,
	datab => \ALT_INV_b[0]~input_o\,
	dataf => \ALT_INV_cin~input_o\,
	combout => \FA0|s~combout\);

-- Location: IOIBUF_X89_Y21_N21
\b[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_b(3),
	o => \b[3]~input_o\);

-- Location: IOIBUF_X89_Y25_N55
\a[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_a(3),
	o => \a[3]~input_o\);

-- Location: MLABCELL_X72_Y1_N39
\FA3|p\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA3|p~combout\ = ( \a[3]~input_o\ & ( !\b[3]~input_o\ ) ) # ( !\a[3]~input_o\ & ( \b[3]~input_o\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111000000001111111111111111000000001111111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_b[3]~input_o\,
	dataf => \ALT_INV_a[3]~input_o\,
	combout => \FA3|p~combout\);

-- Location: IOIBUF_X89_Y25_N21
\a[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_a(1),
	o => \a[1]~input_o\);

-- Location: IOIBUF_X89_Y25_N38
\b[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_b(1),
	o => \b[1]~input_o\);

-- Location: MLABCELL_X72_Y1_N3
\FA1|s\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA1|s~combout\ = ( \cin~input_o\ & ( !\a[1]~input_o\ $ (!\b[1]~input_o\ $ (((\b[0]~input_o\) # (\a[0]~input_o\)))) ) ) # ( !\cin~input_o\ & ( !\a[1]~input_o\ $ (!\b[1]~input_o\ $ (((\a[0]~input_o\ & \b[0]~input_o\)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001111011100001000111101110000101111000100001110111100010000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_a[0]~input_o\,
	datab => \ALT_INV_b[0]~input_o\,
	datac => \ALT_INV_a[1]~input_o\,
	datad => \ALT_INV_b[1]~input_o\,
	dataf => \ALT_INV_cin~input_o\,
	combout => \FA1|s~combout\);

-- Location: IOIBUF_X89_Y20_N95
\b[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_b(2),
	o => \b[2]~input_o\);

-- Location: MLABCELL_X72_Y1_N36
\FA1|cout\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA1|cout~combout\ = ( \cin~input_o\ & ( (!\b[1]~input_o\ & (\a[1]~input_o\ & ((\b[0]~input_o\) # (\a[0]~input_o\)))) # (\b[1]~input_o\ & (((\a[1]~input_o\) # (\b[0]~input_o\)) # (\a[0]~input_o\))) ) ) # ( !\cin~input_o\ & ( (!\b[1]~input_o\ & 
-- (\a[0]~input_o\ & (\b[0]~input_o\ & \a[1]~input_o\))) # (\b[1]~input_o\ & (((\a[0]~input_o\ & \b[0]~input_o\)) # (\a[1]~input_o\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000100011111000000010001111100000111011111110000011101111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_a[0]~input_o\,
	datab => \ALT_INV_b[0]~input_o\,
	datac => \ALT_INV_b[1]~input_o\,
	datad => \ALT_INV_a[1]~input_o\,
	dataf => \ALT_INV_cin~input_o\,
	combout => \FA1|cout~combout\);

-- Location: IOIBUF_X89_Y21_N38
\a[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_a(2),
	o => \a[2]~input_o\);

-- Location: MLABCELL_X72_Y1_N12
\decoder_inst|seg_decoder|seg0_internal[1]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \decoder_inst|seg_decoder|seg0_internal[1]~0_combout\ = ( \FA1|cout~combout\ & ( \a[2]~input_o\ & ( (!\b[2]~input_o\ & ((!\FA3|p~combout\ $ (\FA1|s~combout\)))) # (\b[2]~input_o\ & ((!\FA0|s~combout\) # ((!\FA3|p~combout\) # (!\FA1|s~combout\)))) ) ) ) # 
-- ( !\FA1|cout~combout\ & ( \a[2]~input_o\ & ( (!\FA3|p~combout\ & ((!\FA1|s~combout\) # ((!\FA0|s~combout\ & !\b[2]~input_o\)))) # (\FA3|p~combout\ & (((!\b[2]~input_o\) # (\FA1|s~combout\)))) ) ) ) # ( \FA1|cout~combout\ & ( !\a[2]~input_o\ & ( 
-- (!\FA3|p~combout\ & ((!\FA1|s~combout\) # ((!\FA0|s~combout\ & !\b[2]~input_o\)))) # (\FA3|p~combout\ & (((!\b[2]~input_o\) # (\FA1|s~combout\)))) ) ) ) # ( !\FA1|cout~combout\ & ( !\a[2]~input_o\ & ( (!\b[2]~input_o\ & ((!\FA3|p~combout\ $ 
-- (!\FA1|s~combout\)))) # (\b[2]~input_o\ & ((!\FA0|s~combout\) # ((!\FA1|s~combout\) # (\FA3|p~combout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011110011111011111110111100001111111011110000111100001111111110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \FA0|ALT_INV_s~combout\,
	datab => \FA3|ALT_INV_p~combout\,
	datac => \FA1|ALT_INV_s~combout\,
	datad => \ALT_INV_b[2]~input_o\,
	datae => \FA1|ALT_INV_cout~combout\,
	dataf => \ALT_INV_a[2]~input_o\,
	combout => \decoder_inst|seg_decoder|seg0_internal[1]~0_combout\);

-- Location: MLABCELL_X72_Y1_N48
\decoder_inst|seg_decoder|seg0_internal[2]~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \decoder_inst|seg_decoder|seg0_internal[2]~1_combout\ = ( \FA1|cout~combout\ & ( \a[2]~input_o\ & ( (!\FA3|p~combout\ & ((!\FA1|s~combout\ & ((!\b[2]~input_o\))) # (\FA1|s~combout\ & ((!\FA0|s~combout\) # (\b[2]~input_o\))))) # (\FA3|p~combout\ & 
-- ((!\FA0|s~combout\ & ((!\FA1|s~combout\) # (\b[2]~input_o\))) # (\FA0|s~combout\ & (!\FA1|s~combout\ & \b[2]~input_o\)))) ) ) ) # ( !\FA1|cout~combout\ & ( \a[2]~input_o\ & ( (!\FA3|p~combout\ & ((!\FA0|s~combout\) # ((!\FA1|s~combout\)))) # 
-- (\FA3|p~combout\ & ((!\FA1|s~combout\ & (!\FA0|s~combout\ & \b[2]~input_o\)) # (\FA1|s~combout\ & ((!\b[2]~input_o\))))) ) ) ) # ( \FA1|cout~combout\ & ( !\a[2]~input_o\ & ( (!\FA3|p~combout\ & ((!\FA0|s~combout\) # ((!\FA1|s~combout\)))) # 
-- (\FA3|p~combout\ & ((!\FA1|s~combout\ & (!\FA0|s~combout\ & \b[2]~input_o\)) # (\FA1|s~combout\ & ((!\b[2]~input_o\))))) ) ) ) # ( !\FA1|cout~combout\ & ( !\a[2]~input_o\ & ( (!\FA3|p~combout\ & ((!\FA0|s~combout\ & ((!\FA1|s~combout\) # 
-- (\b[2]~input_o\))) # (\FA0|s~combout\ & (!\FA1|s~combout\ & \b[2]~input_o\)))) # (\FA3|p~combout\ & ((!\FA1|s~combout\ & ((!\b[2]~input_o\))) # (\FA1|s~combout\ & ((!\FA0|s~combout\) # (\b[2]~input_o\))))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1011001011001011110010111110100011001011111010001110100000111110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \FA0|ALT_INV_s~combout\,
	datab => \FA3|ALT_INV_p~combout\,
	datac => \FA1|ALT_INV_s~combout\,
	datad => \ALT_INV_b[2]~input_o\,
	datae => \FA1|ALT_INV_cout~combout\,
	dataf => \ALT_INV_a[2]~input_o\,
	combout => \decoder_inst|seg_decoder|seg0_internal[2]~1_combout\);

-- Location: MLABCELL_X72_Y1_N54
\decoder_inst|seg_decoder|seg0_internal[3]~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \decoder_inst|seg_decoder|seg0_internal[3]~2_combout\ = ( \FA1|cout~combout\ & ( \a[2]~input_o\ & ( (!\FA0|s~combout\ & ((!\b[2]~input_o\) # (!\FA3|p~combout\ $ (\FA1|s~combout\)))) ) ) ) # ( !\FA1|cout~combout\ & ( \a[2]~input_o\ & ( (!\FA0|s~combout\ & 
-- ((!\FA3|p~combout\ $ (!\FA1|s~combout\)) # (\b[2]~input_o\))) ) ) ) # ( \FA1|cout~combout\ & ( !\a[2]~input_o\ & ( (!\FA0|s~combout\ & ((!\FA3|p~combout\ $ (!\FA1|s~combout\)) # (\b[2]~input_o\))) ) ) ) # ( !\FA1|cout~combout\ & ( !\a[2]~input_o\ & ( 
-- (!\FA0|s~combout\ & ((!\b[2]~input_o\) # (!\FA3|p~combout\ $ (!\FA1|s~combout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101000101000001010001010101000101000101010101010101010000010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \FA0|ALT_INV_s~combout\,
	datab => \FA3|ALT_INV_p~combout\,
	datac => \FA1|ALT_INV_s~combout\,
	datad => \ALT_INV_b[2]~input_o\,
	datae => \FA1|ALT_INV_cout~combout\,
	dataf => \ALT_INV_a[2]~input_o\,
	combout => \decoder_inst|seg_decoder|seg0_internal[3]~2_combout\);

-- Location: MLABCELL_X72_Y1_N30
\decoder_inst|seg_decoder|seg0_internal[4]~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \decoder_inst|seg_decoder|seg0_internal[4]~3_combout\ = ( \FA1|cout~combout\ & ( \a[2]~input_o\ & ( (!\FA0|s~combout\ & ((!\b[2]~input_o\) # (!\FA3|p~combout\ $ (\FA1|s~combout\)))) # (\FA0|s~combout\ & ((!\FA3|p~combout\ & ((!\FA1|s~combout\) # 
-- (\b[2]~input_o\))) # (\FA3|p~combout\ & (!\FA1|s~combout\ $ (!\b[2]~input_o\))))) ) ) ) # ( !\FA1|cout~combout\ & ( \a[2]~input_o\ & ( (!\FA0|s~combout\ & ((!\FA3|p~combout\ $ (!\FA1|s~combout\)) # (\b[2]~input_o\))) # (\FA0|s~combout\ & 
-- ((!\FA3|p~combout\ & (!\FA1|s~combout\)) # (\FA3|p~combout\ & ((!\b[2]~input_o\) # (\FA1|s~combout\))))) ) ) ) # ( \FA1|cout~combout\ & ( !\a[2]~input_o\ & ( (!\FA0|s~combout\ & ((!\FA3|p~combout\ $ (!\FA1|s~combout\)) # (\b[2]~input_o\))) # 
-- (\FA0|s~combout\ & ((!\FA3|p~combout\ & (!\FA1|s~combout\)) # (\FA3|p~combout\ & ((!\b[2]~input_o\) # (\FA1|s~combout\))))) ) ) ) # ( !\FA1|cout~combout\ & ( !\a[2]~input_o\ & ( (!\FA0|s~combout\ & ((!\b[2]~input_o\) # (!\FA3|p~combout\ $ 
-- (!\FA1|s~combout\)))) # (\FA0|s~combout\ & ((!\FA3|p~combout\ & (!\FA1|s~combout\ $ (!\b[2]~input_o\))) # (\FA3|p~combout\ & ((!\FA1|s~combout\) # (\b[2]~input_o\))))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1011111001111001011110011110101101111001111010111110101111010110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \FA0|ALT_INV_s~combout\,
	datab => \FA3|ALT_INV_p~combout\,
	datac => \FA1|ALT_INV_s~combout\,
	datad => \ALT_INV_b[2]~input_o\,
	datae => \FA1|ALT_INV_cout~combout\,
	dataf => \ALT_INV_a[2]~input_o\,
	combout => \decoder_inst|seg_decoder|seg0_internal[4]~3_combout\);

-- Location: MLABCELL_X72_Y1_N6
\decoder_inst|seg_decoder|seg0_internal[5]\ : cyclonev_lcell_comb
-- Equation(s):
-- \decoder_inst|seg_decoder|seg0_internal\(5) = ( \FA1|cout~combout\ & ( \a[2]~input_o\ & ( ((!\FA3|p~combout\ & ((!\b[2]~input_o\) # (\FA1|s~combout\))) # (\FA3|p~combout\ & ((!\FA1|s~combout\) # (\b[2]~input_o\)))) # (\FA0|s~combout\) ) ) ) # ( 
-- !\FA1|cout~combout\ & ( \a[2]~input_o\ & ( ((!\FA3|p~combout\) # (!\FA1|s~combout\ $ (!\b[2]~input_o\))) # (\FA0|s~combout\) ) ) ) # ( \FA1|cout~combout\ & ( !\a[2]~input_o\ & ( ((!\FA3|p~combout\) # (!\FA1|s~combout\ $ (!\b[2]~input_o\))) # 
-- (\FA0|s~combout\) ) ) ) # ( !\FA1|cout~combout\ & ( !\a[2]~input_o\ & ( ((!\FA3|p~combout\ & ((!\FA1|s~combout\) # (\b[2]~input_o\))) # (\FA3|p~combout\ & ((!\b[2]~input_o\) # (\FA1|s~combout\)))) # (\FA0|s~combout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111011111011111110111111111110111011111111111011111110101111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \FA0|ALT_INV_s~combout\,
	datab => \FA3|ALT_INV_p~combout\,
	datac => \FA1|ALT_INV_s~combout\,
	datad => \ALT_INV_b[2]~input_o\,
	datae => \FA1|ALT_INV_cout~combout\,
	dataf => \ALT_INV_a[2]~input_o\,
	combout => \decoder_inst|seg_decoder|seg0_internal\(5));

-- Location: MLABCELL_X72_Y1_N42
\decoder_inst|seg_decoder|seg0_internal[6]\ : cyclonev_lcell_comb
-- Equation(s):
-- \decoder_inst|seg_decoder|seg0_internal\(6) = ( \FA1|cout~combout\ & ( \a[2]~input_o\ & ( (!\b[2]~input_o\) # ((!\FA0|s~combout\ & ((!\FA3|p~combout\) # (!\FA1|s~combout\))) # (\FA0|s~combout\ & (!\FA3|p~combout\ $ (\FA1|s~combout\)))) ) ) ) # ( 
-- !\FA1|cout~combout\ & ( \a[2]~input_o\ & ( ((!\FA0|s~combout\ & ((!\FA1|s~combout\) # (\FA3|p~combout\))) # (\FA0|s~combout\ & (!\FA3|p~combout\ $ (!\FA1|s~combout\)))) # (\b[2]~input_o\) ) ) ) # ( \FA1|cout~combout\ & ( !\a[2]~input_o\ & ( 
-- ((!\FA0|s~combout\ & ((!\FA1|s~combout\) # (\FA3|p~combout\))) # (\FA0|s~combout\ & (!\FA3|p~combout\ $ (!\FA1|s~combout\)))) # (\b[2]~input_o\) ) ) ) # ( !\FA1|cout~combout\ & ( !\a[2]~input_o\ & ( (!\b[2]~input_o\) # ((!\FA0|s~combout\ & 
-- ((!\FA1|s~combout\) # (\FA3|p~combout\))) # (\FA0|s~combout\ & (!\FA3|p~combout\ $ (!\FA1|s~combout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111110110110101101101111111110110110111111111111111111101001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \FA0|ALT_INV_s~combout\,
	datab => \FA3|ALT_INV_p~combout\,
	datac => \FA1|ALT_INV_s~combout\,
	datad => \ALT_INV_b[2]~input_o\,
	datae => \FA1|ALT_INV_cout~combout\,
	dataf => \ALT_INV_a[2]~input_o\,
	combout => \decoder_inst|seg_decoder|seg0_internal\(6));

-- Location: MLABCELL_X72_Y1_N18
\decoder_inst|seg_decoder|seg0_internal[7]\ : cyclonev_lcell_comb
-- Equation(s):
-- \decoder_inst|seg_decoder|seg0_internal\(7) = ( \FA1|cout~combout\ & ( \a[2]~input_o\ & ( (!\FA0|s~combout\ & ((!\b[2]~input_o\) # (!\FA3|p~combout\ $ (\FA1|s~combout\)))) # (\FA0|s~combout\ & ((!\FA3|p~combout\ $ (\FA1|s~combout\)) # (\b[2]~input_o\))) ) 
-- ) ) # ( !\FA1|cout~combout\ & ( \a[2]~input_o\ & ( (!\FA0|s~combout\ & ((!\FA3|p~combout\ $ (!\FA1|s~combout\)) # (\b[2]~input_o\))) # (\FA0|s~combout\ & ((!\b[2]~input_o\) # (!\FA3|p~combout\ $ (\FA1|s~combout\)))) ) ) ) # ( \FA1|cout~combout\ & ( 
-- !\a[2]~input_o\ & ( (!\FA0|s~combout\ & ((!\FA3|p~combout\ $ (!\FA1|s~combout\)) # (\b[2]~input_o\))) # (\FA0|s~combout\ & ((!\b[2]~input_o\) # (!\FA3|p~combout\ $ (\FA1|s~combout\)))) ) ) ) # ( !\FA1|cout~combout\ & ( !\a[2]~input_o\ & ( 
-- (!\FA0|s~combout\ & ((!\b[2]~input_o\) # (!\FA3|p~combout\ $ (!\FA1|s~combout\)))) # (\FA0|s~combout\ & ((!\FA3|p~combout\ $ (!\FA1|s~combout\)) # (\b[2]~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1011111001111101011111011110101101111101111010111110101111010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \FA0|ALT_INV_s~combout\,
	datab => \FA3|ALT_INV_p~combout\,
	datac => \FA1|ALT_INV_s~combout\,
	datad => \ALT_INV_b[2]~input_o\,
	datae => \FA1|ALT_INV_cout~combout\,
	dataf => \ALT_INV_a[2]~input_o\,
	combout => \decoder_inst|seg_decoder|seg0_internal\(7));

-- Location: MLABCELL_X72_Y1_N24
\decoder_inst|bdc_decoder|y1[0]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \decoder_inst|bdc_decoder|y1[0]~0_combout\ = ( \FA3|p~combout\ & ( (!\FA1|cout~combout\ & ((!\a[2]~input_o\ & ((\b[2]~input_o\) # (\FA1|s~combout\))) # (\a[2]~input_o\ & ((!\b[2]~input_o\))))) # (\FA1|cout~combout\ & (!\a[2]~input_o\ & 
-- ((!\b[2]~input_o\)))) ) ) # ( !\FA3|p~combout\ & ( (!\FA1|cout~combout\ & (\a[2]~input_o\ & (\FA1|s~combout\ & \b[2]~input_o\))) # (\FA1|cout~combout\ & ((!\a[2]~input_o\ & (\FA1|s~combout\ & \b[2]~input_o\)) # (\a[2]~input_o\ & ((\b[2]~input_o\) # 
-- (\FA1|s~combout\))))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000100010111000000010001011101101110100010000110111010001000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \FA1|ALT_INV_cout~combout\,
	datab => \ALT_INV_a[2]~input_o\,
	datac => \FA1|ALT_INV_s~combout\,
	datad => \ALT_INV_b[2]~input_o\,
	dataf => \FA3|ALT_INV_p~combout\,
	combout => \decoder_inst|bdc_decoder|y1[0]~0_combout\);

-- Location: MLABCELL_X72_Y1_N27
\FA3|cout\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA3|cout~combout\ = ( \a[3]~input_o\ & ( ((!\FA1|cout~combout\ & (\a[2]~input_o\ & \b[2]~input_o\)) # (\FA1|cout~combout\ & ((\b[2]~input_o\) # (\a[2]~input_o\)))) # (\b[3]~input_o\) ) ) # ( !\a[3]~input_o\ & ( (\b[3]~input_o\ & ((!\FA1|cout~combout\ & 
-- (\a[2]~input_o\ & \b[2]~input_o\)) # (\FA1|cout~combout\ & ((\b[2]~input_o\) # (\a[2]~input_o\))))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000010111000000000001011100010111111111110001011111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \FA1|ALT_INV_cout~combout\,
	datab => \ALT_INV_a[2]~input_o\,
	datac => \ALT_INV_b[2]~input_o\,
	datad => \ALT_INV_b[3]~input_o\,
	dataf => \ALT_INV_a[3]~input_o\,
	combout => \FA3|cout~combout\);

-- Location: MLABCELL_X21_Y51_N3
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


