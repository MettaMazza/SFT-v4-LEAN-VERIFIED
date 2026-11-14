from pathlib import Path
import sys,json,subprocess,os,itertools,re,hashlib
from fractions import Fraction as F
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import coupled_ensemble_synchronization_terminal_law_v1 as src
values=[F(-1),F(0),F(1,8),F(1,4),F(1,3),F(1,2),F(2,3),F(3,4),F(1),F(2)];counts=[False,True,-1,0,1,2,3,5,8]
def enc(x):
 if isinstance(x,F):return [x.numerator,x.denominator]
 if isinstance(x,(list,tuple)):return list(map(enc,x))
 return x
def arg(x):
 if isinstance(x,F):return f'(LeptonIntervals.normalize ({x.numerator}) {x.denominator} (by decide))'
 if isinstance(x,bool):return '(.boolean '+str(x).lower()+')'
 return '(.integer ('+str(x)+'))'
s='''import SFT.Physics.CoupledEnsembleSynchronization
import SFT.Host.Canonical
open SFT.Physics CoupledEnsembleSynchronization SFT.Host.Canonical
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def list (xs : List Rat) : Value := .array (xs.map frac)
def pair (xs : Rat × Rat) : Value := .array [frac xs.1,frac xs.2]
def scale : Scale → Value | .empty => .array [] | .positive q => frac q
def result (f : α → Value) : Except String α → Value | .ok x => f x | .error e => .object [("error",.text e)]
#eval IO.println (render (.array [
''';fields=[];expected=[];numbers={}
ops=[('positive_take','positiveTake',itertools.product(values,values),'frac'),('pair_separation','pairSeparation',itertools.product(values,values),'frac'),('paired_move','pairedMove',itertools.product(values,values,values),'pair'),('residual_record','residualRecord',itertools.product(values,values,values),'list'),('residual_scale','residualScale',[(v,) for v in values],'scale'),('synchronized_ensemble_successor','synchronizedEnsembleSuccessor',itertools.product(values,counts),'list'),('unique_pair_synchronizing_coupling','uniquePairSynchronizingCoupling',[()],'frac')]
for py,lean,args,render in ops:
 count=0
 for a in args:
  try:e=enc(getattr(src,py)(*a))
  except ValueError as ex:e={'error':str(ex)}
  expected.append(e);fields.append('result '+render+' ('+lean+' '+' '.join(map(arg,a))+')');count+=1
 numbers[py]=count
p=w/'constants-recovery/SynchronizationCore973.lean';p.write_text(s+',\n'.join(fields)+']))\n');env={**os.environ,'LEAN_PATH':str(c/'.lake/build/lib/lean')};binary='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';out=subprocess.check_output([binary,'-j1',str(p)],env=env,text=True);actual=json.loads(out);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:5]
m=c/'SFT/Physics/CoupledEnsembleSynchronization.lean';ds=['SFT.Physics.CoupledEnsembleSynchronization.'+n for n in re.findall(r'^(?:def|inductive) (\w+)',m.read_text(),re.M)];p=w/'constants-recovery/SynchronizationCoreAudit973.lean';p.write_text('import SFT.Physics.CoupledEnsembleSynchronization\n'+'\n'.join('#print axioms '+d for d in ds));audit=subprocess.check_output([binary,'-j1',str(p)],env=env,text=True);(w/'synchronization973_core_audit.log').write_text(audit);assert all("'"+d+"' does not depend on any axioms" in audit for d in ds)
(w/'synchronization973_core_report.json').write_text(json.dumps(dict(status='PASS',cases=numbers,total_cases=len(expected),declarations=ds,axioms=[],lean_sha256=hashlib.sha256(m.read_bytes()).hexdigest()),indent=2));print('PASS',len(expected),'original cases',len(ds),'empty declarations')
