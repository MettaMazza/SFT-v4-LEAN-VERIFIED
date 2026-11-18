from pathlib import Path
from fractions import Fraction
import ast,json,hashlib,copy
root=Path(__file__).resolve().parents[1];dest=root;dest.mkdir(exist_ok=True)
hashes={}
def load(name,extra=None,only=None):
 f=root/'v3/sft/physics'/(name+'.py');g={'Fraction':Fraction};g.update(extra or {});hashes[str(f.relative_to(root/'v3'))]=hashlib.sha256(f.read_bytes()).hexdigest()
 for n in ast.parse(f.read_text()).body:
  if isinstance(n,ast.FunctionDef) and (only is None or n.name in only):exec(compile(ast.fix_missing_locations(ast.Module(body=[ast.ImportFrom(module='__future__',names=[ast.alias(name='annotations')],level=0),n],type_ignores=[])),str(f),'exec'),g)
  elif isinstance(n,ast.Assign) and len(n.targets)==1 and isinstance(n.targets[0],ast.Name):
   try:g[n.targets[0].id]=ast.literal_eval(n.value)
   except (ValueError,TypeError):
    if isinstance(n.value,ast.Call) and isinstance(n.value.func,ast.Name) and n.value.func.id=='Fraction':g[n.targets[0].id]=Fraction(*(ast.literal_eval(x) for x in n.value.args))
 return g


g=load('landauer_demon_ledger_terminal_law_v1');record=json.loads((root/'v3/experiments/external_sources/physics/snapshots/landauer-erasure-source-record.json').read_text());assert 'sha256:'+hashlib.sha256((root/'v3/experiments/external_sources/physics/snapshots/landauer-erasure-source-record.json').read_bytes()).hexdigest()=='sha256:76a746eb8760816598724a2db17fb7cd1f3a07325e69193525d313fecea4d27f'
pre=g['reset_preimages']();assert pre==(Fraction(1,4),Fraction(3,4));images=tuple(g['fold_part'](x) for x in pre);assert images==(Fraction(1,2),)*2
assert g['erased_distinction_count']()==1 and g['minimum_throw']()==Fraction(1,2)
cycle=g['demon_cycle_ledger']();assert cycle=={'sorting_gain':('gas-speed-class',),'memory_support':('lower-preimage','upper-preimage'),'reset_image':('ready-half-One',),'erased_distinctions':1,'environment_record':('environment-reverse-label',),'complete':True}
labels={v:g['reset_is_reversible_with_record'](v) for v in ['lower-preimage','upper-preimage','','ready-half-One','environment-reverse-label']};assert list(labels.values())==[True,True,False,False,False]
cases=[(Fraction(n,d),g['fold_part'](Fraction(n,d))) for d in range(1,17) for n in range(1,d+1)]
for x,y in cases:assert (y==Fraction(1,2))==(x in pre)
guards=[]
for x in [Fraction(0),Fraction(-1),Fraction(5,4),0.5,True]:
 try:g['fold_part'](x)
 except ValueError:guards.append(str(x))
 else:raise AssertionError(x)
finite=[]
for k in [0,1,2,16,64]:
 rows=[g['demon_cycle_ledger']() for _ in range(k)];gain=sum((list(v['sorting_gain']) for v in rows),[]);env=sum((list(v['environment_record']) for v in rows),[]);closed=sum(v['erased_distinctions'] for v in rows);assert len(gain)==len(env)==closed==k;finite.append({'cycles':k,'gain':gain,'environment':env,'closed':closed})
def clean(x):
 if isinstance(x,Fraction):return str(x)
 if isinstance(x,dict):return {k:clean(v) for k,v in x.items()}
 if isinstance(x,(list,tuple)):return [clean(v) for v in x]
 return x
out={'source_sha256':hashes,'preimages':pre,'images':images,'erased_distinctions':1,'native_throw':Fraction(1,2),'cycle':cycle,'labels':labels,'fold_cases':cases,'rejected_inputs':guards,'finite_ledgers':finite,'registered_source_record':record,'method':'Unchanged original operations; finite displays accompany existing arbitrary finite-ledger and complete-fibre native proofs. Original four-row empirical label comparison retained.'};(dest/'arithmetic_check.json').write_text(json.dumps(clean(out),indent=2)+'\n');print({'status':'PASS','fold_cases':len(cases),'guards':len(guards),'finite_ledgers':len(finite)})
