`define CopyChunkWords(__lhs, __rhs) \
  __lhs[0] <= __rhs[0];         \
  __lhs[1] <= __rhs[1];         \
  __lhs[2] <= __rhs[2];         \
  __lhs[3] <= __rhs[3];         \
  __lhs[4] <= __rhs[4];         \
  __lhs[5] <= __rhs[5];         \
  __lhs[6] <= __rhs[6];         \
  __lhs[7] <= __rhs[7];         \
  __lhs[8] <= __rhs[8];         \
  __lhs[9] <= __rhs[9];         \
  __lhs[10] <= __rhs[10];       \
  __lhs[11] <= __rhs[11];       \
  __lhs[12] <= __rhs[12];       \
  __lhs[13] <= __rhs[13];       \
  __lhs[14] <= __rhs[14];       \
  __lhs[15] <= __rhs[15];       \

`define CopyDigestWords(__lhs1, __rhs1, __lhs2, __rhs2, __lhs3, __rhs3) \
  __lhs1 <= __rhs1;                                                     \
  __lhs2 <= __rhs2;                                                     \
  __lhs3 <= __rhs3;                                                     \
  
`define CopyTAG( __tag1, __tag0) 	   \
  __tag1 <= __tag0;						   \
  
  
`define CopyABCD0( __t, __f) 	         \
  sa0[__t] <= sa0[__f];						\
  sb0[__t] <= sb0[__f];						\
  sc0[__t] <= sc0[__f];						\
  sd0[__t] <= sd0[__f];						\
  HMACkey[__t] <= HMACkey[__f];			\
  origPassword[__t] <= origPassword[__f];	\
      
`define CopyABCD0f( __t, __f) 	         \
  sa0[__t] <= sa_0[__f];						\
  sb0[__t] <= sb_0[__f];						\
  sc0[__t] <= sc_0[__f];						\
  sd0[__t] <= sd_0[__f];						\
  HMACkey[__t] <= HMACkey_[__f];			\
  origPassword[__t] <= origPassword_[__f];	\
  
`define CopyABCD_( __t, __f) 	         \
  sa_0[__t] <= sa0[__f];						\
  sb_0[__t] <= sb0[__f];						\
  sc_0[__t] <= sc0[__f];						\
  sd_0[__t] <= sd0[__f];						\
  HMACkey_[__t] <= HMACkey[__f];			\
  origPassword_[__t] <= origPassword[__f];	\

module Md5Core (
  input wire clk, 
  input wire [511:0] wb, 
  input wire [31:0] a0,
  input wire [31:0] b0, 
  input wire [31:0] c0, 
  input wire [31:0] d0, 
  input wire [7:0]  tag0,
  input wire [127:0] key0,
  input wire [127:0] pass0,
  output reg [31:0] a64, 
  output reg [31:0] b64, 
  output reg [31:0] c64, 
  output reg [31:0] d64,
  output reg [7:0]  tag63,
  output reg [7:0]  tag64,
  output reg [127:0] key64,
  output reg [127:0] pass64);
  
  wire [31:0] w0 [0:15];
  assign w0[0] = wb[31:0];
  assign w0[1] = wb[63:32];
  assign w0[2] = wb[95:64];
  assign w0[3] = wb[127:96];
  assign w0[4] = wb[159:128];
  assign w0[5] = wb[191:160];
  assign w0[6] = wb[223:192];
  assign w0[7] = wb[255:224];
  assign w0[8] = wb[287:256];
  assign w0[9] = wb[319:288];
  assign w0[10] = wb[351:320];
  assign w0[11] = wb[383:352];
  assign w0[12] = wb[415:384];
  assign w0[13] = wb[447:416];
  assign w0[14] = wb[479:448];
  assign w0[15] = wb[511:480];

  reg [31:0] 
  a1, b1, c1, d1,
  a2, b2, c2, d2,
  a3, b3, c3, d3,
  a4, b4, c4, d4,
  a5, b5, c5, d5,
  a6, b6, c6, d6,
  a7, b7, c7, d7,
  a8, b8, c8, d8,
  a9, b9, c9, d9,
  a10, b10, c10, d10,
  a11, b11, c11, d11,
  a12, b12, c12, d12,
  a13, b13, c13, d13,
  a14, b14, c14, d14,
  a15, b15, c15, d15,
  a16, b16, c16, d16,
  a17, b17, c17, d17,
  a18, b18, c18, d18,
  a19, b19, c19, d19,
  a20, b20, c20, d20,
  a21, b21, c21, d21,
  a22, b22, c22, d22,
  a23, b23, c23, d23,
  a24, b24, c24, d24,
  a25, b25, c25, d25,
  a26, b26, c26, d26,
  a27, b27, c27, d27,
  a28, b28, c28, d28,
  a29, b29, c29, d29,
  a30, b30, c30, d30,
  a31, b31, c31, d31,
  a32, b32, c32, d32,
  a33, b33, c33, d33,
  a34, b34, c34, d34,
  a35, b35, c35, d35,
  a36, b36, c36, d36,
  a37, b37, c37, d37,
  a38, b38, c38, d38,
  a39, b39, c39, d39,
  a40, b40, c40, d40,
  a41, b41, c41, d41,
  a42, b42, c42, d42,
  a43, b43, c43, d43,
  a44, b44, c44, d44,
  a45, b45, c45, d45,
  a46, b46, c46, d46,
  a47, b47, c47, d47,
  a48, b48, c48, d48,
  a49, b49, c49, d49,
  a50, b50, c50, d50,
  a51, b51, c51, d51,
  a52, b52, c52, d52,
  a53, b53, c53, d53,
  a54, b54, c54, d54,
  a55, b55, c55, d55,
  a56, b56, c56, d56,
  a57, b57, c57, d57,
  a58, b58, c58, d58,
  a59, b59, c59, d59,
  a60, b60, c60, d60,
  a61, b61, c61, d61,
  a62, b62, c62, d62,
  a63, b63, c63, d63; 

  reg [31:0] 
  a_0, b_0, c_0, d_0,
  a_1, b_1, c_1, d_1,
  a_2, b_2, c_2, d_2,
  a_3, b_3, c_3, d_3,
  a_4, b_4, c_4, d_4,
  a_5, b_5, c_5, d_5,
  a_6, b_6, c_6, d_6,
  a_7, b_7, c_7, d_7,
  a_8, b_8, c_8, d_8,
  a_9, b_9, c_9, d_9,
  a_10, b_10, c_10, d_10,
  a_11, b_11, c_11, d_11,
  a_12, b_12, c_12, d_12,
  a_13, b_13, c_13, d_13,
  a_14, b_14, c_14, d_14,
  a_15, b_15, c_15, d_15,
  a_16, b_16, c_16, d_16,
  a_17, b_17, c_17, d_17,
  a_18, b_18, c_18, d_18,
  a_19, b_19, c_19, d_19,
  a_20, b_20, c_20, d_20,
  a_21, b_21, c_21, d_21,
  a_22, b_22, c_22, d_22,
  a_23, b_23, c_23, d_23,
  a_24, b_24, c_24, d_24,
  a_25, b_25, c_25, d_25,
  a_26, b_26, c_26, d_26,
  a_27, b_27, c_27, d_27,
  a_28, b_28, c_28, d_28,
  a_29, b_29, c_29, d_29,
  a_30, b_30, c_30, d_30,
  a_31, b_31, c_31, d_31,
  a_32, b_32, c_32, d_32,
  a_33, b_33, c_33, d_33,
  a_34, b_34, c_34, d_34,
  a_35, b_35, c_35, d_35,
  a_36, b_36, c_36, d_36,
  a_37, b_37, c_37, d_37,
  a_38, b_38, c_38, d_38,
  a_39, b_39, c_39, d_39,
  a_40, b_40, c_40, d_40,
  a_41, b_41, c_41, d_41,
  a_42, b_42, c_42, d_42,
  a_43, b_43, c_43, d_43,
  a_44, b_44, c_44, d_44,
  a_45, b_45, c_45, d_45,
  a_46, b_46, c_46, d_46,
  a_47, b_47, c_47, d_47,
  a_48, b_48, c_48, d_48,
  a_49, b_49, c_49, d_49,
  a_50, b_50, c_50, d_50,
  a_51, b_51, c_51, d_51,
  a_52, b_52, c_52, d_52,
  a_53, b_53, c_53, d_53,
  a_54, b_54, c_54, d_54,
  a_55, b_55, c_55, d_55,
  a_56, b_56, c_56, d_56,
  a_57, b_57, c_57, d_57,
  a_58, b_58, c_58, d_58,
  a_59, b_59, c_59, d_59,
  a_60, b_60, c_60, d_60,
  a_61, b_61, c_61, d_61,
  a_62, b_62, c_62, d_62,
  a_63, b_63, c_63, d_63; 

  reg [31:0] 
  a_i0, b_i0, c_i0, d_i0,
  a_i1, b_i1, c_i1, d_i1,
  a_i2, b_i2, c_i2, d_i2,
  a_i3, b_i3, c_i3, d_i3,
  a_i4, b_i4, c_i4, d_i4,
  a_i5, b_i5, c_i5, d_i5,
  a_i6, b_i6, c_i6, d_i6,
  a_i7, b_i7, c_i7, d_i7,
  a_i8, b_i8, c_i8, d_i8,
  a_i9, b_i9, c_i9, d_i9,
  a_i10, b_i10, c_i10, d_i10,
  a_i11, b_i11, c_i11, d_i11,
  a_i12, b_i12, c_i12, d_i12,
  a_i13, b_i13, c_i13, d_i13,
  a_i14, b_i14, c_i14, d_i14,
  a_i15, b_i15, c_i15, d_i15,
  a_i16, b_i16, c_i16, d_i16,
  a_i17, b_i17, c_i17, d_i17,
  a_i18, b_i18, c_i18, d_i18,
  a_i19, b_i19, c_i19, d_i19,
  a_i20, b_i20, c_i20, d_i20,
  a_i21, b_i21, c_i21, d_i21,
  a_i22, b_i22, c_i22, d_i22,
  a_i23, b_i23, c_i23, d_i23,
  a_i24, b_i24, c_i24, d_i24,
  a_i25, b_i25, c_i25, d_i25,
  a_i26, b_i26, c_i26, d_i26,
  a_i27, b_i27, c_i27, d_i27,
  a_i28, b_i28, c_i28, d_i28,
  a_i29, b_i29, c_i29, d_i29,
  a_i30, b_i30, c_i30, d_i30,
  a_i31, b_i31, c_i31, d_i31,
  a_i32, b_i32, c_i32, d_i32,
  a_i33, b_i33, c_i33, d_i33,
  a_i34, b_i34, c_i34, d_i34,
  a_i35, b_i35, c_i35, d_i35,
  a_i36, b_i36, c_i36, d_i36,
  a_i37, b_i37, c_i37, d_i37,
  a_i38, b_i38, c_i38, d_i38,
  a_i39, b_i39, c_i39, d_i39,
  a_i40, b_i40, c_i40, d_i40,
  a_i41, b_i41, c_i41, d_i41,
  a_i42, b_i42, c_i42, d_i42,
  a_i43, b_i43, c_i43, d_i43,
  a_i44, b_i44, c_i44, d_i44,
  a_i45, b_i45, c_i45, d_i45,
  a_i46, b_i46, c_i46, d_i46,
  a_i47, b_i47, c_i47, d_i47,
  a_i48, b_i48, c_i48, d_i48,
  a_i49, b_i49, c_i49, d_i49,
  a_i50, b_i50, c_i50, d_i50,
  a_i51, b_i51, c_i51, d_i51,
  a_i52, b_i52, c_i52, d_i52,
  a_i53, b_i53, c_i53, d_i53,
  a_i54, b_i54, c_i54, d_i54,
  a_i55, b_i55, c_i55, d_i55,
  a_i56, b_i56, c_i56, d_i56,
  a_i57, b_i57, c_i57, d_i57,
  a_i58, b_i58, c_i58, d_i58,
  a_i59, b_i59, c_i59, d_i59,
  a_i60, b_i60, c_i60, d_i60,
  a_i61, b_i61, c_i61, d_i61,
  a_i62, b_i62, c_i62, d_i62,
  a_i63, b_i63, c_i63, d_i63, b_i64; 


  
  reg [7:0] tag1,  tag2,  tag3,  tag4,  tag5,  tag6,  tag7,  tag8,
				tag9,  tag10, tag11, tag12, tag13, tag14, tag15, tag16,
				tag17, tag18, tag19, tag20, tag21, tag22, tag23, tag24,
				tag25, tag26, tag27, tag28, tag29, tag30, tag31, tag32,
				tag33, tag34, tag35, tag36, tag37, tag38, tag39, tag40,
				tag41, tag42, tag43, tag44, tag45, tag46, tag47, tag48,
				tag49, tag50, tag51, tag52, tag53, tag54, tag55, tag56,
				tag57, tag58, tag59, tag60, tag61, tag62 /*, tag63*/;

  reg [7:0] tag_0, tag_1,  tag_2,  tag_3,  tag_4,  tag_5,  tag_6,  tag_7,  tag_8,
				tag_9,  tag_10, tag_11, tag_12, tag_13, tag_14, tag_15, tag_16,
				tag_17, tag_18, tag_19, tag_20, tag_21, tag_22, tag_23, tag_24,
				tag_25, tag_26, tag_27, tag_28, tag_29, tag_30, tag_31, tag_32,
				tag_33, tag_34, tag_35, tag_36, tag_37, tag_38, tag_39, tag_40,
				tag_41, tag_42, tag_43, tag_44, tag_45, tag_46, tag_47, tag_48,
				tag_49, tag_50, tag_51, tag_52, tag_53, tag_54, tag_55, tag_56,
				tag_57, tag_58, tag_59, tag_60, tag_61, tag_62, tag_63;

				
  reg[31:0] sa0 [0:63];			// index 0 is expendable	
  reg[31:0] sb0 [0:63];				
  reg[31:0] sc0 [0:63];				
  reg[31:0] sd0 [0:63];				
  				
  reg[31:0] sa_0 [0:63];			// index 0 is expendable	
  reg[31:0] sb_0 [0:63];				
  reg[31:0] sc_0 [0:63];				
  reg[31:0] sd_0 [0:63];				
  
  reg [127:0] HMACkey[0:63];
  reg [127:0] origPassword[0:63];
  reg [127:0] HMACkey_[0:63];
  reg [127:0] origPassword_[0:63];
				
  reg [31:0] w1 [0:15];
  reg [31:0] w2 [0:15];
  reg [31:0] w3 [0:15];
  reg [31:0] w4 [0:15];
  reg [31:0] w5 [0:15];
  reg [31:0] w6 [0:15];
  reg [31:0] w7 [0:15];
  reg [31:0] w8 [0:15];
  reg [31:0] w9 [0:15];
  reg [31:0] w10 [0:15];
  reg [31:0] w11 [0:15];
  reg [31:0] w12 [0:15];
  reg [31:0] w13 [0:15];
  reg [31:0] w14 [0:15];
  reg [31:0] w15 [0:15];
  reg [31:0] w16 [0:15];
  reg [31:0] w17 [0:15];
  reg [31:0] w18 [0:15];
  reg [31:0] w19 [0:15];
  reg [31:0] w20 [0:15];
  reg [31:0] w21 [0:15];
  reg [31:0] w22 [0:15];
  reg [31:0] w23 [0:15];
  reg [31:0] w24 [0:15];
  reg [31:0] w25 [0:15];
  reg [31:0] w26 [0:15];
  reg [31:0] w27 [0:15];
  reg [31:0] w28 [0:15];
  reg [31:0] w29 [0:15];
  reg [31:0] w30 [0:15];
  reg [31:0] w31 [0:15];
  reg [31:0] w32 [0:15];
  reg [31:0] w33 [0:15];
  reg [31:0] w34 [0:15];
  reg [31:0] w35 [0:15];
  reg [31:0] w36 [0:15];
  reg [31:0] w37 [0:15];
  reg [31:0] w38 [0:15];
  reg [31:0] w39 [0:15];
  reg [31:0] w40 [0:15];
  reg [31:0] w41 [0:15];
  reg [31:0] w42 [0:15];
  reg [31:0] w43 [0:15];
  reg [31:0] w44 [0:15];
  reg [31:0] w45 [0:15];
  reg [31:0] w46 [0:15];
  reg [31:0] w47 [0:15];
  reg [31:0] w48 [0:15];
  reg [31:0] w49 [0:15];
  reg [31:0] w50 [0:15];
  reg [31:0] w51 [0:15];
  reg [31:0] w52 [0:15];
  reg [31:0] w53 [0:15];
  reg [31:0] w54 [0:15];
  reg [31:0] w55 [0:15];
  reg [31:0] w56 [0:15];
  reg [31:0] w57 [0:15];
  reg [31:0] w58 [0:15];
  reg [31:0] w59 [0:15];
  reg [31:0] w60 [0:15];
  reg [31:0] w61 [0:15];
  reg [31:0] w62 [0:15];
  reg [31:0] w63 [0:15];


  reg [31:0] w_0 [0:15];
  reg [31:0] w_1 [0:15];
  reg [31:0] w_2 [0:15];
  reg [31:0] w_3 [0:15];
  reg [31:0] w_4 [0:15];
  reg [31:0] w_5 [0:15];
  reg [31:0] w_6 [0:15];
  reg [31:0] w_7 [0:15];
  reg [31:0] w_8 [0:15];
  reg [31:0] w_9 [0:15];
  reg [31:0] w_10 [0:15];
  reg [31:0] w_11 [0:15];
  reg [31:0] w_12 [0:15];
  reg [31:0] w_13 [0:15];
  reg [31:0] w_14 [0:15];
  reg [31:0] w_15 [0:15];
  reg [31:0] w_16 [0:15];
  reg [31:0] w_17 [0:15];
  reg [31:0] w_18 [0:15];
  reg [31:0] w_19 [0:15];
  reg [31:0] w_20 [0:15];
  reg [31:0] w_21 [0:15];
  reg [31:0] w_22 [0:15];
  reg [31:0] w_23 [0:15];
  reg [31:0] w_24 [0:15];
  reg [31:0] w_25 [0:15];
  reg [31:0] w_26 [0:15];
  reg [31:0] w_27 [0:15];
  reg [31:0] w_28 [0:15];
  reg [31:0] w_29 [0:15];
  reg [31:0] w_30 [0:15];
  reg [31:0] w_31 [0:15];
  reg [31:0] w_32 [0:15];
  reg [31:0] w_33 [0:15];
  reg [31:0] w_34 [0:15];
  reg [31:0] w_35 [0:15];
  reg [31:0] w_36 [0:15];
  reg [31:0] w_37 [0:15];
  reg [31:0] w_38 [0:15];
  reg [31:0] w_39 [0:15];
  reg [31:0] w_40 [0:15];
  reg [31:0] w_41 [0:15];
  reg [31:0] w_42 [0:15];
  reg [31:0] w_43 [0:15];
  reg [31:0] w_44 [0:15];
  reg [31:0] w_45 [0:15];
  reg [31:0] w_46 [0:15];
  reg [31:0] w_47 [0:15];
  reg [31:0] w_48 [0:15];
  reg [31:0] w_49 [0:15];
  reg [31:0] w_50 [0:15];
  reg [31:0] w_51 [0:15];
  reg [31:0] w_52 [0:15];
  reg [31:0] w_53 [0:15];
  reg [31:0] w_54 [0:15];
  reg [31:0] w_55 [0:15];
  reg [31:0] w_56 [0:15];
  reg [31:0] w_57 [0:15];
  reg [31:0] w_58 [0:15];
  reg [31:0] w_59 [0:15];
  reg [31:0] w_60 [0:15];
  reg [31:0] w_61 [0:15];
  reg [31:0] w_62 [0:15];
  reg [31:0] w_63 [0:15];

  
  always @(posedge clk)
    begin
	 /*
      `CopyDigestWords(a1, d0, d1, c0, c1, b0)
      b1 <= b0 + ((((a0 + ((b0 & c0) | ((~b0) & d0)) + 'hd76aa478 + w0[0]) << 7) | ((a0 + ((b0 & c0) | ((~b0) & d0)) + 'hd76aa478 + w0[0]) >> (32 - 7))));
      `CopyChunkWords(w1, w0)
		`CopyTAG( tag1, tag0)
		//`CopyABCD0( 1, 0)
		sa0[1] <= a0;
		sb0[1] <= b0;
		sc0[1] <= c0;
		sd0[1] <= d0;
		HMACkey[1] <= key0;
		origPassword[1] <= pass0;
	*/

		`CopyDigestWords(d_0, d0, c_0, c0, b_0, b0)
		b_i1 <= (a0 + ((b0 & c0) | ((~b0) & d0)));
		`CopyChunkWords(w_0, w0)
		`CopyTAG( tag_0, tag0)
		//`CopyABCD_( 0, 0)
		sa_0[0] <= a0;
		sb_0[0] <= b0;
		sc_0[0] <= c0;
		sd_0[0] <= d0;
		HMACkey_[0] <= key0;
		origPassword_[0] <= pass0;



		`CopyDigestWords(a1, d_0, d1, c_0, c1, b_0)
		b1 <=  b_0 + (((b_i1 + 'hD76AA478 + w_0[0]) << 7) | ((b_i1 + 'hD76AA478 + w_0[0]) >> (32 - 7)));
		`CopyChunkWords(w1, w_0)
		`CopyTAG( tag1, tag_0)
		`CopyABCD0f( 1, 0)

		`CopyDigestWords(d_1, d1, c_1, c1, b_1, b1)
		b_i2 <= (a1 + ((b1 & c1) | ((~b1) & d1)));
		`CopyChunkWords(w_1, w1)
		`CopyTAG( tag_1, tag1)
		`CopyABCD_( 1, 1)

		`CopyDigestWords(a2, d_1, d2, c_1, c2, b_1)
		b2 <=  b_1 + (((b_i2 + 'hE8C7B756 + w_1[1]) << 12) | ((b_i2 + 'hE8C7B756 + w_1[1]) >> (32 - 12)));
		`CopyChunkWords(w2, w_1)
		`CopyTAG( tag2, tag_1)
		`CopyABCD0f( 2, 1)

		`CopyDigestWords(d_2, d2, c_2, c2, b_2, b2)
		b_i3 <= (a2 + ((b2 & c2) | ((~b2) & d2)));
		`CopyChunkWords(w_2, w2)
		`CopyTAG( tag_2, tag2)
		`CopyABCD_( 2, 2)

		`CopyDigestWords(a3, d_2, d3, c_2, c3, b_2)
		b3 <=  b_2 + (((b_i3 + 'h242070DB + w_2[2]) << 17) | ((b_i3 + 'h242070DB + w_2[2]) >> (32 - 17)));
		`CopyChunkWords(w3, w_2)
		`CopyTAG( tag3, tag_2)
		`CopyABCD0f( 3, 2)

		`CopyDigestWords(d_3, d3, c_3, c3, b_3, b3)
		b_i4 <= (a3 + ((b3 & c3) | ((~b3) & d3)));
		`CopyChunkWords(w_3, w3)
		`CopyTAG( tag_3, tag3)
		`CopyABCD_( 3, 3)

		`CopyDigestWords(a4, d_3, d4, c_3, c4, b_3)
		b4 <=  b_3 + (((b_i4 + 'hC1BDCEEE + w_3[3]) << 22) | ((b_i4 + 'hC1BDCEEE + w_3[3]) >> (32 - 22)));
		`CopyChunkWords(w4, w_3)
		`CopyTAG( tag4, tag_3)
		`CopyABCD0f( 4, 3)

		`CopyDigestWords(d_4, d4, c_4, c4, b_4, b4)
		b_i5 <= (a4 + ((b4 & c4) | ((~b4) & d4)));
		`CopyChunkWords(w_4, w4)
		`CopyTAG( tag_4, tag4)
		`CopyABCD_( 4, 4)

		`CopyDigestWords(a5, d_4, d5, c_4, c5, b_4)
		b5 <=  b_4 + (((b_i5 + 'hF57C0FAF + w_4[4]) << 7) | ((b_i5 + 'hF57C0FAF + w_4[4]) >> (32 - 7)));
		`CopyChunkWords(w5, w_4)
		`CopyTAG( tag5, tag_4)
		`CopyABCD0f( 5, 4)

		`CopyDigestWords(d_5, d5, c_5, c5, b_5, b5)
		b_i6 <= (a5 + ((b5 & c5) | ((~b5) & d5)));
		`CopyChunkWords(w_5, w5)
		`CopyTAG( tag_5, tag5)
		`CopyABCD_( 5, 5)

		`CopyDigestWords(a6, d_5, d6, c_5, c6, b_5)
		b6 <=  b_5 + (((b_i6 + 'h4787C62A + w_5[5]) << 12) | ((b_i6 + 'h4787C62A + w_5[5]) >> (32 - 12)));
		`CopyChunkWords(w6, w_5)
		`CopyTAG( tag6, tag_5)
		`CopyABCD0f( 6, 5)

		`CopyDigestWords(d_6, d6, c_6, c6, b_6, b6)
		b_i7 <= (a6 + ((b6 & c6) | ((~b6) & d6)));
		`CopyChunkWords(w_6, w6)
		`CopyTAG( tag_6, tag6)
		`CopyABCD_( 6, 6)

		`CopyDigestWords(a7, d_6, d7, c_6, c7, b_6)
		b7 <=  b_6 + (((b_i7 + 'hA8304613 + w_6[6]) << 17) | ((b_i7 + 'hA8304613 + w_6[6]) >> (32 - 17)));
		`CopyChunkWords(w7, w_6)
		`CopyTAG( tag7, tag_6)
		`CopyABCD0f( 7, 6)

		`CopyDigestWords(d_7, d7, c_7, c7, b_7, b7)
		b_i8 <= (a7 + ((b7 & c7) | ((~b7) & d7)));
		`CopyChunkWords(w_7, w7)
		`CopyTAG( tag_7, tag7)
		`CopyABCD_( 7, 7)

		`CopyDigestWords(a8, d_7, d8, c_7, c8, b_7)
		b8 <=  b_7 + (((b_i8 + 'hFD469501 + w_7[7]) << 22) | ((b_i8 + 'hFD469501 + w_7[7]) >> (32 - 22)));
		`CopyChunkWords(w8, w_7)
		`CopyTAG( tag8, tag_7)
		`CopyABCD0f( 8, 7)

		`CopyDigestWords(d_8, d8, c_8, c8, b_8, b8)
		b_i9 <= (a8 + ((b8 & c8) | ((~b8) & d8)));
		`CopyChunkWords(w_8, w8)
		`CopyTAG( tag_8, tag8)
		`CopyABCD_( 8, 8)

		`CopyDigestWords(a9, d_8, d9, c_8, c9, b_8)
		b9 <=  b_8 + (((b_i9 + 'h698098D8 + w_8[8]) << 7) | ((b_i9 + 'h698098D8 + w_8[8]) >> (32 - 7)));
		`CopyChunkWords(w9, w_8)
		`CopyTAG( tag9, tag_8)
		`CopyABCD0f( 9, 8)

		`CopyDigestWords(d_9, d9, c_9, c9, b_9, b9)
		b_i10 <= (a9 + ((b9 & c9) | ((~b9) & d9)));
		`CopyChunkWords(w_9, w9)
		`CopyTAG( tag_9, tag9)
		`CopyABCD_( 9, 9)

		`CopyDigestWords(a10, d_9, d10, c_9, c10, b_9)
		b10 <=  b_9 + (((b_i10 + 'h8B44F7AF + w_9[9]) << 12) | ((b_i10 + 'h8B44F7AF + w_9[9]) >> (32 - 12)));
		`CopyChunkWords(w10, w_9)
		`CopyTAG( tag10, tag_9)
		`CopyABCD0f( 10, 9)

		`CopyDigestWords(d_10, d10, c_10, c10, b_10, b10)
		b_i11 <= (a10 + ((b10 & c10) | ((~b10) & d10)));
		`CopyChunkWords(w_10, w10)
		`CopyTAG( tag_10, tag10)
		`CopyABCD_( 10, 10)

		`CopyDigestWords(a11, d_10, d11, c_10, c11, b_10)
		b11 <=  b_10 + (((b_i11 + 'hFFFF5BB1 + w_10[10]) << 17) | ((b_i11 + 'hFFFF5BB1 + w_10[10]) >> (32 - 17)));
		`CopyChunkWords(w11, w_10)
		`CopyTAG( tag11, tag_10)
		`CopyABCD0f( 11, 10)

		`CopyDigestWords(d_11, d11, c_11, c11, b_11, b11)
		b_i12 <= (a11 + ((b11 & c11) | ((~b11) & d11)));
		`CopyChunkWords(w_11, w11)
		`CopyTAG( tag_11, tag11)
		`CopyABCD_( 11, 11)

		`CopyDigestWords(a12, d_11, d12, c_11, c12, b_11)
		b12 <=  b_11 + (((b_i12 + 'h895CD7BE + w_11[11]) << 22) | ((b_i12 + 'h895CD7BE + w_11[11]) >> (32 - 22)));
		`CopyChunkWords(w12, w_11)
		`CopyTAG( tag12, tag_11)
		`CopyABCD0f( 12, 11)

		`CopyDigestWords(d_12, d12, c_12, c12, b_12, b12)
		b_i13 <= (a12 + ((b12 & c12) | ((~b12) & d12)));
		`CopyChunkWords(w_12, w12)
		`CopyTAG( tag_12, tag12)
		`CopyABCD_( 12, 12)

		`CopyDigestWords(a13, d_12, d13, c_12, c13, b_12)
		b13 <=  b_12 + (((b_i13 + 'h6B901122 + w_12[12]) << 7) | ((b_i13 + 'h6B901122 + w_12[12]) >> (32 - 7)));
		`CopyChunkWords(w13, w_12)
		`CopyTAG( tag13, tag_12)
		`CopyABCD0f( 13, 12)

		`CopyDigestWords(d_13, d13, c_13, c13, b_13, b13)
		b_i14 <= (a13 + ((b13 & c13) | ((~b13) & d13)));
		`CopyChunkWords(w_13, w13)
		`CopyTAG( tag_13, tag13)
		`CopyABCD_( 13, 13)

		`CopyDigestWords(a14, d_13, d14, c_13, c14, b_13)
		b14 <=  b_13 + (((b_i14 + 'hFD987193 + w_13[13]) << 12) | ((b_i14 + 'hFD987193 + w_13[13]) >> (32 - 12)));
		`CopyChunkWords(w14, w_13)
		`CopyTAG( tag14, tag_13)
		`CopyABCD0f( 14, 13)

		`CopyDigestWords(d_14, d14, c_14, c14, b_14, b14)
		b_i15 <= (a14 + ((b14 & c14) | ((~b14) & d14)));
		`CopyChunkWords(w_14, w14)
		`CopyTAG( tag_14, tag14)
		`CopyABCD_( 14, 14)

		`CopyDigestWords(a15, d_14, d15, c_14, c15, b_14)
		b15 <=  b_14 + (((b_i15 + 'hA679438E + w_14[14]) << 17) | ((b_i15 + 'hA679438E + w_14[14]) >> (32 - 17)));
		`CopyChunkWords(w15, w_14)
		`CopyTAG( tag15, tag_14)
		`CopyABCD0f( 15, 14)

		`CopyDigestWords(d_15, d15, c_15, c15, b_15, b15)
		b_i16 <= (a15 + ((b15 & c15) | ((~b15) & d15)));
		`CopyChunkWords(w_15, w15)
		`CopyTAG( tag_15, tag15)
		`CopyABCD_( 15, 15)

		`CopyDigestWords(a16, d_15, d16, c_15, c16, b_15)
		b16 <=  b_15 + (((b_i16 + 'h49B40821 + w_15[15]) << 22) | ((b_i16 + 'h49B40821 + w_15[15]) >> (32 - 22)));
		`CopyChunkWords(w16, w_15)
		`CopyTAG( tag16, tag_15)
		`CopyABCD0f( 16, 15)


		//=================================================
// original working 123Mhz

		`CopyDigestWords(d_16, d16, c_16, c16, b_16, b16)
		b_i17 <= (a16 +  ((d16 & b16) | (c16 & (~d16))));
		`CopyChunkWords(w_16, w16)
		`CopyTAG( tag_16, tag16)
		`CopyABCD_( 16, 16)

		`CopyDigestWords(a17, d_16, d17, c_16, c17, b_16)
		b17 <=  b_16 + (((b_i17 + 'hF61E2562 + w_16[1]) << 5) | ((b_i17 + 'hF61E2562 + w_16[1]) >> (32 - 5)));
		`CopyChunkWords(w17, w_16)
		`CopyTAG( tag17, tag_16)
		`CopyABCD0f( 17, 16)

		`CopyDigestWords(d_17, d17, c_17, c17, b_17, b17)
		b_i18 <= (a17 + w17[6] + ((d17 & b17) | (c17 & (~d17))));
		`CopyChunkWords(w_17, w17)
		`CopyTAG( tag_17, tag17)
		`CopyABCD_( 17, 17)

		`CopyDigestWords(a18, d_17, d18, c_17, c18, b_17)
		b18 <=  b_17 + (((b_i18 + 'hC040B340 /*+ w_17[6]*/) << 9) | ((b_i18 + 'hC040B340 /*+ w_17[6]*/) >> (32 - 9)));
		`CopyChunkWords(w18, w_17)
		`CopyTAG( tag18, tag_17)
		`CopyABCD0f( 18, 17)

		`CopyDigestWords(d_18, d18, c_18, c18, b_18, b18)
		b_i19 <= (a18 + w18[11] + ((d18 & b18) | (c18 & (~d18))));
		`CopyChunkWords(w_18, w18)
		`CopyTAG( tag_18, tag18)
		`CopyABCD_( 18, 18)

		`CopyDigestWords(a19, d_18, d19, c_18, c19, b_18)
		b19 <=  b_18 + (((b_i19 + 'h265E5A51 /*+ w_18[11]*/) << 14) | ((b_i19 + 'h265E5A51 /*+ w_18[11]*/) >> (32 - 14)));
		`CopyChunkWords(w19, w_18)
		`CopyTAG( tag19, tag_18)
		`CopyABCD0f( 19, 18)

		`CopyDigestWords(d_19, d19, c_19, c19, b_19, b19)
		b_i20 <= (a19 + w19[0] + ((d19 & b19) | (c19 & (~d19))));
		`CopyChunkWords(w_19, w19)
		`CopyTAG( tag_19, tag19)
		`CopyABCD_( 19, 19)

		`CopyDigestWords(a20, d_19, d20, c_19, c20, b_19)
		// original
		//b20 <=  b_19 + (((b_i20 + 'hE9B6C7AA + w_19[0]) << 20) | ((b_i20 + 'hE9B6C7AA + w_19[0]) >> (32 - 20)));
		b20 <=  b_19 + (((b_i20 + 'hE9B6C7AA /*+ w_19[0]*/) << 20) | ((b_i20 + 'hE9B6C7AA /*+ w_19[0]*/) >> (32 - 20)));
		
		`CopyChunkWords(w20, w_19)
		`CopyTAG( tag20, tag_19)
		`CopyABCD0f( 20, 19)

		`CopyDigestWords(d_20, d20, c_20, c20, b_20, b20)
		b_i21 <= (a20 + ((d20 & b20) | (c20 & (~d20))));
		`CopyChunkWords(w_20, w20)
		`CopyTAG( tag_20, tag20)
		`CopyABCD_( 20, 20)

		`CopyDigestWords(a21, d_20, d21, c_20, c21, b_20)
		b21 <=  b_20 + (((b_i21 + 'hD62F105D + w_20[5]) << 5) | ((b_i21 + 'hD62F105D + w_20[5]) >> (32 - 5)));
		`CopyChunkWords(w21, w_20)
		`CopyTAG( tag21, tag_20)
		`CopyABCD0f( 21, 20)

		`CopyDigestWords(d_21, d21, c_21, c21, b_21, b21)
		b_i22 <= (a21 + ((d21 & b21) | (c21 & (~d21))));
		`CopyChunkWords(w_21, w21)
		`CopyTAG( tag_21, tag21)
		`CopyABCD_( 21, 21)

		`CopyDigestWords(a22, d_21, d22, c_21, c22, b_21)
		b22 <=  b_21 + (((b_i22 + 'h2441453 + w_21[10]) << 9) | ((b_i22 + 'h2441453 + w_21[10]) >> (32 - 9)));
		`CopyChunkWords(w22, w_21)
		`CopyTAG( tag22, tag_21)
		`CopyABCD0f( 22, 21)

		`CopyDigestWords(d_22, d22, c_22, c22, b_22, b22)
		b_i23 <= (a22 + ((d22 & b22) | (c22 & (~d22))));
		`CopyChunkWords(w_22, w22)
		`CopyTAG( tag_22, tag22)
		`CopyABCD_( 22, 22)

		`CopyDigestWords(a23, d_22, d23, c_22, c23, b_22)
		b23 <=  b_22 + (((b_i23 + 'hD8A1E681 + w_22[15]) << 14) | ((b_i23 + 'hD8A1E681 + w_22[15]) >> (32 - 14)));
		`CopyChunkWords(w23, w_22)
		`CopyTAG( tag23, tag_22)
		`CopyABCD0f( 23, 22)

		`CopyDigestWords(d_23, d23, c_23, c23, b_23, b23)
		b_i24 <= (a23 + ((d23 & b23) | (c23 & (~d23))));
		`CopyChunkWords(w_23, w23)
		`CopyTAG( tag_23, tag23)
		`CopyABCD_( 23, 23)

		`CopyDigestWords(a24, d_23, d24, c_23, c24, b_23)
		b24 <=  b_23 + (((b_i24 + 'hE7D3FBC8 + w_23[4]) << 20) | ((b_i24 + 'hE7D3FBC8 + w_23[4]) >> (32 - 20)));
		`CopyChunkWords(w24, w_23)
		`CopyTAG( tag24, tag_23)
		`CopyABCD0f( 24, 23)

		`CopyDigestWords(d_24, d24, c_24, c24, b_24, b24)
		b_i25 <= (a24 + ((d24 & b24) | (c24 & (~d24))));
		`CopyChunkWords(w_24, w24)
		`CopyTAG( tag_24, tag24)
		`CopyABCD_( 24, 24)

		`CopyDigestWords(a25, d_24, d25, c_24, c25, b_24)
		b25 <=  b_24 + (((b_i25 + 'h21E1CDE6 + w_24[9]) << 5) | ((b_i25 + 'h21E1CDE6 + w_24[9]) >> (32 - 5)));
		`CopyChunkWords(w25, w_24)
		`CopyTAG( tag25, tag_24)
		`CopyABCD0f( 25, 24)

		`CopyDigestWords(d_25, d25, c_25, c25, b_25, b25)
		b_i26 <= (a25 + ((d25 & b25) | (c25 & (~d25))));
		`CopyChunkWords(w_25, w25)
		`CopyTAG( tag_25, tag25)
		`CopyABCD_( 25, 25)

		`CopyDigestWords(a26, d_25, d26, c_25, c26, b_25)
		b26 <=  b_25 + (((b_i26 + 'hC33707D6 + w_25[14]) << 9) | ((b_i26 + 'hC33707D6 + w_25[14]) >> (32 - 9)));
		`CopyChunkWords(w26, w_25)
		`CopyTAG( tag26, tag_25)
		`CopyABCD0f( 26, 25)

		`CopyDigestWords(d_26, d26, c_26, c26, b_26, b26)
		b_i27 <= (a26 + ((d26 & b26) | (c26 & (~d26))));
		`CopyChunkWords(w_26, w26)
		`CopyTAG( tag_26, tag26)
		`CopyABCD_( 26, 26)

		`CopyDigestWords(a27, d_26, d27, c_26, c27, b_26)
		b27 <=  b_26 + (((b_i27 + 'hF4D50D87 + w_26[3]) << 14) | ((b_i27 + 'hF4D50D87 + w_26[3]) >> (32 - 14)));
		`CopyChunkWords(w27, w_26)
		`CopyTAG( tag27, tag_26)
		`CopyABCD0f( 27, 26)

		`CopyDigestWords(d_27, d27, c_27, c27, b_27, b27)
		b_i28 <= (a27 + ((d27 & b27) | (c27 & (~d27))));
		`CopyChunkWords(w_27, w27)
		`CopyTAG( tag_27, tag27)
		`CopyABCD_( 27, 27)

		`CopyDigestWords(a28, d_27, d28, c_27, c28, b_27)
		b28 <=  b_27 + (((b_i28 + 'h455A14ED + w_27[8]) << 20) | ((b_i28 + 'h455A14ED + w_27[8]) >> (32 - 20)));
		`CopyChunkWords(w28, w_27)
		`CopyTAG( tag28, tag_27)
		`CopyABCD0f( 28, 27)

		`CopyDigestWords(d_28, d28, c_28, c28, b_28, b28)
		b_i29 <= (a28 + ((d28 & b28) | (c28 & (~d28))));
		`CopyChunkWords(w_28, w28)
		`CopyTAG( tag_28, tag28)
		`CopyABCD_( 28, 28)

		`CopyDigestWords(a29, d_28, d29, c_28, c29, b_28)
		b29 <=  b_28 + (((b_i29 + 'hA9E3E905 + w_28[13]) << 5) | ((b_i29 + 'hA9E3E905 + w_28[13]) >> (32 - 5)));
		`CopyChunkWords(w29, w_28)
		`CopyTAG( tag29, tag_28)
		`CopyABCD0f( 29, 28)

		`CopyDigestWords(d_29, d29, c_29, c29, b_29, b29)
		b_i30 <= (a29 + ((d29 & b29) | (c29 & (~d29))));
		`CopyChunkWords(w_29, w29)
		`CopyTAG( tag_29, tag29)
		`CopyABCD_( 29, 29)

		`CopyDigestWords(a30, d_29, d30, c_29, c30, b_29)
		b30 <=  b_29 + (((b_i30 + 'hFCEFA3F8 + w_29[2]) << 9) | ((b_i30 + 'hFCEFA3F8 + w_29[2]) >> (32 - 9)));
		`CopyChunkWords(w30, w_29)
		`CopyTAG( tag30, tag_29)
		`CopyABCD0f( 30, 29)

		`CopyDigestWords(d_30, d30, c_30, c30, b_30, b30)
		b_i31 <= (a30 + ((d30 & b30) | (c30 & (~d30))));
		`CopyChunkWords(w_30, w30)
		`CopyTAG( tag_30, tag30)
		`CopyABCD_( 30, 30)

		`CopyDigestWords(a31, d_30, d31, c_30, c31, b_30)
		b31 <=  b_30 + (((b_i31 + 'h676F02D9 + w_30[7]) << 14) | ((b_i31 + 'h676F02D9 + w_30[7]) >> (32 - 14)));
		`CopyChunkWords(w31, w_30)
		`CopyTAG( tag31, tag_30)
		`CopyABCD0f( 31, 30)

		`CopyDigestWords(d_31, d31, c_31, c31, b_31, b31)
		b_i32 <= (a31 + ((d31 & b31) | (c31 & (~d31))));
		`CopyChunkWords(w_31, w31)
		`CopyTAG( tag_31, tag31)
		`CopyABCD_( 31, 31)

		`CopyDigestWords(a32, d_31, d32, c_31, c32, b_31)
		b32 <=  b_31 + (((b_i32 + 'h8D2A4C8A + w_31[12]) << 20) | ((b_i32 + 'h8D2A4C8A + w_31[12]) >> (32 - 20)));
		`CopyChunkWords(w32, w_31)
		`CopyTAG( tag32, tag_31)
		`CopyABCD0f( 32, 31)




		//=================================================

		/*
		
      `CopyDigestWords(a17, d16, d17, c16, c17, b16)
      b17 <= b16 + (((a16 + ((d16 & b16) | ((~d16) & c16)) + 'hf61e2562 + w16[(5 * 16 + 1) % 16]) << 5) | ((a16 + ((d16 & b16) | ((~d16) & c16)) + 'hf61e2562 + w16[(5 * 16 + 1) % 16]) >> (32 - 5)));
      `CopyChunkWords(w17, w16)
		`CopyTAG( tag17, tag16)
		`CopyABCD0( 17, 16)

      `CopyDigestWords(a18, d17, d18, c17, c18, b17)
      b18 <= b17 + (((a17 + ((d17 & b17) | ((~d17) & c17)) + 'hc040b340 + w17[(5 * 17 + 1) % 16]) << 9) | ((a17 + ((d17 & b17) | ((~d17) & c17)) + 'hc040b340 + w17[(5 * 17 + 1) % 16]) >> (32 - 9)));
      `CopyChunkWords(w18, w17)
		`CopyTAG( tag18, tag17)
		`CopyABCD0( 18, 17)

      `CopyDigestWords(a19, d18, d19, c18, c19, b18)
      b19 <= b18 + (((a18 + ((d18 & b18) | ((~d18) & c18)) + 'h265e5a51 + w18[(5 * 18 + 1) % 16]) << 14) | ((a18 + ((d18 & b18) | ((~d18) & c18)) + 'h265e5a51 + w18[(5 * 18 + 1) % 16]) >> (32 - 14)));
      `CopyChunkWords(w19, w18)
		`CopyTAG( tag19, tag18)
		`CopyABCD0( 19, 18)

      `CopyDigestWords(a20, d19, d20, c19, c20, b19)
      b20 <= b19 + (((a19 + ((d19 & b19) | ((~d19) & c19)) + 'he9b6c7aa + w19[(5 * 19 + 1) % 16]) << 20) | ((a19 + ((d19 & b19) | ((~d19) & c19)) + 'he9b6c7aa + w19[(5 * 19 + 1) % 16]) >> (32 - 20)));
      `CopyChunkWords(w20, w19)
		`CopyTAG( tag20, tag19)
		`CopyABCD0( 20, 19)

      `CopyDigestWords(a21, d20, d21, c20, c21, b20)
      b21 <= b20 + (((a20 + ((d20 & b20) | ((~d20) & c20)) + 'hd62f105d + w20[(5 * 20 + 1) % 16]) << 5) | ((a20 + ((d20 & b20) | ((~d20) & c20)) + 'hd62f105d + w20[(5 * 20 + 1) % 16]) >> (32 - 5)));
      `CopyChunkWords(w21, w20)
		`CopyTAG( tag21, tag20)
		`CopyABCD0( 21, 20)
		
      `CopyDigestWords(a22, d21, d22, c21, c22, b21)
      b22 <= b21 + (((a21 + ((d21 & b21) | ((~d21) & c21)) + 'h02441453 + w21[(5 * 21 + 1) % 16]) << 9) | ((a21 + ((d21 & b21) | ((~d21) & c21)) + 'h02441453 + w21[(5 * 21 + 1) % 16]) >> (32 - 9)));
      `CopyChunkWords(w22, w21)
		`CopyTAG( tag22, tag21)
		`CopyABCD0( 22, 21)

      `CopyDigestWords(a23, d22, d23, c22, c23, b22)
      b23 <= b22 + (((a22 + ((d22 & b22) | ((~d22) & c22)) + 'hd8a1e681 + w22[(5 * 22 + 1) % 16]) << 14) | ((a22 + ((d22 & b22) | ((~d22) & c22)) + 'hd8a1e681 + w22[(5 * 22 + 1) % 16]) >> (32 - 14)));
      `CopyChunkWords(w23, w22)
		`CopyTAG( tag23, tag22)
		`CopyABCD0( 23, 22)

      `CopyDigestWords(a24, d23, d24, c23, c24, b23)
      b24 <= b23 + (((a23 + ((d23 & b23) | ((~d23) & c23)) + 'he7d3fbc8 + w23[(5 * 23 + 1) % 16]) << 20) | ((a23 + ((d23 & b23) | ((~d23) & c23)) + 'he7d3fbc8 + w23[(5 * 23 + 1) % 16]) >> (32 - 20)));
      `CopyChunkWords(w24, w23)
		`CopyTAG( tag24, tag23)
		`CopyABCD0( 24, 23)

      `CopyDigestWords(a25, d24, d25, c24, c25, b24)
      b25 <= b24 + (((a24 + ((d24 & b24) | ((~d24) & c24)) + 'h21e1cde6 + w24[(5 * 24 + 1) % 16]) << 5) | ((a24 + ((d24 & b24) | ((~d24) & c24)) + 'h21e1cde6 + w24[(5 * 24 + 1) % 16]) >> (32 - 5)));
      `CopyChunkWords(w25, w24)
		`CopyTAG( tag25, tag24)
		`CopyABCD0( 25, 24)

      `CopyDigestWords(a26, d25, d26, c25, c26, b25)
      b26 <= b25 + (((a25 + ((d25 & b25) | ((~d25) & c25)) + 'hc33707d6 + w25[(5 * 25 + 1) % 16]) << 9) | ((a25 + ((d25 & b25) | ((~d25) & c25)) + 'hc33707d6 + w25[(5 * 25 + 1) % 16]) >> (32 - 9)));
      `CopyChunkWords(w26, w25)
		`CopyTAG( tag26, tag25)
		`CopyABCD0( 26, 25)

      `CopyDigestWords(a27, d26, d27, c26, c27, b26)
      b27 <= b26 + (((a26 + ((d26 & b26) | ((~d26) & c26)) + 'hf4d50d87 + w26[(5 * 26 + 1) % 16]) << 14) | ((a26 + ((d26 & b26) | ((~d26) & c26)) + 'hf4d50d87 + w26[(5 * 26 + 1) % 16]) >> (32 - 14)));
      `CopyChunkWords(w27, w26)
		`CopyTAG( tag27, tag26)
		`CopyABCD0( 27, 26)

      `CopyDigestWords(a28, d27, d28, c27, c28, b27)
      b28 <= b27 + (((a27 + ((d27 & b27) | ((~d27) & c27)) + 'h455a14ed + w27[(5 * 27 + 1) % 16]) << 20) | ((a27 + ((d27 & b27) | ((~d27) & c27)) + 'h455a14ed + w27[(5 * 27 + 1) % 16]) >> (32 - 20)));
      `CopyChunkWords(w28, w27)
		`CopyTAG( tag28, tag27)
		`CopyABCD0( 28, 27)

      `CopyDigestWords(a29, d28, d29, c28, c29, b28)
      b29 <= b28 + (((a28 + ((d28 & b28) | ((~d28) & c28)) + 'ha9e3e905 + w28[(5 * 28 + 1) % 16]) << 5) | ((a28 + ((d28 & b28) | ((~d28) & c28)) + 'ha9e3e905 + w28[(5 * 28 + 1) % 16]) >> (32 - 5)));
      `CopyChunkWords(w29, w28)
		`CopyTAG( tag29, tag28)
		`CopyABCD0( 29, 28)

      `CopyDigestWords(a30, d29, d30, c29, c30, b29)
      b30 <= b29 + (((a29 + ((d29 & b29) | ((~d29) & c29)) + 'hfcefa3f8 + w29[(5 * 29 + 1) % 16]) << 9) | ((a29 + ((d29 & b29) | ((~d29) & c29)) + 'hfcefa3f8 + w29[(5 * 29 + 1) % 16]) >> (32 - 9)));
      `CopyChunkWords(w30, w29)
		`CopyTAG( tag30, tag29)
		`CopyABCD0( 30, 29)

      `CopyDigestWords(a31, d30, d31, c30, c31, b30)
      b31 <= b30 + (((a30 + ((d30 & b30) | ((~d30) & c30)) + 'h676f02d9 + w30[(5 * 30 + 1) % 16]) << 14) | ((a30 + ((d30 & b30) | ((~d30) & c30)) + 'h676f02d9 + w30[(5 * 30 + 1) % 16]) >> (32 - 14)));
      `CopyChunkWords(w31, w30)
		`CopyTAG( tag31, tag30)
		`CopyABCD0( 31, 30)

      `CopyDigestWords(a32, d31, d32, c31, c32, b31)
      b32 <= b31 + (((a31 + ((d31 & b31) | ((~d31) & c31)) + 'h8d2a4c8a + w31[(5 * 31 + 1) % 16]) << 20) | ((a31 + ((d31 & b31) | ((~d31) & c31)) + 'h8d2a4c8a + w31[(5 * 31 + 1) % 16]) >> (32 - 20)));
      `CopyChunkWords(w32, w31)
		`CopyTAG( tag32, tag31)
		`CopyABCD0( 32, 31)
*/

		//-----------------------------------------------

		`CopyDigestWords(d_32, d32, c_32, c32, b_32, b32)
		b_i33 <= (a32 + (b32 ^ c32 ^ d32));
		`CopyChunkWords(w_32, w32)
		`CopyTAG( tag_32, tag32)
		`CopyABCD_( 32, 32)

		`CopyDigestWords(a33, d_32, d33, c_32, c33, b_32)
		b33 <=  b_32 + (((b_i33 + 'hFFFA3942 + w_32[5]) << 4) | ((b_i33 + 'hFFFA3942 + w_32[5]) >> (32 - 4)));
		`CopyChunkWords(w33, w_32)
		`CopyTAG( tag33, tag_32)
		`CopyABCD0f( 33, 32)

		`CopyDigestWords(d_33, d33, c_33, c33, b_33, b33)
		b_i34 <= (a33 + (b33 ^ c33 ^ d33));
		`CopyChunkWords(w_33, w33)
		`CopyTAG( tag_33, tag33)
		`CopyABCD_( 33, 33)

		`CopyDigestWords(a34, d_33, d34, c_33, c34, b_33)
		b34 <=  b_33 + (((b_i34 + 'h8771F681 + w_33[8]) << 11) | ((b_i34 + 'h8771F681 + w_33[8]) >> (32 - 11)));
		`CopyChunkWords(w34, w_33)
		`CopyTAG( tag34, tag_33)
		`CopyABCD0f( 34, 33)

		`CopyDigestWords(d_34, d34, c_34, c34, b_34, b34)
		b_i35 <= (a34 + (b34 ^ c34 ^ d34));
		`CopyChunkWords(w_34, w34)
		`CopyTAG( tag_34, tag34)
		`CopyABCD_( 34, 34)

		`CopyDigestWords(a35, d_34, d35, c_34, c35, b_34)
		b35 <=  b_34 + (((b_i35 + 'h6D9D6122 + w_34[11]) << 16) | ((b_i35 + 'h6D9D6122 + w_34[11]) >> (32 - 16)));
		`CopyChunkWords(w35, w_34)
		`CopyTAG( tag35, tag_34)
		`CopyABCD0f( 35, 34)

		`CopyDigestWords(d_35, d35, c_35, c35, b_35, b35)
		b_i36 <= (a35 + (b35 ^ c35 ^ d35));
		`CopyChunkWords(w_35, w35)
		`CopyTAG( tag_35, tag35)
		`CopyABCD_( 35, 35)

		`CopyDigestWords(a36, d_35, d36, c_35, c36, b_35)
		b36 <=  b_35 + (((b_i36 + 'hFDE5380C + w_35[14]) << 23) | ((b_i36 + 'hFDE5380C + w_35[14]) >> (32 - 23)));
		`CopyChunkWords(w36, w_35)
		`CopyTAG( tag36, tag_35)
		`CopyABCD0f( 36, 35)

		`CopyDigestWords(d_36, d36, c_36, c36, b_36, b36)
		b_i37 <= (a36 + (b36 ^ c36 ^ d36));
		`CopyChunkWords(w_36, w36)
		`CopyTAG( tag_36, tag36)
		`CopyABCD_( 36, 36)

		`CopyDigestWords(a37, d_36, d37, c_36, c37, b_36)
		b37 <=  b_36 + (((b_i37 + 'hA4BEEA44 + w_36[1]) << 4) | ((b_i37 + 'hA4BEEA44 + w_36[1]) >> (32 - 4)));
		`CopyChunkWords(w37, w_36)
		`CopyTAG( tag37, tag_36)
		`CopyABCD0f( 37, 36)

		`CopyDigestWords(d_37, d37, c_37, c37, b_37, b37)
		b_i38 <= (a37 + (b37 ^ c37 ^ d37));
		`CopyChunkWords(w_37, w37)
		`CopyTAG( tag_37, tag37)
		`CopyABCD_( 37, 37)

		`CopyDigestWords(a38, d_37, d38, c_37, c38, b_37)
		b38 <=  b_37 + (((b_i38 + 'h4BDECFA9 + w_37[4]) << 11) | ((b_i38 + 'h4BDECFA9 + w_37[4]) >> (32 - 11)));
		`CopyChunkWords(w38, w_37)
		`CopyTAG( tag38, tag_37)
		`CopyABCD0f( 38, 37)

		`CopyDigestWords(d_38, d38, c_38, c38, b_38, b38)
		b_i39 <= (a38 + (b38 ^ c38 ^ d38));
		`CopyChunkWords(w_38, w38)
		`CopyTAG( tag_38, tag38)
		`CopyABCD_( 38, 38)

		`CopyDigestWords(a39, d_38, d39, c_38, c39, b_38)
		b39 <=  b_38 + (((b_i39 + 'hF6BB4B60 + w_38[7]) << 16) | ((b_i39 + 'hF6BB4B60 + w_38[7]) >> (32 - 16)));
		`CopyChunkWords(w39, w_38)
		`CopyTAG( tag39, tag_38)
		`CopyABCD0f( 39, 38)

		`CopyDigestWords(d_39, d39, c_39, c39, b_39, b39)
		b_i40 <= (a39 + (b39 ^ c39 ^ d39));
		`CopyChunkWords(w_39, w39)
		`CopyTAG( tag_39, tag39)
		`CopyABCD_( 39, 39)

		`CopyDigestWords(a40, d_39, d40, c_39, c40, b_39)
		b40 <=  b_39 + (((b_i40 + 'hBEBFBC70 + w_39[10]) << 23) | ((b_i40 + 'hBEBFBC70 + w_39[10]) >> (32 - 23)));
		`CopyChunkWords(w40, w_39)
		`CopyTAG( tag40, tag_39)
		`CopyABCD0f( 40, 39)

		`CopyDigestWords(d_40, d40, c_40, c40, b_40, b40)
		b_i41 <= (a40 + (b40 ^ c40 ^ d40));
		`CopyChunkWords(w_40, w40)
		`CopyTAG( tag_40, tag40)
		`CopyABCD_( 40, 40)

		`CopyDigestWords(a41, d_40, d41, c_40, c41, b_40)
		b41 <=  b_40 + (((b_i41 + 'h289B7EC6 + w_40[13]) << 4) | ((b_i41 + 'h289B7EC6 + w_40[13]) >> (32 - 4)));
		`CopyChunkWords(w41, w_40)
		`CopyTAG( tag41, tag_40)
		`CopyABCD0f( 41, 40)

		`CopyDigestWords(d_41, d41, c_41, c41, b_41, b41)
		b_i42 <= (a41 + (b41 ^ c41 ^ d41));
		`CopyChunkWords(w_41, w41)
		`CopyTAG( tag_41, tag41)
		`CopyABCD_( 41, 41)

		`CopyDigestWords(a42, d_41, d42, c_41, c42, b_41)
		b42 <=  b_41 + (((b_i42 + 'hEAA127FA + w_41[0]) << 11) | ((b_i42 + 'hEAA127FA + w_41[0]) >> (32 - 11)));
		`CopyChunkWords(w42, w_41)
		`CopyTAG( tag42, tag_41)
		`CopyABCD0f( 42, 41)

		`CopyDigestWords(d_42, d42, c_42, c42, b_42, b42)
		b_i43 <= (a42 + (b42 ^ c42 ^ d42));
		`CopyChunkWords(w_42, w42)
		`CopyTAG( tag_42, tag42)
		`CopyABCD_( 42, 42)

		`CopyDigestWords(a43, d_42, d43, c_42, c43, b_42)
		b43 <=  b_42 + (((b_i43 + 'hD4EF3085 + w_42[3]) << 16) | ((b_i43 + 'hD4EF3085 + w_42[3]) >> (32 - 16)));
		`CopyChunkWords(w43, w_42)
		`CopyTAG( tag43, tag_42)
		`CopyABCD0f( 43, 42)

		`CopyDigestWords(d_43, d43, c_43, c43, b_43, b43)
		b_i44 <= (a43 + (b43 ^ c43 ^ d43));
		`CopyChunkWords(w_43, w43)
		`CopyTAG( tag_43, tag43)
		`CopyABCD_( 43, 43)

		`CopyDigestWords(a44, d_43, d44, c_43, c44, b_43)
		b44 <=  b_43 + (((b_i44 + 'h4881D05 + w_43[6]) << 23) | ((b_i44 + 'h4881D05 + w_43[6]) >> (32 - 23)));
		`CopyChunkWords(w44, w_43)
		`CopyTAG( tag44, tag_43)
		`CopyABCD0f( 44, 43)

		`CopyDigestWords(d_44, d44, c_44, c44, b_44, b44)
		b_i45 <= (a44 + (b44 ^ c44 ^ d44));
		`CopyChunkWords(w_44, w44)
		`CopyTAG( tag_44, tag44)
		`CopyABCD_( 44, 44)

		`CopyDigestWords(a45, d_44, d45, c_44, c45, b_44)
		b45 <=  b_44 + (((b_i45 + 'hD9D4D039 + w_44[9]) << 4) | ((b_i45 + 'hD9D4D039 + w_44[9]) >> (32 - 4)));
		`CopyChunkWords(w45, w_44)
		`CopyTAG( tag45, tag_44)
		`CopyABCD0f( 45, 44)

		`CopyDigestWords(d_45, d45, c_45, c45, b_45, b45)
		b_i46 <= (a45 + (b45 ^ c45 ^ d45));
		`CopyChunkWords(w_45, w45)
		`CopyTAG( tag_45, tag45)
		`CopyABCD_( 45, 45)

		`CopyDigestWords(a46, d_45, d46, c_45, c46, b_45)
		b46 <=  b_45 + (((b_i46 + 'hE6DB99E5 + w_45[12]) << 11) | ((b_i46 + 'hE6DB99E5 + w_45[12]) >> (32 - 11)));
		`CopyChunkWords(w46, w_45)
		`CopyTAG( tag46, tag_45)
		`CopyABCD0f( 46, 45)

		`CopyDigestWords(d_46, d46, c_46, c46, b_46, b46)
		b_i47 <= (a46 + (b46 ^ c46 ^ d46));
		`CopyChunkWords(w_46, w46)
		`CopyTAG( tag_46, tag46)
		`CopyABCD_( 46, 46)

		`CopyDigestWords(a47, d_46, d47, c_46, c47, b_46)
		b47 <=  b_46 + (((b_i47 + 'h1FA27CF8 + w_46[15]) << 16) | ((b_i47 + 'h1FA27CF8 + w_46[15]) >> (32 - 16)));
		`CopyChunkWords(w47, w_46)
		`CopyTAG( tag47, tag_46)
		`CopyABCD0f( 47, 46)

		`CopyDigestWords(d_47, d47, c_47, c47, b_47, b47)
		b_i48 <= (a47 + (b47 ^ c47 ^ d47));
		`CopyChunkWords(w_47, w47)
		`CopyTAG( tag_47, tag47)
		`CopyABCD_( 47, 47)

		`CopyDigestWords(a48, d_47, d48, c_47, c48, b_47)
		b48 <=  b_47 + (((b_i48 + 'hC4AC5665 + w_47[2]) << 23) | ((b_i48 + 'hC4AC5665 + w_47[2]) >> (32 - 23)));
		`CopyChunkWords(w48, w_47)
		`CopyTAG( tag48, tag_47)
		`CopyABCD0f( 48, 47)
		

		// ======= 49-64 =======
/*
		`CopyDigestWords(d_48, d48, c_48, c48, b_48, b48)
		b_i49 <= (a48 + (c48 ^ (b48 | (~d48))));
		`CopyChunkWords(w_48, w48)
		`CopyTAG( tag_48, tag48)
		`CopyABCD_( 48, 48)

		`CopyDigestWords(a49, d_48, d49, c_48, c49, b_48)
		b49 <=  b_48 + (((b_i49 + 'hF4292244 + w_48[0]) << 6) | ((b_i49 + 'hF4292244 + w_48[0]) >> (32 - 6)));
		`CopyChunkWords(w49, w_48)
		`CopyTAG( tag49, tag_48)
		`CopyABCD0f( 49, 48)

		`CopyDigestWords(d_49, d49, c_49, c49, b_49, b49)
		b_i50 <= (a49 + (c49 ^ (b49 | (~d49))));
		`CopyChunkWords(w_49, w49)
		`CopyTAG( tag_49, tag49)
		`CopyABCD_( 49, 49)

		`CopyDigestWords(a50, d_49, d50, c_49, c50, b_49)
		b50 <=  b_49 + (((b_i50 + 'h432AFF97 + w_49[7]) << 10) | ((b_i50 + 'h432AFF97 + w_49[7]) >> (32 - 10)));
		`CopyChunkWords(w50, w_49)
		`CopyTAG( tag50, tag_49)
		`CopyABCD0f( 50, 49)

		`CopyDigestWords(d_50, d50, c_50, c50, b_50, b50)
		b_i51 <= (a50 + (c50 ^ (b50 | (~d50))));
		`CopyChunkWords(w_50, w50)
		`CopyTAG( tag_50, tag50)
		`CopyABCD_( 50, 50)

		`CopyDigestWords(a51, d_50, d51, c_50, c51, b_50)
		b51 <=  b_50 + (((b_i51 + 'hAB9423A7 + w_50[14]) << 15) | ((b_i51 + 'hAB9423A7 + w_50[14]) >> (32 - 15)));
		`CopyChunkWords(w51, w_50)
		`CopyTAG( tag51, tag_50)
		`CopyABCD0f( 51, 50)

		`CopyDigestWords(d_51, d51, c_51, c51, b_51, b51)
		b_i52 <= (a51 + (c51 ^ (b51 | (~d51))));
		`CopyChunkWords(w_51, w51)
		`CopyTAG( tag_51, tag51)
		`CopyABCD_( 51, 51)

		`CopyDigestWords(a52, d_51, d52, c_51, c52, b_51)
		b52 <=  b_51 + (((b_i52 + 'hFC93A039 + w_51[5]) << 21) | ((b_i52 + 'hFC93A039 + w_51[5]) >> (32 - 21)));
		`CopyChunkWords(w52, w_51)
		`CopyTAG( tag52, tag_51)
		`CopyABCD0f( 52, 51)

		`CopyDigestWords(d_52, d52, c_52, c52, b_52, b52)
		b_i53 <= (a52 + (c52 ^ (b52 | (~d52))));
		`CopyChunkWords(w_52, w52)
		`CopyTAG( tag_52, tag52)
		`CopyABCD_( 52, 52)

		`CopyDigestWords(a53, d_52, d53, c_52, c53, b_52)
		b53 <=  b_52 + (((b_i53 + 'h655B59C3 + w_52[12]) << 6) | ((b_i53 + 'h655B59C3 + w_52[12]) >> (32 - 6)));
		`CopyChunkWords(w53, w_52)
		`CopyTAG( tag53, tag_52)
		`CopyABCD0f( 53, 52)

		`CopyDigestWords(d_53, d53, c_53, c53, b_53, b53)
		b_i54 <= (a53 + (c53 ^ (b53 | (~d53))));
		`CopyChunkWords(w_53, w53)
		`CopyTAG( tag_53, tag53)
		`CopyABCD_( 53, 53)

		`CopyDigestWords(a54, d_53, d54, c_53, c54, b_53)
		b54 <=  b_53 + (((b_i54 + 'h8F0CCC92 + w_53[3]) << 10) | ((b_i54 + 'h8F0CCC92 + w_53[3]) >> (32 - 10)));
		`CopyChunkWords(w54, w_53)
		`CopyTAG( tag54, tag_53)
		`CopyABCD0f( 54, 53)

		`CopyDigestWords(d_54, d54, c_54, c54, b_54, b54)
		b_i55 <= (a54 + (c54 ^ (b54 | (~d54))));
		`CopyChunkWords(w_54, w54)
		`CopyTAG( tag_54, tag54)
		`CopyABCD_( 54, 54)

		`CopyDigestWords(a55, d_54, d55, c_54, c55, b_54)
		b55 <=  b_54 + (((b_i55 + 'hFFEFF47D + w_54[10]) << 15) | ((b_i55 + 'hFFEFF47D + w_54[10]) >> (32 - 15)));
		`CopyChunkWords(w55, w_54)
		`CopyTAG( tag55, tag_54)
		`CopyABCD0f( 55, 54)

		`CopyDigestWords(d_55, d55, c_55, c55, b_55, b55)
		b_i56 <= (a55 + (c55 ^ (b55 | (~d55))));
		`CopyChunkWords(w_55, w55)
		`CopyTAG( tag_55, tag55)
		`CopyABCD_( 55, 55)

		`CopyDigestWords(a56, d_55, d56, c_55, c56, b_55)
		b56 <=  b_55 + (((b_i56 + 'h85845DD1 + w_55[1]) << 21) | ((b_i56 + 'h85845DD1 + w_55[1]) >> (32 - 21)));
		`CopyChunkWords(w56, w_55)
		`CopyTAG( tag56, tag_55)
		`CopyABCD0f( 56, 55)

		`CopyDigestWords(d_56, d56, c_56, c56, b_56, b56)
		b_i57 <= (a56 + (c56 ^ (b56 | (~d56))));
		`CopyChunkWords(w_56, w56)
		`CopyTAG( tag_56, tag56)
		`CopyABCD_( 56, 56)

		`CopyDigestWords(a57, d_56, d57, c_56, c57, b_56)
		b57 <=  b_56 + (((b_i57 + 'h6FA87E4F + w_56[8]) << 6) | ((b_i57 + 'h6FA87E4F + w_56[8]) >> (32 - 6)));
		`CopyChunkWords(w57, w_56)
		`CopyTAG( tag57, tag_56)
		`CopyABCD0f( 57, 56)

		`CopyDigestWords(d_57, d57, c_57, c57, b_57, b57)
		b_i58 <= (a57 + (c57 ^ (b57 | (~d57))));
		`CopyChunkWords(w_57, w57)
		`CopyTAG( tag_57, tag57)
		`CopyABCD_( 57, 57)

		`CopyDigestWords(a58, d_57, d58, c_57, c58, b_57)
		b58 <=  b_57 + (((b_i58 + 'hFE2CE6E0 + w_57[15]) << 10) | ((b_i58 + 'hFE2CE6E0 + w_57[15]) >> (32 - 10)));
		`CopyChunkWords(w58, w_57)
		`CopyTAG( tag58, tag_57)
		`CopyABCD0f( 58, 57)

		`CopyDigestWords(d_58, d58, c_58, c58, b_58, b58)
		b_i59 <= (a58 + (c58 ^ (b58 | (~d58))));
		`CopyChunkWords(w_58, w58)
		`CopyTAG( tag_58, tag58)
		`CopyABCD_( 58, 58)

		`CopyDigestWords(a59, d_58, d59, c_58, c59, b_58)
		b59 <=  b_58 + (((b_i59 + 'hA3014314 + w_58[6]) << 15) | ((b_i59 + 'hA3014314 + w_58[6]) >> (32 - 15)));
		`CopyChunkWords(w59, w_58)
		`CopyTAG( tag59, tag_58)
		`CopyABCD0f( 59, 58)

		`CopyDigestWords(d_59, d59, c_59, c59, b_59, b59)
		b_i60 <= (a59 + (c59 ^ (b59 | (~d59))));
		`CopyChunkWords(w_59, w59)
		`CopyTAG( tag_59, tag59)
		`CopyABCD_( 59, 59)

		`CopyDigestWords(a60, d_59, d60, c_59, c60, b_59)
		b60 <=  b_59 + (((b_i60 + 'h4E0811A1 + w_59[13]) << 21) | ((b_i60 + 'h4E0811A1 + w_59[13]) >> (32 - 21)));
		`CopyChunkWords(w60, w_59)
		`CopyTAG( tag60, tag_59)
		`CopyABCD0f( 60, 59)

		`CopyDigestWords(d_60, d60, c_60, c60, b_60, b60)
		b_i61 <= (a60 + (c60 ^ (b60 | (~d60))));
		`CopyChunkWords(w_60, w60)
		`CopyTAG( tag_60, tag60)
		`CopyABCD_( 60, 60)

		`CopyDigestWords(a61, d_60, d61, c_60, c61, b_60)
		b61 <=  b_60 + (((b_i61 + 'hF7537E82 + w_60[4]) << 6) | ((b_i61 + 'hF7537E82 + w_60[4]) >> (32 - 6)));
		`CopyChunkWords(w61, w_60)
		`CopyTAG( tag61, tag_60)
		`CopyABCD0f( 61, 60)

		`CopyDigestWords(d_61, d61, c_61, c61, b_61, b61)
		b_i62 <= (a61 + (c61 ^ (b61 | (~d61))));
		`CopyChunkWords(w_61, w61)
		`CopyTAG( tag_61, tag61)
		`CopyABCD_( 61, 61)

		`CopyDigestWords(a62, d_61, d62, c_61, c62, b_61)
		b62 <=  b_61 + (((b_i62 + 'hBD3AF235 + w_61[11]) << 10) | ((b_i62 + 'hBD3AF235 + w_61[11]) >> (32 - 10)));
		`CopyChunkWords(w62, w_61)
		`CopyTAG( tag62, tag_61)
		`CopyABCD0f( 62, 61)

		`CopyDigestWords(d_62, d62, c_62, c62, b_62, b62)
		b_i63 <= (a62 + (c62 ^ (b62 | (~d62))));
		`CopyChunkWords(w_62, w62)
		`CopyTAG( tag_62, tag62)
		`CopyABCD_( 62, 62)

		`CopyDigestWords(a63, d_62, d63, c_62, c63, b_62)
		b63 <=  b_62 + (((b_i63 + 'h2AD7D2BB + w_62[2]) << 15) | ((b_i63 + 'h2AD7D2BB + w_62[2]) >> (32 - 15)));
		`CopyChunkWords(w63, w_62)
		`CopyTAG( tag63, tag_62)
		`CopyABCD0f( 63, 62)

		`CopyDigestWords(d_63, d63, c_63, c63, b_63, b63)
		b_i64 <= (a63 + (c63 ^ (b63 | (~d63))));
		`CopyChunkWords(w_63, w63)
		`CopyTAG( tag_63, tag63)
		`CopyABCD_( 63, 63)
*/


		`CopyDigestWords(d_48, d48, c_48, c48, b_48, b48)
		b_i49 <= (a48 + 'hF4292244 + (c48 ^ (b48 | (~d48))));
		`CopyChunkWords(w_48, w48)
		`CopyTAG( tag_48, tag48)
		`CopyABCD_( 48, 48)

		`CopyDigestWords(a49, d_48, d49, c_48, c49, b_48)
		b49 <=  b_48 + ((( b_i49 /*+ 'hF4292244*/ + w_48[0]) << 6) | ((b_i49 /*+ 'hF4292244*/ + w_48[0]) >> (32 - 6)));
		`CopyChunkWords(w49, w_48)
		`CopyTAG( tag49, tag_48)
		`CopyABCD0f( 49, 48)

		`CopyDigestWords(d_49, d49, c_49, c49, b_49, b49)
		b_i50 <= (a49 + 'h432AFF97 + (c49 ^ (b49 | (~d49))));
		`CopyChunkWords(w_49, w49)
		`CopyTAG( tag_49, tag49)
		`CopyABCD_( 49, 49)

		`CopyDigestWords(a50, d_49, d50, c_49, c50, b_49)
		b50 <=  b_49 + ((( b_i50 /*+ 'h432AFF97*/ + w_49[7]) << 10) | ((b_i50 /*+ 'h432AFF97*/ + w_49[7]) >> (32 - 10)));
		`CopyChunkWords(w50, w_49)
		`CopyTAG( tag50, tag_49)
		`CopyABCD0f( 50, 49)

		`CopyDigestWords(d_50, d50, c_50, c50, b_50, b50)
		b_i51 <= (a50 + 'hAB9423A7 + (c50 ^ (b50 | (~d50))));
		`CopyChunkWords(w_50, w50)
		`CopyTAG( tag_50, tag50)
		`CopyABCD_( 50, 50)

		`CopyDigestWords(a51, d_50, d51, c_50, c51, b_50)
		b51 <=  b_50 + ((( b_i51 /*+ 'hAB9423A7*/ + w_50[14]) << 15) | ((b_i51 /*+ 'hAB9423A7*/ + w_50[14]) >> (32 - 15)));
		`CopyChunkWords(w51, w_50)
		`CopyTAG( tag51, tag_50)
		`CopyABCD0f( 51, 50)

		`CopyDigestWords(d_51, d51, c_51, c51, b_51, b51)
		b_i52 <= (a51 + 'hFC93A039 + (c51 ^ (b51 | (~d51))));
		`CopyChunkWords(w_51, w51)
		`CopyTAG( tag_51, tag51)
		`CopyABCD_( 51, 51)

		`CopyDigestWords(a52, d_51, d52, c_51, c52, b_51)
		b52 <=  b_51 + ((( b_i52 /*+ 'hFC93A039*/ + w_51[5]) << 21) | ((b_i52 /*+ 'hFC93A039*/ + w_51[5]) >> (32 - 21)));
		`CopyChunkWords(w52, w_51)
		`CopyTAG( tag52, tag_51)
		`CopyABCD0f( 52, 51)

		`CopyDigestWords(d_52, d52, c_52, c52, b_52, b52)
		b_i53 <= (a52 + 'h655B59C3 + (c52 ^ (b52 | (~d52))));
		`CopyChunkWords(w_52, w52)
		`CopyTAG( tag_52, tag52)
		`CopyABCD_( 52, 52)

		`CopyDigestWords(a53, d_52, d53, c_52, c53, b_52)
		b53 <=  b_52 + ((( b_i53 /*+ 'h655B59C3*/ + w_52[12]) << 6) | ((b_i53 /*+ 'h655B59C3*/ + w_52[12]) >> (32 - 6)));
		`CopyChunkWords(w53, w_52)
		`CopyTAG( tag53, tag_52)
		`CopyABCD0f( 53, 52)

		`CopyDigestWords(d_53, d53, c_53, c53, b_53, b53)
		b_i54 <= (a53 + 'h8F0CCC92 + (c53 ^ (b53 | (~d53))));
		`CopyChunkWords(w_53, w53)
		`CopyTAG( tag_53, tag53)
		`CopyABCD_( 53, 53)

		`CopyDigestWords(a54, d_53, d54, c_53, c54, b_53)
		b54 <=  b_53 + ((( b_i54 /*+ 'h8F0CCC92*/ + w_53[3]) << 10) | ((b_i54 /*+ 'h8F0CCC92*/ + w_53[3]) >> (32 - 10)));
		`CopyChunkWords(w54, w_53)
		`CopyTAG( tag54, tag_53)
		`CopyABCD0f( 54, 53)

		`CopyDigestWords(d_54, d54, c_54, c54, b_54, b54)
		b_i55 <= (a54 + 'hFFEFF47D + (c54 ^ (b54 | (~d54))));
		`CopyChunkWords(w_54, w54)
		`CopyTAG( tag_54, tag54)
		`CopyABCD_( 54, 54)

		`CopyDigestWords(a55, d_54, d55, c_54, c55, b_54)
		b55 <=  b_54 + ((( b_i55 /*+ 'hFFEFF47D*/ + w_54[10]) << 15) | ((b_i55 /*+ 'hFFEFF47D*/ + w_54[10]) >> (32 - 15)));
		`CopyChunkWords(w55, w_54)
		`CopyTAG( tag55, tag_54)
		`CopyABCD0f( 55, 54)

		`CopyDigestWords(d_55, d55, c_55, c55, b_55, b55)
		b_i56 <= (a55 + 'h85845DD1 + (c55 ^ (b55 | (~d55))));
		`CopyChunkWords(w_55, w55)
		`CopyTAG( tag_55, tag55)
		`CopyABCD_( 55, 55)

		`CopyDigestWords(a56, d_55, d56, c_55, c56, b_55)
		b56 <=  b_55 + ((( b_i56 /*+ 'h85845DD1*/ + w_55[1]) << 21) | ((b_i56 /*+ 'h85845DD1*/ + w_55[1]) >> (32 - 21)));
		`CopyChunkWords(w56, w_55)
		`CopyTAG( tag56, tag_55)
		`CopyABCD0f( 56, 55)

		`CopyDigestWords(d_56, d56, c_56, c56, b_56, b56)
		b_i57 <= (a56 + 'h6FA87E4F + (c56 ^ (b56 | (~d56))));
		`CopyChunkWords(w_56, w56)
		`CopyTAG( tag_56, tag56)
		`CopyABCD_( 56, 56)

		`CopyDigestWords(a57, d_56, d57, c_56, c57, b_56)
		b57 <=  b_56 + ((( b_i57 /*+ 'h6FA87E4F*/ + w_56[8]) << 6) | ((b_i57 /*+ 'h6FA87E4F*/ + w_56[8]) >> (32 - 6)));
		`CopyChunkWords(w57, w_56)
		`CopyTAG( tag57, tag_56)
		`CopyABCD0f( 57, 56)

		`CopyDigestWords(d_57, d57, c_57, c57, b_57, b57)
		b_i58 <= (a57 + 'hFE2CE6E0 + (c57 ^ (b57 | (~d57))));
		`CopyChunkWords(w_57, w57)
		`CopyTAG( tag_57, tag57)
		`CopyABCD_( 57, 57)

		`CopyDigestWords(a58, d_57, d58, c_57, c58, b_57)
		b58 <=  b_57 + ((( b_i58 /*+ 'hFE2CE6E0*/ + w_57[15]) << 10) | ((b_i58 /*+ 'hFE2CE6E0*/ + w_57[15]) >> (32 - 10)));
		`CopyChunkWords(w58, w_57)
		`CopyTAG( tag58, tag_57)
		`CopyABCD0f( 58, 57)

		`CopyDigestWords(d_58, d58, c_58, c58, b_58, b58)
		b_i59 <= (a58 + 'hA3014314 + (c58 ^ (b58 | (~d58))));
		`CopyChunkWords(w_58, w58)
		`CopyTAG( tag_58, tag58)
		`CopyABCD_( 58, 58)

		`CopyDigestWords(a59, d_58, d59, c_58, c59, b_58)
		b59 <=  b_58 + ((( b_i59 /*+ 'hA3014314*/ + w_58[6]) << 15) | ((b_i59 /*+ 'hA3014314*/ + w_58[6]) >> (32 - 15)));
		`CopyChunkWords(w59, w_58)
		`CopyTAG( tag59, tag_58)
		`CopyABCD0f( 59, 58)

		`CopyDigestWords(d_59, d59, c_59, c59, b_59, b59)
		b_i60 <= (a59 + 'h4E0811A1 + (c59 ^ (b59 | (~d59))));
		`CopyChunkWords(w_59, w59)
		`CopyTAG( tag_59, tag59)
		`CopyABCD_( 59, 59)

		`CopyDigestWords(a60, d_59, d60, c_59, c60, b_59)
		b60 <=  b_59 + ((( b_i60 /*+ 'h4E0811A1*/ + w_59[13]) << 21) | ((b_i60 /*+ 'h4E0811A1*/ + w_59[13]) >> (32 - 21)));
		`CopyChunkWords(w60, w_59)
		`CopyTAG( tag60, tag_59)
		`CopyABCD0f( 60, 59)

		`CopyDigestWords(d_60, d60, c_60, c60, b_60, b60)
		b_i61 <= (a60 + 'hF7537E82 + (c60 ^ (b60 | (~d60))));
		`CopyChunkWords(w_60, w60)
		`CopyTAG( tag_60, tag60)
		`CopyABCD_( 60, 60)

		`CopyDigestWords(a61, d_60, d61, c_60, c61, b_60)
		b61 <=  b_60 + ((( b_i61 /*+ 'hF7537E82*/ + w_60[4]) << 6) | ((b_i61 /*+ 'hF7537E82*/ + w_60[4]) >> (32 - 6)));
		`CopyChunkWords(w61, w_60)
		`CopyTAG( tag61, tag_60)
		`CopyABCD0f( 61, 60)

		`CopyDigestWords(d_61, d61, c_61, c61, b_61, b61)
		b_i62 <= (a61 + 'hBD3AF235 + (c61 ^ (b61 | (~d61))));
		`CopyChunkWords(w_61, w61)
		`CopyTAG( tag_61, tag61)
		`CopyABCD_( 61, 61)

		`CopyDigestWords(a62, d_61, d62, c_61, c62, b_61)
		b62 <=  b_61 + ((( b_i62 /*+ 'hBD3AF235*/ + w_61[11]) << 10) | ((b_i62 /*+ 'hBD3AF235*/ + w_61[11]) >> (32 - 10)));
		`CopyChunkWords(w62, w_61)
		`CopyTAG( tag62, tag_61)
		`CopyABCD0f( 62, 61)

		`CopyDigestWords(d_62, d62, c_62, c62, b_62, b62)
		b_i63 <= (a62 + 'h2AD7D2BB + (c62 ^ (b62 | (~d62))));
		`CopyChunkWords(w_62, w62)
		`CopyTAG( tag_62, tag62)
		`CopyABCD_( 62, 62)

		`CopyDigestWords(a63, d_62, d63, c_62, c63, b_62)
		b63 <=  b_62 + ((( b_i63 /*+ 'h2AD7D2BB*/ + w_62[2]) << 15) | ((b_i63 /*+ 'h2AD7D2BB*/ + w_62[2]) >> (32 - 15)));
		`CopyChunkWords(w63, w_62)
		`CopyTAG( tag63, tag_62)
		`CopyABCD0f( 63, 62)

		`CopyDigestWords(d_63, d63, c_63, c63, b_63, b63)
		b_i64 <= (a63 + 'hEB86D391 + (c63 ^ (b63 | (~d63))));
		`CopyChunkWords(w_63, w63)
		`CopyTAG( tag_63, tag63)
		`CopyABCD_( 63, 63)


		`CopyDigestWords(a64, (d_63 + sa_0[63]), d64, (c_63 + sd_0[63]), c64, (b_63 + sc_0[63]))
		b64 <=  (sb_0[63] + b_63) + (((b_i64 /*+ 'hEB86D391*/ + w_63[9]) << 21) | ((b_i64 /*+ 'hEB86D391*/ + w_63[9]) >> (32 - 21)));
		//`CopyChunkWords(w64, w_63)
		`CopyTAG( tag64, tag_63)
		//`CopyABCD0f( 64, 63)
		key64 <= HMACkey_[63];
		pass64 <= origPassword_[63];

/*
		// last copies include a0, b0, c0 and d0
      `CopyDigestWords(a64, (d63 + sa0[63]), d64, (c63 + sd0[63]), c64, (b63 + sc0[63]))
      b64 <= (sb0[63] + b63) + (((a63 + (c63 ^ (b63 | (~d63))) + 'heb86d391 + w63[(7 * 63) % 16]) << 21) | ((a63 + (c63 ^ (b63 | (~d63))) + 'heb86d391 + w63[(7 * 63) % 16]) >> (32 - 21)));      
		`CopyTAG( tag64, tag63)
		key64 <= HMACkey[63];
		pass64 <= origPassword[63];
*/

/*
      `CopyDigestWords(a49, d48, d49, c48, c49, b48)
      b49 <= b48 + (((a48 + (c48 ^ (b48 | (~d48))) + 'hf4292244 + w48[(7 * 48) % 16]) << 6) | ((a48 + (c48 ^ (b48 | (~d48))) + 'hf4292244 + w48[(7 * 48) % 16]) >> (32 - 6)));
      `CopyChunkWords(w49, w48)
		`CopyTAG( tag49, tag48)
		`CopyABCD0( 49, 48)

      `CopyDigestWords(a50, d49, d50, c49, c50, b49)
      b50 <= b49 + (((a49 + (c49 ^ (b49 | (~d49))) + 'h432aff97 + w49[(7 * 49) % 16]) << 10) | ((a49 + (c49 ^ (b49 | (~d49))) + 'h432aff97 + w49[(7 * 49) % 16]) >> (32 - 10)));
      `CopyChunkWords(w50, w49)
		`CopyTAG( tag50, tag49)
		`CopyABCD0( 50, 49)

      `CopyDigestWords(a51, d50, d51, c50, c51, b50)
      b51 <= b50 + (((a50 + (c50 ^ (b50 | (~d50))) + 'hab9423a7 + w50[(7 * 50) % 16]) << 15) | ((a50 + (c50 ^ (b50 | (~d50))) + 'hab9423a7 + w50[(7 * 50) % 16]) >> (32 - 15)));
      `CopyChunkWords(w51, w50)
		`CopyTAG( tag51, tag50)
		`CopyABCD0( 51, 50)

      `CopyDigestWords(a52, d51, d52, c51, c52, b51)
      b52 <= b51 + (((a51 + (c51 ^ (b51 | (~d51))) + 'hfc93a039 + w51[(7 * 51) % 16]) << 21) | ((a51 + (c51 ^ (b51 | (~d51))) + 'hfc93a039 + w51[(7 * 51) % 16]) >> (32 - 21)));
      `CopyChunkWords(w52, w51)
		`CopyTAG( tag52, tag51)
		`CopyABCD0( 52, 51)

      `CopyDigestWords(a53, d52, d53, c52, c53, b52)
      b53 <= b52 + (((a52 + (c52 ^ (b52 | (~d52))) + 'h655b59c3 + w52[(7 * 52) % 16]) << 6) | ((a52 + (c52 ^ (b52 | (~d52))) + 'h655b59c3 + w52[(7 * 52) % 16]) >> (32 - 6)));
      `CopyChunkWords(w53, w52)
		`CopyTAG( tag53, tag52)
		`CopyABCD0( 53, 52)
 
      `CopyDigestWords(a54, d53, d54, c53, c54, b53)
      b54 <= b53 + (((a53 + (c53 ^ (b53 | (~d53))) + 'h8f0ccc92 + w53[(7 * 53) % 16]) << 10) | ((a53 + (c53 ^ (b53 | (~d53))) + 'h8f0ccc92 + w53[(7 * 53) % 16]) >> (32 - 10)));
      `CopyChunkWords(w54, w53)
		`CopyTAG( tag54, tag53)
		`CopyABCD0( 54, 53)

      `CopyDigestWords(a55, d54, d55, c54, c55, b54)
      b55 <= b54 + (((a54 + (c54 ^ (b54 | (~d54))) + 'hffeff47d + w54[(7 * 54) % 16]) << 15) | ((a54 + (c54 ^ (b54 | (~d54))) + 'hffeff47d + w54[(7 * 54) % 16]) >> (32 - 15)));
      `CopyChunkWords(w55, w54)
		`CopyTAG( tag55, tag54)
		`CopyABCD0( 55, 54)

      `CopyDigestWords(a56, d55, d56, c55, c56, b55)
      b56 <= b55 + (((a55 + (c55 ^ (b55 | (~d55))) + 'h85845dd1 + w55[(7 * 55) % 16]) << 21) | ((a55 + (c55 ^ (b55 | (~d55))) + 'h85845dd1 + w55[(7 * 55) % 16]) >> (32 - 21)));
      `CopyChunkWords(w56, w55)
		`CopyTAG( tag56, tag55)
		`CopyABCD0( 56, 55)

      `CopyDigestWords(a57, d56, d57, c56, c57, b56)
      b57 <= b56 + (((a56 + (c56 ^ (b56 | (~d56))) + 'h6fa87e4f + w56[(7 * 56) % 16]) << 6) | ((a56 + (c56 ^ (b56 | (~d56))) + 'h6fa87e4f + w56[(7 * 56) % 16]) >> (32 - 6)));
      `CopyChunkWords(w57, w56)
		`CopyTAG( tag57, tag56)
		`CopyABCD0( 57, 56)

      `CopyDigestWords(a58, d57, d58, c57, c58, b57)
      b58 <= b57 + (((a57 + (c57 ^ (b57 | (~d57))) + 'hfe2ce6e0 + w57[(7 * 57) % 16]) << 10) | ((a57 + (c57 ^ (b57 | (~d57))) + 'hfe2ce6e0 + w57[(7 * 57) % 16]) >> (32 - 10)));
      `CopyChunkWords(w58, w57)
		`CopyTAG( tag58, tag57)
		`CopyABCD0( 58, 57)

      `CopyDigestWords(a59, d58, d59, c58, c59, b58)
      b59 <= b58 + (((a58 + (c58 ^ (b58 | (~d58))) + 'ha3014314 + w58[(7 * 58) % 16]) << 15) | ((a58 + (c58 ^ (b58 | (~d58))) + 'ha3014314 + w58[(7 * 58) % 16]) >> (32 - 15)));
      `CopyChunkWords(w59, w58)
		`CopyTAG( tag59, tag58)
		`CopyABCD0( 59, 58)

      `CopyDigestWords(a60, d59, d60, c59, c60, b59)
      b60 <= b59 + (((a59 + (c59 ^ (b59 | (~d59))) + 'h4e0811a1 + w59[(7 * 59) % 16]) << 21) | ((a59 + (c59 ^ (b59 | (~d59))) + 'h4e0811a1 + w59[(7 * 59) % 16]) >> (32 - 21)));
      `CopyChunkWords(w60, w59)
		`CopyTAG( tag60, tag59)
		`CopyABCD0( 60, 59)

      `CopyDigestWords(a61, d60, d61, c60, c61, b60)
      b61 <= b60 + (((a60 + (c60 ^ (b60 | (~d60))) + 'hf7537e82 + w60[(7 * 60) % 16]) << 6) | ((a60 + (c60 ^ (b60 | (~d60))) + 'hf7537e82 + w60[(7 * 60) % 16]) >> (32 - 6)));
      `CopyChunkWords(w61, w60)
		`CopyTAG( tag61, tag60)
		`CopyABCD0( 61, 60)

      `CopyDigestWords(a62, d61, d62, c61, c62, b61)
      b62 <= b61 + (((a61 + (c61 ^ (b61 | (~d61))) + 'hbd3af235 + w61[(7 * 61) % 16]) << 10) | ((a61 + (c61 ^ (b61 | (~d61))) + 'hbd3af235 + w61[(7 * 61) % 16]) >> (32 - 10)));
      `CopyChunkWords(w62, w61)
		`CopyTAG( tag62, tag61)
		`CopyABCD0( 62, 61)

      `CopyDigestWords(a63, d62, d63, c62, c63, b62)
      b63 <= b62 + (((a62 + (c62 ^ (b62 | (~d62))) + 'h2ad7d2bb + w62[(7 * 62) % 16]) << 15) | ((a62 + (c62 ^ (b62 | (~d62))) + 'h2ad7d2bb + w62[(7 * 62) % 16]) >> (32 - 15)));
      `CopyChunkWords(w63, w62)
		`CopyTAG( tag63, tag62)
		`CopyABCD0( 63, 62)

		// last copies include a0, b0, c0 and d0
      `CopyDigestWords(a64, (d63 + sa0[63]), d64, (c63 + sd0[63]), c64, (b63 + sc0[63]))
      b64 <= (sb0[63] + b63) + (((a63 + (c63 ^ (b63 | (~d63))) + 'heb86d391 + w63[(7 * 63) % 16]) << 21) | ((a63 + (c63 ^ (b63 | (~d63))) + 'heb86d391 + w63[(7 * 63) % 16]) >> (32 - 21)));      
		`CopyTAG( tag64, tag63)
		key64 <= HMACkey[63];
		pass64 <= origPassword[63];
*/
		
    end
endmodule



