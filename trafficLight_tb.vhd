library ieee;
use ieee.std_logic_1164.all;

entity trafficLight_tb is
end trafficLight_tb;

architecture trafficLight_tb_arch of trafficLight_tb is 
	component trafficLight port (clock : in std_logic; Sa, Sb : in std_logic; Ga, Ya, Ra, Gb, Yb, Rb : out std_logic); end component;
	signal clockT : std_logic := '0'; 
	signal SaT, SbT, GaT, YaT, RaT, GbT, YbT, RbT : std_logic;
begin
	UUT : trafficLight port map (clock => clockT, Sa => SaT, Sb => SbT, Ga => GaT, Ya => YaT, Ra => RaT, Gb => GbT, Yb => YbT, Rb => RbT);

	main : process begin
		SaT <= '0', '1' after 210 ns ;
		SbT <= '0', '1' after 120 ns, '0' after 210 ns;
		wait;
	end process main;
	
	assertions : process begin
		report "Beginning test bench for trafficLight" severity note;
		
		wait for 15 ns;
		assert GaT = '1' and RbT = '1' report "Failure, trafficLight did not initialize properly" severity error;
		
		wait for 100 ns;
		assert (GaT = '1' and RbT = '1') report "Failure, trafficLight did not loop at s5" severity error;
		
		wait for 20 ns;
		assert (YaT = '1' and RbT = '1') report "Failure, trafficLight did not transition to s6" severity error;
		
		wait for 75 ns;
		assert (RaT = '1' and GbT = '1') report "Failure, trafficLight did not loop at s11" severity error;
		
		wait for 90 ns;
		assert (GaT = '1' and RbT = '1') report "Failure, trafficLight did not transition out of s11" severity error;
	
		assert false report "trafficLight test bench complete" severity failure;
	end process assertions;
	
	clock : process (clockT) is begin
		if clockT = '0' then clockT <= '1' after 10 ns, '0' after 20 ns; end if;
	end process clock;
end trafficLight_tb_arch;