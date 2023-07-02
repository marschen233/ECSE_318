entity CSA is
	port (	Sout 	: out bit;
		Cout 	: out bit;
		Sin 	: in bit;
		A	: in bit;
		B	: in bit;
		Cin	: in bit);
end CSA;

architecture CSA_arch of CSA is
begin
	Sout <=  (A AND B) XOR Sin XOR Cin;
	Cout <= ((A AND B) AND Sin) OR (Cin AND ((A AND B) XOR Sin));
end CSA_arch;