from pathlib import Path
from fractions import Fraction as F
from decimal import Decimal,getcontext
import ast,json,hashlib
getcontext().prec=45
root=Path(__file__).resolve().parents[1];g={'Fraction':F,'ONE':F(1),'EMPTY_ONE':('empty-One',)};digests={}
def load(name,selected):
 p=root/'v3/sft/physics'/name;digests[name]=hashlib.sha256(p.read_bytes()).hexdigest();t=ast.parse(p.read_text());nodes=[n for n in t.body if isinstance(n,ast.FunctionDef) and (selected is None or n.name in selected)];exec(compile(ast.Module(body=nodes,type_ignores=[]),str(p),'exec'),g)
load('structural_constants.py',['fold_part','first_return_trace','fold_word_support_count','positive_predecessor','generator_unit_part','generator_period_three'])
load('atomic_constants.py',['binary_count','positive_power','minimal_binary_cover','fine_structure_blocks','promotion_rungs','effective_cover','inverse_fine_structure'])
load('precision_value_laws_v1.py',['terminal_alpha'])
load('higgs_symmetry_terminal_law_v1.py',None)
load('higgs_symmetry_terminal_validation_v1.py',['exact_analysis'])
formal=g['theorem_certificate']();record=json.load(open(root/'v3/experiments/external_sources/physics/snapshots/higgs-terminal-postseal-source-record.json'));a=g['exact_analysis'](record)
assert formal['terminal_mass_ratio']==F(2563352914777,5038463954690)
assert formal['terminal_self_coupling']==F(6570778165695741824959729,50772238045420788745992200)
assert a['predicted_mass_gev']==F(31557437733819647,251923197734500)
assert a['pdg_aggregate_contains_prediction'] and not a['atlas_one_reported_uncertainty_contains_prediction'] and not a['cms_one_reported_uncertainty_contains_prediction']
assert formal['route_cross_lock']['routes_equal'] and a['kappa_interval_contains_prediction']
controls={}
for name,path,value,key in [('outside_mass',[1,'higgs_mass_world_average','reported_interval_from_listed_uncertainty_gev'],['124/1','125/1'],'pdg_aggregate_contains_prediction'),('outside_coupling',[4,'trilinear_self_coupling_constraint','upper_coordinate'],'9/10','kappa_interval_contains_prediction'),('erased_offset',[2,'combined_higgs_mass','reported_value_gev'],str(a['predicted_mass_gev']),'individual_offsets_retained')]:
 c=json.loads(json.dumps(record));c['sources'][path[0]]['rows'][path[1]][path[2]]=value;controls[name]=not g['exact_analysis'](c)[key];assert controls[name]
dec=lambda x:str(Decimal(x.numerator)/Decimal(x.denominator));result={'method':'Execute original pure rational function ASTs and exact original analysis; compare terminal fractions to retained native theorem statements. No scientific source change or compiler rerun.','source_sha256':digests,'formal':formal,'analysis':a,'controls_rejected':controls,'decimal_analysis':{k:dec(v) for k,v in a.items() if isinstance(v,F)}};p=root;p.mkdir(exist_ok=True);(p/'arithmetic_check.json').write_text(json.dumps(result,default=str,indent=2)+'\n');print(json.dumps(result['decimal_analysis'],indent=2));print('fields',len(a),'controls',controls)
