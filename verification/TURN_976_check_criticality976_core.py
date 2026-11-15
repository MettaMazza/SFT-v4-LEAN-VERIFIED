from pathlib import Path
import sys,json,os,subprocess,itertools,re,hashlib
from fractions import Fraction as F
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import coupled_map_criticality_terminal_law_v1 as src
counts=[False,True,-2,-1,0,1,2,3,5,7];parts=[F(-1),F(0),F(1,8),F(1,3),F(1,2),F(2,3),F(3,4),F(1),F(2)]
def arg(x):
 if isinstance(x,bool):return '(.boolean '+str(x).lower()+')'
 if isinstance(x,F):return f'(LeptonIntervals.normalize ({x.numerator}) {x.denominator} (by decide))'
 return '(.integer ('+str(x)+'))'
s='''import SFT.Physics.CoupledMapCriticality
import SFT.Host.Canonical
open SFT.Physics CoupledMapCriticality SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def nat (n : Nat) : Value := .integer (.ofNat n)
def result (f : α → Value) : Except String α → Value | .ok v => f v | .error e => .object [("error",.text e)]
#eval IO.println (render (.array [
''';expected=[];fields=[];cases={}
for name,lean,render,args in [('positive_label_count','positiveLabelCount','nat',[(x,) for x in counts]),('holding_threshold','holdingThreshold','frac',[(x,) for x in counts]),('retained_transverse_multiplier','retainedTransverseMultiplier','frac',itertools.product(counts,parts)),('stability_class','stabilityClass','Value.text',itertools.product(counts,parts))]:
 n=0
 for a in args:
  try:e=getattr(src,name)(*a);e=[e.numerator,e.denominator] if isinstance(e,F) else e
  except ValueError as ex:e={'error':str(ex)}
  expected.append(e);fields.append('result '+render+' ('+lean+' '+' '.join(map(arg,a))+')');n+=1
 cases[name]=n
p=w/'constants-recovery/CriticalityCore976.lean';p.write_text(s+',\n'.join(fields)+']))\n');env={**os.environ,'LEAN_PATH':str(c/'.lake/build/lib/lean')};binary='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';out=subprocess.check_output([binary,'-j1',str(p)],env=env,text=True);assert json.loads(out)==expected
m=c/'SFT/Physics/CoupledMapCriticality.lean';ds=['SFT.Physics.CoupledMapCriticality.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',m.read_text(),re.M)];p=w/'constants-recovery/CriticalityCoreAudit976.lean';p.write_text('import SFT.Physics.CoupledMapCriticality\n'+'\n'.join('#print axioms '+d for d in ds));out=subprocess.check_output([binary,'-j1',str(p)],env=env,text=True);(w/'criticality976_core_audit.log').write_text(out);assert all("'"+d+"' does not depend on any axioms" in out for d in ds)
(w/'criticality976_core_report.json').write_text(json.dumps(dict(status='PASS',cases=cases,total_cases=len(expected),declarations=ds,axioms=[],source_sha256=hashlib.sha256(m.read_bytes()).hexdigest()),indent=2));print('PASS',len(expected),'originalcases;',len(ds),'emptydeclarations')
