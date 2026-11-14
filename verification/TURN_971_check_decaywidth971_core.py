from pathlib import Path
import json,sys,subprocess,os,itertools,re,hashlib
from fractions import Fraction as F
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import decay_width_branching_lifetime_terminal_law_v1 as src
q=json.dumps
def enc(x):
 if isinstance(x,F):return [x.numerator,x.denominator]
 if isinstance(x,(list,tuple)):return list(map(enc,x))
 return x
def rat(x):return f'(LeptonIntervals.normalize ({x.numerator}) {x.denominator} (by decide))'
def arg(x):
 if isinstance(x,F):return rat(x)
 if isinstance(x,(tuple,list)):return '['+','.join(map(arg,x))+']'
 return f'({x})'
xs=[F(-1),F(0),F(1,4),F(1,2),F(1),F(3,2)]
families=[[]]+[list(t) for n in range(1,5) for t in itertools.product(xs[2:5],repeat=n)]+[[F(0)],[F(-1),F(1)],[F(1),F(0)]]
ops=[('positive_carrier','positiveCarrier',list(itertools.product(range(-1,5),repeat=2)),'frac'),('partial_transition_width','partialTransitionWidth',list(itertools.product(xs,repeat=3)),'frac'),('total_transition_width','totalTransitionWidth',[(v,) for v in families],'frac'),('branching_parts','branchingParts',[(v,) for v in families],'ratList'),('complete_branching_partition','completeBranchingPartition',[(v,) for v in families],'frac'),('lifetime_from_width','lifetimeFromWidth',list(itertools.product(xs,repeat=2)),'frac'),('append_open_channel','appendOpenChannel',[(v,x) for v in families[:15] for x in xs],'ratList'),('successor_total_increment','successorTotalIncrement',[(v,x) for v in families[:15] for x in xs],'frac'),('wider_state_lifetime_take','widerStateLifetimeTake',list(itertools.product(xs,repeat=3)),'frac'),('sample_partial_widths','samplePartialWidths',[()],'ratList')]
s='''import SFT.Physics.DecayWidthBranchingLifetime
import SFT.Host.Canonical
open SFT.Physics DecayWidthBranchingLifetime SFT.Host.Canonical
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def ratList (xs : List Rat) : Value := .array (xs.map frac)
def result (f : α → Value) : Except String α → Value | .ok x => f x | .error e => .object [("error",.text e)]
#eval IO.println (render (.array [
''';fields=[];expected=[];counts={}
for py,lean,args,render in ops:
 counts[py]=len(args)
 for aa in args:
  try:v=enc(getattr(src,py)(*aa))
  except ValueError as e:v={'error':str(e)}
  expected.append(v);fields.append(f'result {render} ({lean} '+' '.join(map(arg,aa))+')')
p=w/'constants-recovery/DecayWidthCompare971.lean';p.write_text(s+',\n'.join(fields)+']))\n')
env={**os.environ,'LEAN_PATH':str(c/'.lake/build/lib/lean')};tool='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';out=subprocess.check_output([tool,'-j1',str(p)],env=env,text=True);a=json.loads(out);assert a==expected,[(i,a[i],v) for i,v in enumerate(expected) if a[i]!=v][:6]
module=c/'SFT/Physics/DecayWidthBranchingLifetime.lean';decls=re.findall(r'^def (\w+)',module.read_text(),re.M);p=w/'constants-recovery/DecayWidthAudit971.lean';p.write_text('import SFT.Physics.DecayWidthBranchingLifetime\n'+'\n'.join('#print axioms SFT.Physics.DecayWidthBranchingLifetime.'+d for d in decls)+'\n');audit=subprocess.check_output([tool,'-j1',str(p)],env=env,text=True);(w/'decaywidth971_core_audit.log').write_text(audit);assert audit.count('does not depend on any axioms')==len(decls)
(w/'decaywidth971_core_report.json').write_text(json.dumps({'status':'PASS','total_cases':len(expected),'cases':counts,'declarations':decls,'axioms':[],'lean_sha256':hashlib.sha256(module.read_bytes()).hexdigest()},indent=2)+'\n');print('PASS',len(expected),'source cases;',len(decls),'empty declarations')
