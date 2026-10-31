// Lean compiler output
// Module: SFT.Host.Text
// Imports: public import Init public meta import Init
#include <lean/lean.h>
lean_object* l_SFT_Host_StackDecode_decode(lean_object*,lean_object*);
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
lean_object* lean_string_to_utf8(lean_object*);
lean_object* lean_byte_array_data(lean_object*);
lean_object* lean_array_to_list(lean_object*);
lean_object* l_List_reverse___redArg(lean_object*);
lean_object* lean_uint8_to_nat(uint8_t);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
uint8_t lean_nat_dec_lt(lean_object*, lean_object*);
lean_object* lean_nat_mul(lean_object*, lean_object*);
lean_object* lean_nat_add(lean_object*, lean_object*);
uint32_t l_Char_ofNat(lean_object*);
lean_object* l_List_drop___redArg(lean_object*, lean_object*);
lean_object* lean_byte_array_size(lean_object*);
lean_object* lean_uint32_to_nat(uint32_t);
uint8_t lean_nat_dec_le(lean_object*, lean_object*);
lean_object* lean_string_mk(lean_object*);
lean_object* lean_mk_empty_array_with_capacity(lean_object*);
lean_object* l_List_foldl___at___00Array_appendList_spec__0___redArg(lean_object*, lean_object*);
uint8_t l_List_isEmpty___redArg(lean_object*);
lean_object* l_List_appendTR___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_decode(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_decode___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_chars(lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_chars___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_append(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_append___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4___private_Init_Data_List_Impl_0__List_flatMapTR_go___at___00SFT_Host_Text_join_spec__0(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4___private_Init_Data_List_Impl_0__List_flatMapTR_go___at___00SFT_Host_Text_join_spec__0___boxed(lean_object*, lean_object*);
static const lean_array_object lp_sft__v4_SFT_Host_Text_join___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_array_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 246}, .m_size = 0, .m_capacity = 0, .m_data = {}};
static const lean_object* lp_sft__v4_SFT_Host_Text_join___closed__0 = (const lean_object*)&lp_sft__v4_SFT_Host_Text_join___closed__0_value;
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_join(lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_join___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4___private_Init_Data_List_Impl_0__List_flatMapTR_go___at___00SFT_Host_Text_intercalate_spec__0(lean_object*, lean_object*, lean_object*);
static const lean_string_object lp_sft__v4_SFT_Host_Text_intercalate___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 1, .m_capacity = 1, .m_length = 0, .m_data = ""};
static const lean_object* lp_sft__v4_SFT_Host_Text_intercalate___closed__0 = (const lean_object*)&lp_sft__v4_SFT_Host_Text_intercalate___closed__0_value;
static const lean_array_object lp_sft__v4_SFT_Host_Text_intercalate___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_array_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 246}, .m_size = 0, .m_capacity = 0, .m_data = {}};
static const lean_object* lp_sft__v4_SFT_Host_Text_intercalate___closed__1 = (const lean_object*)&lp_sft__v4_SFT_Host_Text_intercalate___closed__1_value;
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_intercalate(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_sft__v4_List_beq___at___00SFT_Host_Text_equal_spec__1(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_List_beq___at___00SFT_Host_Text_equal_spec__1___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_List_mapTR_loop___at___00SFT_Host_Text_equal_spec__0(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_sft__v4_SFT_Host_Text_equal(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_equal___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_sft__v4_SFT_Host_Text_lexLE(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_lexLE___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_sft__v4_SFT_Host_Text_le(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_le___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_List_mapTR_loop___at___00SFT_Host_Text_lowerAscii_spec__0(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_lowerAscii(lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_lowerAscii___boxed(lean_object*);
LEAN_EXPORT uint8_t lp_sft__v4_SFT_Host_Text_isPrefix(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_isPrefix___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_sft__v4_SFT_Host_Text_containsBytes(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_containsBytes___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_sft__v4_SFT_Host_Text_contains(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_contains___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_decode(lean_object* v_x_1_, lean_object* v_a_2_){ return l_SFT_Host_StackDecode_decode(v_x_1_,v_a_2_); }
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_decode___boxed(lean_object* v_x_100_, lean_object* v_a_101_){
_start:
{
lean_object* v_res_102_; 
v_res_102_ = lp_sft__v4_SFT_Host_Text_decode(v_x_100_, v_a_101_);
lean_dec(v_x_100_);
return v_res_102_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_chars(lean_object* v_s_103_){
_start:
{
lean_object* v___x_104_; lean_object* v___x_105_; lean_object* v___x_106_; lean_object* v___x_107_; lean_object* v___x_108_; 
v___x_104_ = lean_string_to_utf8(v_s_103_);
v___x_105_ = lean_byte_array_size(v___x_104_);
v___x_106_ = lean_byte_array_data(v___x_104_);
v___x_107_ = lean_array_to_list(v___x_106_);
v___x_108_ = lp_sft__v4_SFT_Host_Text_decode(v___x_105_, v___x_107_);
return v___x_108_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_chars___boxed(lean_object* v_s_109_){
_start:
{
lean_object* v_res_110_; 
v_res_110_ = lp_sft__v4_SFT_Host_Text_chars(v_s_109_);
lean_dec_ref(v_s_109_);
return v_res_110_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_append(lean_object* v_a_111_, lean_object* v_b_112_){
_start:
{
lean_object* v___x_113_; lean_object* v___x_114_; lean_object* v___x_115_; lean_object* v___x_116_; 
v___x_113_ = lp_sft__v4_SFT_Host_Text_chars(v_a_111_);
v___x_114_ = lp_sft__v4_SFT_Host_Text_chars(v_b_112_);
v___x_115_ = l_List_appendTR___redArg(v___x_113_, v___x_114_);
v___x_116_ = lean_string_mk(v___x_115_);
return v___x_116_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_append___boxed(lean_object* v_a_117_, lean_object* v_b_118_){
_start:
{
lean_object* v_res_119_; 
v_res_119_ = lp_sft__v4_SFT_Host_Text_append(v_a_117_, v_b_118_);
lean_dec_ref(v_b_118_);
lean_dec_ref(v_a_117_);
return v_res_119_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4___private_Init_Data_List_Impl_0__List_flatMapTR_go___at___00SFT_Host_Text_join_spec__0(lean_object* v_a_120_, lean_object* v_a_121_){
_start:
{
if (lean_obj_tag(v_a_120_) == 0)
{
lean_object* v___x_122_; 
v___x_122_ = lean_array_to_list(v_a_121_);
return v___x_122_;
}
else
{
lean_object* v_head_123_; lean_object* v_tail_124_; lean_object* v___x_125_; lean_object* v___x_126_; 
v_head_123_ = lean_ctor_get(v_a_120_, 0);
v_tail_124_ = lean_ctor_get(v_a_120_, 1);
v___x_125_ = lp_sft__v4_SFT_Host_Text_chars(v_head_123_);
v___x_126_ = l_List_foldl___at___00Array_appendList_spec__0___redArg(v_a_121_, v___x_125_);
v_a_120_ = v_tail_124_;
v_a_121_ = v___x_126_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* lp_sft__v4___private_Init_Data_List_Impl_0__List_flatMapTR_go___at___00SFT_Host_Text_join_spec__0___boxed(lean_object* v_a_128_, lean_object* v_a_129_){
_start:
{
lean_object* v_res_130_; 
v_res_130_ = lp_sft__v4___private_Init_Data_List_Impl_0__List_flatMapTR_go___at___00SFT_Host_Text_join_spec__0(v_a_128_, v_a_129_);
lean_dec(v_a_128_);
return v_res_130_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_join(lean_object* v_xs_133_){
_start:
{
lean_object* v___x_134_; lean_object* v___x_135_; lean_object* v___x_136_; 
v___x_134_ = ((lean_object*)(lp_sft__v4_SFT_Host_Text_join___closed__0));
v___x_135_ = lp_sft__v4___private_Init_Data_List_Impl_0__List_flatMapTR_go___at___00SFT_Host_Text_join_spec__0(v_xs_133_, v___x_134_);
v___x_136_ = lean_string_mk(v___x_135_);
return v___x_136_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_join___boxed(lean_object* v_xs_137_){
_start:
{
lean_object* v_res_138_; 
v_res_138_ = lp_sft__v4_SFT_Host_Text_join(v_xs_137_);
lean_dec(v_xs_137_);
return v_res_138_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4___private_Init_Data_List_Impl_0__List_flatMapTR_go___at___00SFT_Host_Text_intercalate_spec__0(lean_object* v_sep_139_, lean_object* v_a_140_, lean_object* v_a_141_){
_start:
{
if (lean_obj_tag(v_a_140_) == 0)
{
lean_object* v___x_142_; 
lean_dec_ref(v_sep_139_);
v___x_142_ = lean_array_to_list(v_a_141_);
return v___x_142_;
}
else
{
lean_object* v_head_143_; lean_object* v_tail_144_; lean_object* v___x_146_; uint8_t v_isShared_147_; uint8_t v_isSharedCheck_155_; 
v_head_143_ = lean_ctor_get(v_a_140_, 0);
v_tail_144_ = lean_ctor_get(v_a_140_, 1);
v_isSharedCheck_155_ = !lean_is_exclusive(v_a_140_);
if (v_isSharedCheck_155_ == 0)
{
v___x_146_ = v_a_140_;
v_isShared_147_ = v_isSharedCheck_155_;
goto v_resetjp_145_;
}
else
{
lean_inc(v_tail_144_);
lean_inc(v_head_143_);
lean_dec(v_a_140_);
v___x_146_ = lean_box(0);
v_isShared_147_ = v_isSharedCheck_155_;
goto v_resetjp_145_;
}
v_resetjp_145_:
{
lean_object* v___x_148_; lean_object* v___x_150_; 
v___x_148_ = lean_box(0);
if (v_isShared_147_ == 0)
{
lean_ctor_set(v___x_146_, 1, v___x_148_);
v___x_150_ = v___x_146_;
goto v_reusejp_149_;
}
else
{
lean_object* v_reuseFailAlloc_154_; 
v_reuseFailAlloc_154_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v_reuseFailAlloc_154_, 0, v_head_143_);
lean_ctor_set(v_reuseFailAlloc_154_, 1, v___x_148_);
v___x_150_ = v_reuseFailAlloc_154_;
goto v_reusejp_149_;
}
v_reusejp_149_:
{
lean_object* v___x_151_; lean_object* v___x_152_; 
lean_inc_ref(v_sep_139_);
v___x_151_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_151_, 0, v_sep_139_);
lean_ctor_set(v___x_151_, 1, v___x_150_);
v___x_152_ = l_List_foldl___at___00Array_appendList_spec__0___redArg(v_a_141_, v___x_151_);
v_a_140_ = v_tail_144_;
v_a_141_ = v___x_152_;
goto _start;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_intercalate(lean_object* v_sep_159_, lean_object* v_x_160_){
_start:
{
if (lean_obj_tag(v_x_160_) == 0)
{
lean_object* v___x_161_; 
lean_dec_ref(v_sep_159_);
v___x_161_ = ((lean_object*)(lp_sft__v4_SFT_Host_Text_intercalate___closed__0));
return v___x_161_;
}
else
{
lean_object* v_head_162_; lean_object* v_tail_163_; lean_object* v___x_165_; uint8_t v_isShared_166_; uint8_t v_isSharedCheck_173_; 
v_head_162_ = lean_ctor_get(v_x_160_, 0);
v_tail_163_ = lean_ctor_get(v_x_160_, 1);
v_isSharedCheck_173_ = !lean_is_exclusive(v_x_160_);
if (v_isSharedCheck_173_ == 0)
{
v___x_165_ = v_x_160_;
v_isShared_166_ = v_isSharedCheck_173_;
goto v_resetjp_164_;
}
else
{
lean_inc(v_tail_163_);
lean_inc(v_head_162_);
lean_dec(v_x_160_);
v___x_165_ = lean_box(0);
v_isShared_166_ = v_isSharedCheck_173_;
goto v_resetjp_164_;
}
v_resetjp_164_:
{
lean_object* v___x_167_; lean_object* v___x_168_; lean_object* v___x_170_; 
v___x_167_ = ((lean_object*)(lp_sft__v4_SFT_Host_Text_intercalate___closed__1));
v___x_168_ = lp_sft__v4___private_Init_Data_List_Impl_0__List_flatMapTR_go___at___00SFT_Host_Text_intercalate_spec__0(v_sep_159_, v_tail_163_, v___x_167_);
if (v_isShared_166_ == 0)
{
lean_ctor_set(v___x_165_, 1, v___x_168_);
v___x_170_ = v___x_165_;
goto v_reusejp_169_;
}
else
{
lean_object* v_reuseFailAlloc_172_; 
v_reuseFailAlloc_172_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v_reuseFailAlloc_172_, 0, v_head_162_);
lean_ctor_set(v_reuseFailAlloc_172_, 1, v___x_168_);
v___x_170_ = v_reuseFailAlloc_172_;
goto v_reusejp_169_;
}
v_reusejp_169_:
{
lean_object* v___x_171_; 
v___x_171_ = lp_sft__v4_SFT_Host_Text_join(v___x_170_);
lean_dec_ref(v___x_170_);
return v___x_171_;
}
}
}
}
}
LEAN_EXPORT uint8_t lp_sft__v4_List_beq___at___00SFT_Host_Text_equal_spec__1(lean_object* v_x_174_, lean_object* v_x_175_){
_start:
{
if (lean_obj_tag(v_x_174_) == 0)
{
if (lean_obj_tag(v_x_175_) == 0)
{
uint8_t v___x_176_; 
v___x_176_ = 1;
return v___x_176_;
}
else
{
uint8_t v___x_177_; 
v___x_177_ = 0;
return v___x_177_;
}
}
else
{
if (lean_obj_tag(v_x_175_) == 0)
{
uint8_t v___x_178_; 
v___x_178_ = 0;
return v___x_178_;
}
else
{
lean_object* v_head_179_; lean_object* v_tail_180_; lean_object* v_head_181_; lean_object* v_tail_182_; uint8_t v___x_183_; 
v_head_179_ = lean_ctor_get(v_x_174_, 0);
v_tail_180_ = lean_ctor_get(v_x_174_, 1);
v_head_181_ = lean_ctor_get(v_x_175_, 0);
v_tail_182_ = lean_ctor_get(v_x_175_, 1);
v___x_183_ = lean_nat_dec_eq(v_head_179_, v_head_181_);
if (v___x_183_ == 0)
{
return v___x_183_;
}
else
{
v_x_174_ = v_tail_180_;
v_x_175_ = v_tail_182_;
goto _start;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_sft__v4_List_beq___at___00SFT_Host_Text_equal_spec__1___boxed(lean_object* v_x_185_, lean_object* v_x_186_){
_start:
{
uint8_t v_res_187_; lean_object* v_r_188_; 
v_res_187_ = lp_sft__v4_List_beq___at___00SFT_Host_Text_equal_spec__1(v_x_185_, v_x_186_);
lean_dec(v_x_186_);
lean_dec(v_x_185_);
v_r_188_ = lean_box(v_res_187_);
return v_r_188_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_List_mapTR_loop___at___00SFT_Host_Text_equal_spec__0(lean_object* v_a_189_, lean_object* v_a_190_){
_start:
{
if (lean_obj_tag(v_a_189_) == 0)
{
lean_object* v___x_191_; 
v___x_191_ = l_List_reverse___redArg(v_a_190_);
return v___x_191_;
}
else
{
lean_object* v_head_192_; lean_object* v_tail_193_; lean_object* v___x_195_; uint8_t v_isShared_196_; uint8_t v_isSharedCheck_203_; 
v_head_192_ = lean_ctor_get(v_a_189_, 0);
v_tail_193_ = lean_ctor_get(v_a_189_, 1);
v_isSharedCheck_203_ = !lean_is_exclusive(v_a_189_);
if (v_isSharedCheck_203_ == 0)
{
v___x_195_ = v_a_189_;
v_isShared_196_ = v_isSharedCheck_203_;
goto v_resetjp_194_;
}
else
{
lean_inc(v_tail_193_);
lean_inc(v_head_192_);
lean_dec(v_a_189_);
v___x_195_ = lean_box(0);
v_isShared_196_ = v_isSharedCheck_203_;
goto v_resetjp_194_;
}
v_resetjp_194_:
{
uint8_t v___x_197_; lean_object* v___x_198_; lean_object* v___x_200_; 
v___x_197_ = lean_unbox(v_head_192_);
lean_dec(v_head_192_);
v___x_198_ = lean_uint8_to_nat(v___x_197_);
if (v_isShared_196_ == 0)
{
lean_ctor_set(v___x_195_, 1, v_a_190_);
lean_ctor_set(v___x_195_, 0, v___x_198_);
v___x_200_ = v___x_195_;
goto v_reusejp_199_;
}
else
{
lean_object* v_reuseFailAlloc_202_; 
v_reuseFailAlloc_202_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v_reuseFailAlloc_202_, 0, v___x_198_);
lean_ctor_set(v_reuseFailAlloc_202_, 1, v_a_190_);
v___x_200_ = v_reuseFailAlloc_202_;
goto v_reusejp_199_;
}
v_reusejp_199_:
{
v_a_189_ = v_tail_193_;
v_a_190_ = v___x_200_;
goto _start;
}
}
}
}
}
LEAN_EXPORT uint8_t lp_sft__v4_SFT_Host_Text_equal(lean_object* v_a_204_, lean_object* v_b_205_){
_start:
{
lean_object* v___x_206_; lean_object* v___x_207_; lean_object* v___x_208_; lean_object* v___x_209_; lean_object* v___x_210_; lean_object* v___x_211_; lean_object* v___x_212_; lean_object* v___x_213_; lean_object* v___x_214_; uint8_t v___x_215_; 
v___x_206_ = lean_string_to_utf8(v_a_204_);
v___x_207_ = lean_byte_array_data(v___x_206_);
v___x_208_ = lean_array_to_list(v___x_207_);
v___x_209_ = lean_box(0);
v___x_210_ = lp_sft__v4_List_mapTR_loop___at___00SFT_Host_Text_equal_spec__0(v___x_208_, v___x_209_);
v___x_211_ = lean_string_to_utf8(v_b_205_);
v___x_212_ = lean_byte_array_data(v___x_211_);
v___x_213_ = lean_array_to_list(v___x_212_);
v___x_214_ = lp_sft__v4_List_mapTR_loop___at___00SFT_Host_Text_equal_spec__0(v___x_213_, v___x_209_);
v___x_215_ = lp_sft__v4_List_beq___at___00SFT_Host_Text_equal_spec__1(v___x_210_, v___x_214_);
lean_dec(v___x_214_);
lean_dec(v___x_210_);
return v___x_215_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_equal___boxed(lean_object* v_a_216_, lean_object* v_b_217_){
_start:
{
uint8_t v_res_218_; lean_object* v_r_219_; 
v_res_218_ = lp_sft__v4_SFT_Host_Text_equal(v_a_216_, v_b_217_);
lean_dec_ref(v_b_217_);
lean_dec_ref(v_a_216_);
v_r_219_ = lean_box(v_res_218_);
return v_r_219_;
}
}
LEAN_EXPORT uint8_t lp_sft__v4_SFT_Host_Text_lexLE(lean_object* v_x_220_, lean_object* v_x_221_){
_start:
{
if (lean_obj_tag(v_x_220_) == 0)
{
uint8_t v___x_222_; 
v___x_222_ = 1;
return v___x_222_;
}
else
{
if (lean_obj_tag(v_x_221_) == 0)
{
uint8_t v___x_223_; 
v___x_223_ = 0;
return v___x_223_;
}
else
{
lean_object* v_head_224_; lean_object* v_tail_225_; lean_object* v_head_226_; lean_object* v_tail_227_; uint8_t v___x_228_; lean_object* v___x_229_; uint8_t v___x_230_; lean_object* v___x_231_; uint8_t v___x_232_; 
v_head_224_ = lean_ctor_get(v_x_220_, 0);
v_tail_225_ = lean_ctor_get(v_x_220_, 1);
v_head_226_ = lean_ctor_get(v_x_221_, 0);
v_tail_227_ = lean_ctor_get(v_x_221_, 1);
v___x_228_ = lean_unbox(v_head_224_);
v___x_229_ = lean_uint8_to_nat(v___x_228_);
v___x_230_ = lean_unbox(v_head_226_);
v___x_231_ = lean_uint8_to_nat(v___x_230_);
v___x_232_ = lean_nat_dec_eq(v___x_229_, v___x_231_);
if (v___x_232_ == 0)
{
uint8_t v___x_233_; 
v___x_233_ = lean_nat_dec_lt(v___x_229_, v___x_231_);
return v___x_233_;
}
else
{
v_x_220_ = v_tail_225_;
v_x_221_ = v_tail_227_;
goto _start;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_lexLE___boxed(lean_object* v_x_235_, lean_object* v_x_236_){
_start:
{
uint8_t v_res_237_; lean_object* v_r_238_; 
v_res_237_ = lp_sft__v4_SFT_Host_Text_lexLE(v_x_235_, v_x_236_);
lean_dec(v_x_236_);
lean_dec(v_x_235_);
v_r_238_ = lean_box(v_res_237_);
return v_r_238_;
}
}
LEAN_EXPORT uint8_t lp_sft__v4_SFT_Host_Text_le(lean_object* v_a_239_, lean_object* v_b_240_){
_start:
{
lean_object* v___x_241_; lean_object* v___x_242_; lean_object* v___x_243_; lean_object* v___x_244_; lean_object* v___x_245_; lean_object* v___x_246_; uint8_t v___x_247_; 
v___x_241_ = lean_string_to_utf8(v_a_239_);
v___x_242_ = lean_byte_array_data(v___x_241_);
v___x_243_ = lean_array_to_list(v___x_242_);
v___x_244_ = lean_string_to_utf8(v_b_240_);
v___x_245_ = lean_byte_array_data(v___x_244_);
v___x_246_ = lean_array_to_list(v___x_245_);
v___x_247_ = lp_sft__v4_SFT_Host_Text_lexLE(v___x_243_, v___x_246_);
lean_dec(v___x_246_);
lean_dec(v___x_243_);
return v___x_247_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_le___boxed(lean_object* v_a_248_, lean_object* v_b_249_){
_start:
{
uint8_t v_res_250_; lean_object* v_r_251_; 
v_res_250_ = lp_sft__v4_SFT_Host_Text_le(v_a_248_, v_b_249_);
lean_dec_ref(v_b_249_);
lean_dec_ref(v_a_248_);
v_r_251_ = lean_box(v_res_250_);
return v_r_251_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_List_mapTR_loop___at___00SFT_Host_Text_lowerAscii_spec__0(lean_object* v_a_252_, lean_object* v_a_253_){
_start:
{
if (lean_obj_tag(v_a_252_) == 0)
{
lean_object* v___x_254_; 
v___x_254_ = l_List_reverse___redArg(v_a_253_);
return v___x_254_;
}
else
{
lean_object* v_head_255_; lean_object* v_tail_256_; lean_object* v___x_258_; uint8_t v_isShared_259_; uint8_t v_isSharedCheck_278_; 
v_head_255_ = lean_ctor_get(v_a_252_, 0);
v_tail_256_ = lean_ctor_get(v_a_252_, 1);
v_isSharedCheck_278_ = !lean_is_exclusive(v_a_252_);
if (v_isSharedCheck_278_ == 0)
{
v___x_258_ = v_a_252_;
v_isShared_259_ = v_isSharedCheck_278_;
goto v_resetjp_257_;
}
else
{
lean_inc(v_tail_256_);
lean_inc(v_head_255_);
lean_dec(v_a_252_);
v___x_258_ = lean_box(0);
v_isShared_259_ = v_isSharedCheck_278_;
goto v_resetjp_257_;
}
v_resetjp_257_:
{
uint32_t v___y_261_; lean_object* v___x_267_; uint32_t v___x_268_; lean_object* v___x_269_; uint8_t v___x_270_; 
v___x_267_ = lean_unsigned_to_nat(65u);
v___x_268_ = lean_unbox_uint32(v_head_255_);
v___x_269_ = lean_uint32_to_nat(v___x_268_);
v___x_270_ = lean_nat_dec_le(v___x_267_, v___x_269_);
if (v___x_270_ == 0)
{
uint32_t v___x_271_; 
lean_dec(v___x_269_);
v___x_271_ = lean_unbox_uint32(v_head_255_);
lean_dec(v_head_255_);
v___y_261_ = v___x_271_;
goto v___jp_260_;
}
else
{
lean_object* v___x_272_; uint8_t v___x_273_; 
v___x_272_ = lean_unsigned_to_nat(90u);
v___x_273_ = lean_nat_dec_le(v___x_269_, v___x_272_);
if (v___x_273_ == 0)
{
uint32_t v___x_274_; 
lean_dec(v___x_269_);
v___x_274_ = lean_unbox_uint32(v_head_255_);
lean_dec(v_head_255_);
v___y_261_ = v___x_274_;
goto v___jp_260_;
}
else
{
lean_object* v___x_275_; lean_object* v___x_276_; uint32_t v___x_277_; 
lean_dec(v_head_255_);
v___x_275_ = lean_unsigned_to_nat(32u);
v___x_276_ = lean_nat_add(v___x_269_, v___x_275_);
lean_dec(v___x_269_);
v___x_277_ = l_Char_ofNat(v___x_276_);
lean_dec(v___x_276_);
v___y_261_ = v___x_277_;
goto v___jp_260_;
}
}
v___jp_260_:
{
lean_object* v___x_262_; lean_object* v___x_264_; 
v___x_262_ = lean_box_uint32(v___y_261_);
if (v_isShared_259_ == 0)
{
lean_ctor_set(v___x_258_, 1, v_a_253_);
lean_ctor_set(v___x_258_, 0, v___x_262_);
v___x_264_ = v___x_258_;
goto v_reusejp_263_;
}
else
{
lean_object* v_reuseFailAlloc_266_; 
v_reuseFailAlloc_266_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v_reuseFailAlloc_266_, 0, v___x_262_);
lean_ctor_set(v_reuseFailAlloc_266_, 1, v_a_253_);
v___x_264_ = v_reuseFailAlloc_266_;
goto v_reusejp_263_;
}
v_reusejp_263_:
{
v_a_252_ = v_tail_256_;
v_a_253_ = v___x_264_;
goto _start;
}
}
}
}
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_lowerAscii(lean_object* v_s_279_){
_start:
{
lean_object* v___x_280_; lean_object* v___x_281_; lean_object* v___x_282_; lean_object* v___x_283_; 
v___x_280_ = lp_sft__v4_SFT_Host_Text_chars(v_s_279_);
v___x_281_ = lean_box(0);
v___x_282_ = lp_sft__v4_List_mapTR_loop___at___00SFT_Host_Text_lowerAscii_spec__0(v___x_280_, v___x_281_);
v___x_283_ = lean_string_mk(v___x_282_);
return v___x_283_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_lowerAscii___boxed(lean_object* v_s_284_){
_start:
{
lean_object* v_res_285_; 
v_res_285_ = lp_sft__v4_SFT_Host_Text_lowerAscii(v_s_284_);
lean_dec_ref(v_s_284_);
return v_res_285_;
}
}
LEAN_EXPORT uint8_t lp_sft__v4_SFT_Host_Text_isPrefix(lean_object* v_x_286_, lean_object* v_x_287_){
_start:
{
if (lean_obj_tag(v_x_286_) == 0)
{
uint8_t v___x_288_; 
v___x_288_ = 1;
return v___x_288_;
}
else
{
if (lean_obj_tag(v_x_287_) == 0)
{
uint8_t v___x_289_; 
v___x_289_ = 0;
return v___x_289_;
}
else
{
lean_object* v_head_290_; lean_object* v_tail_291_; lean_object* v_head_292_; lean_object* v_tail_293_; uint8_t v___x_294_; lean_object* v___x_295_; uint8_t v___x_296_; lean_object* v___x_297_; uint8_t v___x_298_; 
v_head_290_ = lean_ctor_get(v_x_286_, 0);
v_tail_291_ = lean_ctor_get(v_x_286_, 1);
v_head_292_ = lean_ctor_get(v_x_287_, 0);
v_tail_293_ = lean_ctor_get(v_x_287_, 1);
v___x_294_ = lean_unbox(v_head_290_);
v___x_295_ = lean_uint8_to_nat(v___x_294_);
v___x_296_ = lean_unbox(v_head_292_);
v___x_297_ = lean_uint8_to_nat(v___x_296_);
v___x_298_ = lean_nat_dec_eq(v___x_295_, v___x_297_);
if (v___x_298_ == 0)
{
return v___x_298_;
}
else
{
v_x_286_ = v_tail_291_;
v_x_287_ = v_tail_293_;
goto _start;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_isPrefix___boxed(lean_object* v_x_300_, lean_object* v_x_301_){
_start:
{
uint8_t v_res_302_; lean_object* v_r_303_; 
v_res_302_ = lp_sft__v4_SFT_Host_Text_isPrefix(v_x_300_, v_x_301_);
lean_dec(v_x_301_);
lean_dec(v_x_300_);
v_r_303_ = lean_box(v_res_302_);
return v_r_303_;
}
}
LEAN_EXPORT uint8_t lp_sft__v4_SFT_Host_Text_containsBytes(lean_object* v_needle_304_, lean_object* v_x_305_){
_start:
{
if (lean_obj_tag(v_x_305_) == 0)
{
uint8_t v___x_306_; 
v___x_306_ = l_List_isEmpty___redArg(v_needle_304_);
return v___x_306_;
}
else
{
lean_object* v_tail_307_; uint8_t v___x_308_; 
v_tail_307_ = lean_ctor_get(v_x_305_, 1);
v___x_308_ = lp_sft__v4_SFT_Host_Text_isPrefix(v_needle_304_, v_x_305_);
if (v___x_308_ == 0)
{
v_x_305_ = v_tail_307_;
goto _start;
}
else
{
return v___x_308_;
}
}
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_containsBytes___boxed(lean_object* v_needle_310_, lean_object* v_x_311_){
_start:
{
uint8_t v_res_312_; lean_object* v_r_313_; 
v_res_312_ = lp_sft__v4_SFT_Host_Text_containsBytes(v_needle_310_, v_x_311_);
lean_dec(v_x_311_);
lean_dec(v_needle_310_);
v_r_313_ = lean_box(v_res_312_);
return v_r_313_;
}
}
LEAN_EXPORT uint8_t lp_sft__v4_SFT_Host_Text_contains(lean_object* v_s_314_, lean_object* v_needle_315_){
_start:
{
lean_object* v___x_316_; lean_object* v___x_317_; lean_object* v___x_318_; lean_object* v___x_319_; lean_object* v___x_320_; lean_object* v___x_321_; uint8_t v___x_322_; 
v___x_316_ = lean_string_to_utf8(v_needle_315_);
v___x_317_ = lean_byte_array_data(v___x_316_);
v___x_318_ = lean_array_to_list(v___x_317_);
v___x_319_ = lean_string_to_utf8(v_s_314_);
v___x_320_ = lean_byte_array_data(v___x_319_);
v___x_321_ = lean_array_to_list(v___x_320_);
v___x_322_ = lp_sft__v4_SFT_Host_Text_containsBytes(v___x_318_, v___x_321_);
lean_dec(v___x_321_);
lean_dec(v___x_318_);
return v___x_322_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Text_contains___boxed(lean_object* v_s_323_, lean_object* v_needle_324_){
_start:
{
uint8_t v_res_325_; lean_object* v_r_326_; 
v_res_325_ = lp_sft__v4_SFT_Host_Text_contains(v_s_323_, v_needle_324_);
lean_dec_ref(v_needle_324_);
lean_dec_ref(v_s_323_);
v_r_326_ = lean_box(v_res_325_);
return v_r_326_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_sft__v4_SFT_Host_Text(uint8_t builtin) {
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
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
