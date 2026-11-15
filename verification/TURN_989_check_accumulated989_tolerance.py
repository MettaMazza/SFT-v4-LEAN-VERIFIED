from pathlib import Path
import sys,subprocess,json,os,hashlib,re
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');root=w/'v3-runtime500';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';rel='sft/physics/coupling_accumulated_separation_terminal_law_v1.py';data=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':'+rel]);(root/rel).write_bytes(data);sys.path.insert(0,str(root.resolve()));from sft.physics import coupling_accumulated_separation_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
count=lambda x:'.boolean '+str(x).lower() if isinstance(x,bool) else '.integer ('+str(x)+')'
s='''import SFT.Physics.AccumulatedSeparationTolerance
import SFT.Host.Canonical
open SFT.Physics.AccumulatedSeparationTolerance SFT.Host.Canonical
def nv (n : Nat) : Value := .integer (.ofNat n)
def frac (x : Rat) : Value := .object [("numerator",.integer x.num),("denominator",nv x.den)]
def result (f : α → Value) : Except String α → Value | .error e => .object [("error",.text e)] | .ok x => f x
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
''';expected=[];expr=[]
def case(call,code):
 try:v=canonical_value(call())
 except ValueError as e:v={'error':str(e)}
 expected.append(v);expr.append(code)
for n in [False,True,-5,-1,0,1,2,3,5,7,11,127,1024,10000,1000000]:
 for fn,lean,cv in [('tolerance_witness','toleranceWitness','nv'),('tolerance_is_witnessed','toleranceIsWitnessed','Value.boolean')]:
  case(lambda fn=fn,n=n:getattr(src,fn)(n),'result '+cv+' ('+lean+' ('+count(n)+'))')
p=w/'constants-recovery/AccumulatedTolerance989.lean';p.write_text(s+'#eval IO.println (render (.array [\n'+',\n'.join(expr)+']))\n');env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};proc=subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env=env,capture_output=True,text=True);(w/'accumulated989_tolerance_lean.log').write_text(proc.stdout+proc.stderr);assert proc.returncode==0,proc.stdout[-2000:];actual=json.loads(proc.stdout);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:3]
(w/'accumulated989_tolerance_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expected),source_sha256=hashlib.sha256(data).hexdigest()),indent=2));print('PASS',len(expected),'tolerance cases')
