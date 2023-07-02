entity UPM4x4 is
	port ( 	X : in bit_vector (3 downto 0);
		Y : in bit_vector (3 downto 0);
		output : out bit_vector (7 downto 0));
end UPM4x4;

architecture UPM4x4_arch of UPM4x4 is
	signal c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20 : bit;
	signal s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20 : bit;
	component CSA 
		port (	Sout 	: out bit;
			Cout 	: out bit;
			Sin 	: in bit;
			A	: in bit;
			B	: in bit;
			Cin	: in bit);
	end component;
	component CPA 
 		port (	Sout	: out bit;
			Cout	: out bit;
			A	: in bit;
			B	: in bit;
			Cin	: in bit);
	end component;
begin
	CSA1 : CSA port map (s1, c1, '0', y(0), x(0), '0');
	CSA2 : CSA port map (s2, c2, '0', y(1), x(0), '0');
	CSA3 : CSA port map (s3, c3, '0', y(2), x(0), '0');
	CSA4 : CSA port map (s4, c4, '0', y(3), x(0), '0');
	CSA5 : CSA port map (s5, c5, s2, y(0), x(1), c1);
	CSA6 : CSA port map (s6, c6, s3, y(1), x(1), c2);
	CSA7 : CSA port map (s7, c7, s4, y(2), x(1), c3);
	CSA8 : CSA port map (s8, c8, '0', y(3), x(1), c4);
	CSA9 : CSA port map (s9, c9, s6, y(0), x(2), c5);
	CSA10 : CSA port map (s10, c10, s7, y(1), x(2), c6);
	CSA11 : CSA port map (s11, c11, s8, y(2), x(2), c7);
	CSA12 : CSA port map (s12, c12, '0', y(3), x(2), c8);
	CSA13 : CSA port map (s13, c13, s10, y(0), x(3), c9);
	CSA14 : CSA port map (s14, c14, s11, y(1), x(3), c10);
	CSA15 : CSA port map (s15, c15, s12, y(2), x(3), c11);
	CSA16 : CSA port map (s16, c16, '0', y(3), x(3), c12);
	CPA1 : CPA port map (s17, c17, s14, c13, '0');
	CPA2 : CPA port map (s18, c18, s15, c14, c17);
	CPA3 : CPA port map (s19, c19, s16, c15, c18);
	CPA4 : CPA port map (s20, c20, '0', c16, c19);

	output(0) <= s1;
	output(1) <= s5;
	output(2) <= s9;
	output(3) <= s13;
	output(4) <= s17;
	output(5) <= s18;
	output(6) <= s19;
	output(7) <= s20;

end UPM4x4_arch;
