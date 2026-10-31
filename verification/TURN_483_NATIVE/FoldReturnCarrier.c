// Lean compiler output
// Module: SFT.Physics.FoldReturnCarrier
// Imports: public import Init public meta import Init public import SFT.Physics.GeneratorThreeDerivation public import SFT.Mathematics.DiscreteObjects public import SFT.Foundation.CommonRefinement
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
lean_object* l_instDecidableEqNat___boxed(lean_object*, lean_object*);
uint8_t l_instDecidableEqProd___redArg(lean_object*, lean_object*, lean_object*, lean_object*);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
lean_object* lean_nat_add(lean_object*, lean_object*);
lean_object* lean_mk_empty_array_with_capacity(lean_object*);
lean_object* lean_array_to_list(lean_object*);
lean_object* l_List_reverse___redArg(lean_object*);
lean_object* l_List_foldl___at___00Array_appendList_spec__0___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_SFT_Physics_FoldReturnCarrier_key(lean_object*);
static const lean_ctor_object l_SFT_Physics_FoldReturnCarrier_through___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 1}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)(((size_t)(0) << 1) | 1))}};
static const lean_object* l_SFT_Physics_FoldReturnCarrier_through___closed__0 = (const lean_object*)&l_SFT_Physics_FoldReturnCarrier_through___closed__0_value;
LEAN_EXPORT lean_object* l_SFT_Physics_FoldReturnCarrier_through(lean_object*);
LEAN_EXPORT lean_object* l_SFT_Physics_FoldReturnCarrier_through___boxed(lean_object*);
LEAN_EXPORT lean_object* l_List_mapTR_loop___at___00SFT_Physics_FoldReturnCarrier_carrier_spec__0(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_Init_Data_List_Impl_0__List_flatMapTR_go___at___00SFT_Physics_FoldReturnCarrier_carrier_spec__1(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l___private_Init_Data_List_Impl_0__List_flatMapTR_go___at___00SFT_Physics_FoldReturnCarrier_carrier_spec__1___boxed(lean_object*, lean_object*, lean_object*);
static const lean_array_object l_SFT_Physics_FoldReturnCarrier_carrier___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_array_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 246}, .m_size = 0, .m_capacity = 0, .m_data = {}};
static const lean_object* l_SFT_Physics_FoldReturnCarrier_carrier___closed__0 = (const lean_object*)&l_SFT_Physics_FoldReturnCarrier_carrier___closed__0_value;
LEAN_EXPORT lean_object* l_SFT_Physics_FoldReturnCarrier_carrier(lean_object*);
LEAN_EXPORT lean_object* l_SFT_Physics_FoldReturnCarrier_carrier___boxed(lean_object*);
LEAN_EXPORT lean_object* l_SFT_Physics_FoldReturnCarrier_remove(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_SFT_Physics_FoldReturnCarrier_key(lean_object* v_p_1_){
_start:
{
lean_object* v_numerator_2_; lean_object* v_denominator_3_; lean_object* v___x_5_; uint8_t v_isShared_6_; uint8_t v_isSharedCheck_10_; 
v_numerator_2_ = lean_ctor_get(v_p_1_, 0);
v_denominator_3_ = lean_ctor_get(v_p_1_, 1);
v_isSharedCheck_10_ = !lean_is_exclusive(v_p_1_);
if (v_isSharedCheck_10_ == 0)
{
v___x_5_ = v_p_1_;
v_isShared_6_ = v_isSharedCheck_10_;
goto v_resetjp_4_;
}
else
{
lean_inc(v_denominator_3_);
lean_inc(v_numerator_2_);
lean_dec(v_p_1_);
v___x_5_ = lean_box(0);
v_isShared_6_ = v_isSharedCheck_10_;
goto v_resetjp_4_;
}
v_resetjp_4_:
{
lean_object* v___x_8_; 
if (v_isShared_6_ == 0)
{
v___x_8_ = v___x_5_;
goto v_reusejp_7_;
}
else
{
lean_object* v_reuseFailAlloc_9_; 
v_reuseFailAlloc_9_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v_reuseFailAlloc_9_, 0, v_numerator_2_);
lean_ctor_set(v_reuseFailAlloc_9_, 1, v_denominator_3_);
v___x_8_ = v_reuseFailAlloc_9_;
goto v_reusejp_7_;
}
v_reusejp_7_:
{
return v___x_8_;
}
}
}
}
LEAN_EXPORT lean_object* l_SFT_Physics_FoldReturnCarrier_through(lean_object* v_x_14_){
_start:
{
lean_object* v_zero_15_; uint8_t v_isZero_16_; 
v_zero_15_ = lean_unsigned_to_nat(0u);
v_isZero_16_ = lean_nat_dec_eq(v_x_14_, v_zero_15_);
if (v_isZero_16_ == 1)
{
lean_object* v___x_17_; 
v___x_17_ = ((lean_object*)(l_SFT_Physics_FoldReturnCarrier_through___closed__0));
return v___x_17_;
}
else
{
lean_object* v_one_18_; lean_object* v_n_19_; lean_object* v___x_20_; lean_object* v___x_21_; lean_object* v___x_22_; 
v_one_18_ = lean_unsigned_to_nat(1u);
v_n_19_ = lean_nat_sub(v_x_14_, v_one_18_);
v___x_20_ = lean_nat_add(v_n_19_, v_one_18_);
v___x_21_ = l_SFT_Physics_FoldReturnCarrier_through(v_n_19_);
lean_dec(v_n_19_);
v___x_22_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_22_, 0, v___x_20_);
lean_ctor_set(v___x_22_, 1, v___x_21_);
return v___x_22_;
}
}
}
LEAN_EXPORT lean_object* l_SFT_Physics_FoldReturnCarrier_through___boxed(lean_object* v_x_23_){
_start:
{
lean_object* v_res_24_; 
v_res_24_ = l_SFT_Physics_FoldReturnCarrier_through(v_x_23_);
lean_dec(v_x_23_);
return v_res_24_;
}
}
LEAN_EXPORT lean_object* l_List_mapTR_loop___at___00SFT_Physics_FoldReturnCarrier_carrier_spec__0(lean_object* v_n_25_, lean_object* v_a_26_, lean_object* v_a_27_){
_start:
{
if (lean_obj_tag(v_a_26_) == 0)
{
lean_object* v___x_28_; 
lean_dec(v_n_25_);
v___x_28_ = l_List_reverse___redArg(v_a_27_);
return v___x_28_;
}
else
{
lean_object* v_head_29_; lean_object* v_tail_30_; lean_object* v___x_32_; uint8_t v_isShared_33_; uint8_t v_isSharedCheck_39_; 
v_head_29_ = lean_ctor_get(v_a_26_, 0);
v_tail_30_ = lean_ctor_get(v_a_26_, 1);
v_isSharedCheck_39_ = !lean_is_exclusive(v_a_26_);
if (v_isSharedCheck_39_ == 0)
{
v___x_32_ = v_a_26_;
v_isShared_33_ = v_isSharedCheck_39_;
goto v_resetjp_31_;
}
else
{
lean_inc(v_tail_30_);
lean_inc(v_head_29_);
lean_dec(v_a_26_);
v___x_32_ = lean_box(0);
v_isShared_33_ = v_isSharedCheck_39_;
goto v_resetjp_31_;
}
v_resetjp_31_:
{
lean_object* v___x_34_; lean_object* v___x_36_; 
lean_inc(v_n_25_);
v___x_34_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_34_, 0, v_n_25_);
lean_ctor_set(v___x_34_, 1, v_head_29_);
if (v_isShared_33_ == 0)
{
lean_ctor_set(v___x_32_, 1, v_a_27_);
lean_ctor_set(v___x_32_, 0, v___x_34_);
v___x_36_ = v___x_32_;
goto v_reusejp_35_;
}
else
{
lean_object* v_reuseFailAlloc_38_; 
v_reuseFailAlloc_38_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v_reuseFailAlloc_38_, 0, v___x_34_);
lean_ctor_set(v_reuseFailAlloc_38_, 1, v_a_27_);
v___x_36_ = v_reuseFailAlloc_38_;
goto v_reusejp_35_;
}
v_reusejp_35_:
{
v_a_26_ = v_tail_30_;
v_a_27_ = v___x_36_;
goto _start;
}
}
}
}
}
LEAN_EXPORT lean_object* l___private_Init_Data_List_Impl_0__List_flatMapTR_go___at___00SFT_Physics_FoldReturnCarrier_carrier_spec__1(lean_object* v_denominator_40_, lean_object* v_a_41_, lean_object* v_a_42_){
_start:
{
if (lean_obj_tag(v_a_41_) == 0)
{
lean_object* v___x_43_; 
v___x_43_ = lean_array_to_list(v_a_42_);
return v___x_43_;
}
else
{
lean_object* v_head_44_; lean_object* v_tail_45_; lean_object* v___x_46_; lean_object* v___x_47_; lean_object* v___x_48_; lean_object* v___x_49_; 
v_head_44_ = lean_ctor_get(v_a_41_, 0);
lean_inc(v_head_44_);
v_tail_45_ = lean_ctor_get(v_a_41_, 1);
lean_inc(v_tail_45_);
lean_dec_ref_known(v_a_41_, 2);
v___x_46_ = l_SFT_Physics_FoldReturnCarrier_through(v_denominator_40_);
v___x_47_ = lean_box(0);
v___x_48_ = l_List_mapTR_loop___at___00SFT_Physics_FoldReturnCarrier_carrier_spec__0(v_head_44_, v___x_46_, v___x_47_);
v___x_49_ = l_List_foldl___at___00Array_appendList_spec__0___redArg(v_a_42_, v___x_48_);
v_a_41_ = v_tail_45_;
v_a_42_ = v___x_49_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* l___private_Init_Data_List_Impl_0__List_flatMapTR_go___at___00SFT_Physics_FoldReturnCarrier_carrier_spec__1___boxed(lean_object* v_denominator_51_, lean_object* v_a_52_, lean_object* v_a_53_){
_start:
{
lean_object* v_res_54_; 
v_res_54_ = l___private_Init_Data_List_Impl_0__List_flatMapTR_go___at___00SFT_Physics_FoldReturnCarrier_carrier_spec__1(v_denominator_51_, v_a_52_, v_a_53_);
lean_dec(v_denominator_51_);
return v_res_54_;
}
}
LEAN_EXPORT lean_object* l_SFT_Physics_FoldReturnCarrier_carrier(lean_object* v_denominator_57_){
_start:
{
lean_object* v___x_58_; lean_object* v___x_59_; lean_object* v___x_60_; 
v___x_58_ = l_SFT_Physics_FoldReturnCarrier_through(v_denominator_57_);
v___x_59_ = ((lean_object*)(l_SFT_Physics_FoldReturnCarrier_carrier___closed__0));
v___x_60_ = l___private_Init_Data_List_Impl_0__List_flatMapTR_go___at___00SFT_Physics_FoldReturnCarrier_carrier_spec__1(v_denominator_57_, v___x_58_, v___x_59_);
return v___x_60_;
}
}
LEAN_EXPORT lean_object* l_SFT_Physics_FoldReturnCarrier_carrier___boxed(lean_object* v_denominator_61_){
_start:
{
lean_object* v_res_62_; 
v_res_62_ = l_SFT_Physics_FoldReturnCarrier_carrier(v_denominator_61_);
lean_dec(v_denominator_61_);
return v_res_62_;
}
}
LEAN_EXPORT lean_object* l_SFT_Physics_FoldReturnCarrier_remove(lean_object* v_gone_63_, lean_object* v_x_64_){
_start:
{
if (lean_obj_tag(v_x_64_) == 0)
{
lean_dec_ref(v_gone_63_);
return v_x_64_;
}
else
{
lean_object* v_head_65_; lean_object* v_tail_66_; lean_object* v___x_68_; uint8_t v_isShared_69_; uint8_t v_isSharedCheck_77_; 
v_head_65_ = lean_ctor_get(v_x_64_, 0);
v_tail_66_ = lean_ctor_get(v_x_64_, 1);
v_isSharedCheck_77_ = !lean_is_exclusive(v_x_64_);
if (v_isSharedCheck_77_ == 0)
{
v___x_68_ = v_x_64_;
v_isShared_69_ = v_isSharedCheck_77_;
goto v_resetjp_67_;
}
else
{
lean_inc(v_tail_66_);
lean_inc(v_head_65_);
lean_dec(v_x_64_);
v___x_68_ = lean_box(0);
v_isShared_69_ = v_isSharedCheck_77_;
goto v_resetjp_67_;
}
v_resetjp_67_:
{
lean_object* v___x_70_; uint8_t v___x_71_; 
v___x_70_ = lean_alloc_closure((void*)(l_instDecidableEqNat___boxed), 2, 0);
lean_inc_ref(v_gone_63_);
lean_inc(v_head_65_);
lean_inc_ref(v___x_70_);
v___x_71_ = l_instDecidableEqProd___redArg(v___x_70_, v___x_70_, v_head_65_, v_gone_63_);
if (v___x_71_ == 0)
{
lean_object* v___x_72_; lean_object* v___x_74_; 
v___x_72_ = l_SFT_Physics_FoldReturnCarrier_remove(v_gone_63_, v_tail_66_);
if (v_isShared_69_ == 0)
{
lean_ctor_set(v___x_68_, 1, v___x_72_);
v___x_74_ = v___x_68_;
goto v_reusejp_73_;
}
else
{
lean_object* v_reuseFailAlloc_75_; 
v_reuseFailAlloc_75_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v_reuseFailAlloc_75_, 0, v_head_65_);
lean_ctor_set(v_reuseFailAlloc_75_, 1, v___x_72_);
v___x_74_ = v_reuseFailAlloc_75_;
goto v_reusejp_73_;
}
v_reusejp_73_:
{
return v___x_74_;
}
}
else
{
lean_del_object(v___x_68_);
lean_dec(v_head_65_);
v_x_64_ = v_tail_66_;
goto _start;
}
}
}
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_sft__v4_SFT_Physics_GeneratorThreeDerivation(uint8_t builtin);
lean_object* initialize_sft__v4_SFT_Mathematics_DiscreteObjects(uint8_t builtin);
lean_object* initialize_SFT_Foundation_CommonRefinement(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_SFT_Physics_FoldReturnCarrier(uint8_t builtin) {
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
res = initialize_sft__v4_SFT_Physics_GeneratorThreeDerivation(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_sft__v4_SFT_Mathematics_DiscreteObjects(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_SFT_Foundation_CommonRefinement(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
