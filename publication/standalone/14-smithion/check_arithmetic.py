from pathlib import Path
from fractions import Fraction as F
from decimal import Decimal,getcontext
import ast,json,re,hashlib
getcontext().prec=40
root=Path(__file__).resolve().parents[1];g={'Fraction':F,'EMPTY_ONE':(),'NEW_SECTORS':(5,7),'KINDS':('down','up')};digests={}
def load(name,selected):
 p=root/'v3/sft/physics'/name;digests[name]=hashlib.sha256(p.read_bytes()).hexdigest();t=ast.parse(p.read_text());nodes=[n for n in t.body if isinstance(n,ast.FunctionDef) and n.name in selected];assert len(nodes)==len(selected),(name,selected);exec(compile(ast.Module(body=nodes,type_ignores=[]),str(p),'exec'),g)
load('structural_constants.py',['fold_part','first_return_trace','fold_word_support_count','positive_predecessor','generator_unit_part','generator_period_three'])
load('atomic_constants.py',['binary_count','positive_power','minimal_binary_cover','fine_structure_blocks','_promotion_rungs'] if False else ['binary_count','positive_power','minimal_binary_cover','fine_structure_blocks'])
load('lineage_particle_laws.py',['is_prime_count','upper_cover_depth','prime_sector_ladder','mediator_count','sector_coupling'])
load('sector_inventory_law_v1.py',['charge_kind_count','singlet_constituent_count','fermion_mass_part'])
load('particle_mode_generation_terminal_law_v1.py',['positive_whole','interior_fixed_modes','generation_coordinates'])
load('dark_smithion_lfv_terminal_law_v1.py',['coloured_product','spectrum_depth','pair_sum','spectrum_invariants','cubic_side','sign_change_brackets','bisect_bracket','spectrum_root_brackets','mass_ratio_enclosures','smithion_spectrum_census','relic_certificate','lfv_certificate','abundance_certificate'])
load('dark_smithion_lfv_validation_v1.py',['exact_analysis'])
rows=g['smithion_spectrum_census']();dec=lambda x:str(Decimal(x.numerator)/Decimal(x.denominator));out=[];common=2**70
for i,row in enumerate(rows):
 raw=(root/'v4/SFT/Physics'/('SmithionRoots'+str(i)+'.lean')).read_text();native=[F(int(n),int(d)) for n,d in re.findall(r'normalize \((\d+)\) (\d+)',raw)];assert native==[x for b in row['roots'] for x in b],(i,native)
 integers=[[(x*common).numerator for x in b] for b in row['roots']];assert all(b-a==1 for a,b in integers)
 out.append({'sector':row['sector'],'kind':row['kind'],'depth':row['depth'],'invariants':[str(x) for x in row['invariants']],'root_intervals':[[str(x) for x in b] for b in row['roots']],'root_numerators_at_2pow70':integers,'ratio_intervals':[[str(x) for x in b] for b in row['mass_ratios']],'ratio_decimal_intervals':[[dec(x) for x in b] for b in row['mass_ratios']]})
record=json.load(open(root/'v3/experiments/external_sources/physics/snapshots/dark-smithion-lfv-postseal-source-record.json'));analysis=g['exact_analysis'](record);assert analysis['ratio_passes'] and analysis['absolute_transport_passes'];lfv=g['lfv_certificate']();assert lfv['integer_ratio']==(3,5,20);assert g['coloured_product'](3,5)==F(3,1454) and g['coloured_product'](3,7)==F(3,13118)
p=root;p.mkdir(exist_ok=True);result={'method':'Original pure rational function AST execution; all24root endpoints compared to the four retained native originalCompleteRoots theorem statements. No Lean compilation repeated.','source_sha256':digests,'four_root_vectors_match_native':True,'root_denominator':common,'spectra':out,'relic':g['relic_certificate'](),'lfv':lfv,'abundance':g['abundance_certificate'](),'source_analysis':analysis};(p/'arithmetic_check.json').write_text(json.dumps(result,default=str,indent=2)+'\n');print(json.dumps({'spectra':out,'lfv':lfv,'analysis':analysis},default=str,indent=2))
