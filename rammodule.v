// RAM Model  -------> THIS IS ACTUALLY A ROM NOW!
//
// +-----------------------------+
// |    Copyright 1996 DOULOS    |
// |       Library: Memory       |
// |   designer : John Aynsley   |
// +-----------------------------+

module RamChip (clock, Address, DataI, DataO, CS, WE, OE, reset);

parameter AddressSize = 1;
parameter WordSize = 1;

input clock;
input [AddressSize-1:0] Address;
input [WordSize-1:0] DataI;
output reg [WordSize-1:0] DataO;
input CS, WE, OE, reset;
integer i;

/*(* ram_init_file = "ntlmv2.mif" *) */ reg [WordSize-1:0] Mem[0:(1<<AddressSize)-1];

always @ (posedge clock or negedge reset)
begin
	if( ~reset)
	begin
	// this is the data of the SMB packet of NTLMv2 authentication
		Mem[0] <= 512'h0053004C004F0056002D00520049004D0049004C0052004500530055;	// user+domain
		//
		// blob data
		Mem[1] <= 512'h00520050002D004E00490057001E000100330042004D00530008000200000000EC05C1E4754A359001D209DE503165C000000000000001018877665544332211; 
		Mem[2] <= 512'h00390034004800520050002D004E0049005700340003006C00610063006F006C002E00330042004D005300140004005600460041005100520032003900340048;
		Mem[3] <= 512'h65C000080007006C00610063006F006C002E00330042004D005300140005006C00610063006F006C002E00330042004D0053002E005600460041005100520032;
		Mem[4] <= 512'hB127188E9744CA30A1F28D88D50DFAC04A0D37BF293A624908FA6E2B3A080000200000000001000000000000003000300008000000020004000601D209DE5031;
		Mem[5] <= 512'h0000000000350031002E0031002E003800360031002E003200390031002F007300660069006300220009000000000000000000000000000000000010000A2D25;
		Mem[6] <= 512'h0000000000000000;
		// NTLM 
		//Mem[7] <= 512'h5afb04b3756eb917d16f715f38b8a9db; // = 120972 (6)
		Mem[7] <= 512'h7a7315c2a0195d74381fff267cc6a15e;	// = ns120972 (8)
	end
	else begin
		DataO <= (Address < (1<<AddressSize)) ? Mem[Address] : {WordSize{1'bz}};
	end
end
// I use the console output of **manageVolsForm** project to copy the SMB data up here

/*
always @(Address)
begin
	DataO <= Mem[Address];
end
*/

/*
initial begin
   for (i = 0; i < ( 1<<AddressSize); i = i + 1) begin
     Mem[i] = (i & 'hff); 
   end	
end
*/
//assign DataO = (!CS && !OE) ? Mem[Address] : {WordSize{1'bz}};

//always @(CS or WE)
//  if (!CS && !WE)
//    Mem[Address] = DataI;

always @(WE or OE)
  if (!WE && !OE)
    $display("Operational error in RamChip: OE and WE both active");

endmodule

