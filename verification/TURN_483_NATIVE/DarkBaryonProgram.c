// Lean compiler output
// Module: DarkBaryonProgram
// Imports: public import Init public meta import Init public import SFT.Physics.DarkBaryonEvidence
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
lean_object* l_SFT_Physics_DarkBaryonEvidence_generatedCandidateData(lean_object*);
lean_object* l_SFT_Physics_DarkBaryonEvidence_decideCandidate(lean_object*);
lean_object* l_List_appendTR___redArg(lean_object*, lean_object*);
lean_object* l_SFT_Physics_DarkBaryonEvidence_registration(lean_object*);
extern lean_object* l_SFT_Physics_DarkBaryonEvidence_census;
lean_object* lp_sft__v4_List_mapTR_loop___at___00SFT_Physics_GeneratorThreeEvidence_closureData_spec__0(lean_object*, lean_object*);
lean_object* l_SFT_Physics_DarkBaryonEvidence_closure(lean_object*);
lean_object* l_SFT_Physics_DarkBaryonControls_runControls(lean_object*);
lean_object* l_SFT_Host_Canonical_render(lean_object*);
lean_object* lean_string_push(lean_object*, uint32_t);
lean_object* lean_get_stdout();
lean_object* lean_string_utf8_byte_size(lean_object*);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
extern lean_object* l_SFT_Physics_DarkBaryonGrammar_candidates;
LEAN_EXPORT lean_object* l_List_forIn_x27_loop___at___00main_spec__0___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_List_forIn_x27_loop___at___00main_spec__0___redArg___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__1_spec__1(lean_object*);
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__1_spec__1___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__1(lean_object*);
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__1___boxed(lean_object*, lean_object*);
static const lean_string_object l_main___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 13, .m_capacity = 13, .m_length = 12, .m_data = "registration"};
static const lean_object* l_main___closed__0 = (const lean_object*)&l_main___closed__0_value;
static const lean_string_object l_main___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 7, .m_capacity = 7, .m_length = 6, .m_data = "census"};
static const lean_object* l_main___closed__1 = (const lean_object*)&l_main___closed__1_value;
static lean_once_cell_t l_main___closed__2_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_main___closed__2;
static const lean_string_object l_main___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 10, .m_capacity = 10, .m_length = 9, .m_data = "decisions"};
static const lean_object* l_main___closed__3 = (const lean_object*)&l_main___closed__3_value;
static const lean_string_object l_main___closed__4_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 8, .m_capacity = 8, .m_length = 7, .m_data = "closure"};
static const lean_object* l_main___closed__4 = (const lean_object*)&l_main___closed__4_value;
static const lean_string_object l_main___closed__5_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 9, .m_capacity = 9, .m_length = 8, .m_data = "controls"};
static const lean_object* l_main___closed__5 = (const lean_object*)&l_main___closed__5_value;
static const lean_string_object l_main___closed__6_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 11, .m_capacity = 11, .m_length = 10, .m_data = "unknown_id"};
static const lean_object* l_main___closed__6 = (const lean_object*)&l_main___closed__6_value;
static const lean_string_object l_main___closed__7_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 13, .m_capacity = 13, .m_length = 12, .m_data = "unregistered"};
static const lean_object* l_main___closed__7 = (const lean_object*)&l_main___closed__7_value;
static const lean_string_object l_main___closed__8_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 8, .m_capacity = 8, .m_length = 7, .m_data = "ignored"};
static const lean_object* l_main___closed__8 = (const lean_object*)&l_main___closed__8_value;
static const lean_ctor_object l_main___closed__9_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*3 + 0, .m_other = 3, .m_tag = 0}, .m_objs = {((lean_object*)&l_main___closed__7_value),((lean_object*)&l_main___closed__8_value),((lean_object*)&l_main___closed__8_value)}};
static const lean_object* l_main___closed__9 = (const lean_object*)&l_main___closed__9_value;
static lean_once_cell_t l_main___closed__10_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* l_main___closed__10;
static const lean_string_object l_main___closed__11_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 21, .m_capacity = 21, .m_length = 20, .m_data = "incorrectly accepted"};
static const lean_object* l_main___closed__11 = (const lean_object*)&l_main___closed__11_value;
static const lean_string_object l_main___closed__12_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 37, .m_capacity = 37, .m_length = 36, .m_data = "Pass the pinned source manifest hash"};
static const lean_object* l_main___closed__12 = (const lean_object*)&l_main___closed__12_value;
static const lean_ctor_object l_main___closed__13_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 18}, .m_objs = {((lean_object*)&l_main___closed__12_value)}};
static const lean_object* l_main___closed__13 = (const lean_object*)&l_main___closed__13_value;
static const lean_string_object l_main___closed__14_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 1, .m_capacity = 1, .m_length = 0, .m_data = ""};
static const lean_object* l_main___closed__14 = (const lean_object*)&l_main___closed__14_value;
LEAN_EXPORT lean_object* _lean_main(lean_object*);
LEAN_EXPORT lean_object* l_main___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_List_forIn_x27_loop___at___00main_spec__0(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_List_forIn_x27_loop___at___00main_spec__0___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_List_forIn_x27_loop___at___00main_spec__0___redArg(lean_object* v_as_x27_1_, lean_object* v_b_2_){
_start:
{
if (lean_obj_tag(v_as_x27_1_) == 0)
{
lean_object* v___x_4_; 
v___x_4_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v___x_4_, 0, v_b_2_);
return v___x_4_;
}
else
{
lean_object* v_head_5_; lean_object* v_tail_6_; lean_object* v___x_7_; lean_object* v___x_8_; 
v_head_5_ = lean_ctor_get(v_as_x27_1_, 0);
v_tail_6_ = lean_ctor_get(v_as_x27_1_, 1);
v___x_7_ = l_SFT_Physics_DarkBaryonEvidence_generatedCandidateData(v_head_5_);
v___x_8_ = l_SFT_Physics_DarkBaryonEvidence_decideCandidate(v___x_7_);
lean_dec_ref(v___x_7_);
if (lean_obj_tag(v___x_8_) == 0)
{
lean_object* v_a_9_; lean_object* v___x_11_; uint8_t v_isShared_12_; uint8_t v_isSharedCheck_17_; 
lean_dec(v_b_2_);
v_a_9_ = lean_ctor_get(v___x_8_, 0);
v_isSharedCheck_17_ = !lean_is_exclusive(v___x_8_);
if (v_isSharedCheck_17_ == 0)
{
v___x_11_ = v___x_8_;
v_isShared_12_ = v_isSharedCheck_17_;
goto v_resetjp_10_;
}
else
{
lean_inc(v_a_9_);
lean_dec(v___x_8_);
v___x_11_ = lean_box(0);
v_isShared_12_ = v_isSharedCheck_17_;
goto v_resetjp_10_;
}
v_resetjp_10_:
{
lean_object* v___x_14_; 
if (v_isShared_12_ == 0)
{
lean_ctor_set_tag(v___x_11_, 18);
v___x_14_ = v___x_11_;
goto v_reusejp_13_;
}
else
{
lean_object* v_reuseFailAlloc_16_; 
v_reuseFailAlloc_16_ = lean_alloc_ctor(18, 1, 0);
lean_ctor_set(v_reuseFailAlloc_16_, 0, v_a_9_);
v___x_14_ = v_reuseFailAlloc_16_;
goto v_reusejp_13_;
}
v_reusejp_13_:
{
lean_object* v___x_15_; 
v___x_15_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v___x_15_, 0, v___x_14_);
return v___x_15_;
}
}
}
else
{
lean_object* v_a_18_; lean_object* v_decisions_19_; lean_object* v___x_20_; lean_object* v___x_21_; 
v_a_18_ = lean_ctor_get(v___x_8_, 0);
lean_inc(v_a_18_);
lean_dec_ref_known(v___x_8_, 1);
v_decisions_19_ = lean_box(0);
v___x_20_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_20_, 0, v_a_18_);
lean_ctor_set(v___x_20_, 1, v_decisions_19_);
v___x_21_ = l_List_appendTR___redArg(v_b_2_, v___x_20_);
v_as_x27_1_ = v_tail_6_;
v_b_2_ = v___x_21_;
goto _start;
}
}
}
}
LEAN_EXPORT lean_object* l_List_forIn_x27_loop___at___00main_spec__0___redArg___boxed(lean_object* v_as_x27_23_, lean_object* v_b_24_, lean_object* v___y_25_){
_start:
{
lean_object* v_res_26_; 
v_res_26_ = l_List_forIn_x27_loop___at___00main_spec__0___redArg(v_as_x27_23_, v_b_24_);
lean_dec(v_as_x27_23_);
return v_res_26_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__1_spec__1(lean_object* v_s_27_){
_start:
{
lean_object* v___x_29_; lean_object* v_putStr_30_; lean_object* v___x_31_; 
v___x_29_ = lean_get_stdout();
v_putStr_30_ = lean_ctor_get(v___x_29_, 4);
lean_inc_ref(v_putStr_30_);
lean_dec_ref(v___x_29_);
v___x_31_ = lean_apply_2(v_putStr_30_, v_s_27_, lean_box(0));
return v___x_31_;
}
}
LEAN_EXPORT lean_object* l_IO_print___at___00IO_println___at___00main_spec__1_spec__1___boxed(lean_object* v_s_32_, lean_object* v_a_33_){
_start:
{
lean_object* v_res_34_; 
v_res_34_ = l_IO_print___at___00IO_println___at___00main_spec__1_spec__1(v_s_32_);
return v_res_34_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__1(lean_object* v_s_35_){
_start:
{
uint32_t v___x_37_; lean_object* v___x_38_; lean_object* v___x_39_; 
v___x_37_ = 10;
v___x_38_ = lean_string_push(v_s_35_, v___x_37_);
v___x_39_ = l_IO_print___at___00IO_println___at___00main_spec__1_spec__1(v___x_38_);
return v___x_39_;
}
}
LEAN_EXPORT lean_object* l_IO_println___at___00main_spec__1___boxed(lean_object* v_s_40_, lean_object* v_a_41_){
_start:
{
lean_object* v_res_42_; 
v_res_42_ = l_IO_println___at___00main_spec__1(v_s_40_);
return v_res_42_;
}
}
static lean_object* _init_l_main___closed__2(void){
_start:
{
lean_object* v___x_45_; lean_object* v___x_46_; lean_object* v___x_47_; 
v___x_45_ = l_SFT_Physics_DarkBaryonEvidence_census;
v___x_46_ = ((lean_object*)(l_main___closed__1));
v___x_47_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_47_, 0, v___x_46_);
lean_ctor_set(v___x_47_, 1, v___x_45_);
return v___x_47_;
}
}
static lean_object* _init_l_main___closed__10(void){
_start:
{
lean_object* v___x_57_; lean_object* v___x_58_; 
v___x_57_ = ((lean_object*)(l_main___closed__9));
v___x_58_ = l_SFT_Physics_DarkBaryonEvidence_decideCandidate(v___x_57_);
return v___x_58_;
}
}
LEAN_EXPORT lean_object* _lean_main(lean_object* v_args_64_){
_start:
{
lean_object* v___y_67_; lean_object* v___y_68_; lean_object* v___y_69_; lean_object* v___y_98_; 
if (lean_obj_tag(v_args_64_) == 0)
{
lean_object* v___x_119_; 
v___x_119_ = ((lean_object*)(l_main___closed__14));
v___y_98_ = v___x_119_;
goto v___jp_97_;
}
else
{
lean_object* v_head_120_; 
v_head_120_ = lean_ctor_get(v_args_64_, 0);
lean_inc(v_head_120_);
lean_dec_ref_known(v_args_64_, 2);
v___y_98_ = v_head_120_;
goto v___jp_97_;
}
v___jp_66_:
{
lean_object* v___x_70_; lean_object* v___x_71_; lean_object* v___x_72_; lean_object* v___x_73_; lean_object* v___x_74_; lean_object* v___x_75_; lean_object* v___x_76_; lean_object* v___x_77_; lean_object* v___x_78_; lean_object* v___x_79_; lean_object* v___x_80_; lean_object* v___x_81_; lean_object* v___x_82_; lean_object* v___x_83_; lean_object* v___x_84_; lean_object* v___x_85_; lean_object* v___x_86_; lean_object* v___x_87_; lean_object* v___x_88_; lean_object* v___x_89_; lean_object* v___x_90_; lean_object* v___x_91_; lean_object* v___x_92_; lean_object* v___x_93_; lean_object* v___x_94_; lean_object* v___x_95_; lean_object* v___x_96_; 
v___x_70_ = ((lean_object*)(l_main___closed__0));
lean_inc_ref(v___y_68_);
v___x_71_ = l_SFT_Physics_DarkBaryonEvidence_registration(v___y_68_);
v___x_72_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_72_, 0, v___x_70_);
lean_ctor_set(v___x_72_, 1, v___x_71_);
v___x_73_ = lean_obj_once(&l_main___closed__2, &l_main___closed__2_once, _init_l_main___closed__2);
v___x_74_ = ((lean_object*)(l_main___closed__3));
v___x_75_ = lean_box(0);
lean_inc(v___y_67_);
v___x_76_ = lp_sft__v4_List_mapTR_loop___at___00SFT_Physics_GeneratorThreeEvidence_closureData_spec__0(v___y_67_, v___x_75_);
v___x_77_ = lean_alloc_ctor(4, 1, 0);
lean_ctor_set(v___x_77_, 0, v___x_76_);
v___x_78_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_78_, 0, v___x_74_);
lean_ctor_set(v___x_78_, 1, v___x_77_);
v___x_79_ = ((lean_object*)(l_main___closed__4));
v___x_80_ = l_SFT_Physics_DarkBaryonEvidence_closure(v___y_67_);
v___x_81_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_81_, 0, v___x_79_);
lean_ctor_set(v___x_81_, 1, v___x_80_);
v___x_82_ = ((lean_object*)(l_main___closed__5));
v___x_83_ = l_SFT_Physics_DarkBaryonControls_runControls(v___y_68_);
v___x_84_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_84_, 0, v___x_82_);
lean_ctor_set(v___x_84_, 1, v___x_83_);
v___x_85_ = ((lean_object*)(l_main___closed__6));
lean_inc_ref(v___y_69_);
v___x_86_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v___x_86_, 0, v___y_69_);
v___x_87_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_87_, 0, v___x_85_);
lean_ctor_set(v___x_87_, 1, v___x_86_);
v___x_88_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_88_, 0, v___x_87_);
lean_ctor_set(v___x_88_, 1, v___x_75_);
v___x_89_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_89_, 0, v___x_84_);
lean_ctor_set(v___x_89_, 1, v___x_88_);
v___x_90_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_90_, 0, v___x_81_);
lean_ctor_set(v___x_90_, 1, v___x_89_);
v___x_91_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_91_, 0, v___x_78_);
lean_ctor_set(v___x_91_, 1, v___x_90_);
v___x_92_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_92_, 0, v___x_73_);
lean_ctor_set(v___x_92_, 1, v___x_91_);
v___x_93_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_93_, 0, v___x_72_);
lean_ctor_set(v___x_93_, 1, v___x_92_);
v___x_94_ = lean_alloc_ctor(5, 1, 0);
lean_ctor_set(v___x_94_, 0, v___x_93_);
v___x_95_ = l_SFT_Host_Canonical_render(v___x_94_);
v___x_96_ = l_IO_println___at___00main_spec__1(v___x_95_);
return v___x_96_;
}
v___jp_97_:
{
lean_object* v___x_99_; lean_object* v___x_100_; uint8_t v___x_101_; 
v___x_99_ = lean_string_utf8_byte_size(v___y_98_);
v___x_100_ = lean_unsigned_to_nat(0u);
v___x_101_ = lean_nat_dec_eq(v___x_99_, v___x_100_);
if (v___x_101_ == 0)
{
lean_object* v_decisions_102_; lean_object* v___x_103_; lean_object* v___x_104_; 
v_decisions_102_ = lean_box(0);
v___x_103_ = l_SFT_Physics_DarkBaryonGrammar_candidates;
v___x_104_ = l_List_forIn_x27_loop___at___00main_spec__0___redArg(v___x_103_, v_decisions_102_);
if (lean_obj_tag(v___x_104_) == 0)
{
lean_object* v_a_105_; lean_object* v___x_106_; 
v_a_105_ = lean_ctor_get(v___x_104_, 0);
lean_inc(v_a_105_);
lean_dec_ref_known(v___x_104_, 1);
v___x_106_ = lean_obj_once(&l_main___closed__10, &l_main___closed__10_once, _init_l_main___closed__10);
if (lean_obj_tag(v___x_106_) == 0)
{
lean_object* v_a_107_; 
v_a_107_ = lean_ctor_get(v___x_106_, 0);
v___y_67_ = v_a_105_;
v___y_68_ = v___y_98_;
v___y_69_ = v_a_107_;
goto v___jp_66_;
}
else
{
lean_object* v___x_108_; 
v___x_108_ = ((lean_object*)(l_main___closed__11));
v___y_67_ = v_a_105_;
v___y_68_ = v___y_98_;
v___y_69_ = v___x_108_;
goto v___jp_66_;
}
}
else
{
lean_object* v_a_109_; lean_object* v___x_111_; uint8_t v_isShared_112_; uint8_t v_isSharedCheck_116_; 
lean_dec_ref(v___y_98_);
v_a_109_ = lean_ctor_get(v___x_104_, 0);
v_isSharedCheck_116_ = !lean_is_exclusive(v___x_104_);
if (v_isSharedCheck_116_ == 0)
{
v___x_111_ = v___x_104_;
v_isShared_112_ = v_isSharedCheck_116_;
goto v_resetjp_110_;
}
else
{
lean_inc(v_a_109_);
lean_dec(v___x_104_);
v___x_111_ = lean_box(0);
v_isShared_112_ = v_isSharedCheck_116_;
goto v_resetjp_110_;
}
v_resetjp_110_:
{
lean_object* v___x_114_; 
if (v_isShared_112_ == 0)
{
v___x_114_ = v___x_111_;
goto v_reusejp_113_;
}
else
{
lean_object* v_reuseFailAlloc_115_; 
v_reuseFailAlloc_115_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v_reuseFailAlloc_115_, 0, v_a_109_);
v___x_114_ = v_reuseFailAlloc_115_;
goto v_reusejp_113_;
}
v_reusejp_113_:
{
return v___x_114_;
}
}
}
}
else
{
lean_object* v___x_117_; lean_object* v___x_118_; 
lean_dec_ref(v___y_98_);
v___x_117_ = ((lean_object*)(l_main___closed__13));
v___x_118_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v___x_118_, 0, v___x_117_);
return v___x_118_;
}
}
}
}
LEAN_EXPORT lean_object* l_main___boxed(lean_object* v_args_121_, lean_object* v_a_122_){
_start:
{
lean_object* v_res_123_; 
v_res_123_ = _lean_main(v_args_121_);
return v_res_123_;
}
}
LEAN_EXPORT lean_object* l_List_forIn_x27_loop___at___00main_spec__0(lean_object* v_as_124_, lean_object* v_as_x27_125_, lean_object* v_b_126_, lean_object* v_a_127_){
_start:
{
lean_object* v___x_129_; 
v___x_129_ = l_List_forIn_x27_loop___at___00main_spec__0___redArg(v_as_x27_125_, v_b_126_);
return v___x_129_;
}
}
LEAN_EXPORT lean_object* l_List_forIn_x27_loop___at___00main_spec__0___boxed(lean_object* v_as_130_, lean_object* v_as_x27_131_, lean_object* v_b_132_, lean_object* v_a_133_, lean_object* v___y_134_){
_start:
{
lean_object* v_res_135_; 
v_res_135_ = l_List_forIn_x27_loop___at___00main_spec__0(v_as_130_, v_as_x27_131_, v_b_132_, v_a_133_);
lean_dec(v_as_x27_131_);
lean_dec(v_as_130_);
return v_res_135_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_SFT_Physics_FoldFirstReturn(uint8_t builtin);
lean_object* initialize_SFT_Physics_DarkBaryonEvidence(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_DarkBaryonProgram(uint8_t builtin) {
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
res = initialize_SFT_Physics_FoldFirstReturn(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_SFT_Physics_DarkBaryonEvidence(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
char ** lean_setup_args(int argc, char ** argv);
#if defined(WIN32) || defined(_WIN32)
#include <windows.h>
#endif
lean_object* run_main(int argc, char ** argv) {
    lean_object* in = lean_box(0);
    int i = argc;
    while (i > 1) {
      lean_object* n;
      i--;
      n = lean_alloc_ctor(1,2,0); lean_ctor_set(n, 0, lean_mk_string(argv[i])); lean_ctor_set(n, 1, in);
      in = n;
    }
    return _lean_main(in);
}
int main(int argc, char ** argv) {
#if defined(WIN32) || defined(_WIN32)
  SetErrorMode(SEM_FAILCRITICALERRORS);
  SetConsoleOutputCP(CP_UTF8);
#endif
  lean_object* res;
  argv = lean_setup_args(argc, argv);
  res = initialize_DarkBaryonProgram(1 /* builtin */);
  lean_io_mark_end_initialization();
  if (lean_io_result_is_ok(res)) {
    lean_dec_ref(res);
    lean_init_task_manager();
    res = lean_run_main(&run_main, argc, argv);
  }
  lean_finalize_task_manager();
  if (lean_io_result_is_ok(res)) {
    int ret = 0;
    lean_dec_ref(res);
    return ret;
  } else {
    lean_io_result_show_error(res);
    lean_dec_ref(res);
    return 1;
  }
}
#ifdef __cplusplus
}
#endif
