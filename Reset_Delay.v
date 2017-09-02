module	Reset_Delay(iCLK,nRESET);
input		iCLK;
output reg	nRESET;
reg	[19:0]	Cont;


initial Cont = 0;

always@(posedge iCLK)
begin
	if(Cont!=20'hFFFFF)
	begin
		Cont	<=	Cont+1;
		nRESET	<=	1'b0;
	end
	else
	nRESET	<=	1'b1;
end

endmodule