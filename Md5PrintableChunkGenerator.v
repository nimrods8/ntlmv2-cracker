`define Offset(__ofs) (__ofs) * 8 + 7 : (__ofs) * 8
`define Offset16(__ofs) (__ofs) * 8 +15 : (__ofs) * 8
`define Byte(__ofs) chunk[`Offset(__ofs)]
`define Word(__ofs) chunk[`Offset16(__ofs)]
`define Padding 'h80


`define IsMax(__ofs) (`Word(__ofs) == max)
`define SetMin(__ofs) `Word(__ofs) <= min
`define SetPadding(__ofs) `Byte(__ofs) <= `Padding; paddingOffset <= __ofs
`define SetSize(__size) chunk[479:448] <= ((__size) * 8)
`define SetPaddingAndSize(__ofs) `SetPadding(__ofs); `SetSize(__ofs)
//`define Increment(__ofs) `Word(2*__ofs) <= `Word(2*__ofs) + 1
//
// SKIP UNWANTED CHARACTERS														  // was 41
`define Increment(__ofs) `Word(2*__ofs) <= ((`Word(2*__ofs) == 'h0039) ? 'h0061 : \
														 (`Word(2*__ofs) == 'h005a) ? 'h0061 : `Word(2*__ofs) + 1)

module Md5PrintableChunkGenerator(
	input wire clk,
	input wire reset,								// 0 here resets the generator
	input wire [15:0] min,						// UNICODE start character to inject as password
	input wire [15:0] max,						// UNICODE end character to inject as password
	output reg [511:0] chunk = 0
);

reg [7:0] paddingOffset = 0;



always @(posedge clk or negedge reset)
	begin
		if (reset == 0)
		begin
			chunk <= 0;
			paddingOffset <= 0;
		end
		else begin
			if( paddingOffset == 0) 
			begin
				`SetMin( 0);
				`SetPaddingAndSize( 2);
			end  	      
			else	begin 
             if( `IsMax( 0))
             begin
                `SetMin( 0);
                if( paddingOffset == 0 + 2)
                begin
                   `SetMin( 2);
                   `SetPaddingAndSize(2 + 2);
                end
                else begin
                    if( `IsMax( 2))
                    begin
                       `SetMin( 2);
                       if( paddingOffset == 2 + 2)
                       begin
                          `SetMin( 4);
                          `SetPaddingAndSize(4 + 2);
                       end
                       else begin
                           if( `IsMax( 4))
                           begin
                              `SetMin( 4);
                              if (paddingOffset == 4 + 2)
                              begin
                                 `SetMin( 6);
                                 `SetPaddingAndSize(6 + 2);
                              end
                              else begin
                                 if( `IsMax( 6))
                                 begin
 											   `SetMin( 6);
 											   if( paddingOffset == 6 + 2)
                                    begin
                                       `SetMin( 8);
													`SetPaddingAndSize(8 + 2);
											   end
 											   else begin
                                       if( `IsMax( 8))
													begin
													   `SetMin( 8);
                                          if( paddingOffset == 8 + 2)
													   begin
															`SetMin(10);
															`SetPaddingAndSize(10 + 2);
                                          end
 													   else begin
															if( `IsMax( 10))
														    begin
															    `SetMin( 10);
 																 if( paddingOffset == 10 + 2)
																 begin
																    `SetMin( 12);
																	 `SetPaddingAndSize(12 + 2);
																 end
																 else begin
                                                    if( `IsMax( 12))
                                                    begin
                                                       `SetMin( 12);
                                                       if (paddingOffset == 12 + 2)
                                                       begin
                                                          `SetMin( 14);
                                                          `SetPaddingAndSize( 14 + 2);
                                                       end
                                                       else begin
                                                          if( `IsMax( 14))
                                                          begin
                                                             `SetMin( 14);
                                                             if( paddingOffset == 14 + 2)
																				 begin
																					 `SetMin( 16);
																					 `SetPaddingAndSize( 16 + 2);
																				 end
																			    else begin
																					 if( `IsMax( 16))
																					 begin
																						 `SetMin( 16);
																						 if( paddingOffset == 16 + 2)
																							begin
																							   `SetMin( 16 + 2);
																								`SetPaddingAndSize(16 + 4);
																							end
																						   else begin
																								 if( `IsMax( 18))
																								 begin
																									 `SetMin( 18);
																									  if( paddingOffset == 18 + 2)
																								     begin
																										  `SetMin( 18 + 2);
																										  `SetPaddingAndSize( 18 + 4);
																									  end
																									  else begin																																	 
																										   if( `IsMax( 20))
																											begin
																											   `SetMin( 20);
																											   if( paddingOffset == 20 + 2)
																												begin
																													`SetMin(20 + 2);
																													`SetPaddingAndSize(20 + 4);
																												end
																											   else begin
																													 if( `IsMax( 22))
																													  begin
																														  `SetMin( 22);
																														  if( paddingOffset == 22 + 2)
																													     begin
																															  `SetMin(22 + 2);
																															  `SetPaddingAndSize(22 + 4);
																														  end
																														  else begin
																															   if( `IsMax( 24))
																																begin
																																  `SetMin( 24);
																																	if (paddingOffset == 24 + 2)
																																	begin
																																		`SetMin( 24 + 2);
																																		`SetPaddingAndSize(24 + 4);
																																	end
																																else begin
																																	 if( `IsMax( 26))
																																	 begin
																	   															    `SetMin( 26);
																																		 if( paddingOffset == 26 + 2)
																																		 begin
																																			 `SetMin( 26 + 2);
																																			 `SetPaddingAndSize(26 + 4);
																																		 end
																																		 else begin
																																			  if( `IsMax( 28))
																																			  begin
																																				  `SetMin( 28);	
																																				  if (paddingOffset == 28 + 2)
																																					begin
																																					   `SetMin( 28 + 2);
																																					   `SetPaddingAndSize( 28 + 4);
																																					end
																																				   else begin
																																						 if( `IsMax( 30))
																																						 begin
																																							   `SetMin( 30);
																																							   if( paddingOffset == 30 + 2)
																																								begin																																																																						
																																								   `SetMin( 30 + 2);
																																								   `SetPaddingAndSize( 30 + 4);
																																							   end
																																						      else begin
																																									 chunk <= 0;
																																							   end
																																						 end
																																						 else begin	// UNICODE 15 is smaller than max
																																							  `Increment(15);
																																						 end
																																				   end
																																				end
 																																		      else begin		// UNICODE 14 is smaller than max
																																				    `Increment(14);
																																			   end
																																		   end
																															         end
																																		else begin				// UNICODE 13 is smaller than max
																																			 `Increment(13);
																																		end
																																	end
																																end	
																																else begin
																															       `Increment(12);
																															   end
																															end
																														end
																														else begin
																															 `Increment(11);
																													   end
																													end
																												end
																												else begin
																												   `Increment(10);
																												end																										
																											 end
																										  end
																										  else begin
 																											   `Increment(9);
																										  end
																										end
																									end
																									else begin
																										 `Increment(8);
																								   end
																								 end
																							 end
																							 else begin
																							     `Increment(7);
																							 end
																						 end
																					end
																				   else begin
																						 `Increment(6);
																					end
                                                            end
                                                         end
                                                         else begin
																				 `Increment(5);
																			end
                                                      end
                                                   end
                                                   else begin
																		 `Increment(4);
                                                   end
                                                 end
                                              end
                                              else begin
                                                  `Increment(3);
                                              end
                                           end
                                        end
                                        else begin
														  `Increment(2);
													 end
											    end
										    end
											 else begin
												  `Increment(1);
											 end
										end
									end
								   else begin
										 `Increment(0);
									end
								end
							end
						end
	
endmodule


