library ieee;
use ieee.std_logic_1164.all;

entity memory is
	port ( 	Sysaddress : in std_logic_vector (15 downto 0);
			Sysstrobe : in std_logic;
			Sysrw : in std_logic;
			Sysdata : inout std_logic_vector (7 downto 0));
end memory;