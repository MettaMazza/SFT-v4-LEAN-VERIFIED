from pathlib import Path
from fractions import Fraction
import ast,json,hashlib
root=Path(__file__).resolve().parents[1];dest=root;dest.mkdir(exist_ok=True)
mods={};hashes={};trees={}
def load(name,extra=None,only=None):
 f=root/'v3/sft/physics'/(name+'.py');t=ast.parse(f.read_text());trees[name]=t;hashes[str(f.relative_to(root/'v3'))]=hashlib.sha256(f.read_bytes()).hexdigest();g={'Fraction':Fraction};g.update(extra or {});mods[name]=g
 for n in t.body:
  if isinstance(n,ast.FunctionDef) and (only is None or n.name in only):exec(compile(ast.fix_missing_locations(ast.Module(body=[ast.ImportFrom(module='__future__',names=[ast.alias(name='annotations')],level=0),n],type_ignores=[])),str(f),'exec'),g)
  elif isinstance(n,ast.Assign) and len(n.targets)==1 and isinstance(n.targets[0],ast.Name):
   try:g[n.targets[0].id]=ast.literal_eval(n.value)
   except (ValueError,TypeError):pass
 return g
s=load('structural_constants',only=['fold_part','first_return_trace','fold_word_support_count','positive_predecessor','generator_unit_part','generator_period_three']);a=load('atomic_constants',s);m=load('matter_flavour_laws_v1',{**s,**a});c=load('matter_flavour_completion_laws_v1',{**s,**a,**m});t=load('matter_flavour_terminal_ckm_laws_v1',{**s,**a,**m,**c});prior=load('prior_value_laws',s,only=['positive_take']);p=load('matter_flavour_terminal_proton_laws_v1',{**s,**a,**m,**c,'positive_take':prior['positive_take']});v=load('matter_flavour_terminal_ckm_validation_v1',{**m,**t});w=load('matter_flavour_terminal_proton_validation_v1',{**m,**p})
records={fn:c[fn]() for fn in ['mixing_correspondence','mirror_mass_closure','inter_entry_couplings','generation_depth','confinement_lift','baryon_photon_relation']};records['mass_ratio_prefix']=[c['mass_ratio_family'](d) for d in range(1,7)];records['terminal_ckm_relation']=t['terminal_ckm_relation']();records['terminal_baryon_relation']=t['terminal_baryon_photon_relation']();records['terminal_proton_relation']=p['terminal_proton_relation']()
assert [x['heavy_over_light'] for x in records['mass_ratio_prefix']]==[5,17,53,161,485,1457]
assert records['confinement_lift']['down_sharpened_product']==Fraction(3,1454)
assert records['confinement_lift']['up_sharpened_product']==Fraction(3,13118)
obs=json.loads((root/'v3/experiments/external_sources/physics/snapshots/matter-flavour-terminal-source-record.json').read_text());pro=json.loads((root/'v3/experiments/external_sources/physics/snapshots/matter-flavour-terminal-proton-source-record.json').read_text());rows=obs['sources'][0]['rows'];pred=v['terminal_ckm_prediction_intervals']();mapping=dict(zip(pred,['sin_theta12','sin_theta23','sin_theta13','jarlskog']));checks={k:v['overlaps'](x,v['three_sigma_squared'](rows[mapping[k]])) for k,x in pred.items()};assert all(checks.values())
eta=v['terminal_eta_prediction_interval']();cos=obs['sources'][1]['rows'];bbn=cos['bbn_baryon_to_photon_ratio'];planck=cos['planck_derived_baryon_to_photon_ratio'];assert Fraction(bbn['strict_lower'])<eta[0]<=eta[1]<Fraction(bbn['strict_upper']);assert v['overlaps'](eta,(Fraction(planck['value'])-Fraction(planck['standard_uncertainty']),Fraction(planck['value'])+Fraction(planck['standard_uncertainty'])))
pr=w['terminal_proton_prediction_interval']();row=pro['source']['row'];target=(Fraction(row['value'])-Fraction(row['standard_uncertainty']),Fraction(row['value'])+Fraction(row['standard_uncertainty']));assert target[0]<=pr[0]<=pr[1]<=target[1]
r={'method':'Execute unchanged pinned original pure function bodies and their original structural/atomic imports using exact Fraction arithmetic. General native proofs and full-program receipts reused.','source_sha256':hashes,'records':records,'quark_roots':v['refined_quark_roots'](),'lepton_roots':w['refined_roots'](),'alpha_inverse':a['inverse_fine_structure'](),'ckm_predictions':pred,'ckm_checks':checks,'ckm_source':rows,'cosmology_source':cos,'eta_prediction':eta,'proton_prediction':pr,'proton_source':row,'proton_target':target}
def clean(x):
 if isinstance(x,Fraction):return str(x)
 if isinstance(x,dict):return {k:clean(v) for k,v in x.items()}
 if isinstance(x,(list,tuple)):return [clean(v) for v in x]
 return x
(dest/'arithmetic_check.json').write_text(json.dumps(clean(r),indent=2)+'\n');print({'records':len(records),'CKM':checks,'eta':[float(x) for x in eta],'proton':[float(x) for x in pr]})
