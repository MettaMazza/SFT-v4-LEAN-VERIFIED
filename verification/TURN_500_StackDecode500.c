// Lean compiler output
// Module: work.«constants-recovery».SFT.Host.StackDecode
// Imports: public import Init public meta import Init public import SFT.Host.Text
#include <lean/lean.h>
#if defined(__clang__)
#pragma clang diagnostic ignored "-Wunused-parameter"
#pragma clang diagnostic ignored "-Wunused-label"
#elif defined(__GNUC__) && !defined(__CLANG__)
#pragma GCC diagnostic ignored "-Wunused-parameter"
#pragma GCC diagnostic ignored "-Wunused-label"
#pragma GCC diagnostic ignored "-Wunused-but-set-variable"
#endif
#ifdef __cplusplus
extern "C" {
#endif
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
lean_object* l_List_reverse___redArg(lean_object*);
lean_object* lean_uint8_to_nat(uint8_t);
uint8_t lean_nat_dec_lt(lean_object*, lean_object*);
lean_object* l_List_drop___redArg(lean_object*, lean_object*);
lean_object* lean_nat_mul(lean_object*, lean_object*);
lean_object* lean_nat_add(lean_object*, lean_object*);
uint32_t l_Char_ofNat(lean_object*);
LEAN_EXPORT lean_object* l_SFT_Host_StackDecode_run(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_work_constants_x2drecovery_SFT_Host_StackDecode_0__SFT_Host_StackDecode_run_match__1_splitter___redArg(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_work_constants_x2drecovery_SFT_Host_StackDecode_0__SFT_Host_StackDecode_run_match__1_splitter___redArg___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_work_constants_x2drecovery_SFT_Host_StackDecode_0__SFT_Host_StackDecode_run_match__1_splitter(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_work_constants_x2drecovery_SFT_Host_StackDecode_0__SFT_Host_StackDecode_run_match__1_splitter___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_work_constants_x2drecovery_SFT_Host_StackDecode_0__SFT_Host_Text_decode_match__3_splitter___redArg(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_work_constants_x2drecovery_SFT_Host_StackDecode_0__SFT_Host_Text_decode_match__3_splitter___redArg___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_work_constants_x2drecovery_SFT_Host_StackDecode_0__SFT_Host_Text_decode_match__3_splitter(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_work_constants_x2drecovery_SFT_Host_StackDecode_0__SFT_Host_Text_decode_match__3_splitter___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_work_constants_x2drecovery_SFT_Host_StackDecode_0__SFT_Host_Text_decode_match__1_splitter___redArg(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_work_constants_x2drecovery_SFT_Host_StackDecode_0__SFT_Host_Text_decode_match__1_splitter(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_SFT_Host_StackDecode_decode(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_SFT_Host_StackDecode_run(lean_object* v_x_1_, lean_object* v_x_2_, lean_object* v_x_3_){
_start:
{
lean_object* v_zero_4_; uint8_t v_isZero_5_; 
v_zero_4_ = lean_unsigned_to_nat(0u);
v_isZero_5_ = lean_nat_dec_eq(v_x_1_, v_zero_4_);
if (v_isZero_5_ == 1)
{
lean_object* v___x_6_; 
lean_dec(v_x_2_);
lean_dec(v_x_1_);
v___x_6_ = l_List_reverse___redArg(v_x_3_);
return v___x_6_;
}
else
{
if (lean_obj_tag(v_x_2_) == 0)
{
lean_object* v___x_7_; 
lean_dec(v_x_1_);
v___x_7_ = l_List_reverse___redArg(v_x_3_);
return v___x_7_;
}
else
{
lean_object* v_head_8_; lean_object* v_tail_9_; lean_object* v___x_11_; uint8_t v_isShared_12_; uint8_t v_isSharedCheck_100_; 
v_head_8_ = lean_ctor_get(v_x_2_, 0);
v_tail_9_ = lean_ctor_get(v_x_2_, 1);
v_isSharedCheck_100_ = !lean_is_exclusive(v_x_2_);
if (v_isSharedCheck_100_ == 0)
{
v___x_11_ = v_x_2_;
v_isShared_12_ = v_isSharedCheck_100_;
goto v_resetjp_10_;
}
else
{
lean_inc(v_tail_9_);
lean_inc(v_head_8_);
lean_dec(v_x_2_);
v___x_11_ = lean_box(0);
v_isShared_12_ = v_isSharedCheck_100_;
goto v_resetjp_10_;
}
v_resetjp_10_:
{
lean_object* v_one_13_; lean_object* v_n_14_; uint8_t v___x_15_; lean_object* v_n_16_; lean_object* v___x_17_; lean_object* v___y_19_; lean_object* v___y_20_; lean_object* v___y_21_; lean_object* v___y_22_; uint8_t v___y_23_; uint8_t v___x_77_; 
v_one_13_ = lean_unsigned_to_nat(1u);
v_n_14_ = lean_nat_sub(v_x_1_, v_one_13_);
lean_dec(v_x_1_);
v___x_15_ = lean_unbox(v_head_8_);
lean_dec(v_head_8_);
v_n_16_ = lean_uint8_to_nat(v___x_15_);
v___x_17_ = lean_unsigned_to_nat(128u);
v___x_77_ = lean_nat_dec_lt(v_n_16_, v___x_17_);
if (v___x_77_ == 0)
{
uint8_t v___x_78_; lean_object* v___y_80_; lean_object* v___y_81_; uint8_t v___y_82_; uint8_t v___y_89_; 
v___x_78_ = 0;
if (lean_obj_tag(v_tail_9_) == 0)
{
v___y_89_ = v___x_78_;
goto v___jp_88_;
}
else
{
lean_object* v_head_94_; uint8_t v___x_95_; 
v_head_94_ = lean_ctor_get(v_tail_9_, 0);
v___x_95_ = lean_unbox(v_head_94_);
v___y_89_ = v___x_95_;
goto v___jp_88_;
}
v___jp_79_:
{
lean_object* v_d_83_; lean_object* v___x_84_; lean_object* v___x_85_; 
v_d_83_ = lean_uint8_to_nat(v___y_82_);
v___x_84_ = lean_unsigned_to_nat(2u);
v___x_85_ = l_List_drop___redArg(v___x_84_, v_tail_9_);
if (lean_obj_tag(v___x_85_) == 0)
{
v___y_19_ = v_d_83_;
v___y_20_ = v___y_80_;
v___y_21_ = v___x_85_;
v___y_22_ = v___y_81_;
v___y_23_ = v___x_78_;
goto v___jp_18_;
}
else
{
lean_object* v_head_86_; uint8_t v___x_87_; 
v_head_86_ = lean_ctor_get(v___x_85_, 0);
lean_inc(v_head_86_);
v___x_87_ = lean_unbox(v_head_86_);
lean_dec(v_head_86_);
v___y_19_ = v_d_83_;
v___y_20_ = v___y_80_;
v___y_21_ = v___x_85_;
v___y_22_ = v___y_81_;
v___y_23_ = v___x_87_;
goto v___jp_18_;
}
}
v___jp_88_:
{
lean_object* v_c_90_; lean_object* v___x_91_; 
v_c_90_ = lean_uint8_to_nat(v___y_89_);
v___x_91_ = l_List_drop___redArg(v_one_13_, v_tail_9_);
if (lean_obj_tag(v___x_91_) == 0)
{
v___y_80_ = v___x_91_;
v___y_81_ = v_c_90_;
v___y_82_ = v___x_78_;
goto v___jp_79_;
}
else
{
lean_object* v_head_92_; uint8_t v___x_93_; 
v_head_92_ = lean_ctor_get(v___x_91_, 0);
lean_inc(v_head_92_);
v___x_93_ = lean_unbox(v_head_92_);
lean_dec(v_head_92_);
v___y_80_ = v___x_91_;
v___y_81_ = v_c_90_;
v___y_82_ = v___x_93_;
goto v___jp_79_;
}
}
}
else
{
uint32_t v___x_96_; lean_object* v___x_97_; lean_object* v___x_98_; 
lean_del_object(v___x_11_);
v___x_96_ = l_Char_ofNat(v_n_16_);
v___x_97_ = lean_box_uint32(v___x_96_);
v___x_98_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_98_, 0, v___x_97_);
lean_ctor_set(v___x_98_, 1, v_x_3_);
v_x_1_ = v_n_14_;
v_x_2_ = v_tail_9_;
v_x_3_ = v___x_98_;
goto _start;
}
v___jp_18_:
{
lean_object* v___x_24_; uint8_t v___x_25_; 
v___x_24_ = lean_unsigned_to_nat(224u);
v___x_25_ = lean_nat_dec_lt(v_n_16_, v___x_24_);
if (v___x_25_ == 0)
{
lean_object* v___x_26_; uint8_t v___x_27_; 
lean_dec(v___y_20_);
v___x_26_ = lean_unsigned_to_nat(240u);
v___x_27_ = lean_nat_dec_lt(v_n_16_, v___x_26_);
if (v___x_27_ == 0)
{
lean_object* v_e_28_; lean_object* v___x_29_; lean_object* v___x_30_; lean_object* v___x_31_; lean_object* v___x_32_; lean_object* v___x_33_; lean_object* v___x_34_; lean_object* v___x_35_; lean_object* v___x_36_; lean_object* v___x_37_; lean_object* v___x_38_; lean_object* v___x_39_; lean_object* v___x_40_; lean_object* v___x_41_; lean_object* v___x_42_; lean_object* v___x_43_; uint32_t v___x_44_; lean_object* v___x_45_; lean_object* v___x_47_; 
lean_dec(v___y_21_);
v_e_28_ = lean_uint8_to_nat(v___y_23_);
v___x_29_ = lean_unsigned_to_nat(3u);
v___x_30_ = l_List_drop___redArg(v___x_29_, v_tail_9_);
lean_dec(v_tail_9_);
v___x_31_ = lean_nat_sub(v_n_16_, v___x_26_);
v___x_32_ = lean_unsigned_to_nat(262144u);
v___x_33_ = lean_nat_mul(v___x_31_, v___x_32_);
lean_dec(v___x_31_);
v___x_34_ = lean_nat_sub(v___y_22_, v___x_17_);
lean_dec(v___y_22_);
v___x_35_ = lean_unsigned_to_nat(4096u);
v___x_36_ = lean_nat_mul(v___x_34_, v___x_35_);
lean_dec(v___x_34_);
v___x_37_ = lean_nat_add(v___x_33_, v___x_36_);
lean_dec(v___x_36_);
lean_dec(v___x_33_);
v___x_38_ = lean_nat_sub(v___y_19_, v___x_17_);
lean_dec(v___y_19_);
v___x_39_ = lean_unsigned_to_nat(64u);
v___x_40_ = lean_nat_mul(v___x_38_, v___x_39_);
lean_dec(v___x_38_);
v___x_41_ = lean_nat_add(v___x_37_, v___x_40_);
lean_dec(v___x_40_);
lean_dec(v___x_37_);
v___x_42_ = lean_nat_sub(v_e_28_, v___x_17_);
v___x_43_ = lean_nat_add(v___x_41_, v___x_42_);
lean_dec(v___x_42_);
lean_dec(v___x_41_);
v___x_44_ = l_Char_ofNat(v___x_43_);
lean_dec(v___x_43_);
v___x_45_ = lean_box_uint32(v___x_44_);
if (v_isShared_12_ == 0)
{
lean_ctor_set(v___x_11_, 1, v_x_3_);
lean_ctor_set(v___x_11_, 0, v___x_45_);
v___x_47_ = v___x_11_;
goto v_reusejp_46_;
}
else
{
lean_object* v_reuseFailAlloc_49_; 
v_reuseFailAlloc_49_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v_reuseFailAlloc_49_, 0, v___x_45_);
lean_ctor_set(v_reuseFailAlloc_49_, 1, v_x_3_);
v___x_47_ = v_reuseFailAlloc_49_;
goto v_reusejp_46_;
}
v_reusejp_46_:
{
v_x_1_ = v_n_14_;
v_x_2_ = v___x_30_;
v_x_3_ = v___x_47_;
goto _start;
}
}
else
{
lean_object* v___x_50_; lean_object* v___x_51_; lean_object* v___x_52_; lean_object* v___x_53_; lean_object* v___x_54_; lean_object* v___x_55_; lean_object* v___x_56_; lean_object* v___x_57_; lean_object* v___x_58_; uint32_t v___x_59_; lean_object* v___x_60_; lean_object* v___x_62_; 
lean_dec(v_tail_9_);
v___x_50_ = lean_nat_sub(v_n_16_, v___x_24_);
v___x_51_ = lean_unsigned_to_nat(4096u);
v___x_52_ = lean_nat_mul(v___x_50_, v___x_51_);
lean_dec(v___x_50_);
v___x_53_ = lean_nat_sub(v___y_22_, v___x_17_);
lean_dec(v___y_22_);
v___x_54_ = lean_unsigned_to_nat(64u);
v___x_55_ = lean_nat_mul(v___x_53_, v___x_54_);
lean_dec(v___x_53_);
v___x_56_ = lean_nat_add(v___x_52_, v___x_55_);
lean_dec(v___x_55_);
lean_dec(v___x_52_);
v___x_57_ = lean_nat_sub(v___y_19_, v___x_17_);
lean_dec(v___y_19_);
v___x_58_ = lean_nat_add(v___x_56_, v___x_57_);
lean_dec(v___x_57_);
lean_dec(v___x_56_);
v___x_59_ = l_Char_ofNat(v___x_58_);
lean_dec(v___x_58_);
v___x_60_ = lean_box_uint32(v___x_59_);
if (v_isShared_12_ == 0)
{
lean_ctor_set(v___x_11_, 1, v_x_3_);
lean_ctor_set(v___x_11_, 0, v___x_60_);
v___x_62_ = v___x_11_;
goto v_reusejp_61_;
}
else
{
lean_object* v_reuseFailAlloc_64_; 
v_reuseFailAlloc_64_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v_reuseFailAlloc_64_, 0, v___x_60_);
lean_ctor_set(v_reuseFailAlloc_64_, 1, v_x_3_);
v___x_62_ = v_reuseFailAlloc_64_;
goto v_reusejp_61_;
}
v_reusejp_61_:
{
v_x_1_ = v_n_14_;
v_x_2_ = v___y_21_;
v_x_3_ = v___x_62_;
goto _start;
}
}
}
else
{
lean_object* v___x_65_; lean_object* v___x_66_; lean_object* v___x_67_; lean_object* v___x_68_; lean_object* v___x_69_; lean_object* v___x_70_; uint32_t v___x_71_; lean_object* v___x_72_; lean_object* v___x_74_; 
lean_dec(v___y_21_);
lean_dec(v___y_19_);
lean_dec(v_tail_9_);
v___x_65_ = lean_unsigned_to_nat(192u);
v___x_66_ = lean_nat_sub(v_n_16_, v___x_65_);
v___x_67_ = lean_unsigned_to_nat(64u);
v___x_68_ = lean_nat_mul(v___x_66_, v___x_67_);
lean_dec(v___x_66_);
v___x_69_ = lean_nat_sub(v___y_22_, v___x_17_);
lean_dec(v___y_22_);
v___x_70_ = lean_nat_add(v___x_68_, v___x_69_);
lean_dec(v___x_69_);
lean_dec(v___x_68_);
v___x_71_ = l_Char_ofNat(v___x_70_);
lean_dec(v___x_70_);
v___x_72_ = lean_box_uint32(v___x_71_);
if (v_isShared_12_ == 0)
{
lean_ctor_set(v___x_11_, 1, v_x_3_);
lean_ctor_set(v___x_11_, 0, v___x_72_);
v___x_74_ = v___x_11_;
goto v_reusejp_73_;
}
else
{
lean_object* v_reuseFailAlloc_76_; 
v_reuseFailAlloc_76_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v_reuseFailAlloc_76_, 0, v___x_72_);
lean_ctor_set(v_reuseFailAlloc_76_, 1, v_x_3_);
v___x_74_ = v_reuseFailAlloc_76_;
goto v_reusejp_73_;
}
v_reusejp_73_:
{
v_x_1_ = v_n_14_;
v_x_2_ = v___y_20_;
v_x_3_ = v___x_74_;
goto _start;
}
}
}
}
}
}
}
}
LEAN_EXPORT lean_object* l___private_work_constants_x2drecovery_SFT_Host_StackDecode_0__SFT_Host_StackDecode_run_match__1_splitter___redArg(lean_object* v_x_101_, lean_object* v_x_102_, lean_object* v_x_103_, lean_object* v_h__1_104_, lean_object* v_h__2_105_, lean_object* v_h__3_106_){
_start:
{
lean_object* v_zero_107_; uint8_t v_isZero_108_; 
v_zero_107_ = lean_unsigned_to_nat(0u);
v_isZero_108_ = lean_nat_dec_eq(v_x_101_, v_zero_107_);
if (v_isZero_108_ == 1)
{
lean_object* v___x_109_; 
lean_dec(v_h__3_106_);
lean_dec(v_h__2_105_);
v___x_109_ = lean_apply_2(v_h__1_104_, v_x_102_, v_x_103_);
return v___x_109_;
}
else
{
lean_object* v_one_110_; lean_object* v_n_111_; 
lean_dec(v_h__1_104_);
v_one_110_ = lean_unsigned_to_nat(1u);
v_n_111_ = lean_nat_sub(v_x_101_, v_one_110_);
if (lean_obj_tag(v_x_102_) == 0)
{
lean_object* v___x_112_; 
lean_dec(v_h__3_106_);
v___x_112_ = lean_apply_2(v_h__2_105_, v_n_111_, v_x_103_);
return v___x_112_;
}
else
{
lean_object* v_head_113_; lean_object* v_tail_114_; lean_object* v___x_115_; 
lean_dec(v_h__2_105_);
v_head_113_ = lean_ctor_get(v_x_102_, 0);
lean_inc(v_head_113_);
v_tail_114_ = lean_ctor_get(v_x_102_, 1);
lean_inc(v_tail_114_);
lean_dec_ref_known(v_x_102_, 2);
v___x_115_ = lean_apply_4(v_h__3_106_, v_n_111_, v_head_113_, v_tail_114_, v_x_103_);
return v___x_115_;
}
}
}
}
LEAN_EXPORT lean_object* l___private_work_constants_x2drecovery_SFT_Host_StackDecode_0__SFT_Host_StackDecode_run_match__1_splitter___redArg___boxed(lean_object* v_x_116_, lean_object* v_x_117_, lean_object* v_x_118_, lean_object* v_h__1_119_, lean_object* v_h__2_120_, lean_object* v_h__3_121_){
_start:
{
lean_object* v_res_122_; 
v_res_122_ = l___private_work_constants_x2drecovery_SFT_Host_StackDecode_0__SFT_Host_StackDecode_run_match__1_splitter___redArg(v_x_116_, v_x_117_, v_x_118_, v_h__1_119_, v_h__2_120_, v_h__3_121_);
lean_dec(v_x_116_);
return v_res_122_;
}
}
LEAN_EXPORT lean_object* l___private_work_constants_x2drecovery_SFT_Host_StackDecode_0__SFT_Host_StackDecode_run_match__1_splitter(lean_object* v_motive_123_, lean_object* v_x_124_, lean_object* v_x_125_, lean_object* v_x_126_, lean_object* v_h__1_127_, lean_object* v_h__2_128_, lean_object* v_h__3_129_){
_start:
{
lean_object* v_zero_130_; uint8_t v_isZero_131_; 
v_zero_130_ = lean_unsigned_to_nat(0u);
v_isZero_131_ = lean_nat_dec_eq(v_x_124_, v_zero_130_);
if (v_isZero_131_ == 1)
{
lean_object* v___x_132_; 
lean_dec(v_h__3_129_);
lean_dec(v_h__2_128_);
v___x_132_ = lean_apply_2(v_h__1_127_, v_x_125_, v_x_126_);
return v___x_132_;
}
else
{
lean_object* v_one_133_; lean_object* v_n_134_; 
lean_dec(v_h__1_127_);
v_one_133_ = lean_unsigned_to_nat(1u);
v_n_134_ = lean_nat_sub(v_x_124_, v_one_133_);
if (lean_obj_tag(v_x_125_) == 0)
{
lean_object* v___x_135_; 
lean_dec(v_h__3_129_);
v___x_135_ = lean_apply_2(v_h__2_128_, v_n_134_, v_x_126_);
return v___x_135_;
}
else
{
lean_object* v_head_136_; lean_object* v_tail_137_; lean_object* v___x_138_; 
lean_dec(v_h__2_128_);
v_head_136_ = lean_ctor_get(v_x_125_, 0);
lean_inc(v_head_136_);
v_tail_137_ = lean_ctor_get(v_x_125_, 1);
lean_inc(v_tail_137_);
lean_dec_ref_known(v_x_125_, 2);
v___x_138_ = lean_apply_4(v_h__3_129_, v_n_134_, v_head_136_, v_tail_137_, v_x_126_);
return v___x_138_;
}
}
}
}
LEAN_EXPORT lean_object* l___private_work_constants_x2drecovery_SFT_Host_StackDecode_0__SFT_Host_StackDecode_run_match__1_splitter___boxed(lean_object* v_motive_139_, lean_object* v_x_140_, lean_object* v_x_141_, lean_object* v_x_142_, lean_object* v_h__1_143_, lean_object* v_h__2_144_, lean_object* v_h__3_145_){
_start:
{
lean_object* v_res_146_; 
v_res_146_ = l___private_work_constants_x2drecovery_SFT_Host_StackDecode_0__SFT_Host_StackDecode_run_match__1_splitter(v_motive_139_, v_x_140_, v_x_141_, v_x_142_, v_h__1_143_, v_h__2_144_, v_h__3_145_);
lean_dec(v_x_140_);
return v_res_146_;
}
}
LEAN_EXPORT lean_object* l___private_work_constants_x2drecovery_SFT_Host_StackDecode_0__SFT_Host_Text_decode_match__3_splitter___redArg(lean_object* v_x_147_, lean_object* v_h__1_148_, lean_object* v_h__2_149_){
_start:
{
lean_object* v_zero_150_; uint8_t v_isZero_151_; 
v_zero_150_ = lean_unsigned_to_nat(0u);
v_isZero_151_ = lean_nat_dec_eq(v_x_147_, v_zero_150_);
if (v_isZero_151_ == 1)
{
lean_object* v___x_152_; lean_object* v___x_153_; 
lean_dec(v_h__2_149_);
v___x_152_ = lean_box(0);
v___x_153_ = lean_apply_1(v_h__1_148_, v___x_152_);
return v___x_153_;
}
else
{
lean_object* v_one_154_; lean_object* v_n_155_; lean_object* v___x_156_; 
lean_dec(v_h__1_148_);
v_one_154_ = lean_unsigned_to_nat(1u);
v_n_155_ = lean_nat_sub(v_x_147_, v_one_154_);
v___x_156_ = lean_apply_1(v_h__2_149_, v_n_155_);
return v___x_156_;
}
}
}
LEAN_EXPORT lean_object* l___private_work_constants_x2drecovery_SFT_Host_StackDecode_0__SFT_Host_Text_decode_match__3_splitter___redArg___boxed(lean_object* v_x_157_, lean_object* v_h__1_158_, lean_object* v_h__2_159_){
_start:
{
lean_object* v_res_160_; 
v_res_160_ = l___private_work_constants_x2drecovery_SFT_Host_StackDecode_0__SFT_Host_Text_decode_match__3_splitter___redArg(v_x_157_, v_h__1_158_, v_h__2_159_);
lean_dec(v_x_157_);
return v_res_160_;
}
}
LEAN_EXPORT lean_object* l___private_work_constants_x2drecovery_SFT_Host_StackDecode_0__SFT_Host_Text_decode_match__3_splitter(lean_object* v_motive_161_, lean_object* v_x_162_, lean_object* v_h__1_163_, lean_object* v_h__2_164_){
_start:
{
lean_object* v_zero_165_; uint8_t v_isZero_166_; 
v_zero_165_ = lean_unsigned_to_nat(0u);
v_isZero_166_ = lean_nat_dec_eq(v_x_162_, v_zero_165_);
if (v_isZero_166_ == 1)
{
lean_object* v___x_167_; lean_object* v___x_168_; 
lean_dec(v_h__2_164_);
v___x_167_ = lean_box(0);
v___x_168_ = lean_apply_1(v_h__1_163_, v___x_167_);
return v___x_168_;
}
else
{
lean_object* v_one_169_; lean_object* v_n_170_; lean_object* v___x_171_; 
lean_dec(v_h__1_163_);
v_one_169_ = lean_unsigned_to_nat(1u);
v_n_170_ = lean_nat_sub(v_x_162_, v_one_169_);
v___x_171_ = lean_apply_1(v_h__2_164_, v_n_170_);
return v___x_171_;
}
}
}
LEAN_EXPORT lean_object* l___private_work_constants_x2drecovery_SFT_Host_StackDecode_0__SFT_Host_Text_decode_match__3_splitter___boxed(lean_object* v_motive_172_, lean_object* v_x_173_, lean_object* v_h__1_174_, lean_object* v_h__2_175_){
_start:
{
lean_object* v_res_176_; 
v_res_176_ = l___private_work_constants_x2drecovery_SFT_Host_StackDecode_0__SFT_Host_Text_decode_match__3_splitter(v_motive_172_, v_x_173_, v_h__1_174_, v_h__2_175_);
lean_dec(v_x_173_);
return v_res_176_;
}
}
LEAN_EXPORT lean_object* l___private_work_constants_x2drecovery_SFT_Host_StackDecode_0__SFT_Host_Text_decode_match__1_splitter___redArg(lean_object* v_bytes_177_, lean_object* v_h__1_178_, lean_object* v_h__2_179_){
_start:
{
if (lean_obj_tag(v_bytes_177_) == 0)
{
lean_object* v___x_180_; lean_object* v___x_181_; 
lean_dec(v_h__2_179_);
v___x_180_ = lean_box(0);
v___x_181_ = lean_apply_1(v_h__1_178_, v___x_180_);
return v___x_181_;
}
else
{
lean_object* v_head_182_; lean_object* v_tail_183_; lean_object* v___x_184_; 
lean_dec(v_h__1_178_);
v_head_182_ = lean_ctor_get(v_bytes_177_, 0);
lean_inc(v_head_182_);
v_tail_183_ = lean_ctor_get(v_bytes_177_, 1);
lean_inc(v_tail_183_);
lean_dec_ref_known(v_bytes_177_, 2);
v___x_184_ = lean_apply_2(v_h__2_179_, v_head_182_, v_tail_183_);
return v___x_184_;
}
}
}
LEAN_EXPORT lean_object* l___private_work_constants_x2drecovery_SFT_Host_StackDecode_0__SFT_Host_Text_decode_match__1_splitter(lean_object* v_motive_185_, lean_object* v_bytes_186_, lean_object* v_h__1_187_, lean_object* v_h__2_188_){
_start:
{
if (lean_obj_tag(v_bytes_186_) == 0)
{
lean_object* v___x_189_; lean_object* v___x_190_; 
lean_dec(v_h__2_188_);
v___x_189_ = lean_box(0);
v___x_190_ = lean_apply_1(v_h__1_187_, v___x_189_);
return v___x_190_;
}
else
{
lean_object* v_head_191_; lean_object* v_tail_192_; lean_object* v___x_193_; 
lean_dec(v_h__1_187_);
v_head_191_ = lean_ctor_get(v_bytes_186_, 0);
lean_inc(v_head_191_);
v_tail_192_ = lean_ctor_get(v_bytes_186_, 1);
lean_inc(v_tail_192_);
lean_dec_ref_known(v_bytes_186_, 2);
v___x_193_ = lean_apply_2(v_h__2_188_, v_head_191_, v_tail_192_);
return v___x_193_;
}
}
}
LEAN_EXPORT lean_object* l_SFT_Host_StackDecode_decode(lean_object* v_fuel_194_, lean_object* v_bytes_195_){
_start:
{
lean_object* v___x_196_; lean_object* v___x_197_; 
v___x_196_ = lean_box(0);
v___x_197_ = l_SFT_Host_StackDecode_run(v_fuel_194_, v_bytes_195_, v___x_196_);
return v___x_197_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_sft__v4_SFT_Host_Text(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_work_constants_x2drecovery_SFT_Host_StackDecode(uint8_t builtin) {
lean_object * res;
if (_G_initialized) return lean_io_result_mk_ok(lean_box(0));
_G_initialized = true;
lean_initialize_runtime_module();
res = initialize_Init(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_Init(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_sft__v4_SFT_Host_Text(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
