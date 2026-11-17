from pathlib import Path
from fractions import Fraction
from itertools import product
import ast,json,hashlib
root=Path(__file__).resolve().parents[1];dest=root;dest.mkdir(exist_ok=True)
mods={};hashes={}
def load(name,extra=None,only=None):
 f=root/'v3/sft/physics'/(name+'.py');t=ast.parse(f.read_text());hashes[str(f.relative_to(root/'v3'))]=hashlib.sha256(f.read_bytes()).hexdigest();g={'Fraction':Fraction};g.update(extra or {});mods[name]=g
 for n in t.body:
  if isinstance(n,ast.FunctionDef) and (only is None or n.name in only):exec(compile(ast.fix_missing_locations(ast.Module(body=[ast.ImportFrom(module='__future__',names=[ast.alias(name='annotations')],level=0),n],type_ignores=[])),str(f),'exec'),g)
  elif isinstance(n,ast.Assign) and len(n.targets)==1 and isinstance(n.targets[0],ast.Name):
   try:g[n.targets[0].id]=ast.literal_eval(n.value)
   except (ValueError,TypeError):pass
 return g
s=load('structural_constants',only=['fold_part','first_return_trace','fold_word_support_count','positive_predecessor','generator_unit_part','generator_period_three']);a=load('atomic_constants',s);l=load('lineage_particle_laws',{**s,**a});p=load('precision_value_laws_v1',{**s,**a});v=load('electroweak_measured_value_successor_validation_v1',p,only=['interval','exact_electroweak_analysis']);rec=json.loads((root/'v3/experiments/external_sources/physics/snapshots/electroweak-measured-value-successor-source-record.json').read_text());target=rec['registered_target'];analysis=v['exact_electroweak_analysis'](target);assert len(analysis)==10 and all(x for x in analysis.values() if isinstance(x,bool))
controls={}
for name,key,value,test in [('direct','on_shell_sin_squared_center','0.22000','forced_sine_inside_direct_interval'),('W','compatible_w_mass_GeV','81','forced_cosine_inside_compatible_WZ_interval')]:
 t=dict(target);t[key]=value;controls[name]=v['exact_electroweak_analysis'](t);assert not controls[name][test]
sine=p['terminal_electroweak_sin_squared']();cosine=p['terminal_electroweak_cos_squared']();assert sine==Fraction(1930922298157999,8642477221479757) and sine+cosine==1
charged=list(product(range(1,16),repeat=2));neutral=list(product(range(1,5),range(1,15),range(1,15)));assert len(charged)==len(set(charged))==225 and len(neutral)==len(set(neutral))==784
methods=analysis['all_input_WZ_squared_method_record'];assert not methods[0]<=cosine<=methods[1]
r={'method':'Unchanged pinned original pure functions with actual structural and atomic imports; exact Fraction arithmetic. General native proofs and full-program evidence reused.','source_sha256':hashes,'bare':l['electroweak_mixing'](),'bare_WZ':l['wz_squared_ratio'](),'promotion_rungs':a['promotion_rungs'](),'alpha_inverse':a['inverse_fine_structure'](),'support_words':list(product(['lower','upper'],repeat=4)),'running_level':p['electroweak_running_level'](),'charged_channels':charged,'neutral_channels':neutral,'base_share':p['electroweak_running_share'](13),'return_divisor':p['terminal_return_divisor'](),'sine':sine,'cosine':cosine,'target':target,'complete_analysis':analysis,'all_input_arithmetic_membership':False,'controls':controls}
def clean(x):
 if isinstance(x,Fraction):return str(x)
 if isinstance(x,dict):return {k:clean(v) for k,v in x.items()}
 if isinstance(x,(tuple,list)):return [clean(v) for v in x]
 return x
(dest/'arithmetic_check.json').write_text(json.dumps(clean(r),indent=2)+'\n');print({'channels':[len(charged),len(neutral)],'fields':len(analysis),'sine':str(sine),'cosine':str(cosine),'controls':'PASS'})
