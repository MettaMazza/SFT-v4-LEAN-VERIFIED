// Lean compiler output
// Module: SFT.Host.Canonical
// Imports: public import Init public meta import Init public import SFT.Host.SHA256Window
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
lean_object* l_Lean_Name_mkStr4(lean_object*, lean_object*, lean_object*, lean_object*);
uint8_t l_Lean_Syntax_isOfKind(lean_object*, lean_object*);
lean_object* l_Lean_Syntax_getArg(lean_object*, lean_object*);
lean_object* l_Lean_Name_mkStr1(lean_object*);
uint8_t l_Lean_Syntax_matchesNull(lean_object*, lean_object*);
lean_object* l_Lean_replaceRef(lean_object*, lean_object*);
lean_object* l_Lean_SourceInfo_fromRef(lean_object*, uint8_t);
lean_object* l_Lean_Name_str___override(lean_object*, lean_object*);
lean_object* l_Lean_Name_num___override(lean_object*, lean_object*);
lean_object* l_Lean_Syntax_node3(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* lean_uint32_to_nat(uint32_t);
uint8_t lean_nat_dec_lt(lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
lean_object* lean_nat_shiftr(lean_object*, lean_object*);
lean_object* lean_nat_add(lean_object*, lean_object*);
lean_object* l_List_range(lean_object*);
lean_object* l_List_reverse___redArg(lean_object*);
lean_object* lean_nat_mul(lean_object*, lean_object*);
lean_object* lean_nat_pow(lean_object*, lean_object*);
lean_object* lean_nat_div(lean_object*, lean_object*);
lean_object* lean_nat_mod(lean_object*, lean_object*);
uint32_t lp_sft__v4_SFT_Host_SHA256_hexDigit(lean_object*);
lean_object* lean_string_mk(lean_object*);
lean_object* lp_sft__v4_SFT_Host_Text_append(lean_object*, lean_object*);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
lean_object* l_Repr_addAppParen(lean_object*, lean_object*);
lean_object* l_String_quote(lean_object*);
uint8_t lean_nat_dec_le(lean_object*, lean_object*);
lean_object* lean_nat_to_int(lean_object*);
lean_object* l_Bool_repr___redArg(uint8_t);
uint8_t lean_int_dec_lt(lean_object*, lean_object*);
lean_object* l_Int_repr(lean_object*);
lean_object* l_Std_Format_joinSep___at___00Lean_Syntax_formatStxAux_spec__2(lean_object*, lean_object*);
lean_object* lean_string_length(lean_object*);
uint8_t lp_sft__v4_SFT_Host_Text_le(lean_object*, lean_object*);
lean_object* lp_sft__v4_SFT_Host_Text_chars(lean_object*);
lean_object* lp_sft__v4_SFT_Host_Text_join(lean_object*);
lean_object* lean_nat_abs(lean_object*);
lean_object* l_Nat_toDigits(lean_object*, lean_object*);
lean_object* lp_sft__v4_SFT_Host_Text_intercalate(lean_object*, lean_object*);
lean_object* l_String_toRawSubstring_x27(lean_object*);
lean_object* l_Lean_addMacroScope(lean_object*, lean_object*, lean_object*);
lean_object* l_Lean_Syntax_node2(lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* lean_string_to_utf8(lean_object*);
lean_object* lp_sft__v4_SFT_Host_SHA256Window_digest(lean_object*);
static const lean_string_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 9, .m_capacity = 9, .m_length = 8, .m_data = "_private"};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__0 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__0_value;
static const lean_ctor_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 8, .m_other = 2, .m_tag = 1}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__0_value),LEAN_SCALAR_PTR_LITERAL(103, 214, 75, 80, 34, 198, 193, 153)}};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__1 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__1_value;
static const lean_string_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 4, .m_capacity = 4, .m_length = 3, .m_data = "SFT"};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__2 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__2_value;
static const lean_ctor_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 8, .m_other = 2, .m_tag = 1}, .m_objs = {((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__1_value),((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__2_value),LEAN_SCALAR_PTR_LITERAL(83, 54, 9, 36, 111, 25, 234, 138)}};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__3 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__3_value;
static const lean_string_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__4_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 5, .m_capacity = 5, .m_length = 4, .m_data = "Host"};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__4 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__4_value;
static const lean_ctor_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__5_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 8, .m_other = 2, .m_tag = 1}, .m_objs = {((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__3_value),((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__4_value),LEAN_SCALAR_PTR_LITERAL(93, 131, 252, 172, 93, 87, 189, 30)}};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__5 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__5_value;
static const lean_string_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__6_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 10, .m_capacity = 10, .m_length = 9, .m_data = "Canonical"};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__6 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__6_value;
static const lean_ctor_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__7_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 8, .m_other = 2, .m_tag = 1}, .m_objs = {((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__5_value),((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__6_value),LEAN_SCALAR_PTR_LITERAL(20, 237, 152, 131, 243, 111, 135, 120)}};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__7 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__7_value;
static const lean_ctor_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__8_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 8, .m_other = 2, .m_tag = 2}, .m_objs = {((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__7_value),((lean_object*)(((size_t)(0) << 1) | 1)),LEAN_SCALAR_PTR_LITERAL(21, 8, 234, 223, 129, 10, 168, 188)}};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__8 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__8_value;
static const lean_ctor_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__9_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 8, .m_other = 2, .m_tag = 1}, .m_objs = {((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__8_value),((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__2_value),LEAN_SCALAR_PTR_LITERAL(217, 99, 101, 29, 168, 0, 203, 123)}};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__9 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__9_value;
static const lean_ctor_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__10_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 8, .m_other = 2, .m_tag = 1}, .m_objs = {((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__9_value),((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__4_value),LEAN_SCALAR_PTR_LITERAL(95, 24, 84, 176, 6, 121, 173, 137)}};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__10 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__10_value;
static const lean_ctor_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__11_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 8, .m_other = 2, .m_tag = 1}, .m_objs = {((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__10_value),((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__6_value),LEAN_SCALAR_PTR_LITERAL(62, 137, 7, 18, 113, 36, 38, 190)}};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__11 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__11_value;
static const lean_string_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__12_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 10, .m_capacity = 10, .m_length = 9, .m_data = "term_+++_"};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__12 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__12_value;
static const lean_ctor_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__13_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 8, .m_other = 2, .m_tag = 1}, .m_objs = {((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__11_value),((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__12_value),LEAN_SCALAR_PTR_LITERAL(193, 185, 137, 26, 113, 30, 72, 206)}};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__13 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__13_value;
static const lean_string_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__14_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 8, .m_capacity = 8, .m_length = 7, .m_data = "andthen"};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__14 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__14_value;
static const lean_ctor_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__15_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 8, .m_other = 2, .m_tag = 1}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__14_value),LEAN_SCALAR_PTR_LITERAL(40, 255, 78, 30, 143, 119, 117, 174)}};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__15 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__15_value;
static const lean_string_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__16_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 6, .m_capacity = 6, .m_length = 5, .m_data = " +++ "};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__16 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__16_value;
static const lean_ctor_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__17_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 5}, .m_objs = {((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__16_value)}};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__17 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__17_value;
static const lean_string_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__18_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 5, .m_capacity = 5, .m_length = 4, .m_data = "term"};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__18 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__18_value;
static const lean_ctor_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__19_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 8, .m_other = 2, .m_tag = 1}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__18_value),LEAN_SCALAR_PTR_LITERAL(187, 230, 181, 162, 253, 146, 122, 119)}};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__19 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__19_value;
static const lean_ctor_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__20_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 7}, .m_objs = {((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__19_value),((lean_object*)(((size_t)(65) << 1) | 1))}};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__20 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__20_value;
static const lean_ctor_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__21_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*3 + 0, .m_other = 3, .m_tag = 2}, .m_objs = {((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__15_value),((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__17_value),((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__20_value)}};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__21 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__21_value;
static const lean_ctor_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__22_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*4 + 0, .m_other = 4, .m_tag = 4}, .m_objs = {((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__13_value),((lean_object*)(((size_t)(65) << 1) | 1)),((lean_object*)(((size_t)(66) << 1) | 1)),((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__21_value)}};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__22 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__22_value;
LEAN_EXPORT const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b__ = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__22_value;
static const lean_string_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 5, .m_capacity = 5, .m_length = 4, .m_data = "Lean"};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__0 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__0_value;
static const lean_string_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 7, .m_capacity = 7, .m_length = 6, .m_data = "Parser"};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__1 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__1_value;
static const lean_string_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 5, .m_capacity = 5, .m_length = 4, .m_data = "Term"};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__2 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__2_value;
static const lean_string_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 4, .m_capacity = 4, .m_length = 3, .m_data = "app"};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__3 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__3_value;
static const lean_ctor_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__4_value_aux_0 = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 8, .m_other = 2, .m_tag = 1}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__0_value),LEAN_SCALAR_PTR_LITERAL(70, 193, 83, 126, 233, 67, 208, 165)}};
static const lean_ctor_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__4_value_aux_1 = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 8, .m_other = 2, .m_tag = 1}, .m_objs = {((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__4_value_aux_0),((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__1_value),LEAN_SCALAR_PTR_LITERAL(103, 136, 125, 166, 167, 98, 71, 111)}};
static const lean_ctor_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__4_value_aux_2 = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 8, .m_other = 2, .m_tag = 1}, .m_objs = {((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__4_value_aux_1),((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__2_value),LEAN_SCALAR_PTR_LITERAL(75, 170, 162, 138, 136, 204, 251, 229)}};
static const lean_ctor_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__4_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 8, .m_other = 2, .m_tag = 1}, .m_objs = {((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__4_value_aux_2),((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__3_value),LEAN_SCALAR_PTR_LITERAL(69, 118, 10, 41, 220, 156, 243, 179)}};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__4 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__4_value;
static const lean_string_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__5_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 21, .m_capacity = 21, .m_length = 20, .m_data = "SFT.Host.Text.append"};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__5 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__5_value;
static lean_once_cell_t lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__6_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__6;
static const lean_string_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__7_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 5, .m_capacity = 5, .m_length = 4, .m_data = "Text"};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__7 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__7_value;
static const lean_string_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__8_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 7, .m_capacity = 7, .m_length = 6, .m_data = "append"};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__8 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__8_value;
static const lean_ctor_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__9_value_aux_0 = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 8, .m_other = 2, .m_tag = 1}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__2_value),LEAN_SCALAR_PTR_LITERAL(55, 75, 87, 48, 138, 34, 130, 129)}};
static const lean_ctor_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__9_value_aux_1 = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 8, .m_other = 2, .m_tag = 1}, .m_objs = {((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__9_value_aux_0),((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__4_value),LEAN_SCALAR_PTR_LITERAL(81, 125, 114, 110, 246, 130, 34, 10)}};
static const lean_ctor_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__9_value_aux_2 = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 8, .m_other = 2, .m_tag = 1}, .m_objs = {((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__9_value_aux_1),((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__7_value),LEAN_SCALAR_PTR_LITERAL(200, 54, 187, 36, 203, 24, 143, 249)}};
static const lean_ctor_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__9_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 8, .m_other = 2, .m_tag = 1}, .m_objs = {((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__9_value_aux_2),((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__8_value),LEAN_SCALAR_PTR_LITERAL(51, 116, 153, 36, 126, 183, 23, 244)}};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__9 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__9_value;
static const lean_ctor_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__10_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 1}, .m_objs = {((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__9_value),((lean_object*)(((size_t)(0) << 1) | 1))}};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__10 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__10_value;
static const lean_ctor_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__11_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 1}, .m_objs = {((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__10_value),((lean_object*)(((size_t)(0) << 1) | 1))}};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__11 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__11_value;
static const lean_string_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__12_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 5, .m_capacity = 5, .m_length = 4, .m_data = "null"};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__12 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__12_value;
static const lean_ctor_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__13_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 8, .m_other = 2, .m_tag = 1}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__12_value),LEAN_SCALAR_PTR_LITERAL(24, 58, 49, 223, 146, 207, 197, 136)}};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__13 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__13_value;
LEAN_EXPORT lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___boxed(lean_object*, lean_object*, lean_object*);
static const lean_string_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______unexpand__SFT__Host__Text__append__1___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 6, .m_capacity = 6, .m_length = 5, .m_data = "ident"};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______unexpand__SFT__Host__Text__append__1___closed__0 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______unexpand__SFT__Host__Text__append__1___closed__0_value;
static const lean_ctor_object lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______unexpand__SFT__Host__Text__append__1___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 8, .m_other = 2, .m_tag = 1}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______unexpand__SFT__Host__Text__append__1___closed__0_value),LEAN_SCALAR_PTR_LITERAL(52, 159, 208, 51, 14, 60, 6, 71)}};
static const lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______unexpand__SFT__Host__Text__append__1___closed__1 = (const lean_object*)&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______unexpand__SFT__Host__Text__append__1___closed__1_value;
LEAN_EXPORT lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______unexpand__SFT__Host__Text__append__1(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______unexpand__SFT__Host__Text__append__1___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_ctorIdx(lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_ctorIdx___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_ctorElim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_ctorElim(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_ctorElim___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_text_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_text_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_boolean_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_boolean_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_integer_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_integer_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_null_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_null_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_array_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_array_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_object_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_object_elim(lean_object*, lean_object*, lean_object*, lean_object*);
static const lean_string_object lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 30, .m_capacity = 30, .m_length = 29, .m_data = "SFT.Host.Canonical.Value.null"};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__0 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__0_value;
static const lean_ctor_object lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__0_value)}};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__1 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__1_value;
static const lean_string_object lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 30, .m_capacity = 30, .m_length = 29, .m_data = "SFT.Host.Canonical.Value.text"};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__2 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__2_value;
static const lean_ctor_object lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__2_value)}};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__3 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__3_value;
static const lean_ctor_object lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__4_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__3_value),((lean_object*)(((size_t)(1) << 1) | 1))}};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__4 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__4_value;
static lean_once_cell_t lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__5_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__5;
static lean_once_cell_t lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__6_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__6;
static const lean_string_object lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__7_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 33, .m_capacity = 33, .m_length = 32, .m_data = "SFT.Host.Canonical.Value.boolean"};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__7 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__7_value;
static const lean_ctor_object lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__8_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__7_value)}};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__8 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__8_value;
static const lean_ctor_object lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__9_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__8_value),((lean_object*)(((size_t)(1) << 1) | 1))}};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__9 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__9_value;
static const lean_string_object lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__10_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 33, .m_capacity = 33, .m_length = 32, .m_data = "SFT.Host.Canonical.Value.integer"};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__10 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__10_value;
static const lean_ctor_object lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__11_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__10_value)}};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__11 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__11_value;
static const lean_ctor_object lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__12_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__11_value),((lean_object*)(((size_t)(1) << 1) | 1))}};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__12 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__12_value;
static lean_once_cell_t lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__13_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__13;
static const lean_string_object lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__14_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 31, .m_capacity = 31, .m_length = 30, .m_data = "SFT.Host.Canonical.Value.array"};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__14 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__14_value;
static const lean_ctor_object lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__15_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__14_value)}};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__15 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__15_value;
static const lean_ctor_object lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__16_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__15_value),((lean_object*)(((size_t)(1) << 1) | 1))}};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__16 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__16_value;
static const lean_string_object lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 3, .m_capacity = 3, .m_length = 2, .m_data = "[]"};
static const lean_object* lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__0 = (const lean_object*)&lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__0_value;
static const lean_ctor_object lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__0_value)}};
static const lean_object* lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__1 = (const lean_object*)&lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__1_value;
static const lean_string_object lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 2, .m_capacity = 2, .m_length = 1, .m_data = ","};
static const lean_object* lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__3 = (const lean_object*)&lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__3_value;
static const lean_ctor_object lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__4_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__3_value)}};
static const lean_object* lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__4 = (const lean_object*)&lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__4_value;
static const lean_ctor_object lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__5_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__4_value),((lean_object*)(((size_t)(1) << 1) | 1))}};
static const lean_object* lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__5 = (const lean_object*)&lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__5_value;
LEAN_EXPORT lean_object* lp_sft__v4_List_foldl___at___00List_foldl___at___00Std_Format_joinSep___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0_spec__0_spec__1_spec__3(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_List_foldl___at___00Std_Format_joinSep___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0_spec__0_spec__1(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_Std_Format_joinSep___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0_spec__0(lean_object*, lean_object*);
static const lean_string_object lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 2, .m_capacity = 2, .m_length = 1, .m_data = "["};
static const lean_object* lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__2 = (const lean_object*)&lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__2_value;
static lean_once_cell_t lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__7_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__7;
static lean_once_cell_t lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__8_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__8;
static const lean_ctor_object lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__9_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__2_value)}};
static const lean_object* lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__9 = (const lean_object*)&lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__9_value;
static const lean_string_object lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__6_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 2, .m_capacity = 2, .m_length = 1, .m_data = "]"};
static const lean_object* lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__6 = (const lean_object*)&lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__6_value;
static const lean_ctor_object lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__10_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__6_value)}};
static const lean_object* lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__10 = (const lean_object*)&lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__10_value;
LEAN_EXPORT lean_object* lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg(lean_object*);
static const lean_string_object lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__17_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 32, .m_capacity = 32, .m_length = 31, .m_data = "SFT.Host.Canonical.Value.object"};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__17 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__17_value;
static const lean_ctor_object lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__18_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__17_value)}};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__18 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__18_value;
static const lean_ctor_object lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__19_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__18_value),((lean_object*)(((size_t)(1) << 1) | 1))}};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__19 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__19_value;
static const lean_string_object lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 2, .m_capacity = 2, .m_length = 1, .m_data = "("};
static const lean_object* lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg___closed__0 = (const lean_object*)&lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg___closed__0_value;
static lean_once_cell_t lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg___closed__2_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg___closed__2;
static lean_once_cell_t lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg___closed__3_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg___closed__3;
static const lean_ctor_object lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg___closed__4_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg___closed__0_value)}};
static const lean_object* lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg___closed__4 = (const lean_object*)&lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg___closed__4_value;
static const lean_string_object lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 2, .m_capacity = 2, .m_length = 1, .m_data = ")"};
static const lean_object* lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg___closed__1 = (const lean_object*)&lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg___closed__1_value;
static const lean_ctor_object lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg___closed__5_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg___closed__1_value)}};
static const lean_object* lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg___closed__5 = (const lean_object*)&lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg___closed__5_value;
LEAN_EXPORT lean_object* lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_List_foldl___at___00List_foldl___at___00Std_Format_joinSep___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__3_spec__5_spec__7(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_List_foldl___at___00Std_Format_joinSep___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__3_spec__5(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_Std_Format_joinSep___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__3(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_instReprValue_repr(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_Std_Format_joinSep___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0_spec__0___lam__0(lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___boxed(lean_object*, lean_object*);
static const lean_closure_object lp_sft__v4_SFT_Host_Canonical_instReprValue___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___boxed, .m_arity = 2, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* lp_sft__v4_SFT_Host_Canonical_instReprValue___closed__0 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_instReprValue___closed__0_value;
LEAN_EXPORT const lean_object* lp_sft__v4_SFT_Host_Canonical_instReprValue = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_instReprValue___closed__0_value;
LEAN_EXPORT lean_object* lp_sft__v4_List_mapTR_loop___at___00SFT_Host_Canonical_hex4_spec__0(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_List_mapTR_loop___at___00SFT_Host_Canonical_hex4_spec__0___boxed(lean_object*, lean_object*, lean_object*);
static lean_once_cell_t lp_sft__v4_SFT_Host_Canonical_hex4___closed__0_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_sft__v4_SFT_Host_Canonical_hex4___closed__0;
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_hex4(lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_hex4___boxed(lean_object*);
static const lean_string_object lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 3, .m_capacity = 3, .m_length = 2, .m_data = "\\u"};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__0 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__0_value;
static const lean_string_object lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 3, .m_capacity = 3, .m_length = 2, .m_data = "\\r"};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__1 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__1_value;
static const lean_string_object lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 3, .m_capacity = 3, .m_length = 2, .m_data = "\\f"};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__2 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__2_value;
static const lean_string_object lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 3, .m_capacity = 3, .m_length = 2, .m_data = "\\n"};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__3 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__3_value;
static const lean_string_object lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__4_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 3, .m_capacity = 3, .m_length = 2, .m_data = "\\t"};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__4 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__4_value;
static const lean_string_object lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__5_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 3, .m_capacity = 3, .m_length = 2, .m_data = "\\b"};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__5 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__5_value;
static const lean_string_object lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__6_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 3, .m_capacity = 3, .m_length = 2, .m_data = "\\\\"};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__6 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__6_value;
static const lean_string_object lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__7_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 3, .m_capacity = 3, .m_length = 2, .m_data = "\\\""};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__7 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__7_value;
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_escapeChar(uint32_t);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_escapeChar___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_List_mapTR_loop___at___00SFT_Host_Canonical_quote_spec__0(lean_object*, lean_object*);
static const lean_string_object lp_sft__v4_SFT_Host_Canonical_quote___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 2, .m_capacity = 2, .m_length = 1, .m_data = "\""};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_quote___closed__0 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_quote___closed__0_value;
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_quote(lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_quote___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_insertField(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_sortFields(lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_List_mapTR_loop___at___00SFT_Host_Canonical_render_spec__0(lean_object*, lean_object*);
static const lean_string_object lp_sft__v4_SFT_Host_Canonical_renderField___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 2, .m_capacity = 2, .m_length = 1, .m_data = ":"};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_renderField___closed__0 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_renderField___closed__0_value;
static const lean_string_object lp_sft__v4_SFT_Host_Canonical_render___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 6, .m_capacity = 6, .m_length = 5, .m_data = "false"};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_render___closed__0 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_render___closed__0_value;
static const lean_string_object lp_sft__v4_SFT_Host_Canonical_render___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 5, .m_capacity = 5, .m_length = 4, .m_data = "true"};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_render___closed__1 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_render___closed__1_value;
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_render___boxed__const__1;
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_renderValues(lean_object*);
static const lean_string_object lp_sft__v4_SFT_Host_Canonical_render___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 2, .m_capacity = 2, .m_length = 1, .m_data = "{"};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_render___closed__2 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_render___closed__2_value;
static const lean_string_object lp_sft__v4_SFT_Host_Canonical_render___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 2, .m_capacity = 2, .m_length = 1, .m_data = "}"};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_render___closed__3 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_render___closed__3_value;
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_render(lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_renderField(lean_object*);
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_renderFields(lean_object*);
static const lean_string_object lp_sft__v4_SFT_Host_Canonical_identity___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 8, .m_capacity = 8, .m_length = 7, .m_data = "sha256:"};
static const lean_object* lp_sft__v4_SFT_Host_Canonical_identity___closed__0 = (const lean_object*)&lp_sft__v4_SFT_Host_Canonical_identity___closed__0_value;
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_identity(lean_object*);
static lean_object* _init_lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__6(void){
_start:
{
lean_object* v___x_65_; lean_object* v___x_66_; 
v___x_65_ = ((lean_object*)(lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__5));
v___x_66_ = l_String_toRawSubstring_x27(v___x_65_);
return v___x_66_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1(lean_object* v_x_83_, lean_object* v_a_84_, lean_object* v_a_85_){
_start:
{
lean_object* v___x_86_; lean_object* v___x_87_; uint8_t v___x_88_; 
v___x_86_ = lean_unsigned_to_nat(0u);
v___x_87_ = ((lean_object*)(lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__13));
lean_inc(v_x_83_);
v___x_88_ = l_Lean_Syntax_isOfKind(v_x_83_, v___x_87_);
if (v___x_88_ == 0)
{
lean_object* v___x_89_; lean_object* v___x_90_; 
lean_dec(v_x_83_);
v___x_89_ = lean_box(1);
v___x_90_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_90_, 0, v___x_89_);
lean_ctor_set(v___x_90_, 1, v_a_85_);
return v___x_90_;
}
else
{
lean_object* v_quotContext_91_; lean_object* v_currMacroScope_92_; lean_object* v_ref_93_; lean_object* v___x_94_; lean_object* v___x_95_; lean_object* v___x_96_; uint8_t v___x_97_; lean_object* v___x_98_; lean_object* v___x_99_; lean_object* v___x_100_; lean_object* v___x_101_; lean_object* v___x_102_; lean_object* v___x_103_; lean_object* v___x_104_; lean_object* v___x_105_; lean_object* v___x_106_; lean_object* v___x_107_; lean_object* v___x_108_; 
v_quotContext_91_ = lean_ctor_get(v_a_84_, 1);
v_currMacroScope_92_ = lean_ctor_get(v_a_84_, 2);
v_ref_93_ = lean_ctor_get(v_a_84_, 5);
v___x_94_ = l_Lean_Syntax_getArg(v_x_83_, v___x_86_);
v___x_95_ = lean_unsigned_to_nat(2u);
v___x_96_ = l_Lean_Syntax_getArg(v_x_83_, v___x_95_);
lean_dec(v_x_83_);
v___x_97_ = 0;
v___x_98_ = l_Lean_SourceInfo_fromRef(v_ref_93_, v___x_97_);
v___x_99_ = ((lean_object*)(lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__4));
v___x_100_ = lean_obj_once(&lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__6, &lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__6_once, _init_lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__6);
v___x_101_ = ((lean_object*)(lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__9));
lean_inc(v_currMacroScope_92_);
lean_inc(v_quotContext_91_);
v___x_102_ = l_Lean_addMacroScope(v_quotContext_91_, v___x_101_, v_currMacroScope_92_);
v___x_103_ = ((lean_object*)(lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__11));
lean_inc_n(v___x_98_, 2);
v___x_104_ = lean_alloc_ctor(3, 4, 0);
lean_ctor_set(v___x_104_, 0, v___x_98_);
lean_ctor_set(v___x_104_, 1, v___x_100_);
lean_ctor_set(v___x_104_, 2, v___x_102_);
lean_ctor_set(v___x_104_, 3, v___x_103_);
v___x_105_ = ((lean_object*)(lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__13));
v___x_106_ = l_Lean_Syntax_node2(v___x_98_, v___x_105_, v___x_94_, v___x_96_);
v___x_107_ = l_Lean_Syntax_node2(v___x_98_, v___x_99_, v___x_104_, v___x_106_);
v___x_108_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_108_, 0, v___x_107_);
lean_ctor_set(v___x_108_, 1, v_a_85_);
return v___x_108_;
}
}
}
LEAN_EXPORT lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___boxed(lean_object* v_x_109_, lean_object* v_a_110_, lean_object* v_a_111_){
_start:
{
lean_object* v_res_112_; 
v_res_112_ = lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1(v_x_109_, v_a_110_, v_a_111_);
lean_dec_ref(v_a_110_);
return v_res_112_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______unexpand__SFT__Host__Text__append__1(lean_object* v_x_116_, lean_object* v_a_117_, lean_object* v_a_118_){
_start:
{
lean_object* v___x_119_; uint8_t v___x_120_; 
v___x_119_ = ((lean_object*)(lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__4));
lean_inc(v_x_116_);
v___x_120_ = l_Lean_Syntax_isOfKind(v_x_116_, v___x_119_);
if (v___x_120_ == 0)
{
lean_object* v___x_121_; lean_object* v___x_122_; 
lean_dec(v_x_116_);
v___x_121_ = lean_box(0);
v___x_122_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_122_, 0, v___x_121_);
lean_ctor_set(v___x_122_, 1, v_a_118_);
return v___x_122_;
}
else
{
lean_object* v___x_123_; lean_object* v___x_124_; lean_object* v___x_125_; uint8_t v___x_126_; 
v___x_123_ = lean_unsigned_to_nat(0u);
v___x_124_ = l_Lean_Syntax_getArg(v_x_116_, v___x_123_);
v___x_125_ = ((lean_object*)(lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______unexpand__SFT__Host__Text__append__1___closed__1));
lean_inc(v___x_124_);
v___x_126_ = l_Lean_Syntax_isOfKind(v___x_124_, v___x_125_);
if (v___x_126_ == 0)
{
lean_object* v___x_127_; lean_object* v___x_128_; 
lean_dec(v___x_124_);
lean_dec(v_x_116_);
v___x_127_ = lean_box(0);
v___x_128_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_128_, 0, v___x_127_);
lean_ctor_set(v___x_128_, 1, v_a_118_);
return v___x_128_;
}
else
{
lean_object* v___x_129_; lean_object* v___x_130_; lean_object* v___x_131_; uint8_t v___x_132_; 
v___x_129_ = lean_unsigned_to_nat(1u);
v___x_130_ = l_Lean_Syntax_getArg(v_x_116_, v___x_129_);
lean_dec(v_x_116_);
v___x_131_ = lean_unsigned_to_nat(2u);
lean_inc(v___x_130_);
v___x_132_ = l_Lean_Syntax_matchesNull(v___x_130_, v___x_131_);
if (v___x_132_ == 0)
{
lean_object* v___x_133_; lean_object* v___x_134_; 
lean_dec(v___x_130_);
lean_dec(v___x_124_);
v___x_133_ = lean_box(0);
v___x_134_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_134_, 0, v___x_133_);
lean_ctor_set(v___x_134_, 1, v_a_118_);
return v___x_134_;
}
else
{
lean_object* v___x_135_; lean_object* v___x_136_; lean_object* v_ref_137_; uint8_t v___x_138_; lean_object* v___x_139_; lean_object* v___x_140_; lean_object* v___x_141_; lean_object* v___x_142_; lean_object* v___x_143_; lean_object* v___x_144_; 
v___x_135_ = l_Lean_Syntax_getArg(v___x_130_, v___x_123_);
v___x_136_ = l_Lean_Syntax_getArg(v___x_130_, v___x_129_);
lean_dec(v___x_130_);
v_ref_137_ = l_Lean_replaceRef(v___x_124_, v_a_117_);
lean_dec(v___x_124_);
v___x_138_ = 0;
v___x_139_ = l_Lean_SourceInfo_fromRef(v_ref_137_, v___x_138_);
lean_dec(v_ref_137_);
v___x_140_ = ((lean_object*)(lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__13));
v___x_141_ = ((lean_object*)(lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical_term___x2b_x2b_x2b___00__closed__16));
lean_inc(v___x_139_);
v___x_142_ = lean_alloc_ctor(2, 2, 0);
lean_ctor_set(v___x_142_, 0, v___x_139_);
lean_ctor_set(v___x_142_, 1, v___x_141_);
v___x_143_ = l_Lean_Syntax_node3(v___x_139_, v___x_140_, v___x_135_, v___x_142_, v___x_136_);
v___x_144_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_144_, 0, v___x_143_);
lean_ctor_set(v___x_144_, 1, v_a_118_);
return v___x_144_;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______unexpand__SFT__Host__Text__append__1___boxed(lean_object* v_x_145_, lean_object* v_a_146_, lean_object* v_a_147_){
_start:
{
lean_object* v_res_148_; 
v_res_148_ = lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______unexpand__SFT__Host__Text__append__1(v_x_145_, v_a_146_, v_a_147_);
lean_dec(v_a_146_);
return v_res_148_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_ctorIdx(lean_object* v_x_149_){
_start:
{
switch(lean_obj_tag(v_x_149_))
{
case 0:
{
lean_object* v___x_150_; 
v___x_150_ = lean_unsigned_to_nat(0u);
return v___x_150_;
}
case 1:
{
lean_object* v___x_151_; 
v___x_151_ = lean_unsigned_to_nat(1u);
return v___x_151_;
}
case 2:
{
lean_object* v___x_152_; 
v___x_152_ = lean_unsigned_to_nat(2u);
return v___x_152_;
}
case 3:
{
lean_object* v___x_153_; 
v___x_153_ = lean_unsigned_to_nat(3u);
return v___x_153_;
}
case 4:
{
lean_object* v___x_154_; 
v___x_154_ = lean_unsigned_to_nat(4u);
return v___x_154_;
}
default: 
{
lean_object* v___x_155_; 
v___x_155_ = lean_unsigned_to_nat(5u);
return v___x_155_;
}
}
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_ctorIdx___boxed(lean_object* v_x_156_){
_start:
{
lean_object* v_res_157_; 
v_res_157_ = lp_sft__v4_SFT_Host_Canonical_Value_ctorIdx(v_x_156_);
lean_dec(v_x_156_);
return v_res_157_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_ctorElim___redArg(lean_object* v_t_158_, lean_object* v_k_159_){
_start:
{
switch(lean_obj_tag(v_t_158_))
{
case 0:
{
lean_object* v_a_160_; lean_object* v___x_161_; 
v_a_160_ = lean_ctor_get(v_t_158_, 0);
lean_inc_ref(v_a_160_);
lean_dec_ref_known(v_t_158_, 1);
v___x_161_ = lean_apply_1(v_k_159_, v_a_160_);
return v___x_161_;
}
case 1:
{
uint8_t v_a_162_; lean_object* v___x_163_; lean_object* v___x_164_; 
v_a_162_ = lean_ctor_get_uint8(v_t_158_, 0);
lean_dec_ref_known(v_t_158_, 0);
v___x_163_ = lean_box(v_a_162_);
v___x_164_ = lean_apply_1(v_k_159_, v___x_163_);
return v___x_164_;
}
case 3:
{
return v_k_159_;
}
default: 
{
lean_object* v_a_165_; lean_object* v___x_166_; 
v_a_165_ = lean_ctor_get(v_t_158_, 0);
lean_inc(v_a_165_);
lean_dec(v_t_158_);
v___x_166_ = lean_apply_1(v_k_159_, v_a_165_);
return v___x_166_;
}
}
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_ctorElim(lean_object* v_motive__1_167_, lean_object* v_ctorIdx_168_, lean_object* v_t_169_, lean_object* v_h_170_, lean_object* v_k_171_){
_start:
{
lean_object* v___x_172_; 
v___x_172_ = lp_sft__v4_SFT_Host_Canonical_Value_ctorElim___redArg(v_t_169_, v_k_171_);
return v___x_172_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_ctorElim___boxed(lean_object* v_motive__1_173_, lean_object* v_ctorIdx_174_, lean_object* v_t_175_, lean_object* v_h_176_, lean_object* v_k_177_){
_start:
{
lean_object* v_res_178_; 
v_res_178_ = lp_sft__v4_SFT_Host_Canonical_Value_ctorElim(v_motive__1_173_, v_ctorIdx_174_, v_t_175_, v_h_176_, v_k_177_);
lean_dec(v_ctorIdx_174_);
return v_res_178_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_text_elim___redArg(lean_object* v_t_179_, lean_object* v_text_180_){
_start:
{
lean_object* v___x_181_; 
v___x_181_ = lp_sft__v4_SFT_Host_Canonical_Value_ctorElim___redArg(v_t_179_, v_text_180_);
return v___x_181_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_text_elim(lean_object* v_motive__1_182_, lean_object* v_t_183_, lean_object* v_h_184_, lean_object* v_text_185_){
_start:
{
lean_object* v___x_186_; 
v___x_186_ = lp_sft__v4_SFT_Host_Canonical_Value_ctorElim___redArg(v_t_183_, v_text_185_);
return v___x_186_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_boolean_elim___redArg(lean_object* v_t_187_, lean_object* v_boolean_188_){
_start:
{
lean_object* v___x_189_; 
v___x_189_ = lp_sft__v4_SFT_Host_Canonical_Value_ctorElim___redArg(v_t_187_, v_boolean_188_);
return v___x_189_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_boolean_elim(lean_object* v_motive__1_190_, lean_object* v_t_191_, lean_object* v_h_192_, lean_object* v_boolean_193_){
_start:
{
lean_object* v___x_194_; 
v___x_194_ = lp_sft__v4_SFT_Host_Canonical_Value_ctorElim___redArg(v_t_191_, v_boolean_193_);
return v___x_194_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_integer_elim___redArg(lean_object* v_t_195_, lean_object* v_integer_196_){
_start:
{
lean_object* v___x_197_; 
v___x_197_ = lp_sft__v4_SFT_Host_Canonical_Value_ctorElim___redArg(v_t_195_, v_integer_196_);
return v___x_197_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_integer_elim(lean_object* v_motive__1_198_, lean_object* v_t_199_, lean_object* v_h_200_, lean_object* v_integer_201_){
_start:
{
lean_object* v___x_202_; 
v___x_202_ = lp_sft__v4_SFT_Host_Canonical_Value_ctorElim___redArg(v_t_199_, v_integer_201_);
return v___x_202_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_null_elim___redArg(lean_object* v_t_203_, lean_object* v_null_204_){
_start:
{
lean_object* v___x_205_; 
v___x_205_ = lp_sft__v4_SFT_Host_Canonical_Value_ctorElim___redArg(v_t_203_, v_null_204_);
return v___x_205_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_null_elim(lean_object* v_motive__1_206_, lean_object* v_t_207_, lean_object* v_h_208_, lean_object* v_null_209_){
_start:
{
lean_object* v___x_210_; 
v___x_210_ = lp_sft__v4_SFT_Host_Canonical_Value_ctorElim___redArg(v_t_207_, v_null_209_);
return v___x_210_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_array_elim___redArg(lean_object* v_t_211_, lean_object* v_array_212_){
_start:
{
lean_object* v___x_213_; 
v___x_213_ = lp_sft__v4_SFT_Host_Canonical_Value_ctorElim___redArg(v_t_211_, v_array_212_);
return v___x_213_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_array_elim(lean_object* v_motive__1_214_, lean_object* v_t_215_, lean_object* v_h_216_, lean_object* v_array_217_){
_start:
{
lean_object* v___x_218_; 
v___x_218_ = lp_sft__v4_SFT_Host_Canonical_Value_ctorElim___redArg(v_t_215_, v_array_217_);
return v___x_218_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_object_elim___redArg(lean_object* v_t_219_, lean_object* v_object_220_){
_start:
{
lean_object* v___x_221_; 
v___x_221_ = lp_sft__v4_SFT_Host_Canonical_Value_ctorElim___redArg(v_t_219_, v_object_220_);
return v___x_221_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_Value_object_elim(lean_object* v_motive__1_222_, lean_object* v_t_223_, lean_object* v_h_224_, lean_object* v_object_225_){
_start:
{
lean_object* v___x_226_; 
v___x_226_ = lp_sft__v4_SFT_Host_Canonical_Value_ctorElim___redArg(v_t_223_, v_object_225_);
return v___x_226_;
}
}
static lean_object* _init_lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__5(void){
_start:
{
lean_object* v___x_236_; lean_object* v___x_237_; 
v___x_236_ = lean_unsigned_to_nat(2u);
v___x_237_ = lean_nat_to_int(v___x_236_);
return v___x_237_;
}
}
static lean_object* _init_lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__6(void){
_start:
{
lean_object* v___x_238_; lean_object* v___x_239_; 
v___x_238_ = lean_unsigned_to_nat(1u);
v___x_239_ = lean_nat_to_int(v___x_238_);
return v___x_239_;
}
}
static lean_object* _init_lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__13(void){
_start:
{
lean_object* v___x_252_; lean_object* v___x_253_; 
v___x_252_ = lean_unsigned_to_nat(0u);
v___x_253_ = lean_nat_to_int(v___x_252_);
return v___x_253_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_List_foldl___at___00List_foldl___at___00Std_Format_joinSep___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0_spec__0_spec__1_spec__3(lean_object* v_x_269_, lean_object* v_x_270_, lean_object* v_x_271_){
_start:
{
if (lean_obj_tag(v_x_271_) == 0)
{
lean_dec(v_x_269_);
return v_x_270_;
}
else
{
lean_object* v_head_272_; lean_object* v_tail_273_; lean_object* v___x_275_; uint8_t v_isShared_276_; uint8_t v_isSharedCheck_284_; 
v_head_272_ = lean_ctor_get(v_x_271_, 0);
v_tail_273_ = lean_ctor_get(v_x_271_, 1);
v_isSharedCheck_284_ = !lean_is_exclusive(v_x_271_);
if (v_isSharedCheck_284_ == 0)
{
v___x_275_ = v_x_271_;
v_isShared_276_ = v_isSharedCheck_284_;
goto v_resetjp_274_;
}
else
{
lean_inc(v_tail_273_);
lean_inc(v_head_272_);
lean_dec(v_x_271_);
v___x_275_ = lean_box(0);
v_isShared_276_ = v_isSharedCheck_284_;
goto v_resetjp_274_;
}
v_resetjp_274_:
{
lean_object* v___x_278_; 
lean_inc(v_x_269_);
if (v_isShared_276_ == 0)
{
lean_ctor_set_tag(v___x_275_, 5);
lean_ctor_set(v___x_275_, 1, v_x_269_);
lean_ctor_set(v___x_275_, 0, v_x_270_);
v___x_278_ = v___x_275_;
goto v_reusejp_277_;
}
else
{
lean_object* v_reuseFailAlloc_283_; 
v_reuseFailAlloc_283_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v_reuseFailAlloc_283_, 0, v_x_270_);
lean_ctor_set(v_reuseFailAlloc_283_, 1, v_x_269_);
v___x_278_ = v_reuseFailAlloc_283_;
goto v_reusejp_277_;
}
v_reusejp_277_:
{
lean_object* v___x_279_; lean_object* v___x_280_; lean_object* v___x_281_; 
v___x_279_ = lean_unsigned_to_nat(0u);
v___x_280_ = lp_sft__v4_SFT_Host_Canonical_instReprValue_repr(v_head_272_, v___x_279_);
v___x_281_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_281_, 0, v___x_278_);
lean_ctor_set(v___x_281_, 1, v___x_280_);
v_x_270_ = v___x_281_;
v_x_271_ = v_tail_273_;
goto _start;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_sft__v4_List_foldl___at___00Std_Format_joinSep___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0_spec__0_spec__1(lean_object* v_x_285_, lean_object* v_x_286_, lean_object* v_x_287_){
_start:
{
if (lean_obj_tag(v_x_287_) == 0)
{
lean_dec(v_x_285_);
return v_x_286_;
}
else
{
lean_object* v_head_288_; lean_object* v_tail_289_; lean_object* v___x_291_; uint8_t v_isShared_292_; uint8_t v_isSharedCheck_300_; 
v_head_288_ = lean_ctor_get(v_x_287_, 0);
v_tail_289_ = lean_ctor_get(v_x_287_, 1);
v_isSharedCheck_300_ = !lean_is_exclusive(v_x_287_);
if (v_isSharedCheck_300_ == 0)
{
v___x_291_ = v_x_287_;
v_isShared_292_ = v_isSharedCheck_300_;
goto v_resetjp_290_;
}
else
{
lean_inc(v_tail_289_);
lean_inc(v_head_288_);
lean_dec(v_x_287_);
v___x_291_ = lean_box(0);
v_isShared_292_ = v_isSharedCheck_300_;
goto v_resetjp_290_;
}
v_resetjp_290_:
{
lean_object* v___x_294_; 
lean_inc(v_x_285_);
if (v_isShared_292_ == 0)
{
lean_ctor_set_tag(v___x_291_, 5);
lean_ctor_set(v___x_291_, 1, v_x_285_);
lean_ctor_set(v___x_291_, 0, v_x_286_);
v___x_294_ = v___x_291_;
goto v_reusejp_293_;
}
else
{
lean_object* v_reuseFailAlloc_299_; 
v_reuseFailAlloc_299_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v_reuseFailAlloc_299_, 0, v_x_286_);
lean_ctor_set(v_reuseFailAlloc_299_, 1, v_x_285_);
v___x_294_ = v_reuseFailAlloc_299_;
goto v_reusejp_293_;
}
v_reusejp_293_:
{
lean_object* v___x_295_; lean_object* v___x_296_; lean_object* v___x_297_; lean_object* v___x_298_; 
v___x_295_ = lean_unsigned_to_nat(0u);
v___x_296_ = lp_sft__v4_SFT_Host_Canonical_instReprValue_repr(v_head_288_, v___x_295_);
v___x_297_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_297_, 0, v___x_294_);
lean_ctor_set(v___x_297_, 1, v___x_296_);
v___x_298_ = lp_sft__v4_List_foldl___at___00List_foldl___at___00Std_Format_joinSep___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0_spec__0_spec__1_spec__3(v_x_285_, v___x_297_, v_tail_289_);
return v___x_298_;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_sft__v4_Std_Format_joinSep___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0_spec__0(lean_object* v_x_301_, lean_object* v_x_302_){
_start:
{
if (lean_obj_tag(v_x_301_) == 0)
{
lean_object* v___x_303_; 
lean_dec(v_x_302_);
v___x_303_ = lean_box(0);
return v___x_303_;
}
else
{
lean_object* v_tail_304_; 
v_tail_304_ = lean_ctor_get(v_x_301_, 1);
if (lean_obj_tag(v_tail_304_) == 0)
{
lean_object* v_head_305_; lean_object* v___x_306_; 
lean_dec(v_x_302_);
v_head_305_ = lean_ctor_get(v_x_301_, 0);
lean_inc(v_head_305_);
lean_dec_ref_known(v_x_301_, 2);
v___x_306_ = lp_sft__v4_Std_Format_joinSep___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0_spec__0___lam__0(v_head_305_);
return v___x_306_;
}
else
{
lean_object* v_head_307_; lean_object* v___x_308_; lean_object* v___x_309_; 
lean_inc(v_tail_304_);
v_head_307_ = lean_ctor_get(v_x_301_, 0);
lean_inc(v_head_307_);
lean_dec_ref_known(v_x_301_, 2);
v___x_308_ = lp_sft__v4_Std_Format_joinSep___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0_spec__0___lam__0(v_head_307_);
v___x_309_ = lp_sft__v4_List_foldl___at___00Std_Format_joinSep___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0_spec__0_spec__1(v_x_302_, v___x_308_, v_tail_304_);
return v___x_309_;
}
}
}
}
static lean_object* _init_lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__7(void){
_start:
{
lean_object* v___x_311_; lean_object* v___x_312_; 
v___x_311_ = ((lean_object*)(lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__2));
v___x_312_ = lean_string_length(v___x_311_);
return v___x_312_;
}
}
static lean_object* _init_lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__8(void){
_start:
{
lean_object* v___x_313_; lean_object* v___x_314_; 
v___x_313_ = lean_obj_once(&lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__7, &lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__7_once, _init_lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__7);
v___x_314_ = lean_nat_to_int(v___x_313_);
return v___x_314_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg(lean_object* v_a_320_){
_start:
{
if (lean_obj_tag(v_a_320_) == 0)
{
lean_object* v___x_321_; 
v___x_321_ = ((lean_object*)(lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__1));
return v___x_321_;
}
else
{
lean_object* v___x_322_; lean_object* v___x_323_; lean_object* v___x_324_; lean_object* v___x_325_; lean_object* v___x_326_; lean_object* v___x_327_; lean_object* v___x_328_; lean_object* v___x_329_; uint8_t v___x_330_; lean_object* v___x_331_; 
v___x_322_ = ((lean_object*)(lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__5));
v___x_323_ = lp_sft__v4_Std_Format_joinSep___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0_spec__0(v_a_320_, v___x_322_);
v___x_324_ = lean_obj_once(&lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__8, &lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__8_once, _init_lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__8);
v___x_325_ = ((lean_object*)(lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__9));
v___x_326_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_326_, 0, v___x_325_);
lean_ctor_set(v___x_326_, 1, v___x_323_);
v___x_327_ = ((lean_object*)(lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__10));
v___x_328_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_328_, 0, v___x_326_);
lean_ctor_set(v___x_328_, 1, v___x_327_);
v___x_329_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_329_, 0, v___x_324_);
lean_ctor_set(v___x_329_, 1, v___x_328_);
v___x_330_ = 0;
v___x_331_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_331_, 0, v___x_329_);
lean_ctor_set_uint8(v___x_331_, sizeof(void*)*1, v___x_330_);
return v___x_331_;
}
}
}
static lean_object* _init_lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg___closed__2(void){
_start:
{
lean_object* v___x_339_; lean_object* v___x_340_; 
v___x_339_ = ((lean_object*)(lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg___closed__0));
v___x_340_ = lean_string_length(v___x_339_);
return v___x_340_;
}
}
static lean_object* _init_lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg___closed__3(void){
_start:
{
lean_object* v___x_341_; lean_object* v___x_342_; 
v___x_341_ = lean_obj_once(&lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg___closed__2, &lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg___closed__2_once, _init_lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg___closed__2);
v___x_342_ = lean_nat_to_int(v___x_341_);
return v___x_342_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg(lean_object* v_x_348_){
_start:
{
lean_object* v_fst_349_; lean_object* v_snd_350_; lean_object* v___x_352_; uint8_t v_isShared_353_; uint8_t v_isSharedCheck_374_; 
v_fst_349_ = lean_ctor_get(v_x_348_, 0);
v_snd_350_ = lean_ctor_get(v_x_348_, 1);
v_isSharedCheck_374_ = !lean_is_exclusive(v_x_348_);
if (v_isSharedCheck_374_ == 0)
{
v___x_352_ = v_x_348_;
v_isShared_353_ = v_isSharedCheck_374_;
goto v_resetjp_351_;
}
else
{
lean_inc(v_snd_350_);
lean_inc(v_fst_349_);
lean_dec(v_x_348_);
v___x_352_ = lean_box(0);
v_isShared_353_ = v_isSharedCheck_374_;
goto v_resetjp_351_;
}
v_resetjp_351_:
{
lean_object* v___x_354_; lean_object* v___x_355_; lean_object* v___x_356_; lean_object* v___x_358_; 
v___x_354_ = l_String_quote(v_fst_349_);
v___x_355_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_355_, 0, v___x_354_);
v___x_356_ = lean_box(0);
if (v_isShared_353_ == 0)
{
lean_ctor_set_tag(v___x_352_, 1);
lean_ctor_set(v___x_352_, 1, v___x_356_);
lean_ctor_set(v___x_352_, 0, v___x_355_);
v___x_358_ = v___x_352_;
goto v_reusejp_357_;
}
else
{
lean_object* v_reuseFailAlloc_373_; 
v_reuseFailAlloc_373_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v_reuseFailAlloc_373_, 0, v___x_355_);
lean_ctor_set(v_reuseFailAlloc_373_, 1, v___x_356_);
v___x_358_ = v_reuseFailAlloc_373_;
goto v_reusejp_357_;
}
v_reusejp_357_:
{
lean_object* v___x_359_; lean_object* v___x_360_; lean_object* v___x_361_; lean_object* v___x_362_; lean_object* v___x_363_; lean_object* v___x_364_; lean_object* v___x_365_; lean_object* v___x_366_; lean_object* v___x_367_; lean_object* v___x_368_; lean_object* v___x_369_; lean_object* v___x_370_; uint8_t v___x_371_; lean_object* v___x_372_; 
v___x_359_ = lean_unsigned_to_nat(0u);
v___x_360_ = lp_sft__v4_SFT_Host_Canonical_instReprValue_repr(v_snd_350_, v___x_359_);
v___x_361_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_361_, 0, v___x_360_);
lean_ctor_set(v___x_361_, 1, v___x_358_);
v___x_362_ = l_List_reverse___redArg(v___x_361_);
v___x_363_ = ((lean_object*)(lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__5));
v___x_364_ = l_Std_Format_joinSep___at___00Lean_Syntax_formatStxAux_spec__2(v___x_362_, v___x_363_);
v___x_365_ = lean_obj_once(&lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg___closed__3, &lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg___closed__3_once, _init_lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg___closed__3);
v___x_366_ = ((lean_object*)(lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg___closed__4));
v___x_367_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_367_, 0, v___x_366_);
lean_ctor_set(v___x_367_, 1, v___x_364_);
v___x_368_ = ((lean_object*)(lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg___closed__5));
v___x_369_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_369_, 0, v___x_367_);
lean_ctor_set(v___x_369_, 1, v___x_368_);
v___x_370_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_370_, 0, v___x_365_);
lean_ctor_set(v___x_370_, 1, v___x_369_);
v___x_371_ = 0;
v___x_372_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_372_, 0, v___x_370_);
lean_ctor_set_uint8(v___x_372_, sizeof(void*)*1, v___x_371_);
return v___x_372_;
}
}
}
}
LEAN_EXPORT lean_object* lp_sft__v4_List_foldl___at___00List_foldl___at___00Std_Format_joinSep___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__3_spec__5_spec__7(lean_object* v_x_375_, lean_object* v_x_376_, lean_object* v_x_377_){
_start:
{
if (lean_obj_tag(v_x_377_) == 0)
{
lean_dec(v_x_375_);
return v_x_376_;
}
else
{
lean_object* v_head_378_; lean_object* v_tail_379_; lean_object* v___x_381_; uint8_t v_isShared_382_; uint8_t v_isSharedCheck_389_; 
v_head_378_ = lean_ctor_get(v_x_377_, 0);
v_tail_379_ = lean_ctor_get(v_x_377_, 1);
v_isSharedCheck_389_ = !lean_is_exclusive(v_x_377_);
if (v_isSharedCheck_389_ == 0)
{
v___x_381_ = v_x_377_;
v_isShared_382_ = v_isSharedCheck_389_;
goto v_resetjp_380_;
}
else
{
lean_inc(v_tail_379_);
lean_inc(v_head_378_);
lean_dec(v_x_377_);
v___x_381_ = lean_box(0);
v_isShared_382_ = v_isSharedCheck_389_;
goto v_resetjp_380_;
}
v_resetjp_380_:
{
lean_object* v___x_384_; 
lean_inc(v_x_375_);
if (v_isShared_382_ == 0)
{
lean_ctor_set_tag(v___x_381_, 5);
lean_ctor_set(v___x_381_, 1, v_x_375_);
lean_ctor_set(v___x_381_, 0, v_x_376_);
v___x_384_ = v___x_381_;
goto v_reusejp_383_;
}
else
{
lean_object* v_reuseFailAlloc_388_; 
v_reuseFailAlloc_388_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v_reuseFailAlloc_388_, 0, v_x_376_);
lean_ctor_set(v_reuseFailAlloc_388_, 1, v_x_375_);
v___x_384_ = v_reuseFailAlloc_388_;
goto v_reusejp_383_;
}
v_reusejp_383_:
{
lean_object* v___x_385_; lean_object* v___x_386_; 
v___x_385_ = lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg(v_head_378_);
v___x_386_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_386_, 0, v___x_384_);
lean_ctor_set(v___x_386_, 1, v___x_385_);
v_x_376_ = v___x_386_;
v_x_377_ = v_tail_379_;
goto _start;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_sft__v4_List_foldl___at___00Std_Format_joinSep___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__3_spec__5(lean_object* v_x_390_, lean_object* v_x_391_, lean_object* v_x_392_){
_start:
{
if (lean_obj_tag(v_x_392_) == 0)
{
lean_dec(v_x_390_);
return v_x_391_;
}
else
{
lean_object* v_head_393_; lean_object* v_tail_394_; lean_object* v___x_396_; uint8_t v_isShared_397_; uint8_t v_isSharedCheck_404_; 
v_head_393_ = lean_ctor_get(v_x_392_, 0);
v_tail_394_ = lean_ctor_get(v_x_392_, 1);
v_isSharedCheck_404_ = !lean_is_exclusive(v_x_392_);
if (v_isSharedCheck_404_ == 0)
{
v___x_396_ = v_x_392_;
v_isShared_397_ = v_isSharedCheck_404_;
goto v_resetjp_395_;
}
else
{
lean_inc(v_tail_394_);
lean_inc(v_head_393_);
lean_dec(v_x_392_);
v___x_396_ = lean_box(0);
v_isShared_397_ = v_isSharedCheck_404_;
goto v_resetjp_395_;
}
v_resetjp_395_:
{
lean_object* v___x_399_; 
lean_inc(v_x_390_);
if (v_isShared_397_ == 0)
{
lean_ctor_set_tag(v___x_396_, 5);
lean_ctor_set(v___x_396_, 1, v_x_390_);
lean_ctor_set(v___x_396_, 0, v_x_391_);
v___x_399_ = v___x_396_;
goto v_reusejp_398_;
}
else
{
lean_object* v_reuseFailAlloc_403_; 
v_reuseFailAlloc_403_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v_reuseFailAlloc_403_, 0, v_x_391_);
lean_ctor_set(v_reuseFailAlloc_403_, 1, v_x_390_);
v___x_399_ = v_reuseFailAlloc_403_;
goto v_reusejp_398_;
}
v_reusejp_398_:
{
lean_object* v___x_400_; lean_object* v___x_401_; lean_object* v___x_402_; 
v___x_400_ = lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg(v_head_393_);
v___x_401_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_401_, 0, v___x_399_);
lean_ctor_set(v___x_401_, 1, v___x_400_);
v___x_402_ = lp_sft__v4_List_foldl___at___00List_foldl___at___00Std_Format_joinSep___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__3_spec__5_spec__7(v_x_390_, v___x_401_, v_tail_394_);
return v___x_402_;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_sft__v4_Std_Format_joinSep___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__3(lean_object* v_x_405_, lean_object* v_x_406_){
_start:
{
if (lean_obj_tag(v_x_405_) == 0)
{
lean_object* v___x_407_; 
lean_dec(v_x_406_);
v___x_407_ = lean_box(0);
return v___x_407_;
}
else
{
lean_object* v_tail_408_; 
v_tail_408_ = lean_ctor_get(v_x_405_, 1);
if (lean_obj_tag(v_tail_408_) == 0)
{
lean_object* v_head_409_; lean_object* v___x_410_; 
lean_dec(v_x_406_);
v_head_409_ = lean_ctor_get(v_x_405_, 0);
lean_inc(v_head_409_);
lean_dec_ref_known(v_x_405_, 2);
v___x_410_ = lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg(v_head_409_);
return v___x_410_;
}
else
{
lean_object* v_head_411_; lean_object* v___x_412_; lean_object* v___x_413_; 
lean_inc(v_tail_408_);
v_head_411_ = lean_ctor_get(v_x_405_, 0);
lean_inc(v_head_411_);
lean_dec_ref_known(v_x_405_, 2);
v___x_412_ = lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg(v_head_411_);
v___x_413_ = lp_sft__v4_List_foldl___at___00Std_Format_joinSep___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__3_spec__5(v_x_406_, v___x_412_, v_tail_408_);
return v___x_413_;
}
}
}
}
LEAN_EXPORT lean_object* lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1___redArg(lean_object* v_a_414_){
_start:
{
if (lean_obj_tag(v_a_414_) == 0)
{
lean_object* v___x_415_; 
v___x_415_ = ((lean_object*)(lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__1));
return v___x_415_;
}
else
{
lean_object* v___x_416_; lean_object* v___x_417_; lean_object* v___x_418_; lean_object* v___x_419_; lean_object* v___x_420_; lean_object* v___x_421_; lean_object* v___x_422_; lean_object* v___x_423_; uint8_t v___x_424_; lean_object* v___x_425_; 
v___x_416_ = ((lean_object*)(lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__5));
v___x_417_ = lp_sft__v4_Std_Format_joinSep___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__3(v_a_414_, v___x_416_);
v___x_418_ = lean_obj_once(&lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__8, &lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__8_once, _init_lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__8);
v___x_419_ = ((lean_object*)(lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__9));
v___x_420_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_420_, 0, v___x_419_);
lean_ctor_set(v___x_420_, 1, v___x_417_);
v___x_421_ = ((lean_object*)(lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__10));
v___x_422_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_422_, 0, v___x_420_);
lean_ctor_set(v___x_422_, 1, v___x_421_);
v___x_423_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_423_, 0, v___x_418_);
lean_ctor_set(v___x_423_, 1, v___x_422_);
v___x_424_ = 0;
v___x_425_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_425_, 0, v___x_423_);
lean_ctor_set_uint8(v___x_425_, sizeof(void*)*1, v___x_424_);
return v___x_425_;
}
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_instReprValue_repr(lean_object* v_x_426_, lean_object* v_prec_427_){
_start:
{
lean_object* v___y_429_; lean_object* v___y_430_; lean_object* v___y_431_; lean_object* v___y_438_; 
switch(lean_obj_tag(v_x_426_))
{
case 0:
{
lean_object* v_a_444_; lean_object* v___x_446_; uint8_t v_isShared_447_; uint8_t v_isSharedCheck_464_; 
v_a_444_ = lean_ctor_get(v_x_426_, 0);
v_isSharedCheck_464_ = !lean_is_exclusive(v_x_426_);
if (v_isSharedCheck_464_ == 0)
{
v___x_446_ = v_x_426_;
v_isShared_447_ = v_isSharedCheck_464_;
goto v_resetjp_445_;
}
else
{
lean_inc(v_a_444_);
lean_dec(v_x_426_);
v___x_446_ = lean_box(0);
v_isShared_447_ = v_isSharedCheck_464_;
goto v_resetjp_445_;
}
v_resetjp_445_:
{
lean_object* v___y_449_; lean_object* v___x_460_; uint8_t v___x_461_; 
v___x_460_ = lean_unsigned_to_nat(1024u);
v___x_461_ = lean_nat_dec_le(v___x_460_, v_prec_427_);
if (v___x_461_ == 0)
{
lean_object* v___x_462_; 
v___x_462_ = lean_obj_once(&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__5, &lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__5_once, _init_lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__5);
v___y_449_ = v___x_462_;
goto v___jp_448_;
}
else
{
lean_object* v___x_463_; 
v___x_463_ = lean_obj_once(&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__6, &lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__6_once, _init_lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__6);
v___y_449_ = v___x_463_;
goto v___jp_448_;
}
v___jp_448_:
{
lean_object* v___x_450_; lean_object* v___x_451_; lean_object* v___x_453_; 
v___x_450_ = ((lean_object*)(lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__4));
v___x_451_ = l_String_quote(v_a_444_);
if (v_isShared_447_ == 0)
{
lean_ctor_set_tag(v___x_446_, 3);
lean_ctor_set(v___x_446_, 0, v___x_451_);
v___x_453_ = v___x_446_;
goto v_reusejp_452_;
}
else
{
lean_object* v_reuseFailAlloc_459_; 
v_reuseFailAlloc_459_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v_reuseFailAlloc_459_, 0, v___x_451_);
v___x_453_ = v_reuseFailAlloc_459_;
goto v_reusejp_452_;
}
v_reusejp_452_:
{
lean_object* v___x_454_; lean_object* v___x_455_; uint8_t v___x_456_; lean_object* v___x_457_; lean_object* v___x_458_; 
v___x_454_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_454_, 0, v___x_450_);
lean_ctor_set(v___x_454_, 1, v___x_453_);
lean_inc(v___y_449_);
v___x_455_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_455_, 0, v___y_449_);
lean_ctor_set(v___x_455_, 1, v___x_454_);
v___x_456_ = 0;
v___x_457_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_457_, 0, v___x_455_);
lean_ctor_set_uint8(v___x_457_, sizeof(void*)*1, v___x_456_);
v___x_458_ = l_Repr_addAppParen(v___x_457_, v_prec_427_);
return v___x_458_;
}
}
}
}
case 1:
{
uint8_t v_a_465_; lean_object* v___y_467_; lean_object* v___x_475_; uint8_t v___x_476_; 
v_a_465_ = lean_ctor_get_uint8(v_x_426_, 0);
lean_dec_ref_known(v_x_426_, 0);
v___x_475_ = lean_unsigned_to_nat(1024u);
v___x_476_ = lean_nat_dec_le(v___x_475_, v_prec_427_);
if (v___x_476_ == 0)
{
lean_object* v___x_477_; 
v___x_477_ = lean_obj_once(&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__5, &lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__5_once, _init_lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__5);
v___y_467_ = v___x_477_;
goto v___jp_466_;
}
else
{
lean_object* v___x_478_; 
v___x_478_ = lean_obj_once(&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__6, &lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__6_once, _init_lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__6);
v___y_467_ = v___x_478_;
goto v___jp_466_;
}
v___jp_466_:
{
lean_object* v___x_468_; lean_object* v___x_469_; lean_object* v___x_470_; lean_object* v___x_471_; uint8_t v___x_472_; lean_object* v___x_473_; lean_object* v___x_474_; 
v___x_468_ = ((lean_object*)(lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__9));
v___x_469_ = l_Bool_repr___redArg(v_a_465_);
v___x_470_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_470_, 0, v___x_468_);
lean_ctor_set(v___x_470_, 1, v___x_469_);
lean_inc(v___y_467_);
v___x_471_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_471_, 0, v___y_467_);
lean_ctor_set(v___x_471_, 1, v___x_470_);
v___x_472_ = 0;
v___x_473_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_473_, 0, v___x_471_);
lean_ctor_set_uint8(v___x_473_, sizeof(void*)*1, v___x_472_);
v___x_474_ = l_Repr_addAppParen(v___x_473_, v_prec_427_);
return v___x_474_;
}
}
case 2:
{
lean_object* v_a_479_; lean_object* v___x_481_; uint8_t v_isShared_482_; uint8_t v_isSharedCheck_502_; 
v_a_479_ = lean_ctor_get(v_x_426_, 0);
v_isSharedCheck_502_ = !lean_is_exclusive(v_x_426_);
if (v_isSharedCheck_502_ == 0)
{
v___x_481_ = v_x_426_;
v_isShared_482_ = v_isSharedCheck_502_;
goto v_resetjp_480_;
}
else
{
lean_inc(v_a_479_);
lean_dec(v_x_426_);
v___x_481_ = lean_box(0);
v_isShared_482_ = v_isSharedCheck_502_;
goto v_resetjp_480_;
}
v_resetjp_480_:
{
lean_object* v___y_484_; lean_object* v___x_498_; uint8_t v___x_499_; 
v___x_498_ = lean_unsigned_to_nat(1024u);
v___x_499_ = lean_nat_dec_le(v___x_498_, v_prec_427_);
if (v___x_499_ == 0)
{
lean_object* v___x_500_; 
v___x_500_ = lean_obj_once(&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__5, &lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__5_once, _init_lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__5);
v___y_484_ = v___x_500_;
goto v___jp_483_;
}
else
{
lean_object* v___x_501_; 
v___x_501_ = lean_obj_once(&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__6, &lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__6_once, _init_lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__6);
v___y_484_ = v___x_501_;
goto v___jp_483_;
}
v___jp_483_:
{
lean_object* v___x_485_; lean_object* v___x_486_; uint8_t v___x_487_; 
v___x_485_ = ((lean_object*)(lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__12));
v___x_486_ = lean_obj_once(&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__13, &lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__13_once, _init_lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__13);
v___x_487_ = lean_int_dec_lt(v_a_479_, v___x_486_);
if (v___x_487_ == 0)
{
lean_object* v___x_488_; lean_object* v___x_490_; 
v___x_488_ = l_Int_repr(v_a_479_);
lean_dec(v_a_479_);
if (v_isShared_482_ == 0)
{
lean_ctor_set_tag(v___x_481_, 3);
lean_ctor_set(v___x_481_, 0, v___x_488_);
v___x_490_ = v___x_481_;
goto v_reusejp_489_;
}
else
{
lean_object* v_reuseFailAlloc_491_; 
v_reuseFailAlloc_491_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v_reuseFailAlloc_491_, 0, v___x_488_);
v___x_490_ = v_reuseFailAlloc_491_;
goto v_reusejp_489_;
}
v_reusejp_489_:
{
v___y_429_ = v___y_484_;
v___y_430_ = v___x_485_;
v___y_431_ = v___x_490_;
goto v___jp_428_;
}
}
else
{
lean_object* v___x_492_; lean_object* v___x_493_; lean_object* v___x_495_; 
v___x_492_ = lean_unsigned_to_nat(1024u);
v___x_493_ = l_Int_repr(v_a_479_);
lean_dec(v_a_479_);
if (v_isShared_482_ == 0)
{
lean_ctor_set_tag(v___x_481_, 3);
lean_ctor_set(v___x_481_, 0, v___x_493_);
v___x_495_ = v___x_481_;
goto v_reusejp_494_;
}
else
{
lean_object* v_reuseFailAlloc_497_; 
v_reuseFailAlloc_497_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v_reuseFailAlloc_497_, 0, v___x_493_);
v___x_495_ = v_reuseFailAlloc_497_;
goto v_reusejp_494_;
}
v_reusejp_494_:
{
lean_object* v___x_496_; 
v___x_496_ = l_Repr_addAppParen(v___x_495_, v___x_492_);
v___y_429_ = v___y_484_;
v___y_430_ = v___x_485_;
v___y_431_ = v___x_496_;
goto v___jp_428_;
}
}
}
}
}
case 3:
{
lean_object* v___x_503_; uint8_t v___x_504_; 
v___x_503_ = lean_unsigned_to_nat(1024u);
v___x_504_ = lean_nat_dec_le(v___x_503_, v_prec_427_);
if (v___x_504_ == 0)
{
lean_object* v___x_505_; 
v___x_505_ = lean_obj_once(&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__5, &lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__5_once, _init_lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__5);
v___y_438_ = v___x_505_;
goto v___jp_437_;
}
else
{
lean_object* v___x_506_; 
v___x_506_ = lean_obj_once(&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__6, &lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__6_once, _init_lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__6);
v___y_438_ = v___x_506_;
goto v___jp_437_;
}
}
case 4:
{
lean_object* v_a_507_; lean_object* v___y_509_; lean_object* v___x_517_; uint8_t v___x_518_; 
v_a_507_ = lean_ctor_get(v_x_426_, 0);
lean_inc(v_a_507_);
lean_dec_ref_known(v_x_426_, 1);
v___x_517_ = lean_unsigned_to_nat(1024u);
v___x_518_ = lean_nat_dec_le(v___x_517_, v_prec_427_);
if (v___x_518_ == 0)
{
lean_object* v___x_519_; 
v___x_519_ = lean_obj_once(&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__5, &lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__5_once, _init_lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__5);
v___y_509_ = v___x_519_;
goto v___jp_508_;
}
else
{
lean_object* v___x_520_; 
v___x_520_ = lean_obj_once(&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__6, &lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__6_once, _init_lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__6);
v___y_509_ = v___x_520_;
goto v___jp_508_;
}
v___jp_508_:
{
lean_object* v___x_510_; lean_object* v___x_511_; lean_object* v___x_512_; lean_object* v___x_513_; uint8_t v___x_514_; lean_object* v___x_515_; lean_object* v___x_516_; 
v___x_510_ = ((lean_object*)(lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__16));
v___x_511_ = lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg(v_a_507_);
v___x_512_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_512_, 0, v___x_510_);
lean_ctor_set(v___x_512_, 1, v___x_511_);
lean_inc(v___y_509_);
v___x_513_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_513_, 0, v___y_509_);
lean_ctor_set(v___x_513_, 1, v___x_512_);
v___x_514_ = 0;
v___x_515_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_515_, 0, v___x_513_);
lean_ctor_set_uint8(v___x_515_, sizeof(void*)*1, v___x_514_);
v___x_516_ = l_Repr_addAppParen(v___x_515_, v_prec_427_);
return v___x_516_;
}
}
default: 
{
lean_object* v_a_521_; lean_object* v___y_523_; lean_object* v___x_531_; uint8_t v___x_532_; 
v_a_521_ = lean_ctor_get(v_x_426_, 0);
lean_inc(v_a_521_);
lean_dec_ref_known(v_x_426_, 1);
v___x_531_ = lean_unsigned_to_nat(1024u);
v___x_532_ = lean_nat_dec_le(v___x_531_, v_prec_427_);
if (v___x_532_ == 0)
{
lean_object* v___x_533_; 
v___x_533_ = lean_obj_once(&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__5, &lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__5_once, _init_lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__5);
v___y_523_ = v___x_533_;
goto v___jp_522_;
}
else
{
lean_object* v___x_534_; 
v___x_534_ = lean_obj_once(&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__6, &lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__6_once, _init_lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__6);
v___y_523_ = v___x_534_;
goto v___jp_522_;
}
v___jp_522_:
{
lean_object* v___x_524_; lean_object* v___x_525_; lean_object* v___x_526_; lean_object* v___x_527_; uint8_t v___x_528_; lean_object* v___x_529_; lean_object* v___x_530_; 
v___x_524_ = ((lean_object*)(lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__19));
v___x_525_ = lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1___redArg(v_a_521_);
v___x_526_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_526_, 0, v___x_524_);
lean_ctor_set(v___x_526_, 1, v___x_525_);
lean_inc(v___y_523_);
v___x_527_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_527_, 0, v___y_523_);
lean_ctor_set(v___x_527_, 1, v___x_526_);
v___x_528_ = 0;
v___x_529_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_529_, 0, v___x_527_);
lean_ctor_set_uint8(v___x_529_, sizeof(void*)*1, v___x_528_);
v___x_530_ = l_Repr_addAppParen(v___x_529_, v_prec_427_);
return v___x_530_;
}
}
}
v___jp_428_:
{
lean_object* v___x_432_; lean_object* v___x_433_; uint8_t v___x_434_; lean_object* v___x_435_; lean_object* v___x_436_; 
lean_inc(v___y_430_);
v___x_432_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_432_, 0, v___y_430_);
lean_ctor_set(v___x_432_, 1, v___y_431_);
lean_inc(v___y_429_);
v___x_433_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_433_, 0, v___y_429_);
lean_ctor_set(v___x_433_, 1, v___x_432_);
v___x_434_ = 0;
v___x_435_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_435_, 0, v___x_433_);
lean_ctor_set_uint8(v___x_435_, sizeof(void*)*1, v___x_434_);
v___x_436_ = l_Repr_addAppParen(v___x_435_, v_prec_427_);
return v___x_436_;
}
v___jp_437_:
{
lean_object* v___x_439_; lean_object* v___x_440_; uint8_t v___x_441_; lean_object* v___x_442_; lean_object* v___x_443_; 
v___x_439_ = ((lean_object*)(lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__1));
lean_inc(v___y_438_);
v___x_440_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_440_, 0, v___y_438_);
lean_ctor_set(v___x_440_, 1, v___x_439_);
v___x_441_ = 0;
v___x_442_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_442_, 0, v___x_440_);
lean_ctor_set_uint8(v___x_442_, sizeof(void*)*1, v___x_441_);
v___x_443_ = l_Repr_addAppParen(v___x_442_, v_prec_427_);
return v___x_443_;
}
}
}
LEAN_EXPORT lean_object* lp_sft__v4_Std_Format_joinSep___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0_spec__0___lam__0(lean_object* v___y_535_){
_start:
{
lean_object* v___x_536_; lean_object* v___x_537_; 
v___x_536_ = lean_unsigned_to_nat(0u);
v___x_537_ = lp_sft__v4_SFT_Host_Canonical_instReprValue_repr(v___y_535_, v___x_536_);
return v___x_537_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___boxed(lean_object* v_x_538_, lean_object* v_prec_539_){
_start:
{
lean_object* v_res_540_; 
v_res_540_ = lp_sft__v4_SFT_Host_Canonical_instReprValue_repr(v_x_538_, v_prec_539_);
lean_dec(v_prec_539_);
return v_res_540_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0(lean_object* v_a_541_, lean_object* v_n_542_){
_start:
{
lean_object* v___x_543_; 
v___x_543_ = lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg(v_a_541_);
return v___x_543_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___boxed(lean_object* v_a_544_, lean_object* v_n_545_){
_start:
{
lean_object* v_res_546_; 
v_res_546_ = lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0(v_a_544_, v_n_545_);
lean_dec(v_n_545_);
return v_res_546_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1(lean_object* v_a_547_, lean_object* v_n_548_){
_start:
{
lean_object* v___x_549_; 
v___x_549_ = lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1___redArg(v_a_547_);
return v___x_549_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1___boxed(lean_object* v_a_550_, lean_object* v_n_551_){
_start:
{
lean_object* v_res_552_; 
v_res_552_ = lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1(v_a_550_, v_n_551_);
lean_dec(v_n_551_);
return v_res_552_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2(lean_object* v_x_553_, lean_object* v_x_554_){
_start:
{
lean_object* v___x_555_; 
v___x_555_ = lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___redArg(v_x_553_);
return v___x_555_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2___boxed(lean_object* v_x_556_, lean_object* v_x_557_){
_start:
{
lean_object* v_res_558_; 
v_res_558_ = lp_sft__v4_Prod_repr___at___00List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__1_spec__2(v_x_556_, v_x_557_);
lean_dec(v_x_557_);
return v_res_558_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_List_mapTR_loop___at___00SFT_Host_Canonical_hex4_spec__0(lean_object* v_n_561_, lean_object* v_a_562_, lean_object* v_a_563_){
_start:
{
if (lean_obj_tag(v_a_562_) == 0)
{
lean_object* v___x_564_; 
v___x_564_ = l_List_reverse___redArg(v_a_563_);
return v___x_564_;
}
else
{
lean_object* v_head_565_; lean_object* v_tail_566_; lean_object* v___x_568_; uint8_t v_isShared_569_; uint8_t v_isSharedCheck_585_; 
v_head_565_ = lean_ctor_get(v_a_562_, 0);
v_tail_566_ = lean_ctor_get(v_a_562_, 1);
v_isSharedCheck_585_ = !lean_is_exclusive(v_a_562_);
if (v_isSharedCheck_585_ == 0)
{
v___x_568_ = v_a_562_;
v_isShared_569_ = v_isSharedCheck_585_;
goto v_resetjp_567_;
}
else
{
lean_inc(v_tail_566_);
lean_inc(v_head_565_);
lean_dec(v_a_562_);
v___x_568_ = lean_box(0);
v_isShared_569_ = v_isSharedCheck_585_;
goto v_resetjp_567_;
}
v_resetjp_567_:
{
lean_object* v___x_570_; lean_object* v___x_571_; lean_object* v___x_572_; lean_object* v___x_573_; lean_object* v___x_574_; lean_object* v___x_575_; lean_object* v___x_576_; lean_object* v___x_577_; lean_object* v___x_578_; uint32_t v___x_579_; lean_object* v___x_580_; lean_object* v___x_582_; 
v___x_570_ = lean_unsigned_to_nat(2u);
v___x_571_ = lean_unsigned_to_nat(4u);
v___x_572_ = lean_unsigned_to_nat(3u);
v___x_573_ = lean_nat_sub(v___x_572_, v_head_565_);
lean_dec(v_head_565_);
v___x_574_ = lean_nat_mul(v___x_571_, v___x_573_);
lean_dec(v___x_573_);
v___x_575_ = lean_nat_pow(v___x_570_, v___x_574_);
lean_dec(v___x_574_);
v___x_576_ = lean_nat_div(v_n_561_, v___x_575_);
lean_dec(v___x_575_);
v___x_577_ = lean_unsigned_to_nat(16u);
v___x_578_ = lean_nat_mod(v___x_576_, v___x_577_);
lean_dec(v___x_576_);
v___x_579_ = lp_sft__v4_SFT_Host_SHA256_hexDigit(v___x_578_);
lean_dec(v___x_578_);
v___x_580_ = lean_box_uint32(v___x_579_);
if (v_isShared_569_ == 0)
{
lean_ctor_set(v___x_568_, 1, v_a_563_);
lean_ctor_set(v___x_568_, 0, v___x_580_);
v___x_582_ = v___x_568_;
goto v_reusejp_581_;
}
else
{
lean_object* v_reuseFailAlloc_584_; 
v_reuseFailAlloc_584_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v_reuseFailAlloc_584_, 0, v___x_580_);
lean_ctor_set(v_reuseFailAlloc_584_, 1, v_a_563_);
v___x_582_ = v_reuseFailAlloc_584_;
goto v_reusejp_581_;
}
v_reusejp_581_:
{
v_a_562_ = v_tail_566_;
v_a_563_ = v___x_582_;
goto _start;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_sft__v4_List_mapTR_loop___at___00SFT_Host_Canonical_hex4_spec__0___boxed(lean_object* v_n_586_, lean_object* v_a_587_, lean_object* v_a_588_){
_start:
{
lean_object* v_res_589_; 
v_res_589_ = lp_sft__v4_List_mapTR_loop___at___00SFT_Host_Canonical_hex4_spec__0(v_n_586_, v_a_587_, v_a_588_);
lean_dec(v_n_586_);
return v_res_589_;
}
}
static lean_object* _init_lp_sft__v4_SFT_Host_Canonical_hex4___closed__0(void){
_start:
{
lean_object* v___x_590_; lean_object* v___x_591_; 
v___x_590_ = lean_unsigned_to_nat(4u);
v___x_591_ = l_List_range(v___x_590_);
return v___x_591_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_hex4(lean_object* v_n_592_){
_start:
{
lean_object* v___x_593_; lean_object* v___x_594_; lean_object* v___x_595_; lean_object* v___x_596_; 
v___x_593_ = lean_obj_once(&lp_sft__v4_SFT_Host_Canonical_hex4___closed__0, &lp_sft__v4_SFT_Host_Canonical_hex4___closed__0_once, _init_lp_sft__v4_SFT_Host_Canonical_hex4___closed__0);
v___x_594_ = lean_box(0);
v___x_595_ = lp_sft__v4_List_mapTR_loop___at___00SFT_Host_Canonical_hex4_spec__0(v_n_592_, v___x_593_, v___x_594_);
v___x_596_ = lean_string_mk(v___x_595_);
return v___x_596_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_hex4___boxed(lean_object* v_n_597_){
_start:
{
lean_object* v_res_598_; 
v_res_598_ = lp_sft__v4_SFT_Host_Canonical_hex4(v_n_597_);
lean_dec(v_n_597_);
return v_res_598_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_escapeChar(uint32_t v_c_607_){
_start:
{
lean_object* v_n_608_; lean_object* v___x_630_; uint8_t v___x_631_; 
v_n_608_ = lean_uint32_to_nat(v_c_607_);
v___x_630_ = lean_unsigned_to_nat(34u);
v___x_631_ = lean_nat_dec_eq(v_n_608_, v___x_630_);
if (v___x_631_ == 0)
{
lean_object* v___x_632_; uint8_t v___x_633_; 
v___x_632_ = lean_unsigned_to_nat(92u);
v___x_633_ = lean_nat_dec_eq(v_n_608_, v___x_632_);
if (v___x_633_ == 0)
{
lean_object* v___x_634_; uint8_t v___x_635_; 
v___x_634_ = lean_unsigned_to_nat(8u);
v___x_635_ = lean_nat_dec_eq(v_n_608_, v___x_634_);
if (v___x_635_ == 0)
{
lean_object* v___x_636_; uint8_t v___x_637_; 
v___x_636_ = lean_unsigned_to_nat(9u);
v___x_637_ = lean_nat_dec_eq(v_n_608_, v___x_636_);
if (v___x_637_ == 0)
{
lean_object* v___x_638_; uint8_t v___x_639_; 
v___x_638_ = lean_unsigned_to_nat(10u);
v___x_639_ = lean_nat_dec_eq(v_n_608_, v___x_638_);
if (v___x_639_ == 0)
{
lean_object* v___x_640_; uint8_t v___x_641_; 
v___x_640_ = lean_unsigned_to_nat(12u);
v___x_641_ = lean_nat_dec_eq(v_n_608_, v___x_640_);
if (v___x_641_ == 0)
{
lean_object* v___x_642_; uint8_t v___x_643_; 
v___x_642_ = lean_unsigned_to_nat(13u);
v___x_643_ = lean_nat_dec_eq(v_n_608_, v___x_642_);
if (v___x_643_ == 0)
{
lean_object* v___x_644_; uint8_t v___x_645_; 
v___x_644_ = lean_unsigned_to_nat(32u);
v___x_645_ = lean_nat_dec_lt(v_n_608_, v___x_644_);
if (v___x_645_ == 0)
{
lean_object* v___x_646_; uint8_t v___x_647_; 
v___x_646_ = lean_unsigned_to_nat(126u);
v___x_647_ = lean_nat_dec_lt(v___x_646_, v_n_608_);
if (v___x_647_ == 0)
{
lean_object* v___x_648_; lean_object* v___x_649_; lean_object* v___x_650_; lean_object* v___x_651_; 
lean_dec(v_n_608_);
v___x_648_ = lean_box(0);
v___x_649_ = lean_box_uint32(v_c_607_);
v___x_650_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_650_, 0, v___x_649_);
lean_ctor_set(v___x_650_, 1, v___x_648_);
v___x_651_ = lean_string_mk(v___x_650_);
return v___x_651_;
}
else
{
goto v___jp_609_;
}
}
else
{
goto v___jp_609_;
}
}
else
{
lean_object* v___x_652_; 
lean_dec(v_n_608_);
v___x_652_ = ((lean_object*)(lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__1));
return v___x_652_;
}
}
else
{
lean_object* v___x_653_; 
lean_dec(v_n_608_);
v___x_653_ = ((lean_object*)(lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__2));
return v___x_653_;
}
}
else
{
lean_object* v___x_654_; 
lean_dec(v_n_608_);
v___x_654_ = ((lean_object*)(lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__3));
return v___x_654_;
}
}
else
{
lean_object* v___x_655_; 
lean_dec(v_n_608_);
v___x_655_ = ((lean_object*)(lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__4));
return v___x_655_;
}
}
else
{
lean_object* v___x_656_; 
lean_dec(v_n_608_);
v___x_656_ = ((lean_object*)(lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__5));
return v___x_656_;
}
}
else
{
lean_object* v___x_657_; 
lean_dec(v_n_608_);
v___x_657_ = ((lean_object*)(lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__6));
return v___x_657_;
}
}
else
{
lean_object* v___x_658_; 
lean_dec(v_n_608_);
v___x_658_ = ((lean_object*)(lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__7));
return v___x_658_;
}
v___jp_609_:
{
lean_object* v___x_610_; uint8_t v___x_611_; 
v___x_610_ = lean_unsigned_to_nat(65536u);
v___x_611_ = lean_nat_dec_lt(v_n_608_, v___x_610_);
if (v___x_611_ == 0)
{
lean_object* v___x_612_; lean_object* v___x_613_; lean_object* v___x_614_; lean_object* v___x_615_; lean_object* v___x_616_; lean_object* v___x_617_; lean_object* v___x_618_; lean_object* v___x_619_; lean_object* v___x_620_; lean_object* v___x_621_; lean_object* v___x_622_; lean_object* v___x_623_; lean_object* v___x_624_; lean_object* v___x_625_; lean_object* v___x_626_; 
v___x_612_ = ((lean_object*)(lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__0));
v___x_613_ = lean_unsigned_to_nat(55296u);
v___x_614_ = lean_nat_sub(v_n_608_, v___x_610_);
lean_dec(v_n_608_);
v___x_615_ = lean_unsigned_to_nat(1024u);
v___x_616_ = lean_unsigned_to_nat(10u);
v___x_617_ = lean_nat_shiftr(v___x_614_, v___x_616_);
v___x_618_ = lean_nat_add(v___x_613_, v___x_617_);
lean_dec(v___x_617_);
v___x_619_ = lp_sft__v4_SFT_Host_Canonical_hex4(v___x_618_);
lean_dec(v___x_618_);
v___x_620_ = lean_unsigned_to_nat(56320u);
v___x_621_ = lean_nat_mod(v___x_614_, v___x_615_);
lean_dec(v___x_614_);
v___x_622_ = lean_nat_add(v___x_620_, v___x_621_);
lean_dec(v___x_621_);
v___x_623_ = lp_sft__v4_SFT_Host_Canonical_hex4(v___x_622_);
lean_dec(v___x_622_);
v___x_624_ = lp_sft__v4_SFT_Host_Text_append(v___x_612_, v___x_623_);
lean_dec_ref(v___x_623_);
v___x_625_ = lp_sft__v4_SFT_Host_Text_append(v___x_619_, v___x_624_);
lean_dec_ref(v___x_624_);
lean_dec_ref(v___x_619_);
v___x_626_ = lp_sft__v4_SFT_Host_Text_append(v___x_612_, v___x_625_);
lean_dec_ref(v___x_625_);
return v___x_626_;
}
else
{
lean_object* v___x_627_; lean_object* v___x_628_; lean_object* v___x_629_; 
v___x_627_ = ((lean_object*)(lp_sft__v4_SFT_Host_Canonical_escapeChar___closed__0));
v___x_628_ = lp_sft__v4_SFT_Host_Canonical_hex4(v_n_608_);
lean_dec(v_n_608_);
v___x_629_ = lp_sft__v4_SFT_Host_Text_append(v___x_627_, v___x_628_);
lean_dec_ref(v___x_628_);
return v___x_629_;
}
}
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_escapeChar___boxed(lean_object* v_c_659_){
_start:
{
uint32_t v_c_boxed_660_; lean_object* v_res_661_; 
v_c_boxed_660_ = lean_unbox_uint32(v_c_659_);
lean_dec(v_c_659_);
v_res_661_ = lp_sft__v4_SFT_Host_Canonical_escapeChar(v_c_boxed_660_);
return v_res_661_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_List_mapTR_loop___at___00SFT_Host_Canonical_quote_spec__0(lean_object* v_a_662_, lean_object* v_a_663_){
_start:
{
if (lean_obj_tag(v_a_662_) == 0)
{
lean_object* v___x_664_; 
v___x_664_ = l_List_reverse___redArg(v_a_663_);
return v___x_664_;
}
else
{
lean_object* v_head_665_; lean_object* v_tail_666_; lean_object* v___x_668_; uint8_t v_isShared_669_; uint8_t v_isSharedCheck_676_; 
v_head_665_ = lean_ctor_get(v_a_662_, 0);
v_tail_666_ = lean_ctor_get(v_a_662_, 1);
v_isSharedCheck_676_ = !lean_is_exclusive(v_a_662_);
if (v_isSharedCheck_676_ == 0)
{
v___x_668_ = v_a_662_;
v_isShared_669_ = v_isSharedCheck_676_;
goto v_resetjp_667_;
}
else
{
lean_inc(v_tail_666_);
lean_inc(v_head_665_);
lean_dec(v_a_662_);
v___x_668_ = lean_box(0);
v_isShared_669_ = v_isSharedCheck_676_;
goto v_resetjp_667_;
}
v_resetjp_667_:
{
uint32_t v___x_670_; lean_object* v___x_671_; lean_object* v___x_673_; 
v___x_670_ = lean_unbox_uint32(v_head_665_);
lean_dec(v_head_665_);
v___x_671_ = lp_sft__v4_SFT_Host_Canonical_escapeChar(v___x_670_);
if (v_isShared_669_ == 0)
{
lean_ctor_set(v___x_668_, 1, v_a_663_);
lean_ctor_set(v___x_668_, 0, v___x_671_);
v___x_673_ = v___x_668_;
goto v_reusejp_672_;
}
else
{
lean_object* v_reuseFailAlloc_675_; 
v_reuseFailAlloc_675_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v_reuseFailAlloc_675_, 0, v___x_671_);
lean_ctor_set(v_reuseFailAlloc_675_, 1, v_a_663_);
v___x_673_ = v_reuseFailAlloc_675_;
goto v_reusejp_672_;
}
v_reusejp_672_:
{
v_a_662_ = v_tail_666_;
v_a_663_ = v___x_673_;
goto _start;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_quote(lean_object* v_s_678_){
_start:
{
lean_object* v___x_679_; lean_object* v___x_680_; lean_object* v___x_681_; lean_object* v___x_682_; lean_object* v___x_683_; lean_object* v___x_684_; lean_object* v___x_685_; 
v___x_679_ = ((lean_object*)(lp_sft__v4_SFT_Host_Canonical_quote___closed__0));
v___x_680_ = lp_sft__v4_SFT_Host_Text_chars(v_s_678_);
v___x_681_ = lean_box(0);
v___x_682_ = lp_sft__v4_List_mapTR_loop___at___00SFT_Host_Canonical_quote_spec__0(v___x_680_, v___x_681_);
v___x_683_ = lp_sft__v4_SFT_Host_Text_join(v___x_682_);
lean_dec(v___x_682_);
v___x_684_ = lp_sft__v4_SFT_Host_Text_append(v___x_683_, v___x_679_);
lean_dec_ref(v___x_683_);
v___x_685_ = lp_sft__v4_SFT_Host_Text_append(v___x_679_, v___x_684_);
lean_dec_ref(v___x_684_);
return v___x_685_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_quote___boxed(lean_object* v_s_686_){
_start:
{
lean_object* v_res_687_; 
v_res_687_ = lp_sft__v4_SFT_Host_Canonical_quote(v_s_686_);
lean_dec_ref(v_s_686_);
return v_res_687_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_insertField(lean_object* v_v_688_, lean_object* v_x_689_){
_start:
{
if (lean_obj_tag(v_x_689_) == 0)
{
lean_object* v___x_690_; 
v___x_690_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_690_, 0, v_v_688_);
lean_ctor_set(v___x_690_, 1, v_x_689_);
return v___x_690_;
}
else
{
lean_object* v_head_691_; lean_object* v_tail_692_; lean_object* v_fst_693_; lean_object* v_fst_694_; uint8_t v___x_695_; 
v_head_691_ = lean_ctor_get(v_x_689_, 0);
lean_inc(v_head_691_);
v_tail_692_ = lean_ctor_get(v_x_689_, 1);
v_fst_693_ = lean_ctor_get(v_v_688_, 0);
v_fst_694_ = lean_ctor_get(v_head_691_, 0);
v___x_695_ = lp_sft__v4_SFT_Host_Text_le(v_fst_693_, v_fst_694_);
if (v___x_695_ == 0)
{
lean_object* v___x_697_; uint8_t v_isShared_698_; uint8_t v_isSharedCheck_703_; 
lean_inc(v_tail_692_);
v_isSharedCheck_703_ = !lean_is_exclusive(v_x_689_);
if (v_isSharedCheck_703_ == 0)
{
lean_object* v_unused_704_; lean_object* v_unused_705_; 
v_unused_704_ = lean_ctor_get(v_x_689_, 1);
lean_dec(v_unused_704_);
v_unused_705_ = lean_ctor_get(v_x_689_, 0);
lean_dec(v_unused_705_);
v___x_697_ = v_x_689_;
v_isShared_698_ = v_isSharedCheck_703_;
goto v_resetjp_696_;
}
else
{
lean_dec(v_x_689_);
v___x_697_ = lean_box(0);
v_isShared_698_ = v_isSharedCheck_703_;
goto v_resetjp_696_;
}
v_resetjp_696_:
{
lean_object* v___x_699_; lean_object* v___x_701_; 
v___x_699_ = lp_sft__v4_SFT_Host_Canonical_insertField(v_v_688_, v_tail_692_);
if (v_isShared_698_ == 0)
{
lean_ctor_set(v___x_697_, 1, v___x_699_);
v___x_701_ = v___x_697_;
goto v_reusejp_700_;
}
else
{
lean_object* v_reuseFailAlloc_702_; 
v_reuseFailAlloc_702_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v_reuseFailAlloc_702_, 0, v_head_691_);
lean_ctor_set(v_reuseFailAlloc_702_, 1, v___x_699_);
v___x_701_ = v_reuseFailAlloc_702_;
goto v_reusejp_700_;
}
v_reusejp_700_:
{
return v___x_701_;
}
}
}
else
{
lean_object* v___x_707_; uint8_t v_isShared_708_; uint8_t v_isSharedCheck_712_; 
v_isSharedCheck_712_ = !lean_is_exclusive(v_head_691_);
if (v_isSharedCheck_712_ == 0)
{
lean_object* v_unused_713_; lean_object* v_unused_714_; 
v_unused_713_ = lean_ctor_get(v_head_691_, 1);
lean_dec(v_unused_713_);
v_unused_714_ = lean_ctor_get(v_head_691_, 0);
lean_dec(v_unused_714_);
v___x_707_ = v_head_691_;
v_isShared_708_ = v_isSharedCheck_712_;
goto v_resetjp_706_;
}
else
{
lean_dec(v_head_691_);
v___x_707_ = lean_box(0);
v_isShared_708_ = v_isSharedCheck_712_;
goto v_resetjp_706_;
}
v_resetjp_706_:
{
lean_object* v___x_710_; 
if (v_isShared_708_ == 0)
{
lean_ctor_set_tag(v___x_707_, 1);
lean_ctor_set(v___x_707_, 1, v_x_689_);
lean_ctor_set(v___x_707_, 0, v_v_688_);
v___x_710_ = v___x_707_;
goto v_reusejp_709_;
}
else
{
lean_object* v_reuseFailAlloc_711_; 
v_reuseFailAlloc_711_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v_reuseFailAlloc_711_, 0, v_v_688_);
lean_ctor_set(v_reuseFailAlloc_711_, 1, v_x_689_);
v___x_710_ = v_reuseFailAlloc_711_;
goto v_reusejp_709_;
}
v_reusejp_709_:
{
return v___x_710_;
}
}
}
}
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_sortFields(lean_object* v_x_715_){
_start:
{
if (lean_obj_tag(v_x_715_) == 0)
{
return v_x_715_;
}
else
{
lean_object* v_head_716_; lean_object* v_tail_717_; lean_object* v___x_718_; lean_object* v___x_719_; 
v_head_716_ = lean_ctor_get(v_x_715_, 0);
lean_inc(v_head_716_);
v_tail_717_ = lean_ctor_get(v_x_715_, 1);
lean_inc(v_tail_717_);
lean_dec_ref_known(v_x_715_, 2);
v___x_718_ = lp_sft__v4_SFT_Host_Canonical_sortFields(v_tail_717_);
v___x_719_ = lp_sft__v4_SFT_Host_Canonical_insertField(v_head_716_, v___x_718_);
return v___x_719_;
}
}
}
LEAN_EXPORT lean_object* lp_sft__v4_List_mapTR_loop___at___00SFT_Host_Canonical_render_spec__0(lean_object* v_a_720_, lean_object* v_a_721_){
_start:
{
if (lean_obj_tag(v_a_720_) == 0)
{
lean_object* v___x_722_; 
v___x_722_ = l_List_reverse___redArg(v_a_721_);
return v___x_722_;
}
else
{
lean_object* v_head_723_; lean_object* v_tail_724_; lean_object* v___x_726_; uint8_t v_isShared_727_; uint8_t v_isSharedCheck_733_; 
v_head_723_ = lean_ctor_get(v_a_720_, 0);
v_tail_724_ = lean_ctor_get(v_a_720_, 1);
v_isSharedCheck_733_ = !lean_is_exclusive(v_a_720_);
if (v_isSharedCheck_733_ == 0)
{
v___x_726_ = v_a_720_;
v_isShared_727_ = v_isSharedCheck_733_;
goto v_resetjp_725_;
}
else
{
lean_inc(v_tail_724_);
lean_inc(v_head_723_);
lean_dec(v_a_720_);
v___x_726_ = lean_box(0);
v_isShared_727_ = v_isSharedCheck_733_;
goto v_resetjp_725_;
}
v_resetjp_725_:
{
lean_object* v_snd_728_; lean_object* v___x_730_; 
v_snd_728_ = lean_ctor_get(v_head_723_, 1);
lean_inc(v_snd_728_);
lean_dec(v_head_723_);
if (v_isShared_727_ == 0)
{
lean_ctor_set(v___x_726_, 1, v_a_721_);
lean_ctor_set(v___x_726_, 0, v_snd_728_);
v___x_730_ = v___x_726_;
goto v_reusejp_729_;
}
else
{
lean_object* v_reuseFailAlloc_732_; 
v_reuseFailAlloc_732_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v_reuseFailAlloc_732_, 0, v_snd_728_);
lean_ctor_set(v_reuseFailAlloc_732_, 1, v_a_721_);
v___x_730_ = v_reuseFailAlloc_732_;
goto v_reusejp_729_;
}
v_reusejp_729_:
{
v_a_720_ = v_tail_724_;
v_a_721_ = v___x_730_;
goto _start;
}
}
}
}
}
static lean_object* _init_lp_sft__v4_SFT_Host_Canonical_render___boxed__const__1(void){
_start:
{
uint32_t v___x_737_; lean_object* v___x_738_; 
v___x_737_ = 45;
v___x_738_ = lean_box_uint32(v___x_737_);
return v___x_738_;
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_renderValues(lean_object* v_x_739_){
_start:
{
if (lean_obj_tag(v_x_739_) == 0)
{
lean_object* v___x_740_; 
v___x_740_ = lean_box(0);
return v___x_740_;
}
else
{
lean_object* v_head_741_; lean_object* v_tail_742_; lean_object* v___x_744_; uint8_t v_isShared_745_; uint8_t v_isSharedCheck_751_; 
v_head_741_ = lean_ctor_get(v_x_739_, 0);
v_tail_742_ = lean_ctor_get(v_x_739_, 1);
v_isSharedCheck_751_ = !lean_is_exclusive(v_x_739_);
if (v_isSharedCheck_751_ == 0)
{
v___x_744_ = v_x_739_;
v_isShared_745_ = v_isSharedCheck_751_;
goto v_resetjp_743_;
}
else
{
lean_inc(v_tail_742_);
lean_inc(v_head_741_);
lean_dec(v_x_739_);
v___x_744_ = lean_box(0);
v_isShared_745_ = v_isSharedCheck_751_;
goto v_resetjp_743_;
}
v_resetjp_743_:
{
lean_object* v___x_746_; lean_object* v___x_747_; lean_object* v___x_749_; 
v___x_746_ = lp_sft__v4_SFT_Host_Canonical_render(v_head_741_);
v___x_747_ = lp_sft__v4_SFT_Host_Canonical_renderValues(v_tail_742_);
if (v_isShared_745_ == 0)
{
lean_ctor_set(v___x_744_, 1, v___x_747_);
lean_ctor_set(v___x_744_, 0, v___x_746_);
v___x_749_ = v___x_744_;
goto v_reusejp_748_;
}
else
{
lean_object* v_reuseFailAlloc_750_; 
v_reuseFailAlloc_750_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v_reuseFailAlloc_750_, 0, v___x_746_);
lean_ctor_set(v_reuseFailAlloc_750_, 1, v___x_747_);
v___x_749_ = v_reuseFailAlloc_750_;
goto v_reusejp_748_;
}
v_reusejp_748_:
{
return v___x_749_;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_render(lean_object* v_x_754_){
_start:
{
switch(lean_obj_tag(v_x_754_))
{
case 0:
{
lean_object* v_a_755_; lean_object* v___x_756_; 
v_a_755_ = lean_ctor_get(v_x_754_, 0);
lean_inc_ref(v_a_755_);
lean_dec_ref_known(v_x_754_, 1);
v___x_756_ = lp_sft__v4_SFT_Host_Canonical_quote(v_a_755_);
lean_dec_ref(v_a_755_);
return v___x_756_;
}
case 1:
{
uint8_t v_a_757_; 
v_a_757_ = lean_ctor_get_uint8(v_x_754_, 0);
lean_dec_ref_known(v_x_754_, 0);
if (v_a_757_ == 0)
{
lean_object* v___x_758_; 
v___x_758_ = ((lean_object*)(lp_sft__v4_SFT_Host_Canonical_render___closed__0));
return v___x_758_;
}
else
{
lean_object* v___x_759_; 
v___x_759_ = ((lean_object*)(lp_sft__v4_SFT_Host_Canonical_render___closed__1));
return v___x_759_;
}
}
case 2:
{
lean_object* v_a_760_; lean_object* v___x_761_; uint8_t v___x_762_; 
v_a_760_ = lean_ctor_get(v_x_754_, 0);
lean_inc(v_a_760_);
lean_dec_ref_known(v_x_754_, 1);
v___x_761_ = lean_obj_once(&lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__13, &lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__13_once, _init_lp_sft__v4_SFT_Host_Canonical_instReprValue_repr___closed__13);
v___x_762_ = lean_int_dec_lt(v_a_760_, v___x_761_);
if (v___x_762_ == 0)
{
lean_object* v___x_763_; lean_object* v___x_764_; lean_object* v___x_765_; lean_object* v___x_766_; 
v___x_763_ = lean_unsigned_to_nat(10u);
v___x_764_ = lean_nat_abs(v_a_760_);
lean_dec(v_a_760_);
v___x_765_ = l_Nat_toDigits(v___x_763_, v___x_764_);
v___x_766_ = lean_string_mk(v___x_765_);
return v___x_766_;
}
else
{
lean_object* v___x_767_; lean_object* v___x_768_; lean_object* v___x_769_; lean_object* v___x_770_; lean_object* v___x_771_; lean_object* v___x_772_; 
v___x_767_ = lean_unsigned_to_nat(10u);
v___x_768_ = lean_nat_abs(v_a_760_);
lean_dec(v_a_760_);
v___x_769_ = l_Nat_toDigits(v___x_767_, v___x_768_);
v___x_770_ = lp_sft__v4_SFT_Host_Canonical_render___boxed__const__1;
v___x_771_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_771_, 0, v___x_770_);
lean_ctor_set(v___x_771_, 1, v___x_769_);
v___x_772_ = lean_string_mk(v___x_771_);
return v___x_772_;
}
}
case 3:
{
lean_object* v___x_773_; 
v___x_773_ = ((lean_object*)(lp_sft__v4___private_SFT_Host_Canonical_0__SFT_Host_Canonical___aux__SFT__Host__Canonical______macroRules____private__SFT__Host__Canonical__0__SFT__Host__Canonical__term___x2b_x2b_x2b____1___closed__12));
return v___x_773_;
}
case 4:
{
lean_object* v_a_774_; lean_object* v___x_775_; lean_object* v___x_776_; lean_object* v___x_777_; lean_object* v___x_778_; lean_object* v___x_779_; lean_object* v___x_780_; lean_object* v___x_781_; 
v_a_774_ = lean_ctor_get(v_x_754_, 0);
lean_inc(v_a_774_);
lean_dec_ref_known(v_x_754_, 1);
v___x_775_ = ((lean_object*)(lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__2));
v___x_776_ = ((lean_object*)(lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__3));
v___x_777_ = lp_sft__v4_SFT_Host_Canonical_renderValues(v_a_774_);
v___x_778_ = lp_sft__v4_SFT_Host_Text_intercalate(v___x_776_, v___x_777_);
v___x_779_ = ((lean_object*)(lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__6));
v___x_780_ = lp_sft__v4_SFT_Host_Text_append(v___x_778_, v___x_779_);
lean_dec_ref(v___x_778_);
v___x_781_ = lp_sft__v4_SFT_Host_Text_append(v___x_775_, v___x_780_);
lean_dec_ref(v___x_780_);
return v___x_781_;
}
default: 
{
lean_object* v_a_782_; lean_object* v___x_783_; lean_object* v___x_784_; lean_object* v___x_785_; lean_object* v___x_786_; lean_object* v___x_787_; lean_object* v___x_788_; lean_object* v___x_789_; lean_object* v___x_790_; lean_object* v___x_791_; lean_object* v___x_792_; 
v_a_782_ = lean_ctor_get(v_x_754_, 0);
lean_inc(v_a_782_);
lean_dec_ref_known(v_x_754_, 1);
v___x_783_ = ((lean_object*)(lp_sft__v4_SFT_Host_Canonical_render___closed__2));
v___x_784_ = ((lean_object*)(lp_sft__v4_List_repr___at___00SFT_Host_Canonical_instReprValue_repr_spec__0___redArg___closed__3));
v___x_785_ = lp_sft__v4_SFT_Host_Canonical_renderFields(v_a_782_);
v___x_786_ = lp_sft__v4_SFT_Host_Canonical_sortFields(v___x_785_);
v___x_787_ = lean_box(0);
v___x_788_ = lp_sft__v4_List_mapTR_loop___at___00SFT_Host_Canonical_render_spec__0(v___x_786_, v___x_787_);
v___x_789_ = lp_sft__v4_SFT_Host_Text_intercalate(v___x_784_, v___x_788_);
v___x_790_ = ((lean_object*)(lp_sft__v4_SFT_Host_Canonical_render___closed__3));
v___x_791_ = lp_sft__v4_SFT_Host_Text_append(v___x_789_, v___x_790_);
lean_dec_ref(v___x_789_);
v___x_792_ = lp_sft__v4_SFT_Host_Text_append(v___x_783_, v___x_791_);
lean_dec_ref(v___x_791_);
return v___x_792_;
}
}
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_renderField(lean_object* v_x_793_){
_start:
{
lean_object* v_fst_794_; lean_object* v_snd_795_; lean_object* v___x_797_; uint8_t v_isShared_798_; uint8_t v_isSharedCheck_807_; 
v_fst_794_ = lean_ctor_get(v_x_793_, 0);
v_snd_795_ = lean_ctor_get(v_x_793_, 1);
v_isSharedCheck_807_ = !lean_is_exclusive(v_x_793_);
if (v_isSharedCheck_807_ == 0)
{
v___x_797_ = v_x_793_;
v_isShared_798_ = v_isSharedCheck_807_;
goto v_resetjp_796_;
}
else
{
lean_inc(v_snd_795_);
lean_inc(v_fst_794_);
lean_dec(v_x_793_);
v___x_797_ = lean_box(0);
v_isShared_798_ = v_isSharedCheck_807_;
goto v_resetjp_796_;
}
v_resetjp_796_:
{
lean_object* v___x_799_; lean_object* v___x_800_; lean_object* v___x_801_; lean_object* v___x_802_; lean_object* v___x_803_; lean_object* v___x_805_; 
v___x_799_ = lp_sft__v4_SFT_Host_Canonical_quote(v_fst_794_);
v___x_800_ = ((lean_object*)(lp_sft__v4_SFT_Host_Canonical_renderField___closed__0));
v___x_801_ = lp_sft__v4_SFT_Host_Canonical_render(v_snd_795_);
v___x_802_ = lp_sft__v4_SFT_Host_Text_append(v___x_800_, v___x_801_);
lean_dec_ref(v___x_801_);
v___x_803_ = lp_sft__v4_SFT_Host_Text_append(v___x_799_, v___x_802_);
lean_dec_ref(v___x_802_);
lean_dec_ref(v___x_799_);
if (v_isShared_798_ == 0)
{
lean_ctor_set(v___x_797_, 1, v___x_803_);
v___x_805_ = v___x_797_;
goto v_reusejp_804_;
}
else
{
lean_object* v_reuseFailAlloc_806_; 
v_reuseFailAlloc_806_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v_reuseFailAlloc_806_, 0, v_fst_794_);
lean_ctor_set(v_reuseFailAlloc_806_, 1, v___x_803_);
v___x_805_ = v_reuseFailAlloc_806_;
goto v_reusejp_804_;
}
v_reusejp_804_:
{
return v___x_805_;
}
}
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_renderFields(lean_object* v_x_808_){
_start:
{
if (lean_obj_tag(v_x_808_) == 0)
{
lean_object* v___x_809_; 
v___x_809_ = lean_box(0);
return v___x_809_;
}
else
{
lean_object* v_head_810_; lean_object* v_tail_811_; lean_object* v___x_813_; uint8_t v_isShared_814_; uint8_t v_isSharedCheck_820_; 
v_head_810_ = lean_ctor_get(v_x_808_, 0);
v_tail_811_ = lean_ctor_get(v_x_808_, 1);
v_isSharedCheck_820_ = !lean_is_exclusive(v_x_808_);
if (v_isSharedCheck_820_ == 0)
{
v___x_813_ = v_x_808_;
v_isShared_814_ = v_isSharedCheck_820_;
goto v_resetjp_812_;
}
else
{
lean_inc(v_tail_811_);
lean_inc(v_head_810_);
lean_dec(v_x_808_);
v___x_813_ = lean_box(0);
v_isShared_814_ = v_isSharedCheck_820_;
goto v_resetjp_812_;
}
v_resetjp_812_:
{
lean_object* v___x_815_; lean_object* v___x_816_; lean_object* v___x_818_; 
v___x_815_ = lp_sft__v4_SFT_Host_Canonical_renderField(v_head_810_);
v___x_816_ = lp_sft__v4_SFT_Host_Canonical_renderFields(v_tail_811_);
if (v_isShared_814_ == 0)
{
lean_ctor_set(v___x_813_, 1, v___x_816_);
lean_ctor_set(v___x_813_, 0, v___x_815_);
v___x_818_ = v___x_813_;
goto v_reusejp_817_;
}
else
{
lean_object* v_reuseFailAlloc_819_; 
v_reuseFailAlloc_819_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v_reuseFailAlloc_819_, 0, v___x_815_);
lean_ctor_set(v_reuseFailAlloc_819_, 1, v___x_816_);
v___x_818_ = v_reuseFailAlloc_819_;
goto v_reusejp_817_;
}
v_reusejp_817_:
{
return v___x_818_;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_sft__v4_SFT_Host_Canonical_identity(lean_object* v_v_822_){
_start:
{
lean_object* v___x_823_; lean_object* v___x_824_; lean_object* v___x_825_; lean_object* v___x_826_; lean_object* v___x_827_; 
v___x_823_ = ((lean_object*)(lp_sft__v4_SFT_Host_Canonical_identity___closed__0));
v___x_824_ = lp_sft__v4_SFT_Host_Canonical_render(v_v_822_);
v___x_825_ = lean_string_to_utf8(v___x_824_);
lean_dec_ref(v___x_824_);
v___x_826_ = lp_sft__v4_SFT_Host_SHA256Window_digest(v___x_825_);
v___x_827_ = lp_sft__v4_SFT_Host_Text_append(v___x_823_, v___x_826_);
lean_dec_ref(v___x_826_);
return v___x_827_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_sft__v4_SFT_Host_SHA256Window(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_sft__v4_SFT_Host_Canonical(uint8_t builtin) {
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
res = initialize_sft__v4_SFT_Host_SHA256Window(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
lp_sft__v4_SFT_Host_Canonical_render___boxed__const__1 = _init_lp_sft__v4_SFT_Host_Canonical_render___boxed__const__1();
lean_mark_persistent(lp_sft__v4_SFT_Host_Canonical_render___boxed__const__1);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
