library ieee;
use ieee.std_logic_1164.all;

entity cache is 
	port (	Sysadress : out std_logic_vector (15 downto 0);
			Sysstrobe : out std_logic;
			Sysrw : out std_logic;
			Sysdata : inout std_logic_vector (7 downto 0));
end cache;
