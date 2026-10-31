// Lean compiler output
// Module: SFT.Physics.FoldFirstReturn
// Imports: public import Init public meta import Init public import SFT.Physics.FoldReturnCarrier
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
lean_object* l_SFT_Foundation_ExactOperations_foldPart(lean_object*);
lean_object* l_instDecidableEqNat___boxed(lean_object*, lean_object*);
lean_object* l_SFT_Physics_FoldReturnCarrier_key(lean_object*);
uint8_t l_instDecidableEqProd___redArg(lean_object*, lean_object*, lean_object*, lean_object*);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
lean_object* l_SFT_Physics_FoldReturnCarrier_remove(lean_object*, lean_object*);
lean_object* lp_sft__v4_SFT_Physics_GeneratorThreeDerivation_unitPart___redArg(lean_object*);
lean_object* l_SFT_Physics_FoldReturnCarrier_carrier(lean_object*);
lean_object* l_List_lengthTR___redArg(lean_object*);
lean_object* l_SFT_Foundation_ExactPartCarrier_admitFraction(lean_object*);
lean_object* lean_nat_add(lean_object*, lean_object*);
static const lean_string_object l_SFT_Physics_FoldFirstReturn_recurrenceError___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 72, .m_capacity = 72, .m_length = 71, .m_data = "ValueError: registered part entered another recurrence before returning"};
static const lean_object* l_SFT_Physics_FoldFirstReturn_recurrenceError___closed__0 = (const lean_object*)&l_SFT_Physics_FoldFirstReturn_recurrenceError___closed__0_value;
LEAN_EXPORT const lean_object* l_SFT_Physics_FoldFirstReturn_recurrenceError = (const lean_object*)&l_SFT_Physics_FoldFirstReturn_recurrenceError___closed__0_value;
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_prepend(lean_object*, lean_object*);
LEAN_EXPORT uint8_t l_SFT_Mathematics_DiscreteObjects_has___at___00SFT_Physics_FoldFirstReturn_runBounded_spec__0(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_SFT_Mathematics_DiscreteObjects_has___at___00SFT_Physics_FoldFirstReturn_runBounded_spec__0___boxed(lean_object*, lean_object*);
static const lean_ctor_object l_SFT_Physics_FoldFirstReturn_runBounded___redArg___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 0}, .m_objs = {((lean_object*)&l_SFT_Physics_FoldFirstReturn_recurrenceError___closed__0_value)}};
static const lean_object* l_SFT_Physics_FoldFirstReturn_runBounded___redArg___closed__0 = (const lean_object*)&l_SFT_Physics_FoldFirstReturn_runBounded___redArg___closed__0_value;
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_runBounded___redArg(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_runBounded___redArg___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_runBounded(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_runBounded___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_firstReturn(lean_object*);
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_Input_ctorIdx(lean_object*);
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_Input_ctorIdx___boxed(lean_object*);
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_Input_ctorElim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_Input_ctorElim(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_Input_ctorElim___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_Input_fraction_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_Input_fraction_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_Input_nonFraction_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_Input_nonFraction_elim(lean_object*, lean_object*, lean_object*, lean_object*);
static const lean_string_object l_SFT_Physics_FoldFirstReturn_checkedFold___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 68, .m_capacity = 68, .m_length = 67, .m_data = "ValueError: Fold action requires one exact positive part of the One"};
static const lean_object* l_SFT_Physics_FoldFirstReturn_checkedFold___closed__0 = (const lean_object*)&l_SFT_Physics_FoldFirstReturn_checkedFold___closed__0_value;
static const lean_ctor_object l_SFT_Physics_FoldFirstReturn_checkedFold___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 0}, .m_objs = {((lean_object*)&l_SFT_Physics_FoldFirstReturn_checkedFold___closed__0_value)}};
static const lean_object* l_SFT_Physics_FoldFirstReturn_checkedFold___closed__1 = (const lean_object*)&l_SFT_Physics_FoldFirstReturn_checkedFold___closed__1_value;
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_checkedFold(lean_object*);
static const lean_string_object l_SFT_Physics_FoldFirstReturn_checkedFirstReturn___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 63, .m_capacity = 63, .m_length = 62, .m_data = "ValueError: first return requires one exact positive Fold part"};
static const lean_object* l_SFT_Physics_FoldFirstReturn_checkedFirstReturn___closed__0 = (const lean_object*)&l_SFT_Physics_FoldFirstReturn_checkedFirstReturn___closed__0_value;
static const lean_ctor_object l_SFT_Physics_FoldFirstReturn_checkedFirstReturn___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 0}, .m_objs = {((lean_object*)&l_SFT_Physics_FoldFirstReturn_checkedFirstReturn___closed__0_value)}};
static const lean_object* l_SFT_Physics_FoldFirstReturn_checkedFirstReturn___closed__1 = (const lean_object*)&l_SFT_Physics_FoldFirstReturn_checkedFirstReturn___closed__1_value;
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_checkedFirstReturn(lean_object*);
static const lean_string_object l_SFT_Physics_FoldFirstReturn_generatorPeriod___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 73, .m_capacity = 73, .m_length = 72, .m_data = "ValueError: Fold recurrence did not force the first two distinct periods"};
static const lean_object* l_SFT_Physics_FoldFirstReturn_generatorPeriod___closed__0 = (const lean_object*)&l_SFT_Physics_FoldFirstReturn_generatorPeriod___closed__0_value;
static const lean_ctor_object l_SFT_Physics_FoldFirstReturn_generatorPeriod___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 0}, .m_objs = {((lean_object*)&l_SFT_Physics_FoldFirstReturn_generatorPeriod___closed__0_value)}};
static const lean_object* l_SFT_Physics_FoldFirstReturn_generatorPeriod___closed__1 = (const lean_object*)&l_SFT_Physics_FoldFirstReturn_generatorPeriod___closed__1_value;
static lean_once_cell_t l_SFT_Physics_FoldFirstReturn_generatorPeriod___closed__2_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_SFT_Physics_FoldFirstReturn_generatorPeriod___closed__2;
static lean_once_cell_t l_SFT_Physics_FoldFirstReturn_generatorPeriod___closed__3_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_SFT_Physics_FoldFirstReturn_generatorPeriod___closed__3;
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_generatorPeriod;
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_prepend(lean_object* v_state_3_, lean_object* v_x_4_){
_start:
{
if (lean_obj_tag(v_x_4_) == 0)
{
lean_dec_ref(v_state_3_);
return v_x_4_;
}
else
{
lean_object* v_a_5_; lean_object* v___x_7_; uint8_t v_isShared_8_; uint8_t v_isSharedCheck_13_; 
v_a_5_ = lean_ctor_get(v_x_4_, 0);
v_isSharedCheck_13_ = !lean_is_exclusive(v_x_4_);
if (v_isSharedCheck_13_ == 0)
{
v___x_7_ = v_x_4_;
v_isShared_8_ = v_isSharedCheck_13_;
goto v_resetjp_6_;
}
else
{
lean_inc(v_a_5_);
lean_dec(v_x_4_);
v___x_7_ = lean_box(0);
v_isShared_8_ = v_isSharedCheck_13_;
goto v_resetjp_6_;
}
v_resetjp_6_:
{
lean_object* v___x_9_; lean_object* v___x_11_; 
v___x_9_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_9_, 0, v_state_3_);
lean_ctor_set(v___x_9_, 1, v_a_5_);
if (v_isShared_8_ == 0)
{
lean_ctor_set(v___x_7_, 0, v___x_9_);
v___x_11_ = v___x_7_;
goto v_reusejp_10_;
}
else
{
lean_object* v_reuseFailAlloc_12_; 
v_reuseFailAlloc_12_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v_reuseFailAlloc_12_, 0, v___x_9_);
v___x_11_ = v_reuseFailAlloc_12_;
goto v_reusejp_10_;
}
v_reusejp_10_:
{
return v___x_11_;
}
}
}
}
}
LEAN_EXPORT uint8_t l_SFT_Mathematics_DiscreteObjects_has___at___00SFT_Physics_FoldFirstReturn_runBounded_spec__0(lean_object* v_x_14_, lean_object* v_x_15_){
_start:
{
if (lean_obj_tag(v_x_14_) == 0)
{
uint8_t v___x_16_; 
lean_dec_ref(v_x_15_);
v___x_16_ = 0;
return v___x_16_;
}
else
{
lean_object* v_head_17_; lean_object* v_tail_18_; lean_object* v___x_19_; uint8_t v___x_20_; 
v_head_17_ = lean_ctor_get(v_x_14_, 0);
lean_inc(v_head_17_);
v_tail_18_ = lean_ctor_get(v_x_14_, 1);
lean_inc(v_tail_18_);
lean_dec_ref_known(v_x_14_, 2);
v___x_19_ = lean_alloc_closure((void*)(l_instDecidableEqNat___boxed), 2, 0);
lean_inc_ref(v_x_15_);
lean_inc_ref(v___x_19_);
v___x_20_ = l_instDecidableEqProd___redArg(v___x_19_, v___x_19_, v_head_17_, v_x_15_);
if (v___x_20_ == 0)
{
v_x_14_ = v_tail_18_;
goto _start;
}
else
{
lean_dec(v_tail_18_);
lean_dec_ref(v_x_15_);
return v___x_20_;
}
}
}
}
LEAN_EXPORT lean_object* l_SFT_Mathematics_DiscreteObjects_has___at___00SFT_Physics_FoldFirstReturn_runBounded_spec__0___boxed(lean_object* v_x_22_, lean_object* v_x_23_){
_start:
{
uint8_t v_res_24_; lean_object* v_r_25_; 
v_res_24_ = l_SFT_Mathematics_DiscreteObjects_has___at___00SFT_Physics_FoldFirstReturn_runBounded_spec__0(v_x_22_, v_x_23_);
v_r_25_ = lean_box(v_res_24_);
return v_r_25_;
}
}
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_runBounded___redArg(lean_object* v_source_28_, lean_object* v_x_29_, lean_object* v_x_30_, lean_object* v_x_31_, lean_object* v_x_32_){
_start:
{
lean_object* v_next_33_; lean_object* v___x_34_; lean_object* v___x_35_; lean_object* v___x_36_; uint8_t v___x_37_; 
v_next_33_ = l_SFT_Foundation_ExactOperations_foldPart(v_x_32_);
v___x_34_ = lean_alloc_closure((void*)(l_instDecidableEqNat___boxed), 2, 0);
lean_inc_ref(v_next_33_);
v___x_35_ = l_SFT_Physics_FoldReturnCarrier_key(v_next_33_);
lean_inc_ref(v_source_28_);
v___x_36_ = l_SFT_Physics_FoldReturnCarrier_key(v_source_28_);
lean_inc_ref(v___x_35_);
lean_inc_ref(v___x_34_);
v___x_37_ = l_instDecidableEqProd___redArg(v___x_34_, v___x_34_, v___x_35_, v___x_36_);
if (v___x_37_ == 0)
{
uint8_t v___x_38_; 
lean_inc_ref(v___x_35_);
lean_inc(v_x_31_);
v___x_38_ = l_SFT_Mathematics_DiscreteObjects_has___at___00SFT_Physics_FoldFirstReturn_runBounded_spec__0(v_x_31_, v___x_35_);
if (v___x_38_ == 0)
{
lean_object* v_zero_39_; uint8_t v_isZero_40_; lean_object* v_one_41_; lean_object* v_n_42_; lean_object* v___x_43_; lean_object* v___x_44_; lean_object* v_tail_45_; lean_object* v___x_46_; 
v_zero_39_ = lean_unsigned_to_nat(0u);
v_isZero_40_ = lean_nat_dec_eq(v_x_29_, v_zero_39_);
v_one_41_ = lean_unsigned_to_nat(1u);
v_n_42_ = lean_nat_sub(v_x_29_, v_one_41_);
lean_inc_ref(v___x_35_);
v___x_43_ = l_SFT_Physics_FoldReturnCarrier_remove(v___x_35_, v_x_30_);
v___x_44_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_44_, 0, v___x_35_);
lean_ctor_set(v___x_44_, 1, v_x_31_);
v_tail_45_ = l_SFT_Physics_FoldFirstReturn_runBounded___redArg(v_source_28_, v_n_42_, v___x_43_, v___x_44_, v_next_33_);
lean_dec(v_n_42_);
v___x_46_ = l_SFT_Physics_FoldFirstReturn_prepend(v_next_33_, v_tail_45_);
return v___x_46_;
}
else
{
lean_object* v___x_47_; 
lean_dec_ref(v___x_35_);
lean_dec_ref(v_next_33_);
lean_dec(v_x_31_);
lean_dec(v_x_30_);
lean_dec_ref(v_source_28_);
v___x_47_ = ((lean_object*)(l_SFT_Physics_FoldFirstReturn_runBounded___redArg___closed__0));
return v___x_47_;
}
}
else
{
lean_object* v___x_48_; lean_object* v___x_49_; lean_object* v___x_50_; 
lean_dec_ref(v___x_35_);
lean_dec(v_x_31_);
lean_dec(v_x_30_);
lean_dec_ref(v_source_28_);
v___x_48_ = lean_box(0);
v___x_49_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_49_, 0, v_next_33_);
lean_ctor_set(v___x_49_, 1, v___x_48_);
v___x_50_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v___x_50_, 0, v___x_49_);
return v___x_50_;
}
}
}
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_runBounded___redArg___boxed(lean_object* v_source_51_, lean_object* v_x_52_, lean_object* v_x_53_, lean_object* v_x_54_, lean_object* v_x_55_){
_start:
{
lean_object* v_res_56_; 
v_res_56_ = l_SFT_Physics_FoldFirstReturn_runBounded___redArg(v_source_51_, v_x_52_, v_x_53_, v_x_54_, v_x_55_);
lean_dec_ref(v_x_55_);
lean_dec(v_x_52_);
return v_res_56_;
}
}
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_runBounded(lean_object* v_source_57_, lean_object* v_denominator_58_, lean_object* v_x_59_, lean_object* v_x_60_, lean_object* v_x_61_, lean_object* v_x_62_, lean_object* v_x_63_, lean_object* v_x_64_, lean_object* v_x_65_){
_start:
{
lean_object* v___x_66_; 
v___x_66_ = l_SFT_Physics_FoldFirstReturn_runBounded___redArg(v_source_57_, v_x_59_, v_x_60_, v_x_61_, v_x_64_);
return v___x_66_;
}
}
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_runBounded___boxed(lean_object* v_source_67_, lean_object* v_denominator_68_, lean_object* v_x_69_, lean_object* v_x_70_, lean_object* v_x_71_, lean_object* v_x_72_, lean_object* v_x_73_, lean_object* v_x_74_, lean_object* v_x_75_){
_start:
{
lean_object* v_res_76_; 
v_res_76_ = l_SFT_Physics_FoldFirstReturn_runBounded(v_source_67_, v_denominator_68_, v_x_69_, v_x_70_, v_x_71_, v_x_72_, v_x_73_, v_x_74_, v_x_75_);
lean_dec_ref(v_x_74_);
lean_dec(v_x_69_);
lean_dec(v_denominator_68_);
return v_res_76_;
}
}
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_firstReturn(lean_object* v_source_77_){
_start:
{
lean_object* v_denominator_78_; lean_object* v___x_79_; lean_object* v___x_80_; lean_object* v___x_81_; lean_object* v___x_82_; lean_object* v___x_83_; lean_object* v___x_84_; 
v_denominator_78_ = lean_ctor_get(v_source_77_, 1);
v___x_79_ = l_SFT_Physics_FoldReturnCarrier_carrier(v_denominator_78_);
v___x_80_ = l_List_lengthTR___redArg(v___x_79_);
lean_inc_ref_n(v_source_77_, 2);
v___x_81_ = l_SFT_Physics_FoldReturnCarrier_key(v_source_77_);
v___x_82_ = lean_box(0);
v___x_83_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_83_, 0, v___x_81_);
lean_ctor_set(v___x_83_, 1, v___x_82_);
v___x_84_ = l_SFT_Physics_FoldFirstReturn_runBounded___redArg(v_source_77_, v___x_80_, v___x_79_, v___x_83_, v_source_77_);
lean_dec(v___x_80_);
lean_dec_ref(v_source_77_);
return v___x_84_;
}
}
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_Input_ctorIdx(lean_object* v_x_85_){
_start:
{
if (lean_obj_tag(v_x_85_) == 0)
{
lean_object* v___x_86_; 
v___x_86_ = lean_unsigned_to_nat(0u);
return v___x_86_;
}
else
{
lean_object* v___x_87_; 
v___x_87_ = lean_unsigned_to_nat(1u);
return v___x_87_;
}
}
}
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_Input_ctorIdx___boxed(lean_object* v_x_88_){
_start:
{
lean_object* v_res_89_; 
v_res_89_ = l_SFT_Physics_FoldFirstReturn_Input_ctorIdx(v_x_88_);
lean_dec(v_x_88_);
return v_res_89_;
}
}
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_Input_ctorElim___redArg(lean_object* v_t_90_, lean_object* v_k_91_){
_start:
{
if (lean_obj_tag(v_t_90_) == 0)
{
lean_object* v_value_92_; lean_object* v___x_93_; 
v_value_92_ = lean_ctor_get(v_t_90_, 0);
lean_inc_ref(v_value_92_);
lean_dec_ref_known(v_t_90_, 1);
v___x_93_ = lean_apply_1(v_k_91_, v_value_92_);
return v___x_93_;
}
else
{
return v_k_91_;
}
}
}
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_Input_ctorElim(lean_object* v_motive_94_, lean_object* v_ctorIdx_95_, lean_object* v_t_96_, lean_object* v_h_97_, lean_object* v_k_98_){
_start:
{
lean_object* v___x_99_; 
v___x_99_ = l_SFT_Physics_FoldFirstReturn_Input_ctorElim___redArg(v_t_96_, v_k_98_);
return v___x_99_;
}
}
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_Input_ctorElim___boxed(lean_object* v_motive_100_, lean_object* v_ctorIdx_101_, lean_object* v_t_102_, lean_object* v_h_103_, lean_object* v_k_104_){
_start:
{
lean_object* v_res_105_; 
v_res_105_ = l_SFT_Physics_FoldFirstReturn_Input_ctorElim(v_motive_100_, v_ctorIdx_101_, v_t_102_, v_h_103_, v_k_104_);
lean_dec(v_ctorIdx_101_);
return v_res_105_;
}
}
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_Input_fraction_elim___redArg(lean_object* v_t_106_, lean_object* v_fraction_107_){
_start:
{
lean_object* v___x_108_; 
v___x_108_ = l_SFT_Physics_FoldFirstReturn_Input_ctorElim___redArg(v_t_106_, v_fraction_107_);
return v___x_108_;
}
}
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_Input_fraction_elim(lean_object* v_motive_109_, lean_object* v_t_110_, lean_object* v_h_111_, lean_object* v_fraction_112_){
_start:
{
lean_object* v___x_113_; 
v___x_113_ = l_SFT_Physics_FoldFirstReturn_Input_ctorElim___redArg(v_t_110_, v_fraction_112_);
return v___x_113_;
}
}
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_Input_nonFraction_elim___redArg(lean_object* v_t_114_, lean_object* v_nonFraction_115_){
_start:
{
lean_object* v___x_116_; 
v___x_116_ = l_SFT_Physics_FoldFirstReturn_Input_ctorElim___redArg(v_t_114_, v_nonFraction_115_);
return v___x_116_;
}
}
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_Input_nonFraction_elim(lean_object* v_motive_117_, lean_object* v_t_118_, lean_object* v_h_119_, lean_object* v_nonFraction_120_){
_start:
{
lean_object* v___x_121_; 
v___x_121_ = l_SFT_Physics_FoldFirstReturn_Input_ctorElim___redArg(v_t_118_, v_nonFraction_120_);
return v___x_121_;
}
}
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_checkedFold(lean_object* v_x_125_){
_start:
{
if (lean_obj_tag(v_x_125_) == 0)
{
lean_object* v_value_128_; lean_object* v___x_129_; 
v_value_128_ = lean_ctor_get(v_x_125_, 0);
lean_inc_ref(v_value_128_);
lean_dec_ref_known(v_x_125_, 1);
v___x_129_ = l_SFT_Foundation_ExactPartCarrier_admitFraction(v_value_128_);
if (lean_obj_tag(v___x_129_) == 0)
{
goto v___jp_126_;
}
else
{
lean_object* v_val_130_; lean_object* v___x_132_; uint8_t v_isShared_133_; uint8_t v_isSharedCheck_138_; 
v_val_130_ = lean_ctor_get(v___x_129_, 0);
v_isSharedCheck_138_ = !lean_is_exclusive(v___x_129_);
if (v_isSharedCheck_138_ == 0)
{
v___x_132_ = v___x_129_;
v_isShared_133_ = v_isSharedCheck_138_;
goto v_resetjp_131_;
}
else
{
lean_inc(v_val_130_);
lean_dec(v___x_129_);
v___x_132_ = lean_box(0);
v_isShared_133_ = v_isSharedCheck_138_;
goto v_resetjp_131_;
}
v_resetjp_131_:
{
lean_object* v___x_134_; lean_object* v___x_136_; 
v___x_134_ = l_SFT_Foundation_ExactOperations_foldPart(v_val_130_);
lean_dec(v_val_130_);
if (v_isShared_133_ == 0)
{
lean_ctor_set(v___x_132_, 0, v___x_134_);
v___x_136_ = v___x_132_;
goto v_reusejp_135_;
}
else
{
lean_object* v_reuseFailAlloc_137_; 
v_reuseFailAlloc_137_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v_reuseFailAlloc_137_, 0, v___x_134_);
v___x_136_ = v_reuseFailAlloc_137_;
goto v_reusejp_135_;
}
v_reusejp_135_:
{
return v___x_136_;
}
}
}
}
else
{
goto v___jp_126_;
}
v___jp_126_:
{
lean_object* v___x_127_; 
v___x_127_ = ((lean_object*)(l_SFT_Physics_FoldFirstReturn_checkedFold___closed__1));
return v___x_127_;
}
}
}
LEAN_EXPORT lean_object* l_SFT_Physics_FoldFirstReturn_checkedFirstReturn(lean_object* v_x_142_){
_start:
{
if (lean_obj_tag(v_x_142_) == 0)
{
lean_object* v_value_145_; lean_object* v___x_146_; 
v_value_145_ = lean_ctor_get(v_x_142_, 0);
lean_inc_ref(v_value_145_);
lean_dec_ref_known(v_x_142_, 1);
v___x_146_ = l_SFT_Foundation_ExactPartCarrier_admitFraction(v_value_145_);
if (lean_obj_tag(v___x_146_) == 0)
{
goto v___jp_143_;
}
else
{
lean_object* v_val_147_; lean_object* v___x_148_; 
v_val_147_ = lean_ctor_get(v___x_146_, 0);
lean_inc(v_val_147_);
lean_dec_ref_known(v___x_146_, 1);
v___x_148_ = l_SFT_Physics_FoldFirstReturn_firstReturn(v_val_147_);
return v___x_148_;
}
}
else
{
goto v___jp_143_;
}
v___jp_143_:
{
lean_object* v___x_144_; 
v___x_144_ = ((lean_object*)(l_SFT_Physics_FoldFirstReturn_checkedFirstReturn___closed__1));
return v___x_144_;
}
}
}
static lean_object* _init_l_SFT_Physics_FoldFirstReturn_generatorPeriod___closed__2(void){
_start:
{
lean_object* v___x_152_; lean_object* v___x_153_; 
v___x_152_ = lean_unsigned_to_nat(2u);
v___x_153_ = lp_sft__v4_SFT_Physics_GeneratorThreeDerivation_unitPart___redArg(v___x_152_);
return v___x_153_;
}
}
static lean_object* _init_l_SFT_Physics_FoldFirstReturn_generatorPeriod___closed__3(void){
_start:
{
lean_object* v___x_154_; lean_object* v___x_155_; 
v___x_154_ = lean_obj_once(&l_SFT_Physics_FoldFirstReturn_generatorPeriod___closed__2, &l_SFT_Physics_FoldFirstReturn_generatorPeriod___closed__2_once, _init_l_SFT_Physics_FoldFirstReturn_generatorPeriod___closed__2);
v___x_155_ = l_SFT_Physics_FoldFirstReturn_firstReturn(v___x_154_);
return v___x_155_;
}
}
static lean_object* _init_l_SFT_Physics_FoldFirstReturn_generatorPeriod(void){
_start:
{
lean_object* v___x_158_; lean_object* v___x_159_; 
v___x_158_ = lean_unsigned_to_nat(2u);
v___x_159_ = lean_obj_once(&l_SFT_Physics_FoldFirstReturn_generatorPeriod___closed__3, &l_SFT_Physics_FoldFirstReturn_generatorPeriod___closed__3_once, _init_l_SFT_Physics_FoldFirstReturn_generatorPeriod___closed__3);
if (lean_obj_tag(v___x_159_) == 0)
{
lean_object* v_a_160_; lean_object* v___x_161_; 
v_a_160_ = lean_ctor_get(v___x_159_, 0);
lean_inc(v_a_160_);
v___x_161_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v___x_161_, 0, v_a_160_);
return v___x_161_;
}
else
{
lean_object* v_a_162_; lean_object* v___x_163_; lean_object* v___x_164_; lean_object* v___x_165_; lean_object* v___x_166_; lean_object* v___x_167_; 
v_a_162_ = lean_ctor_get(v___x_159_, 0);
v___x_163_ = l_List_lengthTR___redArg(v_a_162_);
v___x_164_ = lean_unsigned_to_nat(1u);
v___x_165_ = lean_nat_add(v___x_163_, v___x_164_);
v___x_166_ = lp_sft__v4_SFT_Physics_GeneratorThreeDerivation_unitPart___redArg(v___x_165_);
v___x_167_ = l_SFT_Physics_FoldFirstReturn_firstReturn(v___x_166_);
if (lean_obj_tag(v___x_167_) == 0)
{
lean_object* v_a_168_; lean_object* v___x_170_; uint8_t v_isShared_171_; uint8_t v_isSharedCheck_175_; 
lean_dec(v___x_165_);
lean_dec(v___x_163_);
v_a_168_ = lean_ctor_get(v___x_167_, 0);
v_isSharedCheck_175_ = !lean_is_exclusive(v___x_167_);
if (v_isSharedCheck_175_ == 0)
{
v___x_170_ = v___x_167_;
v_isShared_171_ = v_isSharedCheck_175_;
goto v_resetjp_169_;
}
else
{
lean_inc(v_a_168_);
lean_dec(v___x_167_);
v___x_170_ = lean_box(0);
v_isShared_171_ = v_isSharedCheck_175_;
goto v_resetjp_169_;
}
v_resetjp_169_:
{
lean_object* v___x_173_; 
if (v_isShared_171_ == 0)
{
v___x_173_ = v___x_170_;
goto v_reusejp_172_;
}
else
{
lean_object* v_reuseFailAlloc_174_; 
v_reuseFailAlloc_174_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v_reuseFailAlloc_174_, 0, v_a_168_);
v___x_173_ = v_reuseFailAlloc_174_;
goto v_reusejp_172_;
}
v_reusejp_172_:
{
return v___x_173_;
}
}
}
else
{
lean_object* v_a_176_; lean_object* v___x_178_; uint8_t v_isShared_179_; uint8_t v_isSharedCheck_186_; 
v_a_176_ = lean_ctor_get(v___x_167_, 0);
v_isSharedCheck_186_ = !lean_is_exclusive(v___x_167_);
if (v_isSharedCheck_186_ == 0)
{
v___x_178_ = v___x_167_;
v_isShared_179_ = v_isSharedCheck_186_;
goto v_resetjp_177_;
}
else
{
lean_inc(v_a_176_);
lean_dec(v___x_167_);
v___x_178_ = lean_box(0);
v_isShared_179_ = v_isSharedCheck_186_;
goto v_resetjp_177_;
}
v_resetjp_177_:
{
uint8_t v___x_180_; 
v___x_180_ = lean_nat_dec_eq(v___x_163_, v___x_158_);
lean_dec(v___x_163_);
if (v___x_180_ == 0)
{
lean_del_object(v___x_178_);
lean_dec(v_a_176_);
lean_dec(v___x_165_);
goto v___jp_156_;
}
else
{
lean_object* v___x_181_; uint8_t v___x_182_; 
v___x_181_ = l_List_lengthTR___redArg(v_a_176_);
lean_dec(v_a_176_);
v___x_182_ = lean_nat_dec_eq(v___x_181_, v___x_165_);
lean_dec(v___x_165_);
if (v___x_182_ == 0)
{
lean_dec(v___x_181_);
lean_del_object(v___x_178_);
goto v___jp_156_;
}
else
{
lean_object* v___x_184_; 
if (v_isShared_179_ == 0)
{
lean_ctor_set(v___x_178_, 0, v___x_181_);
v___x_184_ = v___x_178_;
goto v_reusejp_183_;
}
else
{
lean_object* v_reuseFailAlloc_185_; 
v_reuseFailAlloc_185_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v_reuseFailAlloc_185_, 0, v___x_181_);
v___x_184_ = v_reuseFailAlloc_185_;
goto v_reusejp_183_;
}
v_reusejp_183_:
{
return v___x_184_;
}
}
}
}
}
}
v___jp_156_:
{
lean_object* v___x_157_; 
v___x_157_ = ((lean_object*)(l_SFT_Physics_FoldFirstReturn_generatorPeriod___closed__1));
return v___x_157_;
}
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_SFT_Physics_FoldReturnCarrier(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_SFT_Physics_FoldFirstReturn(uint8_t builtin) {
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
res = initialize_SFT_Physics_FoldReturnCarrier(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
l_SFT_Physics_FoldFirstReturn_generatorPeriod = _init_l_SFT_Physics_FoldFirstReturn_generatorPeriod();
lean_mark_persistent(l_SFT_Physics_FoldFirstReturn_generatorPeriod);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
