from pathlib import Path
from fractions import Fraction
from math import comb,prod
from itertools import product
import ast,json,hashlib,copy
root=Path(__file__).resolve().parents[1];dest=root
g={'Fraction':Fraction,'comb':comb,'prod':prod}
def load(path,names=None):
 tree=ast.parse((root/'v3'/path).read_text());nodes=[n for n in tree.body if isinstance(n,ast.FunctionDef) and (names is None or n.name in names)];exec(compile(ast.Module(body=nodes,type_ignores=[]),path,'exec'),g)
source='sft/physics/spin_statistics_condensation_terminal_law_v1.py';load(source);cert=g['theorem_certificate']();assert cert==dict(occupation=True,weights=True,cold=True,spin=True)
censuses=[]
for n in range(1,7):
 for l in range(1,7):
  c=g['occupation_census'](n,l);assert c['complete'];assert c['boson_vectors']==tuple(w for w in product(range(n+1),repeat=l) if sum(w)==n);assert c['fermion_vectors']==tuple(w for w in product(range(2),repeat=l) if sum(w)==n);assert len(set(c['boson_vectors']))==c['boson_count'];minimum=g['minimal_throw_ground_certificate'](n,l);assert minimum=={'least_total_throw':n,'survivors':((n,)+(0,)*(l-1),),'unique':True};censuses.append({'N':n,'L':l,'census':c,'minimum':minimum})
weights=[]
for l in range(2,6):
 for n in range(1,l+1):
  for exchange in ['preserving','alternating']:
   for d in range(1,5):
    ws=g['canonical_occupation_weights'](n,l,exchange,d);assert sum(w for _,w in ws)==1;assert all(w>0 for _,w in ws)
    weights.append({'N':n,'L':l,'exchange':exchange,'depth':d,'rows':ws})
crossings=[]
for m in range(2,6):
 for l in range(2,6):
  for n in range(2,7):
   c=g['critical_condensation_certificate'](n,l,m);assert c['prior_below'] and c['ground_share']>=Fraction(m-1,m);assert all(row[1]<c['lock_share'] for row in c['rows'][:-1]);assert all(a[1]<b[1] for a,b in zip(c['rows'],c['rows'][1:]));assert c['critical_mean_throw']==g['canonical_mean_throw'](n,l,'preserving',c['critical_depth']);crossings.append(c)
validation='sft/physics/spin_statistics_condensation_validation_v1.py';load(validation,['exact_spin_statistics_analysis']);recordpath='experiments/external_sources/physics/snapshots/spin-statistics-condensation-postseal-source-record.json';record=json.loads((root/'v3'/recordpath).read_text());target=record['registered_target'];analysis=g['exact_spin_statistics_analysis'](target);assert len(analysis)==15 and analysis['bec_interval']==(89,99) and analysis['spinor_interval']==(666,742);assert all(v for v in analysis.values());bad=copy.deepcopy(target);bad['spinor_measured_return_degrees_center']=600;assert not g['exact_spin_statistics_analysis'](bad)['spinor_interval_contains_forced_return'];bad=copy.deepcopy(target);bad['bec_ground_share_increases_as_temperature_is_lowered']=False;assert not g['exact_spin_statistics_analysis'](bad)['bec_cooling_direction'];bad['bec_ground_share_increases_as_temperature_is_lowered']=1;assert not g['exact_spin_statistics_analysis'](bad)['bec_cooling_direction']
hashes={}
for row in record['sources']:
 path=row['snapshot_path'];h=hashlib.sha256((root/'v3'/path).read_bytes()).hexdigest();assert 'sha256:'+h==row['snapshot_hash'];hashes[path]=h
for path in [source,validation,recordpath]:hashes[path]=hashlib.sha256((root/'v3'/path).read_bytes()).hexdigest()
assert hashes[recordpath]=='9d24c12e31092f34854c71c3dce2b355dd1d1f2ae6347a03bbea45ef01508cfa'
guards=[]
for args in [(True,2,'preserving'),(0,2,'preserving'),(2,0,'preserving'),(2,2,'other')]:
 try:g['occupation_vectors'](*args)
 except ValueError as e:guards.append({'args':args,'error':str(e)})
 else:raise AssertionError('invalid accepted')
for args in [(2,1,2),(2,2,1)]:
 try:g['critical_condensation_certificate'](*args)
 except ValueError as e:guards.append({'args':args,'error':str(e)})
 else:raise AssertionError('invalid accepted')
assert g['canonical_occupation_weights'](3,2,'alternating')==()
try:g['canonical_mean_throw'](3,2,'alternating',1)
except ValueError as e:guards.append({'args':[3,2,'alternating',1],'error':str(e)})
else:raise AssertionError('empty mean accepted')
r={'status':'PASS','method':'Unchanged pinned original function bodies; full original four-field certificate, ordered occupation outputs versus independent Cartesian enumeration, exact rational weights, minimum and first-crossing records, complete15field measured analysis, original adverse controls, strict Boolean boundary, source digests and input guards. Native general proofs retained separately.','source_sha256':hashes,'certificate':cert,'censuses':censuses,'weights':weights,'crossings':crossings,'spin':g['exchange_spin_census'](),'return':g['spin_return_certificate'](),'analysis':analysis,'guards':guards}
dest.mkdir(parents=True,exist_ok=True);(dest/'arithmetic_check.json').write_text(json.dumps(r,indent=2,default=lambda x:str(x) if isinstance(x,Fraction) else None)+'\n');print({'status':'PASS','censuses':len(censuses),'weights':len(weights),'crossings':len(crossings),'analysis_fields':len(analysis),'source_digests':len(hashes),'guard_errors':len(guards),'example':g['critical_condensation_certificate'](2,2,3)})
