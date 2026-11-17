from pathlib import Path
from fractions import Fraction
from dataclasses import dataclass,replace,asdict,is_dataclass
from functools import lru_cache
from itertools import product
import ast,json,hashlib,types,sys
root=Path('/tmp/sft_compact_sources');dest=Path('publication/standalone/15-compact-waves');dest.mkdir(exist_ok=True)
mods={};trees={};hashes={}
def load(short,extra=None,only=None):
 f=root/'v3/sft/physics'/(short+'.py');t=ast.parse(f.read_text());trees[short]=t;hashes[str(f.relative_to(root/'v3'))]=hashlib.sha256(f.read_bytes()).hexdigest();m=types.ModuleType(short);sys.modules[short]=m;g=m.__dict__;g.update(Fraction=Fraction,dataclass=dataclass,replace=replace,lru_cache=lru_cache,product=product);g.update(extra or {});mods[short]=g
 for n in t.body:
  if (isinstance(n,ast.FunctionDef) and (only is None or n.name in only)) or (isinstance(n,ast.ClassDef) and n.name=='CandidateForm'):
   nodes=[ast.ImportFrom(module='__future__',names=[ast.alias(name='annotations')],level=0),n];exec(compile(ast.fix_missing_locations(ast.Module(body=nodes,type_ignores=[])),str(f),'exec'),g)
  elif isinstance(n,ast.Assign) and len(n.targets)==1 and isinstance(n.targets[0],ast.Name) and n.targets[0].id not in ['SPEC','_theorem']:
   try:g[n.targets[0].id]=eval(compile(ast.Expression(n.value),str(f),'eval'),g)
   except (NameError,AttributeError):pass
 return g
struct=load('structural_constants',only=['fold_part','first_return_trace','fold_word_support_count','positive_predecessor','generator_unit_part','generator_period_three'])
names=['static_exterior_clock_terminal_law_v1','quadrupole_radiated_power_terminal_law_v1','stellar_galactic_tidal_terminal_law_v1','compact_horizon_terminal_law_v1','gravitational_wave_chirp_ringdown_terminal_law_v1'];laws=[load(n,{'generator_period_three':struct['generator_period_three']}) for n in names];static,quad,stellar,horizon,chirp=laws
certs=[static['exterior_certificate'](),quad['radiated_power_certificate'](),stellar['theorem_certificate'](),horizon['theorem_certificate'](),chirp['theorem_certificate']()]
assert certs[0]['exact_clock_pair']['far_over_near_rate']==Fraction(16,15)
assert certs[1]['base_power']==18 and certs[1]['doubled_power']==72 and certs[1]['static_power_record']==()
assert all(certs[3][k] for k in ['all_exclusion_scalings_close','two_pre_horizon_families','reference_cross_closes','all_evaporation_traces_close']);assert all(certs[4][k] for k in ['all_chirps_close','merger_closes','all_ringdowns_close'])
obsnames=['static-exterior-clock-source-record.json','quadrupole-radiated-power-source-record.json','stellar-galactic-tidal-postseal-source-record.json','compact-horizon-postseal-source-record.json','gravitational-wave-chirp-ringdown-postseal-source-record.json'];valnames=['static_exterior_clock_terminal_validation_v1','quadrupole_radiated_power_terminal_validation_v1','stellar_galactic_tidal_terminal_validation_v1','compact_horizon_terminal_validation_v1','gravitational_wave_chirp_ringdown_validation_v1'];observations=[];records=[]
for i,(name,recordname) in enumerate(zip(valnames,obsnames)):
 record=json.loads((root/'v3/experiments/external_sources/physics/snapshots'/recordname).read_text());records.append(record);g=load(name,laws[i],only=['exact_analysis','exact_measurement_analysis']);fn=g.get('exact_analysis',g.get('exact_measurement_analysis'));observations.append(fn(record['registered_target'] if i<2 else record))
assert len(observations[0])==26 and len(observations[1])==24 and len(observations[2])==34 and len(observations[3])==17 and len(observations[4])==16
assert observations[2]['stellar_contains_four']==(False,False,False,False,True,False);assert observations[2]['stellar_contains_three']==(False,False,False,False,False,True);assert not observations[2]['btfr_central_contains_four'] and observations[2]['btfr_systematic_contains_four'];assert observations[3]['neutron_star_interval_solar']==(Fraction(201,100),Fraction(43,20));assert observations[4]['chirp_frequency_interval_hz']==(Fraction(35),Fraction(450))
grammars={}
for name,g in zip(names,laws):
 t=trees[name]
 if 'candidate_forms' in g:
  forms=g['candidate_forms']();survivors=[f.candidate_id for f in forms if g['form_survives'](f)];assert len(forms)==2916 and len(survivors)==1;fn=next(n for n in t.body if isinstance(n,ast.FunctionDef) and n.name=='candidate_forms');call=next(n for n in ast.walk(fn) if isinstance(n,ast.Call) and isinstance(n.func,ast.Name) and n.func.id=='product');grammars[name]={'domains':{x.id:g[x.id] for x in call.args},'candidate_count':len(forms),'survivor':survivors[0]}
 else:
  spec=next(n for n in t.body if isinstance(n,ast.Assign) and isinstance(n.targets[0],ast.Name) and n.targets[0].id=='SPEC');axes=[]
  for x in next(k.value for k in spec.value.keywords if k.arg=='axes').elts:
   vals=[ast.literal_eval(v) for v in x.args];axes.append(dict(zip(['key','question','rejected','rejected_reason','admitted','admitted_reason'],vals)))
  grammars[name]={'axes':axes,'candidate_count':2**len(axes),'survivor':[x['admitted'] for x in axes]}
def clean(v):
 if isinstance(v,Fraction):return str(v)
 if is_dataclass(v):return clean(asdict(v))
 if isinstance(v,dict):return {str(k):clean(x) for k,x in v.items()}
 if isinstance(v,(list,tuple)):return [clean(x) for x in v]
 return v
r={'method':'Unchanged pinned original pure function bodies and original exact dataclasses/Fraction; existing native general proofs and retained complete program/evidence comparisons reused.','source_sha256':hashes,'certificates':dict(zip(names,certs)),'observations':dict(zip(valnames,observations)),'grammars':grammars,'depth3_inspiral':chirp['inspiral_trace'](3),'depth4_ringdown':chirp['ringdown_trace'](4),'depth4_evaporation':horizon['evaporation_trace'](4),'tidal_example':stellar['tidal_terminal'](5,2)};(dest/'arithmetic_check.json').write_text(json.dumps(clean(r),indent=2)+'\n');print({'certificate_fields':[len(x) for x in certs],'observation_fields':[len(x) for x in observations],'grammar_counts':[x['candidate_count'] for x in grammars.values()]})
