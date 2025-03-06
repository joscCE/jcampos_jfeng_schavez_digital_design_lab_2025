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

-- DATE "03/06/2025 10:42:19"

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
-- cout	=>  Location: PIN_AC27,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: 2mA
-- cin	=>  Location: PIN_AD26,	 I/O Standard: 3.3-V LVCMOS,	 Current Strength: Default
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
SIGNAL \b[1]~input_o\ : std_logic;
SIGNAL \a[1]~input_o\ : std_logic;
SIGNAL \FA1|cout~combout\ : std_logic;
SIGNAL \b[3]~input_o\ : std_logic;
SIGNAL \a[2]~input_o\ : std_logic;
SIGNAL \b[2]~input_o\ : std_logic;
SIGNAL \a[3]~input_o\ : std_logic;
SIGNAL \FA3|s~combout\ : std_logic;
SIGNAL \FA0|s~combout\ : std_logic;
SIGNAL \FA1|s~combout\ : std_logic;
SIGNAL \FA2|s~combout\ : std_logic;
SIGNAL \decoder_inst|Mux6~0_combout\ : std_logic;
SIGNAL \decoder_inst|Mux5~0_combout\ : std_logic;
SIGNAL \decoder_inst|Mux4~0_combout\ : std_logic;
SIGNAL \decoder_inst|Mux3~0_combout\ : std_logic;
SIGNAL \decoder_inst|Mux2~0_combout\ : std_logic;
SIGNAL \decoder_inst|Mux1~0_combout\ : std_logic;
SIGNAL \decoder_inst|Mux0~0_combout\ : std_logic;
SIGNAL \FA3|cout~combout\ : std_logic;
SIGNAL \ALT_INV_b[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_a[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_b[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_a[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_b[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_a[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_b[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_a[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_cin~input_o\ : std_logic;
SIGNAL \decoder_inst|ALT_INV_Mux6~0_combout\ : std_logic;
SIGNAL \FA3|ALT_INV_s~combout\ : std_logic;
SIGNAL \FA2|ALT_INV_s~combout\ : std_logic;
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
\decoder_inst|ALT_INV_Mux6~0_combout\ <= NOT \decoder_inst|Mux6~0_combout\;
\FA3|ALT_INV_s~combout\ <= NOT \FA3|s~combout\;
\FA2|ALT_INV_s~combout\ <= NOT \FA2|s~combout\;
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
	i => \decoder_inst|ALT_INV_Mux6~0_combout\,
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
	i => \decoder_inst|Mux5~0_combout\,
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
	i => \decoder_inst|Mux4~0_combout\,
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
	i => \decoder_inst|Mux3~0_combout\,
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
	i => \decoder_inst|Mux2~0_combout\,
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
	i => \decoder_inst|Mux1~0_combout\,
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
	i => \decoder_inst|Mux0~0_combout\,
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
	i => VCC,
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
	i => VCC,
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
	i => VCC,
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
	i => VCC,
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
	i => VCC,
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
	i => VCC,
	devoe => ww_devoe,
	o => ww_seg1(7));

-- Location: IOOBUF_X89_Y16_N22
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

-- Location: IOIBUF_X89_Y16_N4
\cin~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_cin,
	o => \cin~input_o\);

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

-- Location: LABCELL_X83_Y16_N42
\FA1|cout\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA1|cout~combout\ = ( \b[1]~input_o\ & ( \a[1]~input_o\ ) ) # ( !\b[1]~input_o\ & ( \a[1]~input_o\ & ( (!\a[0]~input_o\ & (\b[0]~input_o\ & \cin~input_o\)) # (\a[0]~input_o\ & ((\cin~input_o\) # (\b[0]~input_o\))) ) ) ) # ( \b[1]~input_o\ & ( 
-- !\a[1]~input_o\ & ( (!\a[0]~input_o\ & (\b[0]~input_o\ & \cin~input_o\)) # (\a[0]~input_o\ & ((\cin~input_o\) # (\b[0]~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000101110001011100010111000101111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_a[0]~input_o\,
	datab => \ALT_INV_b[0]~input_o\,
	datac => \ALT_INV_cin~input_o\,
	datae => \ALT_INV_b[1]~input_o\,
	dataf => \ALT_INV_a[1]~input_o\,
	combout => \FA1|cout~combout\);

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

-- Location: LABCELL_X83_Y16_N24
\FA3|s\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA3|s~combout\ = ( \b[2]~input_o\ & ( \a[3]~input_o\ & ( !\b[3]~input_o\ $ (((\a[2]~input_o\) # (\FA1|cout~combout\))) ) ) ) # ( !\b[2]~input_o\ & ( \a[3]~input_o\ & ( !\b[3]~input_o\ $ (((\FA1|cout~combout\ & \a[2]~input_o\))) ) ) ) # ( \b[2]~input_o\ & 
-- ( !\a[3]~input_o\ & ( !\b[3]~input_o\ $ (((!\FA1|cout~combout\ & !\a[2]~input_o\))) ) ) ) # ( !\b[2]~input_o\ & ( !\a[3]~input_o\ & ( !\b[3]~input_o\ $ (((!\FA1|cout~combout\) # (!\a[2]~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100111100001111001111000011110000110000111100001100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \FA1|ALT_INV_cout~combout\,
	datac => \ALT_INV_b[3]~input_o\,
	datad => \ALT_INV_a[2]~input_o\,
	datae => \ALT_INV_b[2]~input_o\,
	dataf => \ALT_INV_a[3]~input_o\,
	combout => \FA3|s~combout\);

-- Location: LABCELL_X83_Y16_N30
\FA0|s\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA0|s~combout\ = ( \a[0]~input_o\ & ( !\b[0]~input_o\ $ (\cin~input_o\) ) ) # ( !\a[0]~input_o\ & ( !\b[0]~input_o\ $ (!\cin~input_o\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011110000111100001111000011110011000011110000111100001111000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_b[0]~input_o\,
	datac => \ALT_INV_cin~input_o\,
	dataf => \ALT_INV_a[0]~input_o\,
	combout => \FA0|s~combout\);

-- Location: LABCELL_X83_Y16_N39
\FA1|s\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA1|s~combout\ = ( \b[1]~input_o\ & ( \a[1]~input_o\ & ( (!\cin~input_o\ & (\b[0]~input_o\ & \a[0]~input_o\)) # (\cin~input_o\ & ((\a[0]~input_o\) # (\b[0]~input_o\))) ) ) ) # ( !\b[1]~input_o\ & ( \a[1]~input_o\ & ( (!\cin~input_o\ & ((!\b[0]~input_o\) 
-- # (!\a[0]~input_o\))) # (\cin~input_o\ & (!\b[0]~input_o\ & !\a[0]~input_o\)) ) ) ) # ( \b[1]~input_o\ & ( !\a[1]~input_o\ & ( (!\cin~input_o\ & ((!\b[0]~input_o\) # (!\a[0]~input_o\))) # (\cin~input_o\ & (!\b[0]~input_o\ & !\a[0]~input_o\)) ) ) ) # ( 
-- !\b[1]~input_o\ & ( !\a[1]~input_o\ & ( (!\cin~input_o\ & (\b[0]~input_o\ & \a[0]~input_o\)) # (\cin~input_o\ & ((\a[0]~input_o\) # (\b[0]~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000010101011111111110101010000011111010101000000000010101011111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_cin~input_o\,
	datac => \ALT_INV_b[0]~input_o\,
	datad => \ALT_INV_a[0]~input_o\,
	datae => \ALT_INV_b[1]~input_o\,
	dataf => \ALT_INV_a[1]~input_o\,
	combout => \FA1|s~combout\);

-- Location: LABCELL_X83_Y16_N51
\FA2|s\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA2|s~combout\ = ( \b[2]~input_o\ & ( !\a[2]~input_o\ $ (\FA1|cout~combout\) ) ) # ( !\b[2]~input_o\ & ( !\a[2]~input_o\ $ (!\FA1|cout~combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011110000111100110000111100001100111100001111001100001111000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_a[2]~input_o\,
	datac => \FA1|ALT_INV_cout~combout\,
	datae => \ALT_INV_b[2]~input_o\,
	combout => \FA2|s~combout\);

-- Location: LABCELL_X83_Y16_N3
\decoder_inst|Mux6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \decoder_inst|Mux6~0_combout\ = ( \FA2|s~combout\ & ( (!\FA3|s~combout\ & ((!\FA0|s~combout\) # (!\FA1|s~combout\))) # (\FA3|s~combout\ & ((\FA1|s~combout\) # (\FA0|s~combout\))) ) ) # ( !\FA2|s~combout\ & ( (\FA1|s~combout\) # (\FA3|s~combout\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010111111111010101011111111110101111111101011010111111110101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \FA3|ALT_INV_s~combout\,
	datac => \FA0|ALT_INV_s~combout\,
	datad => \FA1|ALT_INV_s~combout\,
	dataf => \FA2|ALT_INV_s~combout\,
	combout => \decoder_inst|Mux6~0_combout\);

-- Location: LABCELL_X83_Y16_N6
\decoder_inst|Mux5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \decoder_inst|Mux5~0_combout\ = ( \FA2|s~combout\ & ( (\FA0|s~combout\ & (!\FA3|s~combout\ $ (!\FA1|s~combout\))) ) ) # ( !\FA2|s~combout\ & ( (!\FA3|s~combout\ & ((\FA1|s~combout\) # (\FA0|s~combout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010001010101010001000101010101000010001001000100001000100100010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \FA3|ALT_INV_s~combout\,
	datab => \FA0|ALT_INV_s~combout\,
	datad => \FA1|ALT_INV_s~combout\,
	dataf => \FA2|ALT_INV_s~combout\,
	combout => \decoder_inst|Mux5~0_combout\);

-- Location: LABCELL_X83_Y16_N0
\decoder_inst|Mux4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \decoder_inst|Mux4~0_combout\ = ( \FA2|s~combout\ & ( (!\FA3|s~combout\ & ((!\FA1|s~combout\) # (\FA0|s~combout\))) ) ) # ( !\FA2|s~combout\ & ( (\FA0|s~combout\ & ((!\FA3|s~combout\) # (!\FA1|s~combout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011001100100010001100110010001010101010001000101010101000100010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \FA3|ALT_INV_s~combout\,
	datab => \FA0|ALT_INV_s~combout\,
	datad => \FA1|ALT_INV_s~combout\,
	dataf => \FA2|ALT_INV_s~combout\,
	combout => \decoder_inst|Mux4~0_combout\);

-- Location: LABCELL_X83_Y16_N9
\decoder_inst|Mux3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \decoder_inst|Mux3~0_combout\ = ( \FA2|s~combout\ & ( (!\FA0|s~combout\ & (!\FA3|s~combout\ & !\FA1|s~combout\)) # (\FA0|s~combout\ & ((\FA1|s~combout\))) ) ) # ( !\FA2|s~combout\ & ( (!\FA3|s~combout\ & (\FA0|s~combout\ & !\FA1|s~combout\)) # 
-- (\FA3|s~combout\ & (!\FA0|s~combout\ & \FA1|s~combout\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010010000100100001001000010010010000011100000111000001110000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \FA3|ALT_INV_s~combout\,
	datab => \FA0|ALT_INV_s~combout\,
	datac => \FA1|ALT_INV_s~combout\,
	dataf => \FA2|ALT_INV_s~combout\,
	combout => \decoder_inst|Mux3~0_combout\);

-- Location: LABCELL_X83_Y16_N12
\decoder_inst|Mux2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \decoder_inst|Mux2~0_combout\ = ( \FA2|s~combout\ & ( (\FA3|s~combout\ & ((!\FA0|s~combout\) # (\FA1|s~combout\))) ) ) # ( !\FA2|s~combout\ & ( (!\FA3|s~combout\ & (!\FA0|s~combout\ & \FA1|s~combout\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000010001000000000001000100001000100010101010100010001010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \FA3|ALT_INV_s~combout\,
	datab => \FA0|ALT_INV_s~combout\,
	datad => \FA1|ALT_INV_s~combout\,
	dataf => \FA2|ALT_INV_s~combout\,
	combout => \decoder_inst|Mux2~0_combout\);

-- Location: LABCELL_X83_Y16_N15
\decoder_inst|Mux1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \decoder_inst|Mux1~0_combout\ = ( \FA2|s~combout\ & ( (!\FA3|s~combout\ & (!\FA0|s~combout\ $ (!\FA1|s~combout\))) # (\FA3|s~combout\ & ((!\FA0|s~combout\) # (\FA1|s~combout\))) ) ) # ( !\FA2|s~combout\ & ( (\FA3|s~combout\ & (\FA0|s~combout\ & 
-- \FA1|s~combout\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000100000001000000010000000101101101011011010110110101101101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \FA3|ALT_INV_s~combout\,
	datab => \FA0|ALT_INV_s~combout\,
	datac => \FA1|ALT_INV_s~combout\,
	dataf => \FA2|ALT_INV_s~combout\,
	combout => \decoder_inst|Mux1~0_combout\);

-- Location: LABCELL_X83_Y16_N18
\decoder_inst|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \decoder_inst|Mux0~0_combout\ = ( \FA2|s~combout\ & ( (!\FA1|s~combout\ & (!\FA3|s~combout\ $ (\FA0|s~combout\))) ) ) # ( !\FA2|s~combout\ & ( (\FA0|s~combout\ & (!\FA1|s~combout\ $ (\FA3|s~combout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011000011000000001100001111000000000011001100000000001100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \FA1|ALT_INV_s~combout\,
	datac => \FA3|ALT_INV_s~combout\,
	datad => \FA0|ALT_INV_s~combout\,
	dataf => \FA2|ALT_INV_s~combout\,
	combout => \decoder_inst|Mux0~0_combout\);

-- Location: LABCELL_X83_Y16_N57
\FA3|cout\ : cyclonev_lcell_comb
-- Equation(s):
-- \FA3|cout~combout\ = ( \b[2]~input_o\ & ( \a[3]~input_o\ & ( ((\FA1|cout~combout\) # (\a[2]~input_o\)) # (\b[3]~input_o\) ) ) ) # ( !\b[2]~input_o\ & ( \a[3]~input_o\ & ( ((\a[2]~input_o\ & \FA1|cout~combout\)) # (\b[3]~input_o\) ) ) ) # ( \b[2]~input_o\ 
-- & ( !\a[3]~input_o\ & ( (\b[3]~input_o\ & ((\FA1|cout~combout\) # (\a[2]~input_o\))) ) ) ) # ( !\b[2]~input_o\ & ( !\a[3]~input_o\ & ( (\b[3]~input_o\ & (\a[2]~input_o\ & \FA1|cout~combout\)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000100000001000101010001010101010111010101110111111101111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_b[3]~input_o\,
	datab => \ALT_INV_a[2]~input_o\,
	datac => \FA1|ALT_INV_cout~combout\,
	datae => \ALT_INV_b[2]~input_o\,
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


