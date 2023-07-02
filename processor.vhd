library ieee;
use ieee.std_logic_1164.all;

entity processor is 
	port ( 	address : out std_logic_vector (15 downto 0);
			Pstrobe : out std_logic;
			Prw : out std_logic;
			Pready : in std_logic;
			Pdata : inout std_logic_vector (32 downto 0));
end processor;