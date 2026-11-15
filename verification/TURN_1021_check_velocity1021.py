from pathlib import Path
import sys,json,subprocess,os,re,hashlib,concurrent.futures
from fractions import Fraction as F
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');runtime=w/'v3-runtime500';sys.path.insert(0,str(runtime.resolve()))
from sft.physics import velocity_composition_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
rel='sft/physics/velocity_composition_terminal_law_v1.py';pinned=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show','76f1b34e9e9682989adcbb088797b4ae4ce4fcf1:'+rel]);assert (runtime/rel).read_bytes()==pinned
expected=[];expr=[]
def q(x):return f'(SFT.Physics.LeptonIntervals.normalize ({x.numerator}) {x.denominator} (by decide))'
def motion(x):return '.rest' if x is src.REST else '(.speed '+q(x)+')'
def record(f,args,e,kind):
 try:expected.append({'ok':canonical_value(f(*args))})
 except ValueError as ex:expected.append({'error':str(ex)})
 expr.append('out '+kind+' ('+e+')')
vals=[F(-1),F(0),F(1,8),F(1,4),F(1,3),F(1,2),F(2,3),F(3,4),F(7,8),F(1),F(2)]
for a in vals:
 record(src._speed,[a],'speed '+q(a),'rational');record(src.held_pair,[a],'heldPair '+q(a),'pair')
 for b in vals:
  record(src.compose_same_direction,[a,b],'composeSameDirection '+motion(a)+' '+motion(b),'motionValue')
  record(src.compose_held_pairs,[a,b],'composeHeldPairs '+q(a)+' '+q(b),'pair')
  for n in [False,True]:
   for d in [False,True]:record(src.candidate_value,[a,b,n,d],'candidateValue '+q(a)+' '+q(b)+' '+str(n).lower()+' '+str(d).lower(),'rational')
for a in [src.REST]+vals:
 for b in [src.REST]:
  record(src.compose_same_direction,[a,b],'composeSameDirection '+motion(a)+' '+motion(b),'motionValue');record(src.compose_same_direction,[b,a],'composeSameDirection '+motion(b)+' '+motion(a),'motionValue')
for f in vals:
 for h in [src.EMPTY]+vals:
  if h is not src.EMPTY and f>h and f+h==0:continue
  record(src.recover_speed,[(f,h)],'recoverSpeed ⟨'+q(f)+','+('.empty' if h is src.EMPTY else '.part '+q(h))+'⟩','rational')
header='''import SFT.Physics.VelocityComposition
import SFT.Host.Canonical
open SFT.Physics.VelocityComposition SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def rational (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def motionValue : Motion → Value | .rest => .text "typed-rest-motion" | .speed q => rational q
def heldValue : Held → Value | .empty => .text "typed-empty-held-part" | .part q => rational q
def pair (p : Pair) : Value := .array [rational p.forward,heldValue p.held]
def out (f : α → Value) : Except String α → Value | .ok x => .object [("ok",f x)] | .error e => .object [("error",.text e)]
'''
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')}
def batch(i):
 p=w/f'constants-recovery/Velocity1021_{i}.lean';p.write_text(header+'#eval IO.println (render (.array ['+',\n'.join(expr[i:i+100])+']))\n');x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/f'velocity1021_batch{i}.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];return json.loads(x.stdout)
with concurrent.futures.ThreadPoolExecutor(max_workers=8) as pool:actual=[a for rows in pool.map(batch,range(0,len(expr),100)) for a in rows]
assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:5]
p=r/'SFT/Physics/VelocityComposition.lean';names=['SFT.Physics.VelocityComposition.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',p.read_text(),re.M)];audit=w/'velocity1021_audit.lean';audit.write_text('import SFT.Physics.VelocityComposition\n'+''.join('#print axioms '+n+'\n' for n in names));x=subprocess.run([lean,str(audit)],env=env,capture_output=True,text=True);(w/'velocity1021_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
report=dict(status='PASS',cases=len(expected),declarations=names,axioms=[],source_sha256=hashlib.sha256(p.read_bytes()).hexdigest(),original_sha256=hashlib.sha256(pinned).hexdigest());(w/'velocity1021_report.json').write_text(json.dumps(report,indent=2));print(json.dumps(report))
