from pathlib import Path
from fractions import Fraction as F
from dataclasses import dataclass,asdict
import ast,json,hashlib
root=Path(__file__).resolve().parents[1];g={'Fraction':F,'dataclass':dataclass,'__name__':'__main__'};digests={}
def load(path,selected):
 p=root/'v3'/path;digests[path]=hashlib.sha256(p.read_bytes()).hexdigest();t=ast.parse(p.read_text());nodes=[n for n in t.body if isinstance(n,(ast.FunctionDef,ast.ClassDef)) and n.name in selected];assert len(nodes)==len(selected);exec(compile(ast.Module(body=nodes,type_ignores=[]),str(p),'exec'),g)
load('sft/physics/structural_constants.py',['fold_part','first_return_trace','fold_word_support_count','positive_predecessor','generator_unit_part','generator_period_three'])
load('sft/physics/atomic_constants.py',['binary_count','positive_power','minimal_binary_cover','fine_structure_blocks','promotion_rungs','effective_cover','inverse_fine_structure','orientation_count','boundary_count','orbit_capacity','colour_coupling','spin_orbit_threshold','oscillator_closure','nuclear_closure','nuclear_closure_prefix','greatest_whole_not_exceeding','atomic_endpoint'])
load('sft/chemistry/gblock_predictions.py',['OccupiedSubshell','generated_subshell_order','fill_configuration','subshell_occupation','noble_closures','first_occupied_coordinate','smithium_record'])
capacities=[g['orbit_capacity'](i) for i in range(1,6)];closures=g['nuclear_closure_prefix'](12);noble=g['noble_closures'](7);smithium=g['smithium_record']();endpoint=g['atomic_endpoint']();assert capacities==[2,6,10,14,18] and closures[:8]==(2,8,20,28,50,82,126,184);assert noble==(2,10,18,36,54,86,118);assert g['first_occupied_coordinate'](5,5)==121;assert smithium=={'proton':126,'neutron':184,'mass':310,'configuration':((8,1,2),(5,5,6)),'valence':8,'predicted_positive_oxidation_counts':(2,3,4,5,6,7,8)};assert endpoint==137
configs={str(i):[asdict(r) for r in g['fill_configuration'](i)] for i in [118,119,120,121,126,137]}
assert all(sum(r['occupied'] for r in rows)==int(i) for i,rows in configs.items())
walk=[];total=0
for n,r in g['generated_subshell_order'](2*endpoint):
 c=g['orbit_capacity'](r);walk.append([n,r,c,total+1,total+c]);total+=c
 if total>=138:break
ratio=g['inverse_fine_structure']();lower=ratio.numerator-137*ratio.denominator;upper=138*ratio.denominator-ratio.numerator;assert lower>0 and upper>0
result={'method':'Original pure rational and complete filling function AST execution; compare explicit values with retained native theorem outputs. No source changes or compiler reruns.','source_sha256':digests,'orbit_capacities':capacities,'nuclear_closures':closures,'threshold':g['spin_orbit_threshold'](),'noble_closures':noble,'first5g':121,'smithium':smithium,'endpoint':endpoint,'inverse_alpha':str(ratio),'endpoint_crossproduct_margins':[lower,upper],'configurations':configs,'complete_walk_through_5g':walk};p=root;p.mkdir(exist_ok=True);(p/'arithmetic_check.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps({k:v for k,v in result.items() if k not in ['configurations','source_sha256','method']},indent=2))
