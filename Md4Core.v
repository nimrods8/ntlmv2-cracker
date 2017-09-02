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
  __lhs3 <= __rhs3;   																	\
                                                  
`define USE_SLOW
	
module Md4Core (
  input wire clk, 
  input wire [511:0] wb, 
  input wire [31:0] a0,
  input wire [31:0] b0, 
  input wire [31:0] c0, 
  input wire [31:0] d0, 
  output wire [31:0] a64, 
  output wire [31:0] b64, 
  output wire [31:0] c64, 
  output wire [31:0] d64,
  output reg [127:0] passwordText);
  
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
  a48, b48, c48, d48
  /*
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
  a63, b63, c63, d63
  */
  ; 

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

`ifndef USE_SLOW
  reg [31:0] w_47 [0:15];
  reg [31:0] b_48, c_48, d_48, b_i48;
  
`endif  


  // testing
  reg [31:0] a__48, b__48, c__48, d__48;
  reg [127:0] passwordText_temp;
  
/*
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
  */
  always @(posedge clk)
    begin
	   // wait for the a0, b0, c0 and d0 values to stabilize,,,
		// start 1st batch,
      `CopyDigestWords(a1, d0, d1, c0, c1, b0)
      b1 <= (( (a0 + ((b0 & c0) | (~b0 & d0)) + 'h0 + w0[0])) << 3) | ((a0 + ((b0 & c0) | (~b0 & d0)) + 'h0 + w0[0]) >> (32 - 3));
      `CopyChunkWords(w1, w0)

      `CopyDigestWords(a2, d1, d2, c1, c2, b1)
      b2 <= (( (a1 + ((b1 & c1) | (~b1 & d1)) + 'h0 + w1[1])) << 7) | ((a1 + ((b1 & c1) | (~b1 & d1)) + 'h0 + w1[1]) >> (32 - 7));
      `CopyChunkWords(w2, w1)

      `CopyDigestWords(a3, d2, d3, c2, c3, b2)
      b3 <= (( (a2 + ((b2 & c2) | (~b2 & d2)) + 'h0 + w2[2])) << 11) | ((a2 + ((b2 & c2) | (~b2 & d2)) + 'h0 + w2[2]) >> (32 - 11));
      `CopyChunkWords(w3, w2)

      `CopyDigestWords(a4, d3, d4, c3, c4, b3)
      b4 <= (( (a3 + ((b3 & c3) | (~b3 & d3)) + 'h0 + w3[3])) << 19) | ((a3 + ((b3 & c3) | (~b3 & d3)) + 'h0 + w3[3]) >> (32 - 19));
      `CopyChunkWords(w4, w3)

      `CopyDigestWords(a5, d4, d5, c4, c5, b4)
      b5 <= (( (a4 + ((b4 & c4) | (~b4 & d4)) + 'h0 + w4[4])) << 3) | ((a4 + ((b4 & c4) | (~b4 & d4)) + 'h0 + w4[4]) >> (32 - 3));
      `CopyChunkWords(w5, w4)

      `CopyDigestWords(a6, d5, d6, c5, c6, b5)
      b6 <= (( (a5 + ((b5 & c5) | (~b5 & d5)) + 'h0 + w5[5])) << 7) | ((a5 + ((b5 & c5) | (~b5 & d5)) + 'h0 + w5[5]) >> (32 - 7));
      `CopyChunkWords(w6, w5)

      `CopyDigestWords(a7, d6, d7, c6, c7, b6)
      b7 <= (( (a6 + ((b6 & c6) | (~b6 & d6)) + 'h0 + w6[6])) << 11) | ((a6 + ((b6 & c6) | (~b6 & d6)) + 'h0 + w6[6]) >> (32 - 11));
      `CopyChunkWords(w7, w6)

      `CopyDigestWords(a8, d7, d8, c7, c8, b7)
      b8 <= (( (a7 + ((b7 & c7) | (~b7 & d7)) + 'h0 + w7[7])) << 19) | ((a7 + ((b7 & c7) | (~b7 & d7)) + 'h0 + w7[7]) >> (32 - 19));
      `CopyChunkWords(w8, w7)

      `CopyDigestWords(a9, d8, d9, c8, c9, b8)
      b9 <= (( (a8 + ((b8 & c8) | (~b8 & d8)) + 'h0 + w8[8])) << 3) | ((a8 + ((b8 & c8) | (~b8 & d8)) + 'h0 + w8[8]) >> (32 - 3));
      `CopyChunkWords(w9, w8)

      `CopyDigestWords(a10, d9, d10, c9, c10, b9)
      b10 <= (( (a9 + ((b9 & c9) | (~b9 & d9)) + 'h0 + w9[9])) << 7) | ((a9 + ((b9 & c9) | (~b9 & d9)) + 'h0 + w9[9]) >> (32 - 7));
      `CopyChunkWords(w10, w9)

      `CopyDigestWords(a11, d10, d11, c10, c11, b10)
      b11 <= (( (a10 + ((b10 & c10) | (~b10 & d10)) + 'h0 + w10[10])) << 11) | ((a10 + ((b10 & c10) | (~b10 & d10)) + 'h0 + w10[10]) >> (32 - 11));
      `CopyChunkWords(w11, w10)

      `CopyDigestWords(a12, d11, d12, c11, c12, b11)
      b12 <= (( (a11 + ((b11 & c11) | (~b11 & d11)) + 'h0 + w11[11])) << 19) | ((a11 + ((b11 & c11) | (~b11 & d11)) + 'h0 + w11[11]) >> (32 - 19));
      `CopyChunkWords(w12, w11)

      `CopyDigestWords(a13, d12, d13, c12, c13, b12)
      b13 <= (( (a12 + ((b12 & c12) | (~b12 & d12)) + 'h0 + w12[12])) << 3) | ((a12 + ((b12 & c12) | (~b12 & d12)) + 'h0 + w12[12]) >> (32 - 3));
      `CopyChunkWords(w13, w12)

      `CopyDigestWords(a14, d13, d14, c13, c14, b13)
      b14 <= (( (a13 + ((b13 & c13) | (~b13 & d13)) + 'h0 + w13[13])) << 7) | ((a13 + ((b13 & c13) | (~b13 & d13)) + 'h0 + w13[13]) >> (32 - 7));
      `CopyChunkWords(w14, w13)

      `CopyDigestWords(a15, d14, d15, c14, c15, b14)
      b15 <= (( (a14 + ((b14 & c14) | (~b14 & d14)) + 'h0 + w14[14])) << 11) | ((a14 + ((b14 & c14) | (~b14 & d14)) + 'h0 + w14[14]) >> (32 - 11));
      `CopyChunkWords(w15, w14)

      `CopyDigestWords(a16, d15, d16, c15, c16, b15)
      b16 <= (( (a15 + ((b15 & c15) | (~b15 & d15)) + 'h0 + w15[15])) << 19) | ((a15 + ((b15 & c15) | (~b15 & d15)) + 'h0 + w15[15]) >> (32 - 19));
      `CopyChunkWords(w16, w15)

		// start 2nd batch
		// (((x) & ((y) | (z))) | ((y) & (z)))
      `CopyDigestWords(a17, d16, d17, c16, c17, b16)
		b17 <= (((a16 + ((b16 & c16) | (b16 & d16) | ( c16 & d16)) + 'h5a827999 + w16[0]) << 3) | ((a16 + ((b16 & c16) | (b16 & d16) | ( c16 & d16)) + 'h5a827999 + w16[0]) >> (32 - 3)));
      `CopyChunkWords(w17, w16)

      `CopyDigestWords(a18, d17, d18, c17, c18, b17)
		b18 <= (((a17 + ((b17 & c17) | (b17 & d17) | ( c17 & d17)) + 'h5a827999 + w17[4]) << 5) | ((a17 + ((b17 & c17) | (b17 & d17) | ( c17 & d17)) + 'h5a827999 + w17[4]) >> (32 - 5)));
      `CopyChunkWords(w18, w17)

      `CopyDigestWords(a19, d18, d19, c18, c19, b18)
		b19 <= (((a18 + ((b18 & c18) | (b18 & d18) | ( c18 & d18)) + 'h5a827999 + w18[8]) << 9) | ((a18 + ((b18 & c18) | (b18 & d18) | ( c18 & d18)) + 'h5a827999 + w18[8]) >> (32 - 9)));
      `CopyChunkWords(w19, w18)

      `CopyDigestWords(a20, d19, d20, c19, c20, b19)
		b20 <= (((a19 + ((b19 & c19) | (b19 & d19) | ( c19 & d19)) + 'h5a827999 + w19[12]) << 13) | ((a19 + ((b19 & c19) | (b19 & d19) | ( c19 & d19)) + 'h5a827999 + w19[12]) >> (32 - 13)));
      `CopyChunkWords(w20, w19)

      `CopyDigestWords(a21, d20, d21, c20, c21, b20)
		b21 <= (((a20 + ((b20 & c20) | (b20 & d20) | ( c20 & d20)) + 'h5a827999 + w20[1]) << 3) | ((a20 + ((b20 & c20) | (b20 & d20) | ( c20 & d20)) + 'h5a827999 + w20[1]) >> (32 - 3)));
      `CopyChunkWords(w21, w20)

      `CopyDigestWords(a22, d21, d22, c21, c22, b21)
		b22 <= (((a21 + ((b21 & c21) | (b21 & d21) | ( c21 & d21)) + 'h5a827999 + w21[5]) << 5) | ((a21 + ((b21 & c21) | (b21 & d21) | ( c21 & d21)) + 'h5a827999 + w21[5]) >> (32 - 5)));
      `CopyChunkWords(w22, w21)

      `CopyDigestWords(a23, d22, d23, c22, c23, b22)
		b23 <= (((a22 + ((b22 & c22) | (b22 & d22) | ( c22 & d22)) + 'h5a827999 + w22[9]) << 9) | ((a22 + ((b22 & c22) | (b22 & d22) | ( c22 & d22)) + 'h5a827999 + w22[9]) >> (32 - 9)));
      `CopyChunkWords(w23, w22)

      `CopyDigestWords(a24, d23, d24, c23, c24, b23)
		b24 <= (((a23 + ((b23 & c23) | (b23 & d23) | ( c23 & d23)) + 'h5a827999 + w23[13]) << 13) | ((a23 + ((b23 & c23) | (b23 & d23) | ( c23 & d23)) + 'h5a827999 + w23[13]) >> (32 - 13)));
      `CopyChunkWords(w24, w23)

      `CopyDigestWords(a25, d24, d25, c24, c25, b24)
		b25 <= (((a24 + ((b24 & c24) | (b24 & d24) | ( c24 & d24)) + 'h5a827999 + w24[2]) << 3) | ((a24 + ((b24 & c24) | (b24 & d24) | ( c24 & d24)) + 'h5a827999 + w24[2]) >> (32 - 3)));
      `CopyChunkWords(w25, w24)

      `CopyDigestWords(a26, d25, d26, c25, c26, b25)
		b26 <= (((a25 + ((b25 & c25) | (b25 & d25) | ( c25 & d25)) + 'h5a827999 + w25[6]) << 5) | ((a25 + ((b25 & c25) | (b25 & d25) | ( c25 & d25)) + 'h5a827999 + w25[6]) >> (32 - 5)));
      `CopyChunkWords(w26, w25)

      `CopyDigestWords(a27, d26, d27, c26, c27, b26)
		b27 <= (((a26 + ((b26 & c26) | (b26 & d26) | ( c26 & d26)) + 'h5a827999 + w26[10]) << 9) | ((a26 + ((b26 & c26) | (b26 & d26) | ( c26 & d26)) + 'h5a827999 + w26[10]) >> (32 - 9)));
      `CopyChunkWords(w27, w26)

      `CopyDigestWords(a28, d27, d28, c27, c28, b27)
		b28 <= (((a27 + ((b27 & c27) | (b27 & d27) | ( c27 & d27)) + 'h5a827999 + w27[14]) << 13) | ((a27 + ((b27 & c27) | (b27 & d27) | ( c27 & d27)) + 'h5a827999 + w27[14]) >> (32 - 13)));
      `CopyChunkWords(w28, w27)

      `CopyDigestWords(a29, d28, d29, c28, c29, b28)
		b29 <= (((a28 + ((b28 & c28) | (b28 & d28) | ( c28 & d28)) + 'h5a827999 + w28[3]) << 3) | ((a28 + ((b28 & c28) | (b28 & d28) | ( c28 & d28)) + 'h5a827999 + w28[3]) >> (32 - 3)));
      `CopyChunkWords(w29, w28)

      `CopyDigestWords(a30, d29, d30, c29, c30, b29)
		b30 <= (((a29 + ((b29 & c29) | (b29 & d29) | ( c29 & d29)) + 'h5a827999 + w29[7]) << 5) | ((a29 + ((b29 & c29) | (b29 & d29) | ( c29 & d29)) + 'h5a827999 + w29[7]) >> (32 - 5)));
      `CopyChunkWords(w30, w29)

      `CopyDigestWords(a31, d30, d31, c30, c31, b30)
		b31 <= (((a30 + ((b30 & c30) | (b30 & d30) | ( c30 & d30)) + 'h5a827999 + w30[11]) << 9) | ((a30 + ((b30 & c30) | (b30 & d30) | ( c30 & d30)) + 'h5a827999 + w30[11]) >> (32 - 9)));
      `CopyChunkWords(w31, w30)

      `CopyDigestWords(a32, d31, d32, c31, c32, b31)
		b32 <= (((a31 + ((b31 & c31) | (b31 & d31) | ( c31 & d31)) + 'h5a827999 + w31[15]) << 13) | ((a31 + ((b31 & c31) | (b31 & d31) | ( c31 & d31)) + 'h5a827999 + w31[15]) >> (32 - 13)));		
      `CopyChunkWords(w32, w31)
	
		// start 3rd batch
		// #define H(x, y, z)			((x) ^ (y) ^ (z))
      `CopyDigestWords(a33, d32, d33, c32, c33, b32)
      b33 <= (((a32 + (b32 ^ c32 ^ d32) + 'h6ed9eba1 + w32[0]) << 3) | ((a32 + (b32 ^ c32 ^ d32) + 'h6ed9eba1 + w32[0]) >> (32 - 3)));
      `CopyChunkWords(w33, w32)

      `CopyDigestWords(a34, d33, d34, c33, c34, b33)
      b34 <= (((a33 + (b33 ^ c33 ^ d33) + 'h6ed9eba1 + w33[8]) << 9) | ((a33 + (b33 ^ c33 ^ d33) + 'h6ed9eba1 + w33[8]) >> (32 - 9)));
      `CopyChunkWords(w34, w33)

      `CopyDigestWords(a35, d34, d35, c34, c35, b34)
      b35 <= (((a34 + (b34 ^ c34 ^ d34) + 'h6ed9eba1 + w34[4]) << 11) | ((a34 + (b34 ^ c34 ^ d34) + 'h6ed9eba1 + w34[4]) >> (32 - 11)));
      `CopyChunkWords(w35, w34)

      `CopyDigestWords(a36, d35, d36, c35, c36, b35)
      b36 <= (((a35 + (b35 ^ c35 ^ d35) + 'h6ed9eba1 + w35[12]) << 15) | ((a35 + (b35 ^ c35 ^ d35) + 'h6ed9eba1 + w35[12]) >> (32 - 15)));
      `CopyChunkWords(w36, w35)

      `CopyDigestWords(a37, d36, d37, c36, c37, b36)
      b37 <= (((a36 + (b36 ^ c36 ^ d36) + 'h6ed9eba1 + w36[2]) << 3) | ((a36 + (b36 ^ c36 ^ d36) + 'h6ed9eba1 + w36[2]) >> (32 - 3)));
      `CopyChunkWords(w37, w36)

      `CopyDigestWords(a38, d37, d38, c37, c38, b37)
      b38 <= (((a37 + (b37 ^ c37 ^ d37) + 'h6ed9eba1 + w37[10]) << 9) | ((a37 + (b37 ^ c37 ^ d37) + 'h6ed9eba1 + w37[10]) >> (32 - 9)));
      `CopyChunkWords(w38, w37)

      `CopyDigestWords(a39, d38, d39, c38, c39, b38)
      b39 <= (((a38 + (b38 ^ c38 ^ d38) + 'h6ed9eba1 + w38[6]) << 11) | ((a38 + (b38 ^ c38 ^ d38) + 'h6ed9eba1 + w38[6]) >> (32 - 11)));
      `CopyChunkWords(w39, w38)

      `CopyDigestWords(a40, d39, d40, c39, c40, b39)
      b40 <= (((a39 + (b39 ^ c39 ^ d39) + 'h6ed9eba1 + w39[14]) << 15) | ((a39 + (b39 ^ c39 ^ d39) + 'h6ed9eba1 + w39[14]) >> (32 - 15)));
      `CopyChunkWords(w40, w39)

      `CopyDigestWords(a41, d40, d41, c40, c41, b40)
      b41 <= (((a40 + (b40 ^ c40 ^ d40) + 'h6ed9eba1 + w40[1]) << 3) | ((a40 + (b40 ^ c40 ^ d40) + 'h6ed9eba1 + w40[1]) >> (32 - 3)));
      `CopyChunkWords(w41, w40)

      `CopyDigestWords(a42, d41, d42, c41, c42, b41)
      b42 <= (((a41 + (b41 ^ c41 ^ d41) + 'h6ed9eba1 + w41[9]) << 9) | ((a41 + (b41 ^ c41 ^ d41) + 'h6ed9eba1 + w41[9]) >> (32 - 9)));
      `CopyChunkWords(w42, w41)

      `CopyDigestWords(a43, d42, d43, c42, c43, b42)
      b43 <= (((a42 + (b42 ^ c42 ^ d42) + 'h6ed9eba1 + w42[5]) << 11) | ((a42 + (b42 ^ c42 ^ d42) + 'h6ed9eba1 + w42[5]) >> (32 - 11)));
      `CopyChunkWords(w43, w42)

      `CopyDigestWords(a44, d43, d44, c43, c44, b43)
      b44 <= (((a43 + (b43 ^ c43 ^ d43) + 'h6ed9eba1 + w43[13]) << 15) | ((a43 + (b43 ^ c43 ^ d43) + 'h6ed9eba1 + w43[13]) >> (32 - 15)));
      `CopyChunkWords(w44, w43)

      `CopyDigestWords(a45, d44, d45, c44, c45, b44)
      b45 <= (((a44 + (b44 ^ c44 ^ d44) + 'h6ed9eba1 + w44[3]) << 3) | ((a44 + (b44 ^ c44 ^ d44) + 'h6ed9eba1 + w44[3]) >> (32 - 3)));
      `CopyChunkWords(w45, w44)

      `CopyDigestWords(a46, d45, d46, c45, c46, b45)
      b46 <= (((a45 + (b45 ^ c45 ^ d45) + 'h6ed9eba1 + w45[11]) << 9) | ((a45 + (b45 ^ c45 ^ d45) + 'h6ed9eba1 + w45[11]) >> (32 - 9)));
      `CopyChunkWords(w46, w45)

      `CopyDigestWords(a47, d46, d47, c46, c47, b46)
      b47 <= (((a46 + (b46 ^ c46 ^ d46) + 'h6ed9eba1 + w46[7]) << 11) | ((a46 + (b46 ^ c46 ^ d46) + 'h6ed9eba1 + w46[7]) >> (32 - 11)));
      `CopyChunkWords(w47, w46)

`ifdef USE_SLOW
      `CopyDigestWords(a48, d47 + a0, d48, c47 + d0, c48, b47 + c0)
      b48 <= b0 + (((a47 + (b47 ^ c47 ^ d47) + 'h6ed9eba1 + w47[15]) << 15) | ((a47 + (b47 ^ c47 ^ d47) + 'h6ed9eba1 + w47[15]) >> (32 - 15)));
/*
	 passwordText <= { 
			 w47[7][23:16], w47[7][7:0],
			 w47[6][23:16], w47[6][7:0],
			 w47[5][23:16], w47[5][7:0],
			 w47[4][23:16], w47[4][7:0],
			 w47[3][23:16], w47[3][7:0],
			 w47[2][23:16], w47[2][7:0],
			 w47[1][23:16], w47[1][7:0],	 
			 w47[0][23:16], w47[0][7:0] 
*/
		 passwordText_temp <= { 
			 w47[7][23:16], w47[7][7:0],
			 w47[6][23:16], w47[6][7:0],
			 w47[5][23:16], w47[5][7:0],
			 w47[4][23:16], w47[4][7:0],
			 w47[3][23:16], w47[3][7:0],
			 w47[2][23:16], w47[2][7:0],
			 w47[1][23:16], w47[1][7:0],	 
			 w47[0][23:16], w47[0][7:0] 
		};

		
`else
      `CopyDigestWords(d_48, d47, c_48, c47, b_48, b47)
      b_i48 <= (a47 + (b47 ^ c47 ^ d47));
      `CopyChunkWords(w_47, w47)


      `CopyDigestWords(a48, d_48 + a0, d48, c_48 + d0, c48, b_48 + c0)
      b48 <= b0 + ((b_i48 + 'h6ed9eba1 + w_47[15]) << 15) | ((b_i48 + 'h6ed9eba1 + w_47[15]) >> (32 - 15));

	   passwordText_temp <= { 
			 w_47[7][23:16], w_47[7][7:0],
			 w_47[6][23:16], w_47[6][7:0],
			 w_47[5][23:16], w_47[5][7:0],
			 w_47[4][23:16], w_47[4][7:0],
			 w_47[3][23:16], w_47[3][7:0],
			 w_47[2][23:16], w_47[2][7:0],
			 w_47[1][23:16], w_47[1][7:0],	 
			 w_47[0][23:16], w_47[0][7:0] 
		};
`endif
		
   	// testing NS
		//a64 = a48 + a0;
		//b64 = b48 + b0;
		//c64 = c48 + c0;
		//d64 = d48 + d0;
		
		 // try to add another resgiter level
		 a__48 <= a48;
		 b__48 <= b48;
		 c__48 <= c48;
		 d__48 <= d48;
		 passwordText <= passwordText_temp;
    end
	 
	 
	 assign a64 = a__48 /*+ a0*/;
	 assign b64 = b__48 /*+ b0*/;
	 assign c64 = c__48 /*+ c0*/;
	 assign d64 = d__48 /*+ d0*/;
	 
	 
	 
	 
endmodule



