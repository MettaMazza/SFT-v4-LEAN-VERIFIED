from pathlib import Path
import json,sys,subprocess,os,itertools,re,hashlib
from fractions import Fraction as F
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import odd_lattice_all_region_terminal_law_v1 as src
q=json.dumps
def enc(x):
 if isinstance(x,F):return [x.numerator,x.denominator]
 if isinstance(x,(list,tuple)):return list(map(enc,x))
 return x
def arg(x):
 if isinstance(x,F):return f'(LeptonIntervals.normalize ({x.numerator}) {x.denominator} (by decide))'
 if isinstance(x,bool):return '(.boolean '+str(x).lower()+')'
 return '(.integer ('+str(x)+'))'
counts=[False,True,-2,0,1,2,3,5,7,9,15];steps=[False,0,1,2,3];ops=[('is_odd','isOdd',[(n,) for n in counts],'Value.boolean'),('complete_lattice','completeLattice',[(n,) for n in counts],'ratList'),('fold_lattice_index','foldLatticeIndex',list(itertools.product(counts,counts)),'natValue'),('fold_index_trace','foldIndexTrace',list(itertools.product([0,1,2,5,True],counts,steps)),'natList'),('folded_lattice','foldedLattice',list(itertools.product(counts,steps)),'ratList'),('positive_region_label','positiveRegionLabel',list(itertools.product([F(-1),F(0),F(1,4),F(1,2),F(2,3),F(1),F(3,2)],counts)),'natValue'),('occupancy_vector','occupancyVector',list(itertools.product(counts,steps,[False,0,1,2,3,5,8])),'natList')]
s='''import SFT.Physics.OddLatticeAllRegion
import SFT.Host.Canonical
open SFT.Physics OddLatticeAllRegion SFT.Host.Canonical
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def ratList (xs : List Rat) : Value := .array (xs.map frac)
def natValue (n : Nat) : Value := .integer (.ofNat n)
def natList (xs : List Nat) : Value := .array (xs.map natValue)
def result (f : α → Value) : Except String α → Value | .ok x => f x | .error e => .object [("error",.text e)]
#eval IO.println (render (.array [
''';fields=[];expected=[];numbers={}
for py,lean,args,render in ops:
 numbers[py]=len(args)
 for a in args:
  try:e=enc(getattr(src,py)(*a))
  except (ValueError,IndexError) as ex:e={'error':str(ex)}
  expected.append(e);fields.append('result '+render+' ('+lean+' '+' '.join(map(arg,a))+')')
s+=',\n'.join(fields)+']))\n';p=w/'constants-recovery/OddLatticeCore972.lean';p.write_text(s);env={**os.environ,'LEAN_PATH':str(c/'.lake/build/lib/lean')};binary='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';out=subprocess.check_output([binary,'-j1',str(p)],env=env,text=True);actual=json.loads(out);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:10]
m=c/'SFT/Physics/OddLatticeAllRegion.lean';ds=['SFT.Physics.OddLatticeAllRegion.'+n for n in re.findall(r'^def (\w+)',m.read_text(),re.M)];p=w/'constants-recovery/OddLatticeCoreAudit972.lean';p.write_text('import SFT.Physics.OddLatticeAllRegion\n'+'\n'.join('#print axioms '+d for d in ds));audit=subprocess.check_output([binary,'-j1',str(p)],env=env,text=True);(w/'oddlattice972_core_audit.log').write_text(audit);assert all("'"+d+"' does not depend on any axioms" in audit for d in ds)
(w/'oddlattice972_core_report.json').write_text(json.dumps(dict(status='PASS',cases=numbers,total_cases=len(expected),declarations=ds,axioms=[],lean_sha256=hashlib.sha256(m.read_bytes()).hexdigest()),indent=2));print('PASS',len(expected),'source cases;',len(ds),'empty declarations')
