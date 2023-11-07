// RUN: llvm-mc -arch=amdgcn -show-encoding -mcpu=gfx1100 %s | FileCheck --check-prefix=GFX11 %s

//
// Test op_sel/op_sel_hi
//

v_pk_add_u16 v1, v2, v3
// GFX11: encoding: [0x01,0x40,0x0a,0xcc,0x02,0x07,0x02,0x18]

v_pk_add_u16 v1, v2, v3 op_sel:[0,0]
// GFX11: v_pk_add_u16 v1, v2, v3 ; encoding: [0x01,0x40,0x0a,0xcc,0x02,0x07,0x02,0x18]

v_pk_add_u16 v1, v2, v3 op_sel_hi:[1,1]
// GFX11: v_pk_add_u16 v1, v2, v3 ; encoding: [0x01,0x40,0x0a,0xcc,0x02,0x07,0x02,0x18]

v_pk_add_u16 v1, v2, v3 op_sel:[0,0] op_sel_hi:[1,1]
// GFX11: v_pk_add_u16 v1, v2, v3 ; encoding: [0x01,0x40,0x0a,0xcc,0x02,0x07,0x02,0x18]

v_pk_add_u16 v1, v2, v3 op_sel_hi:[0,0]
// GFX11: v_pk_add_u16 v1, v2, v3 op_sel_hi:[0,0] ; encoding: [0x01,0x40,0x0a,0xcc,0x02,0x07,0x02,0x00]

v_pk_add_u16 v1, v2, v3 op_sel:[0,0] op_sel_hi:[0,0]
// GFX11: v_pk_add_u16 v1, v2, v3 op_sel_hi:[0,0] ; encoding: [0x01,0x40,0x0a,0xcc,0x02,0x07,0x02,0x00]

v_pk_add_u16 v1, v2, v3 op_sel:[1,0]
// GFX11: v_pk_add_u16 v1, v2, v3 op_sel:[1,0] ; encoding: [0x01,0x48,0x0a,0xcc,0x02,0x07,0x02,0x18]

v_pk_add_u16 v1, v2, v3 op_sel:[0,1]
// GFX11: v_pk_add_u16 v1, v2, v3 op_sel:[0,1] ; encoding: [0x01,0x50,0x0a,0xcc,0x02,0x07,0x02,0x18]

v_pk_add_u16 v1, v2, v3 op_sel:[1,1]
// GFX11: v_pk_add_u16 v1, v2, v3 op_sel:[1,1] ; encoding: [0x01,0x58,0x0a,0xcc,0x02,0x07,0x02,0x18]

v_pk_add_u16 v1, v2, v3 op_sel_hi:[0,1]
// GFX11: v_pk_add_u16 v1, v2, v3 op_sel_hi:[0,1] ; encoding: [0x01,0x40,0x0a,0xcc,0x02,0x07,0x02,0x10]

v_pk_add_u16 v1, v2, v3 op_sel_hi:[1,0]
// GFX11: v_pk_add_u16 v1, v2, v3 op_sel_hi:[1,0] ; encoding: [0x01,0x40,0x0a,0xcc,0x02,0x07,0x02,0x08]

v_pk_add_u16 v1, v2, v3 op_sel:[1,1] op_sel_hi:[1,1]
// GFX11: v_pk_add_u16 v1, v2, v3 op_sel:[1,1] ; encoding: [0x01,0x58,0x0a,0xcc,0x02,0x07,0x02,0x18]

v_pk_add_u16 v1, v2, v3 op_sel:[1,0] op_sel_hi:[1,0]
// GFX11: v_pk_add_u16 v1, v2, v3 op_sel:[1,0] op_sel_hi:[1,0] ; encoding: [0x01,0x48,0x0a,0xcc,0x02,0x07,0x02,0x08]

v_pk_add_u16 v1, v2, v3 op_sel:[0,1] op_sel_hi:[0,1]
// GFX11: v_pk_add_u16 v1, v2, v3 op_sel:[0,1] op_sel_hi:[0,1] ; encoding: [0x01,0x50,0x0a,0xcc,0x02,0x07,0x02,0x10]

v_pk_add_u16 v1, v2, v3 op_sel:[1,0] op_sel_hi:[0,1]
// GFX11: v_pk_add_u16 v1, v2, v3 op_sel:[1,0] op_sel_hi:[0,1] ; encoding: [0x01,0x48,0x0a,0xcc,0x02,0x07,0x02,0x10]

v_pk_add_u16 v1, v2, v3 op_sel:[0,1] op_sel_hi:[1,0]
// GFX11: v_pk_add_u16 v1, v2, v3 op_sel:[0,1] op_sel_hi:[1,0] ; encoding: [0x01,0x50,0x0a,0xcc,0x02,0x07,0x02,0x08]

//
// Test src2 op_sel/op_sel_hi
//

v_pk_fma_f16 v8, v0, s0, v1
// GFX11: encoding: [0x08,0x40,0x0e,0xcc,0x00,0x01,0x04,0x1c]

v_pk_fma_f16 v8, v0, s0, v1 neg_lo:[0,0,0] neg_hi:[0,0,0]
// GFX11: v_pk_fma_f16 v8, v0, s0, v1 ; encoding: [0x08,0x40,0x0e,0xcc,0x00,0x01,0x04,0x1c]

v_pk_fma_f16 v8, v0, s0, v1 op_sel:[0,0,0] op_sel_hi:[1,1,1] neg_lo:[0,0,0] neg_hi:[0,0,0]
// GFX11: v_pk_fma_f16 v8, v0, s0, v1 ; encoding: [0x08,0x40,0x0e,0xcc,0x00,0x01,0x04,0x1c]

v_pk_fma_f16 v8, v0, s0, v1 op_sel:[0,0,0] op_sel_hi:[1,1,1]
// GFX11: v_pk_fma_f16 v8, v0, s0, v1 ; encoding: [0x08,0x40,0x0e,0xcc,0x00,0x01,0x04,0x1c]

v_pk_fma_f16 v8, v0, s0, v1 op_sel:[0,0,0] op_sel_hi:[0,0,0]
// GFX11: v_pk_fma_f16 v8, v0, s0, v1 op_sel_hi:[0,0,0] ; encoding: [0x08,0x00,0x0e,0xcc,0x00,0x01,0x04,0x04]

v_pk_fma_f16 v8, v0, s0, v1 op_sel:[0,0,1] op_sel_hi:[0,0,1]
// GFX11: v_pk_fma_f16 v8, v0, s0, v1 op_sel:[0,0,1] op_sel_hi:[0,0,1] ; encoding: [0x08,0x60,0x0e,0xcc,0x00,0x01,0x04,0x04]

//
// Test neg_lo/neg_hi
//

v_pk_fma_f16 v8, v0, s0, v1 neg_lo:[1,1,1]
// GFX11: v_pk_fma_f16 v8, v0, s0, v1 neg_lo:[1,1,1] ; encoding: [0x08,0x40,0x0e,0xcc,0x00,0x01,0x04,0xfc]

v_pk_fma_f16 v8, v0, s0, v1 neg_hi:[1,1,1]
// GFX11: v_pk_fma_f16 v8, v0, s0, v1 neg_hi:[1,1,1] ; encoding: [0x08,0x47,0x0e,0xcc,0x00,0x01,0x04,0x1c]

v_pk_fma_f16 v8, v0, s0, v1 neg_lo:[1,1,1] neg_hi:[1,1,1]
// GFX11: v_pk_fma_f16 v8, v0, s0, v1 neg_lo:[1,1,1] neg_hi:[1,1,1] ; encoding: [0x08,0x47,0x0e,0xcc,0x00,0x01,0x04,0xfc]

v_pk_fma_f16 v8, v0, s0, v1 neg_lo:[1,0,0]
// GFX11: v_pk_fma_f16 v8, v0, s0, v1 neg_lo:[1,0,0] ; encoding: [0x08,0x40,0x0e,0xcc,0x00,0x01,0x04,0x3c]

v_pk_fma_f16 v8, v0, s0, v1 neg_lo:[0,1,0]
// GFX11: v_pk_fma_f16 v8, v0, s0, v1 neg_lo:[0,1,0] ; encoding: [0x08,0x40,0x0e,0xcc,0x00,0x01,0x04,0x5c]

v_pk_fma_f16 v8, v0, s0, v1 neg_lo:[0,0,1]
// GFX11: v_pk_fma_f16 v8, v0, s0, v1 neg_lo:[0,0,1] ; encoding: [0x08,0x40,0x0e,0xcc,0x00,0x01,0x04,0x9c]

v_pk_fma_f16 v8, v0, s0, v1 neg_hi:[1,0,0]
// GFX11: v_pk_fma_f16 v8, v0, s0, v1 neg_hi:[1,0,0] ; encoding: [0x08,0x41,0x0e,0xcc,0x00,0x01,0x04,0x1c]

v_pk_fma_f16 v8, v0, s0, v1 neg_hi:[0,1,0]
// GFX11: v_pk_fma_f16 v8, v0, s0, v1 neg_hi:[0,1,0] ; encoding: [0x08,0x42,0x0e,0xcc,0x00,0x01,0x04,0x1c]

v_pk_fma_f16 v8, v0, s0, v1 neg_hi:[0,0,1]
// GFX11: v_pk_fma_f16 v8, v0, s0, v1 neg_hi:[0,0,1] ; encoding: [0x08,0x44,0x0e,0xcc,0x00,0x01,0x04,0x1c]

//
// DOT
//

v_dot4_i32_iu8 v3, v4, v5, v6
// GFX11: v_dot4_i32_iu8 v3, v4, v5, v6                ; encoding: [0x03,0x40,0x16,0xcc,0x04,0x0b,0x1a,0x1c]

v_dot4_i32_iu8 v3, v4, v5, 0xf neg_lo:[1,1]
// GFX11: v_dot4_i32_iu8 v3, v4, v5, 15 neg_lo:[1,1,0] ; encoding: [0x03,0x40,0x16,0xcc,0x04,0x0b,0x3e,0x7a]

v_dot4_u32_u8 v3, v4, v5, v6
// GFX11: v_dot4_u32_u8 v3, v4, v5, v6            ; encoding: [0x03,0x40,0x17,0xcc,0x04,0x0b,0x1a,0x1c]

v_dot4_i32_iu8 v3, v4, v5, 0xf
// GFX11: v_dot4_i32_iu8 v3, v4, v5, 15                ; encoding: [0x03,0x40,0x16,0xcc,0x04,0x0b,0x3e,0x1a]

v_dot8_i32_iu4 v3, v4, v5, 0xf neg_lo:[1,0]
// GFX11: v_dot8_i32_iu4 v3, v4, v5, 15 neg_lo:[1,0,0] ; encoding: [0x03,0x40,0x18,0xcc,0x04,0x0b,0x3e,0x3a]

v_dot8_i32_iu4 v3, v4, v5, v0 neg_lo:[0,0]
// GFX11: v_dot8_i32_iu4 v3, v4, v5, v0                ; encoding: [0x03,0x40,0x18,0xcc,0x04,0x0b,0x02,0x1c]

v_dot8_u32_u4 v0, v1, v2, v3
// GFX11: v_dot8_u32_u4 v0, v1, v2, v3            ; encoding: [0x00,0x40,0x19,0xcc,0x01,0x05,0x0e,0x1c]

v_dot2_f32_f16 v0, v1, v2, v3
// GFX11: v_dot2_f32_f16 v0, v1, v2, v3                ; encoding: [0x00,0x40,0x13,0xcc,0x01,0x05,0x0e,0x1c]

v_dot2_f32_f16 v0, v1, v2, v3 neg_lo:[1,1,0] neg_hi:[1,0,1]
// GFX11: v_dot2_f32_f16 v0, v1, v2, v3 neg_lo:[1,1,0] neg_hi:[1,0,1] ; encoding: [0x00,0x45,0x13,0xcc,0x01,0x05,0x0e,0x7c]

v_dot2_f32_bf16 v0, v1, v2, v3
// GFX11: v_dot2_f32_bf16 v0, v1, v2, v3          ; encoding: [0x00,0x40,0x1a,0xcc,0x01,0x05,0x0e,0x1c]

v_dot2_f32_bf16 v0, v1, v2, v3 neg_lo:[1,1,0] neg_hi:[1,0,1]
// GFX11: v_dot2_f32_bf16 v0, v1, v2, v3 neg_lo:[1,1,0] neg_hi:[1,0,1] ; encoding: [0x00,0x45,0x1a,0xcc,0x01,0x05,0x0e,0x7c]
