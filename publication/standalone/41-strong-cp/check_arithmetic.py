from pathlib import Path
from fractions import Fraction
from dataclasses import dataclass,replace,asdict,is_dataclass
from functools import lru_cache
from itertools import product,combinations
import ast,json,hashlib,types,sys
root=Path('/tmp/sft_cp_sources');dest=Path('publication/standalone/41-strong-cp');dest.mkdir(exist_ok=True)
mods={};trees={};hashes={}
def load(short,extra=None,only=None):
 f=root/'v3/sft/physics'/(short+'.py');t=ast.parse(f.read_text());trees[short]=t;hashes[str(f.relative_to(root/'v3'))]=hashlib.sha256(f.read_bytes()).hexdigest();m=types.ModuleType(short);sys.modules[short]=m;g=m.__dict__;g.update(Fraction=Fraction,dataclass=dataclass,replace=replace,lru_cache=lru_cache,product=product,combinations=combinations);g.update(extra or {});mods[short]=g
 for n in t.body:
  if (isinstance(n,ast.FunctionDef) and (only is None or n.name in only)) or (isinstance(n,ast.ClassDef) and n.name in ['CandidateForm','ResidueRecord']):
   nodes=[ast.ImportFrom(module='__future__',names=[ast.alias(name='annotations')],level=0),n];exec(compile(ast.fix_missing_locations(ast.Module(body=nodes,type_ignores=[])),str(f),'exec'),g)
  elif isinstance(n,ast.Assign) and len(n.targets)==1 and isinstance(n.targets[0],ast.Name) and n.targets[0].id not in ['SPEC','_theorem']:
   try:g[n.targets[0].id]=eval(compile(ast.Expression(n.value),str(f),'eval'),g)
   except (NameError,AttributeError):pass
 return g
struct=load('structural_constants',only=['fold_part','first_return_trace','fold_word_support_count','positive_predecessor','generator_unit_part','generator_period_three'])
atomic=load('atomic_constants',struct,only=['binary_count','positive_power','minimal_binary_cover'])
lineage=load('lineage_particle_laws',{**struct,**atomic},only=['half_one','fold_preimages','half_one_preimages','is_prime_count','upper_cover_depth','prime_sector_ladder','mediator_count','cp_phase_position','parity_fibre'])
baryon=load('baryogenesis_dependency_terminal_law_v1');strong=load('strong_cp_baryon_stability_terminal_law_v1',{**struct,**lineage});census=baryon['complete_condition_census']();cert=strong['theorem_certificate']();assert baryon['unique_positive_process']();assert len(census)==8 and sum(x['positive_residue'] for x in census)==1
assert cert['alignment']['strong_phase']==('aligned-One',Fraction(1)) and cert['actions']['mediator_total']==83 and cert['actions']['cross_fibre_pair_count']==202 and cert['actions']['quark_to_lepton_pair_count']==6
assert len(strong['complete_colour_words']())==27 and all(strong['baryon_tally'](x)==1 for x in strong['complete_colour_words']())
record=json.loads((root/'v3/experiments/external_sources/physics/snapshots/strong-cp-baryon-stability-postseal-source-record.json').read_text());validation=load('strong_cp_baryon_stability_validation_v1',strong,only=['lifetime_value','exact_analysis']);analysis=validation['exact_analysis'](record);assert len(analysis)==14 and analysis['nedm_direct_record_consistent'] and analysis['no_significant_decay_signal'] and analysis['background_candidates_retained']
import copy
edm=copy.deepcopy(record);edm['sources'][0]['rows']['neutron_electric_dipole_moment']['reported_central_status']='confirmed-nonempty-displacement';decay=copy.deepcopy(record);decay['sources'][1]['rows']['p_to_e_plus_pi0']['interpretation']='confirmed-proton-decay';controls={'confirmed_EDM':validation['exact_analysis'](edm),'confirmed_decay':validation['exact_analysis'](decay)};assert not controls['confirmed_EDM']['nedm_direct_record_consistent'] and not controls['confirmed_decay']['no_significant_decay_signal']
grammars={}
for name in ['baryogenesis_dependency_terminal_law_v1','strong_cp_baryon_stability_terminal_law_v1']:
 t=trees[name];spec=next(n for n in t.body if isinstance(n,ast.Assign) and isinstance(n.targets[0],ast.Name) and n.targets[0].id=='SPEC');axes=[]
 for x in next(k.value for k in spec.value.keywords if k.arg=='axes').elts:
  axes.append(dict(zip(['key','question','rejected','rejected_reason','admitted','admitted_reason'],[ast.literal_eval(v) for v in x.args])))
 grammars[name]={'axes':axes,'candidate_count':2**len(axes),'survivor':[x['admitted'] for x in axes]}
def clean(v):
 if isinstance(v,Fraction):return str(v)
 if is_dataclass(v):return clean(asdict(v))
 if isinstance(v,dict):return {str(k):clean(x) for k,x in v.items()}
 if isinstance(v,(list,tuple)):return [clean(x) for x in v]
 return v
r={'method':'Execute unchanged pinned original pure function bodies and declared dataclasses; exact Fraction arithmetic. Preserve original imported structural,atomic andlineage functions. Reuse general native proofs and complete retained source comparisons.','source_sha256':hashes,'condition_census':census,'hand_census':strong['strong_hand_census'](),'strong_certificate':cert,'all83action_signatures':strong['sector_action_signatures'](),'all202cross_pairs':strong['cross_fibre_label_pairs'](),'all27colour_words':strong['complete_colour_words'](),'observation':analysis,'controls':controls,'grammars':grammars};(dest/'arithmetic_check.json').write_text(json.dumps(clean(r),indent=2)+'\n');print({'condition_rows':len(census),'hand_rows':len(strong['strong_hand_census']()),'actions':83,'cross_pairs':202,'colour_words':27,'observation_fields':len(analysis),'grammar_counts':[x['candidate_count'] for x in grammars.values()]})
