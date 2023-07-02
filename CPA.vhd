entity CPA is 
	port (	Sout	: out bit;
		Cout	: out bit;
		A	: in bit;
		B	: in bit;
		Cin	: in bit);
end CPA;

architecture CPA_arch of CPA is
begin
	Sout <= A XOR B XOR Cin;
	Cout <= (A AND B) OR (Cin AND (A AND B));
end CPA_arch;