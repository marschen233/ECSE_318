entity UPM4x4_tb is
end UPM4x4_tb;

architecture UPM4x4_tb_arch of UPM4x4_tb is
	component UPM4x4
		port ( 	X : in bit_vector (3 downto 0);
			Y : in bit_vector (3 downto 0);
			output : out bit_vector (7 downto 0));
	end component;
	
	signal XT, YT : bit_vector (3 downto 0);
	signal ZT : bit_vector (7 downto 0);
begin

UPM4x4_1 : UPM4x4 port map (X => XT, Y => YT, output => ZT);

	process begin
		report "Beginning UPM4x4 test bench" severity note;

		XT <= "0010";
		YT <= "0100";
		wait for 10 ns;
		assert (ZT = "00001000") report "Failed, -- 2*4" severity error;

		XT <= "1111";
		YT <= "0011";
		wait for 10 ns;
		assert (ZT = "00101101") report "Failed, -- 15*3" severity error;

		assert false report "UPM4x4 test bench completed" severity failure;
	end process;

end UPM4x4_tb_arch;
