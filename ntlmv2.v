/******************************************/
/*	By: NS 27-11-2016				   			*/
/*														*/
/* This is a beginning of an     			*/
/* HMAC-MD5 FPGA implementation for NTLMv2*/
/* password cracking								*/
/*														*/
/*	Assumptions:									*/
/* ------------									*/
/* 1. Key length is always 16 Byte 			*/
/*    since it is always MD4-ed  			*/
/*										   			*/
/* 2. userdomain should be filled			*/
/*    somehow by another entity as Unicode*/
/*    as UpperCase( user) || domain			*/
/*														*/
/* 3. Total Length of Unicode(user+domain)*/
/*    cannot be more than 447 bits, or 55 */
/*    bytes (27 characters).					*/
/*														*/
/******************************************/
module ntlmv2
(
	//////////// CLOCK //////////
	input 		          		MAX10_CLK1_50,

	//////////// SDRAM //////////
	/*
	output		    [12:0]		DRAM_ADDR,
	output		     [1:0]		DRAM_BA,
	output		          		DRAM_CAS_N,
	output		          		DRAM_CKE,
	output		          		DRAM_CLK,
	output		          		DRAM_CS_N,
	inout 		    [15:0]		DRAM_DQ,
	output		          		DRAM_LDQM,
	output		          		DRAM_RAS_N,
	output		          		DRAM_UDQM,
	output		          		DRAM_WE_N,
	*/
	//////////// SEG7 //////////
	output		     [7:0]		HEX0,
	output		     [7:0]		HEX1,
	output		     [7:0]		HEX2,
	output		     [7:0]		HEX3,
	output		     [7:0]		HEX4,
	output		     [7:0]		HEX5,

	//////////// KEY //////////
	input 		     [1:0]		KEY,

	//////////// LED //////////
	output		reg  [9:0]		LEDR,

	//////////// SW //////////
	input 		     [9:0]		SW,

	//////////// VGA //////////
	/*
	output		     [3:0]		VGA_B,
	output		     [3:0]		VGA_G,
	output		          		VGA_HS,
	output		     [3:0]		VGA_R,
	output		          		VGA_VS,
	*/

	input wire spi_hasReceived,								// from SPI module
	input wire[31:0] spi_dataIn,									// from SPI module
	output reg result
);

	reg [511:0] message_block/*, mess_blk*/;
	reg [31:0]  a0, b0, c0, d0;
	reg [31:0]  a0_b, b0_b, c0_b, d0_b;
	wire [31:0] a, b, c, d, pass_a, pass_b, pass_c, pass_d;
	wire [127:0] password;
	reg [31:0] a_2, b_2, c_2, d_2;
	reg [7:0] counter, tag0, tag0_b, curAdd;
	reg [15:0] min = 'h0030, max = 'h007a;
	reg md4enable;
	wire [7:0] tagOut, tagNext, tag63;
	reg [127:0] HMACkey, HMACkey_b;
	wire [127:0] HMACkeyOut, HMACkeyOut_b, outPassword;
	wire [511:0] password_chunk;
	reg [127:0] originalPassword, ntlm, savePassword;
	reg [7:0] digit0, digit1, digit2, digit3, digit4, digit5;
	reg [511:0] save2Password, save3Password, save4Password;
	
	// added NS 02-12 ///////////
	reg [15:0] userLen = 'h1c;							// debug, should be received from SPI
	reg [15:0] blobLen = 'h148;
	//////////////////////////////

	//===== PIPELINE OPERATION TAGS =====
	`define TAG_PASSWORD						'h10
	`define TAG_MD5_1							'h20
	`define TAG_MD5_2							'h30
	`define TAG_MD5_3							'h40
	`define TAG_MD5_II_1						'h50
	`define TAG_MD5_II_2						'h60
	`define TAG_MD5_II_3						'h70
	`define TAG_MD5_II_4						'h80
	`define TAG_DEBUG							'h90
	
	//===== RAM DATA =====
	reg [4:0] add;
	wire[511:0] ramData;
	reg ram_cs, write_en, out_en, ramReset, startChecking;
	

initial begin	
	ram_cs 	= 0;
	write_en = 1;
	out_en 	= 0;
	ramReset = 0;
	md4enable = 1; 
	digit0 = 0;
	digit1 = 1;
	digit2 = 2;
	digit3 = 3;
	digit4 = 4;
	digit5 = 5;
	LEDR = 0;
	result = 0;
	startChecking = 0;
end


pll		p1	(	.inclk0(MAX10_CLK1_50),
					.c0(clk));

/*wire clk;
assign clk = MAX10_CLK1_50;
*/


RamChip #( .AddressSize(5), 
			  .WordSize(512)) 
		 ram512( .clock(clk),
					.Address(add), 
					.DataO(ramData), 
					.CS(ram_cs), 
					.WE(write_en), 
					.OE(out_en), 
					.reset(resetGenerator));

					
	 
//
// prepare the UNICODE phrase
//	
Md5PrintableChunkGenerator g(
	.clk( md4enable & clk), 
	.reset(resetGenerator),					// generator is reset when this signal is low
	.min( min),
	.max( max),
	.chunk(password_chunk)					// this to be transferred to md4 below
);
//
// perform MD4 on password_chunk	
//
Md4Core md4 (	
	.clk(md4enable & clk), 
	.wb(password_chunk), 
	.a0('h67452301), 
	.b0('hefcdab89), 
	.c0('h98badcfe), 
	.d0('h10325476), 
	.a64(pass_a), 
	.b64(pass_b), 
	.c64(pass_c), 
	.d64(pass_d),
	.passwordText(password)			// output of the candidate itself
);

Md5Core md5 (
	.clk(clk), 
	.wb(message_block), 
	.a0(a0), 
	.b0(b0), 
	.c0(c0), 
	.d0(d0), 
	.tag0(tag0),
	.key0(HMACkey),
	.pass0( originalPassword),
	.a64(a), 
	.b64(b), 
	.c64(c), 
	.d64(d),
	.tag63(tag63),
	.tag64(tagOut),
	.key64(HMACkeyOut),
	.pass64(outPassword)
);


	// reset conditioner
Reset_Delay		reset( clk, resetGenerator);	
	
	
	
	// deal with RAM address according to low nibble of tagOut
/*
	always @ (tagOut or counter)
	begin
		if( resetGenerator)										// after reset has ended and RAM is ready...
		begin
		   if( counter == 1)
				add <= blobLen / 64 + userLen / 64 + 1 + 1;
			else if( counter == 2)
			begin
				ntlm <= ramData;
				add <= 0;
			end
			else 	add <= tagOut & 'h0F;						// extract the address of the next to pop MD5 task
		end
	end
*/
	always @ (negedge clk)
	begin
		if( resetGenerator)
		begin
			case (counter)
				1:			add <= blobLen / 64 + userLen / 64 + 1 + 1;
				2:   		ntlm <= ramData;
				default: add <= /*tagOut*/ tag63 & 'h0f;
			endcase
		end
	end

	
	always @ (posedge clk or negedge resetGenerator)
	begin							
		if( ~resetGenerator)
		begin
			//userLen <= ramData[31:16];
			//blobLen <= ramData[15:0];
			ram_cs 	<= 0;
			write_en <= 1;
			out_en 	<= 0;
			md4enable <= 1; 
			digit0 <= 0;
			digit1 <= 1;
			digit2 <= 2;
			digit3 <= 3;
			digit4 <= 4;
			digit5 <= 5;
			LEDR <= 0;
			result <= 0;
			startChecking <= 0;
			counter <= 0;
			userLen <= 'h1c;							
			blobLen <= 'h148;
		end
	
									// ntlm value
		/*
											
		███╗   ███╗██████╗ ██╗  ██╗ ██╗██████╗  █████╗ ███████╗███████╗██╗    ██╗ ██████╗ ██████╗ ██████╗ ██╗ 
		████╗ ████║██╔══██╗██║  ██║██╔╝██╔══██╗██╔══██╗██╔════╝██╔════╝██║    ██║██╔═══██╗██╔══██╗██╔══██╗╚██╗
		██╔████╔██║██║  ██║███████║██║ ██████╔╝███████║███████╗███████╗██║ █╗ ██║██║   ██║██████╔╝██║  ██║ ██║
		██║╚██╔╝██║██║  ██║╚════██║██║ ██╔═══╝ ██╔══██║╚════██║╚════██║██║███╗██║██║   ██║██╔══██╗██║  ██║ ██║
		██║ ╚═╝ ██║██████╔╝     ██║╚██╗██║     ██║  ██║███████║███████║╚███╔███╔╝╚██████╔╝██║  ██║██████╔╝██╔╝
		╚═╝     ╚═╝╚═════╝      ╚═╝ ╚═╝╚═╝     ╚═╝  ╚═╝╚══════╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚═╝ 
		*/
		// this first HMAC part does the inner block hash(i_key_pad ∥ message)) 
		// DO MD4 first on the candidate to get 16 byte digest
		else begin
			counter <= counter + 1;

			// only after outpassword is 0 start checking
		   if( outPassword == 0) startChecking <= 1;
			
			//
			// turn ON or OFF the password candidate generator and (in the future) the MD4 hash function
			if(( tag63 & 'hf0) == 0) md4enable <= 1;
			else if( (tag63 & 'hf0) == `TAG_PASSWORD 	||
						 (tag63 & 'hf0) == `TAG_MD5_1		||
						  (tag63 & 'hf0) == `TAG_MD5_2	||
						   (tag63 & 'hf0) == `TAG_MD5_3	||
							 (tag63 & 'hf0) == `TAG_MD5_II_1		||
							  (tag63 & 'hf0) == `TAG_MD5_II_2	||
							   (tag63 & 'hf0) == `TAG_MD5_II_3  ||
								 (tag63 & 'hf0) == `TAG_MD5_II_4)
			begin
				md4enable <= 0;
			end
			else
				md4enable <= 1;
			
			
			// wait until the 48 stage pipeline of md4 passwords is full
			if( counter >= 48)
			begin				
				counter <= 48;
				
				if( (tagOut & 'hf0) == `TAG_MD5_II_4)
				begin
					a0 <= a;
					b0 <= b;
					c0 <= c;
					d0 <= d;
					
					message_block <= HMACkeyOut | ('h80 << (16*8)) | (((16+64) * 8) << 448);	// PAD
					tag0 <= 0;				// restart state machine
					originalPassword <= outPassword;
					// run the md4 also ????????
				end
				else if((tagOut & 'hf0) == `TAG_MD5_II_3)
				begin
					a0 <= 'h67452301;
					b0 <= 'hefcdab89;
					c0 <= 'h98badcfe;
					d0 <= 'h10325476;
					
					message_block <= ({ 384'b00, HMACkeyOut }  ^ 512'h5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c);
					HMACkey <= { d, c, b, a };		// save the result of the previous HASH to be used as the message next				end
					tag0 <= `TAG_MD5_II_4;
					originalPassword <= outPassword;
				end
			
				//
				// MD5 II 2
				//
				else if( (tagOut & 'hf0) == `TAG_MD5_II_2)
				begin
					a0 <= a;
					b0 <= b;
					c0 <= c;
					d0 <= d;
					
					HMACkey <= HMACkeyOut;			// continue rolling the dice...

					// if message contains less than 64 bytes of data or message ended
					curAdd = tagOut ^ `TAG_MD5_II_2;		// remove the TAG_MD5_1 to remain with address only
					if( curAdd == 0)
					begin
							message_block <= (((64 + blobLen) * 8) << 448);
							tag0 <= `TAG_MD5_II_3;		// advance to next address and next state machine
							originalPassword <= outPassword;
					end
					else if(( curAdd - ((userLen >> 6) + 1) == (blobLen >> 6)))		// if end of 1st message ---> PAD
					begin											// : 64 message is less than 64 bytes long
					   if( blobLen % 64 >= 56)				// if bigger than 56 can't fully PAD this message, wait for next message to PAD
						begin
							message_block <= ramData | ('h80 << ((blobLen % 64) * 8));
							tag0 <= `TAG_MD5_II_2 | 0;		
							originalPassword <= outPassword;
						end
						else
						begin
							message_block <= ramData | ('h80 << ((blobLen % 64) * 8)) | (((64 + blobLen) * 8) << 448);
							tag0 <= `TAG_MD5_II_3 | (curAdd + 1);		// advance to next address and next state machine
							originalPassword <= outPassword;
						end
					end
					else begin											// when more than 64 bytes in the User+Domain
						message_block <= ramData;
						tag0 <= `TAG_MD5_II_2 | (curAdd + 1);		// send with address of RAM inside
						originalPassword <= outPassword;
					   /*
						if( curAdd == 3)
							savePassword <= ramData;
						*/
					end
				end
				else if((tagOut & 'hf0) == `TAG_MD5_II_1)
				begin
					a0 <= 'h67452301;
					b0 <= 'hefcdab89;
					c0 <= 'h98badcfe;
					d0 <= 'h10325476;
					
					message_block <= ({ 384'b00, d, c, b, a } ^ 512'h36363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636);
					HMACkey <= { d, c, b, a };		   // save the result for future use in next part of HMAC
					
					curAdd = tagOut ^ `TAG_MD5_II_1;	// remove the TAG_MD5_1 to remain with address only
					tag0 <= `TAG_MD5_II_2 | curAdd;
					originalPassword <= outPassword;
				end // TAG Second MD5 #1
				else if( (tagOut & 'hf0) == `TAG_MD5_3)
				begin
					a0 <= a;
					b0 <= b;
					c0 <= c;
					d0 <= d;
					
					message_block <= { 384'b00, HMACkeyOut } | ('h80 << (16*8)) | (((16+64) * 8) << 448);	// PAD
					tag0 <= `TAG_MD5_II_1 | (tagOut ^ `TAG_MD5_3);
					originalPassword <= outPassword;
				end
				//
				// MD5 2
				//
				else if((tagOut & 'hf0) == `TAG_MD5_2)
				begin
					a0 <= 'h67452301;
					b0 <= 'hefcdab89;
					c0 <= 'h98badcfe;
					d0 <= 'h10325476;
					
					message_block <= ({ 384'b00, HMACkeyOut } ^ 512'h5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c);
					HMACkey <= { d, c, b, a };		// save the result of the previous HASH to be used as the message next				end
					tag0 <= `TAG_MD5_3 | (tagOut ^ `TAG_MD5_2);
					originalPassword <= outPassword;
				end
				//
				//>>>  MD5 1
				//
				else if( (tagOut & 'hf0) == `TAG_MD5_1)
				begin
					a0 <= a;
					b0 <= b;
					c0 <= c;
					d0 <= d;
					
					HMACkey <= HMACkeyOut;			// continue rolling the dice...

					// if message contains less than 64 bytes of data or message ended
					curAdd = tagOut ^ `TAG_MD5_1;	// remove the TAG_MD5_1 to remain with address only
					if(( curAdd == (userLen >> 6)))		// if end of 1st message ---> PAD
					begin											// : 64 message is less than 64 bytes long
						message_block <= ramData | ('h80 << ((userLen % 64)* 8)) | (((64 + userLen) * 8) << 448);
						tag0 <= `TAG_MD5_2 | (curAdd + 1);		// advance to next address and next state machine
						originalPassword <= outPassword;
						
/*						
						// DEBUG!!!!
						if( (outPassword & 128'hffff) == 128'h8030 && startChecking)
						begin
							save2Password <= { 384'h00, d, c, b, a };
							save3Password <= { 384'h00, HMACkeyOut };
						end
*/
					end
					else begin											// when more than 64 bytes in the User+Domain
						message_block <= ramData;
						tag0 <= `TAG_MD5_1 | (curAdd + 1);		// send with address of RAM inside
						originalPassword <= outPassword;
					end
				end
				//
				//
				// <--- D E B U G --->
				//
				//
				/*
				else if( (tagOut & 'hf0) == `TAG_DEBUG)
				begin
					if( tagOut == 'h90)
					begin
						save3Password <= { 384'b00, outPassword };
						save4Password <= { 384'b00, HMACkeyOut };
					end
				end
				*/
				//
				// MD4 output is brought here
				//
				else //----- should push MD4 output into the md5

				begin
					// if the end of the whole NTLMV2 and have NTLM answer in { d, c, b, a }
					if( tagOut == 0) begin
						if( !result)
						begin
							// test this result against NTLM value
							if( {d, c, b, a} == ntlm)
							begin
								LEDR <= 'hAA;
								result <= 1;
								
								savePassword <= outPassword;
								/*
								a_2 <= a;
								b_2 <= b;
								c_2 <= c;
								d_2 <= d;
								*/
							end
							/*
							else if( (outPassword & 128'hffff) == 128'h8030 && startChecking && counter >= 48)
							begin
								LEDR <= 'h303;
								result <= 1;
								savePassword <= outPassword;
								a_2 <= a;
								b_2 <= b;
								c_2 <= c;
								d_2 <= d;
							end
							*/
							else begin
								//result <= 0;
								savePassword <= outPassword;
							end							
						end

						if( KEY[1])
						begin
							digit0 <= (~KEY[0]) ? savePassword[3:0]   : savePassword[27:24];
							digit1 <= (~KEY[0]) ? savePassword[7:4]   : savePassword[31:28];		
							digit2 <= (~KEY[0]) ? savePassword[11:8]  : savePassword[35:32];
							digit3 <= (~KEY[0]) ? savePassword[15:12] : savePassword[39:36];
							digit4 <= (~KEY[0]) ? savePassword[19:16] : savePassword[43:40];
							digit5 <= (~KEY[0]) ? savePassword[23:20] : savePassword[47:44];
						end
						else begin
							digit0 <= (~KEY[0]) ? savePassword[51:48] : savePassword[75:72];
							digit1 <= (~KEY[0]) ? savePassword[55:52] : savePassword[79:76];		
							digit2 <= (~KEY[0]) ? savePassword[59:56] : savePassword[83:80];
							digit3 <= (~KEY[0]) ? savePassword[63:60] : savePassword[87:84];
							digit4 <= (~KEY[0]) ? savePassword[67:64] : savePassword[91:88];
							digit5 <= (~KEY[0]) ? savePassword[71:68] : savePassword[95:92];
						end
					end
						

					//end
/*					
						if( KEY[1]) // key1 not pressed
						begin
							case (SW)
									0:
									begin
										digit0 <= savePassword[3:0];
										digit1 <= savePassword[7:4];
										digit2 <= savePassword[11:8];
										digit3 <= savePassword[15:12];
										digit4 <= savePassword[19:16];
										digit5 <= savePassword[23:20];
									end
									1:
									begin
										digit0 <= savePassword[27:24];
										digit1 <= savePassword[31:28];		
										digit2 <= savePassword[35:32];
										digit3 <= savePassword[39:36];
										digit4 <= savePassword[43:40];
										digit5 <= savePassword[47:44];
									end
									2:
									begin
										digit0 <= savePassword[51:48];
										digit1 <= savePassword[55:52];		
										digit2 <= savePassword[59:56];
										digit3 <= savePassword[63:60];
										digit4 <= savePassword[67:64];
										digit5 <= savePassword[71:68];
									end
									3:
									begin
										digit0 <= savePassword[75:72];
										digit1 <= savePassword[79:76];		
										digit2 <= savePassword[83:80];
										digit3 <= savePassword[87:84];
										digit4 <= savePassword[91:88];
										digit5 <= savePassword[95:92];
									end
									4:
									begin
										digit0 <= savePassword[99:96];
										digit1 <= savePassword[103:100];		
										digit2 <= savePassword[107:104];
										digit3 <= savePassword[111:108];
										digit4 <= savePassword[115:112];
										digit5 <= savePassword[119:116];
									end
									5:
									begin
										digit0 <= savePassword[123:120];
										digit1 <= savePassword[127:124];		
										digit2 <= 0;
										digit3 <= 0;
										digit4 <= 0;
										digit5 <= 0;
									end
									6:
									begin
										digit0 <= blobLen[3:0];
										digit1 <= blobLen[7:4];		
										digit2 <= blobLen[11:8];
										digit3 <= blobLen[15:12];	
										digit4 <= userLen[3:0];
										digit5 <= userLen[7:4];
									end
							endcase
						end
					end
					*/

	
					a0 <= 'h67452301;
					b0 <= 'hefcdab89;
					c0 <= 'h98badcfe;
					d0 <= 'h10325476;
					
					//mess_blk <= { 384'b00, pass_d, pass_c, pass_b, pass_a };
					//message_block <= (mess_blk ^ 512'h36363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636);
					//HMACkey <= mess_blk;	// save the MD4(password) result for future use in next part of HMAC
					
					message_block <= ({ 384'b00, pass_d, pass_c, pass_b, pass_a } ^ 512'h36363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636);
					HMACkey <= {pass_d, pass_c, pass_b, pass_a};	// save the MD4(password) result for future use in next part of HMAC
					tag0 <= `TAG_MD5_1 | 0;
					originalPassword <= password;
				end
			end // endif counter >= 48
		end // endif controllerstate
	end // end always clk block	
		
		
		

SEG7_LUT	SEG7_LUT_ch (
	.oSEG(HEX5),
	.iDIG(digit5)
);

SEG7_LUT	SEG7_4 (
	.oSEG(HEX4),
	.iDIG(digit4)
);

SEG7_LUT	SEG7_LUT_v (
	.oSEG(HEX3),
	.iDIG(digit3)
);

SEG7_LUT	SEG7_LUT_2 (
	.oSEG(HEX2),
	.iDIG(digit2)
);

SEG7_LUT	SEG7_LUT_1 (
	.oSEG(HEX1),
	.iDIG(digit1)
);

SEG7_LUT	SEG7_LUT_0 (
	.oSEG(HEX0),
	.iDIG(digit0)
);

		
		
		/*
		
		//███╗   ███╗██████╗ ███████╗     ██╗
		//████╗ ████║██╔══██╗██╔════╝    ███║
		//██╔████╔██║██║  ██║███████╗    ╚██║
		//██║╚██╔╝██║██║  ██║╚════██║     ██║
		//██║ ╚═╝ ██║██████╔╝███████║     ██║
		//╚═╝     ╚═╝╚═════╝ ╚══════╝     ╚═╝
		
		//
		// take the candidate digest from MD4 and stick it into the first HMAC-MD5
		else if( controllerState == `Controller_first_md5)
		begin
			if( counter == 0)
			begin
				md4enable = 0;				// disable md4 when its already on the way
				if( haveResult)
				begin
					result <= { d, c, b, a };			// take this result and compare it to the NTLM to see if we have a match
					haveResult <= 0;
				end
				
				// read from RAM512
				userdomain = ramData;
			
				a0 = 'h67452301;
				b0 = 'hefcdab89;
				c0 = 'h98badcfe;
				d0 = 'h10325476;

				if( HMACcounter == 1)
					message_block = { d, c, b, a} ^ 'h36363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636;
				else 
					message_block = {pass_d,pass_c,pass_b,pass_a} ^ 'h36363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636;

				md5enable = 1;

	
				//md5CoreRun(	message_block, a0, b0, c0, d0, a, b, c, d);

				
				// <---PADDING---> prepare the first userdomain hash
				if( udLength >> 6 == 0)
				begin
					udmessage = userdomain | ('h80 << (udLength * 8));
					udmessage[511:448] = ((64 + udLength) * 8);
				end
				else begin
					add = add + 1;
					tempUDlen = udLength - 64;
					udmessage = userdomain;

					// need for the data to stabilize???
					userdomain = ramData;
					userdomain = ramData;
					userdomain = ramData;
					userdomain = ramData;

				end
				counter <= counter + 1;
			end
			else begin
				// read result from previous MC5
				a0 = a;
				b0 = b;
				c0 = c;
				d0 = d;
			
				message_block = udmessage;

				md5enable = 1;

				///md5CoreRun(	message_block, a0, b0, c0, d0, a, b, c, d);
				

				// prepare the first userdomain hash
				if(( tempUDlen >> 6) == 0 && ( udLength >> 6) > 0)
				begin
					udmessage <= userdomain | ('h80 << (tempUDlen * 8));
					udmessage[511:448] <= ((64 + udLength) * 8);
					controllerState <= `Controller_second_md5;
					counter <= 0;
				end
				else if(( udLength >> 6) == 0)
				begin
					controllerState <= `Controller_second_md5;
					counter <= 0;
				end			
				else begin
					// stablilize data?
					udmessage = ramData;
					udmessage = ramData;
					udmessage = ramData;
					udmessage = ramData;

					add = add + 1;
					counter = counter + 1;
					tempUDlen = tempUDlen - 64;
				end
			end
		end
		
		//
		//	███╗   ███╗██████╗ ███████╗    ██████╗ 
		//	████╗ ████║██╔══██╗██╔════╝    ╚════██╗
		//	██╔████╔██║██║  ██║███████╗     █████╔╝
		//	██║╚██╔╝██║██║  ██║╚════██║    ██╔═══╝ 
		//	██║ ╚═╝ ██║██████╔╝███████║    ███████╗
		//	╚═╝     ╚═╝╚═════╝ ╚══════╝    ╚══════╝
		
		else if( controllerState == `Controller_second_md5)
		begin
			if( counter == 0)
			begin
			// save hash result and perform outer block hash
				ma0 = a;
				mb0 = b;
				mc0 = c;
				md0 = d;

				a0 = 'h67452301;
				b0 = 'hefcdab89;
				c0 = 'h98badcfe;
				d0 = 'h10325476;
				message_block = {pass_d,pass_c,pass_b,pass_a} ^ 'h5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c;
				
				md5enable = 1;
				
				//md5CoreRun(	message_block, a0, b0, c0, d0, a, b, c, d);
				
				counter <= counter + 1;

				if( HMACcounter == 1)
				begin
					md4enable = 1;				// calculate md4 on next candidate password
					add = 0;
				end
				else
					add <= add + 1;				// advance to next data on the RAM (NTLMV2 blob)
					
				ram_cs <= 0;					// prepare for next clock's md5 by reading userdomain data from RAM
				out_en <= 0;
			end
			else begin
				md4enable = 0;
				a0 = a;
				b0 = b;
				c0 = c;
				d0 = d;
				message_block = {md0,mc0,mb0,ma0} | x_keydata;
				
				md5enable = 1;
				
			//	md5CoreRun(	message_block, a0, b0, c0, d0, a, b, c, d);
				
				counter <= 0;
				//md5enable <= 0;
				controllerState <= `Controller_first_md5;
				userdomain = ramData;
				if( HMACcounter == 1)
				begin
					haveResult <= 1;
					HMACcounter <= 0;
					udLength <= userLen;
					tempUDlen <= userLen;
				end
				else
				begin
					udLength <= blobLen;
					tempUDlen <= blobLen;
					HMACcounter <= HMACcounter + 1;
				end
			end
		end
	end	
*/	



/*
////////////////////////////////////////////////////////////
// COMMUNICATIONS PROTOCOL WITH SPI MASTER	
////////////////////////////////////////////////////////////

`define Control_Waiting 				'h1
`define Control_SetLengthUserDomain	'h2
`define Control_SetLengthBlob			'h3
`define Control_SetExpectedC			'h4
`define Control_SetExpectedD			'h5
`define Control_SetRange				'h6
`define Control_GetData					'h7

`define Command_NoOp                'h00000000

`define Command_ResetGenerator 		'h52300000
`define Command_StartGenerator 		'h52300001

`define Command_SetLengthUserDomain	'h52301000
`define Command_SetLengthBlob			'h52301010
`define Command_SetExpectedC		 	'h52301002
`define Command_SetExpectedD		 	'h52301003


`define Command_SetRange				'h52302000

`define Command_GetCountLow         'h52303000
`define Command_GetCountHigh        'h52303001


`define command_SetChunkData0			'h52304000
`define command_SetChunkData1			'h52304001
`define command_SetChunkData2			'h52304002
`define command_SetChunkData3			'h52304003
`define command_SetChunkData4			'h52304004
`define command_SetChunkData5			'h52304005
`define command_SetChunkData6			'h52304006
`define command_SetChunkData7			'h52304007
`define command_SetChunkData8			'h52304008
`define command_SetChunkData9			'h52304009
`define command_SetChunkData10		'h5230400A
`define command_SetChunkData11		'h5230400B
`define command_SetChunkData12		'h5230400C
`define command_SetChunkData13		'h5230400D
`define command_SetChunkData14		'h5230400E
`define command_SetChunkData15		'h5230400F


reg [7:0] controlState = `Control_Waiting, innerAdd;
reg [31:0] chunk[0:15];

always @(posedge spi_hasReceived)
	begin
		case (controlState)
			`Control_Waiting:
				begin
					case (spi_dataIn)
						`Command_ResetGenerator: 
							begin
								resetGenerator <= 1;
								//reset2 <= 1;
							end
						`Command_StartGenerator: 
							begin
								resetGenerator <= 0;
								//reset2 <= 0;
							end
						`Command_SetLengthUserDomain: 
							begin 
								controlState <= `Control_SetLengthUserDomain;
							end
						`Command_SetLengthBlob: 
							begin 
								controlState <= `Control_SetLengthBlob;
							end
							
						`command_SetChunkData0,
						`command_SetChunkData1,
						`command_SetChunkData2,
						`command_SetChunkData3,
						`command_SetChunkData4,
						`command_SetChunkData5,
						`command_SetChunkData6,
						`command_SetChunkData7,
						`command_SetChunkData8,
						`command_SetChunkData9,
						`command_SetChunkData10,
						`command_SetChunkData11,
						`command_SetChunkData12,
						`command_SetChunkData13,
						`command_SetChunkData14,
						`command_SetChunkData15:
						begin
								controlState <= `Control_GetData;
								innerAdd <= spi_dataIn[7:0];
						end
						

						//`Command_SetExpectedB: controlState <= `Control_SetExpectedB;
						//`Command_SetExpectedC: controlState <= `Control_SetExpectedC;
						//`Command_SetExpectedD: controlState <= `Control_SetExpectedD;
						//`Command_SetRange: controlState <= `Control_SetRange;
                  ////`Command_GetCountLow: dataOut <= count[31:0];
                  //`Command_GetCountHigh: dataOut <= count[63:32];
					endcase					
				end
				
			// *---- CONTROLS ----*
			`Control_SetLengthUserDomain:
				begin
					_userLen <= spi_dataIn[15:0];
					controlState <= `Control_Waiting;
				end
			`Control_SetLengthBlob:
				begin
					_blobLen <= spi_dataIn[15:0];
					controlState <= `Control_Waiting;
				end
				
			`Control_GetData:
			begin
				chunk[innerAdd] <= spi_dataIn;
				controlState <= `Control_Waiting;
			end
			
		endcase	
	end
*/
	
endmodule  
	
	