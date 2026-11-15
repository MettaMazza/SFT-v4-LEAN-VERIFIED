from pathlib import Path
import sys,json,os,subprocess,itertools,re,hashlib
from fractions import Fraction as F
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import post_newtonian_fixed_point_terminal_law_v1 as src
counts=[False,True,-2,-1,0,*range(1,9)];parts=[False,True,F(-1),F(0),F(1,32),F(7,32),F(1,4),F(1,2),F(1),F(7,4)]
def carg(x):return '(.boolean '+str(x).lower()+')' if isinstance(x,bool) else '(.integer ('+str(x)+'))'
def rarg(x):return '.nonFraction' if not isinstance(x,F) else f'(.fraction (LeptonIntervals.normalize ({x.numerator}) {x.denominator} (by decide)))'
def encode(x):
 if isinstance(x,F):return [x.numerator,x.denominator]
 if isinstance(x,(list,tuple)):return list(map(encode,x))
 if isinstance(x,dict):return {k:encode(v) for k,v in x.items()}
 return x
s='''import SFT.Physics.PostNewtonianFixedPoint
import SFT.Host.Canonical
open SFT.Physics PostNewtonianFixedPoint SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def structureValue (v : Structural) : Value := .object [("matter",frac v.matter),("coupling",frac v.coupling),("fixed",frac v.fixed)]
def fractions (xs : List Rat) : Value := .array (xs.map frac)
def result (f : α → Value) : Except String α → Value | .ok v => f v | .error e => .object [("error",.text e)]
#eval IO.println (render (.array [
''';expected=[];fields=[];cases={}
for name,lean,render,args,encs in [('structural_values','structuralValues','structureValue',[()],[]),('fixed_point_candidates','fixedPointCandidates','fractions',[()],[]),('admissible_fixed_points','admissibleFixedPoints','fractions',[()],[]),('self_source_successor','selfSourceSuccessor','frac',[(x,) for x in parts],[rarg]),('iterate','iterate','fractions',[(x,) for x in counts],[carg])]:
 n=0
 for a in args:
  try:e=encode(getattr(src,name)(*a))
  except ValueError as ex:e={'error':str(ex)}
  expected.append(e);fields.append('result '+render+' ('+lean+' '+' '.join(fn(x) for fn,x in zip(encs,a))+')');n+=1
 cases[name]=n
p=w/'constants-recovery/PostNewtonianCore978.lean';p.write_text(s+',\n'.join(fields)+']))\n');env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};binary='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';out=subprocess.check_output([binary,'-j1',str(p)],env=env,text=True);assert json.loads(out)==expected
m=r/'SFT/Physics/PostNewtonianFixedPoint.lean';ds=['SFT.Physics.PostNewtonianFixedPoint.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',m.read_text(),re.M)];p=w/'constants-recovery/PostNewtonianCoreAudit978.lean';p.write_text('import SFT.Physics.PostNewtonianFixedPoint\n'+'\n'.join('#print axioms '+d for d in ds));out=subprocess.check_output([binary,'-j1',str(p)],env=env,text=True);(w/'postnewtonian978_core_audit.log').write_text(out);assert all("'"+d+"' does not depend on any axioms" in out for d in ds)
(w/'postnewtonian978_core_report.json').write_text(json.dumps(dict(status='PASS',cases=cases,total_cases=len(expected),declarations=ds,axioms=[],source_sha256=hashlib.sha256(m.read_bytes()).hexdigest()),indent=2));print('PASS',len(expected),'originalcases;',len(ds),'emptydeclarations')
