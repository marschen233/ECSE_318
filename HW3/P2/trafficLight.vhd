library ieee;
use ieee.std_logic_1164.all;

entity trafficLight is
	port ( 	clock : in std_logic;
		Sa : in std_logic;
		Sb : in std_logic;
		Ga : out std_logic;
		Ya : out std_logic;
		Ra : out std_logic;
		Gb : out std_logic;
		Yb : out std_logic;
		Rb : out std_logic);
end trafficLight;

architecture trafficLight_arch of trafficLight is

	type trafficLightState is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12);
	type lightState is (green, yellow, red);
	
begin
	process
		variable currentState : trafficLightState := s0;
		variable nextState : trafficLightState;
		variable aLight, bLight : lightState;
		
		procedure changeState is begin
			case currentState is
				when s0 => nextState := s1; aLight := green; bLight := red;
				when s1 => nextState := s2;
 				when s2 => nextState := s3;
				when s3 => nextState := s4;
				when s4 => nextState := s5;
				when s5 =>
					if Sb = '1' then nextState := s6; aLight := yellow; end if;
				when s6 => nextState := s7; aLight := red; bLight := green;
				when s7 => nextState := s8;
				when s8 => nextState := s9;
				when s9 => nextState := s10;
				when s10 => nextState := s11;
				when s11 =>
					if Sa = '1' and Sb = '0' then nextState := s12; bLight := yellow; end if;
				when s12 => nextState := s0; aLight := green; bLight := yellow;
			end case;
		end procedure;

		procedure changeLights is begin
			case aLight is
				when green => Ga <= '1'; Ya <= '0'; Ra <= '0';
				when yellow => Ga <= '0'; Ya <= '1'; Ra <= '0';
				when red => Ga <= '0'; Ya <= '0'; Ra <= '1';
			end case;
			
			case bLight is
				when green => Gb <= '1'; Yb <= '0'; Rb <= '0';
				when yellow => Gb <= '0'; Yb <= '1'; Rb <= '0';
				when red => Gb <= '0'; Yb <= '0'; Rb <= '1';
			end case;
		end procedure;
		
	begin
		if (rising_edge(clock)) then changeState; currentState := nextState; changeLights; end if;
		wait for 1 ns;
	end process;


end trafficLight_arch;

