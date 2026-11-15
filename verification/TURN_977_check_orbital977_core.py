from pathlib import Path
import sys,json,os,subprocess,itertools,re,hashlib
from fractions import Fraction as F
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import orbital_dimension_stability_terminal_law_v1 as src
counts=[False,True,-2,-1,0,1,*range(2,16)];ratios=[False,True,F(-1),F(0),F(1,2),F(1),F(3,2),F(2),F(5,2),F(17,8)]
def carg(x):return '(.boolean '+str(x).lower()+')' if isinstance(x,bool) else '(.integer ('+str(x)+'))'
def rarg(x):return '.nonFraction' if not isinstance(x,F) else f'(.fraction (LeptonIntervals.normalize ({x.numerator}) {x.denominator} (by decide)))'
def encode(x):
 if isinstance(x,F):return [x.numerator,x.denominator]
 if isinstance(x,tuple):return list(map(encode,x))
 return x
s='''import SFT.Physics.OrbitalDimensionStability
import SFT.Physics.LeptonIntervals
import SFT.Host.Canonical
open SFT.Physics OrbitalDimensionStability SFT.Host.Canonical SFT.Foundation.ExactOperations
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def frac (q : PositiveFraction) : Value := .array [.integer (.ofNat q.numerator),.integer (.ofNat q.denominator)]
def pair (qs : PositiveFraction × PositiveFraction) : Value := .array [frac qs.1,frac qs.2]
def nat (n : Nat) : Value := .integer (.ofNat n)
def result (f : α → Value) : Except String α → Value | .ok v => f v | .error e => .object [("error",.text e)]
#eval IO.println (render (.array [
''';expected=[];fields=[];cases={}
for name,lean,render,args,encs in [('spatial_dimension','spatialDimension','nat',[(x,) for x in counts],[carg]),('outward_ratio','outwardRatio','frac',[(x,) for x in ratios],[rarg]),('displaced_magnitudes','displacedMagnitudes','pair',itertools.product(counts,ratios),[carg,rarg]),('orbital_stability_class','orbitalStabilityClass','Value.text',itertools.product(counts,ratios),[carg,rarg])]:
 n=0
 for a in args:
  try:e=encode(getattr(src,name)(*a))
  except ValueError as ex:e={'error':str(ex)}
  expected.append(e);fields.append('result '+render+' ('+lean+' '+' '.join(fn(x) for fn,x in zip(encs,a))+')');n+=1
 cases[name]=n
p=w/'constants-recovery/OrbitalCore977.lean';p.write_text(s+',\n'.join(fields)+']))\n');env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};binary='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';out=subprocess.check_output([binary,'-j1',str(p)],env=env,text=True);assert json.loads(out)==expected
m=r/'SFT/Physics/OrbitalDimensionStability.lean';ds=['SFT.Physics.OrbitalDimensionStability.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',m.read_text(),re.M)];p=w/'constants-recovery/OrbitalCoreAudit977.lean';p.write_text('import SFT.Physics.OrbitalDimensionStability\n'+'\n'.join('#print axioms '+d for d in ds));out=subprocess.check_output([binary,'-j1',str(p)],env=env,text=True);(w/'orbital977_core_audit.log').write_text(out);assert all("'"+d+"' does not depend on any axioms" in out for d in ds)
(w/'orbital977_core_report.json').write_text(json.dumps(dict(status='PASS',cases=cases,total_cases=len(expected),declarations=ds,axioms=[],source_sha256=hashlib.sha256(m.read_bytes()).hexdigest()),indent=2));print('PASS',len(expected),'originalcases;',len(ds),'emptydeclarations')
