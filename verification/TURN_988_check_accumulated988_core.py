from pathlib import Path
import sys,subprocess,json,os,hashlib,re
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');root=w/'v3-runtime500';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';rel='sft/physics/coupling_accumulated_separation_terminal_law_v1.py';data=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':'+rel]);(root/rel).write_bytes(data);sys.path.insert(0,str(root.resolve()));from sft.physics import coupling_accumulated_separation_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
count=lambda x:'.boolean '+str(x).lower() if isinstance(x,bool) else '.integer ('+str(x)+')'
s='''import SFT.Physics.AccumulatedSeparation
import SFT.Host.Canonical
open SFT.Physics.AccumulatedSeparation SFT.Host.Canonical
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
for n in [False,True,-5,-1,0,1,2,3,4,5,6,7,8,12,16,24,32,64]:
 for fn,lean,cv in [('binary_support','binarySupport','nv'),('adjacent_sector_gap','adjacentSectorGap','frac'),('finite_partial_accumulation','finitePartialAccumulation','frac'),('successor_is_below_half','successorIsBelowHalf','Value.boolean'),('accumulation_is_bounded','accumulationIsBounded','Value.boolean')]:
  case(lambda fn=fn,n=n:getattr(src,fn)(n),'result '+cv+' ('+lean+' ('+count(n)+'))')
for a in [False,True,-1,0,1,2,3,5,8]:
 for b in [False,True,-1,0,1,2,3,5,8,12]:case(lambda a=a,b=b:src.finite_tail_envelope(a,b),'result Value.boolean (finiteTailEnvelope ('+count(a)+') ('+count(b)+'))')
p=w/'constants-recovery/AccumulatedCore988.lean';p.write_text(s+'#eval IO.println (render (.array [\n'+',\n'.join(expr)+']))\n');env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};proc=subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env=env,capture_output=True,text=True);(w/'accumulated988_core_lean.log').write_text(proc.stdout+proc.stderr);assert proc.returncode==0,proc.stdout[-2000:];actual=json.loads(proc.stdout);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:3]
p=r/'SFT/Physics/AccumulatedSeparation.lean';code=p.read_text();names=re.findall(r'^(?:def|theorem) (\w+)',code,re.M);audit=w/'accumulated988_core_audit.lean';audit.write_text('import SFT.Physics.AccumulatedSeparation\n'+''.join('#print axioms SFT.Physics.AccumulatedSeparation.'+n+'\n' for n in names));out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean',str(audit)],env=env,text=True);(w/'accumulated988_core_audit.log').write_text(out);assert out.count('does not depend on any axioms')==len(names)
(w/'accumulated988_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expected),declarations=names,axioms=[],lean_sha256=hashlib.sha256(code.encode()).hexdigest(),original_source_sha256=hashlib.sha256(data).hexdigest()),indent=2));print('PASS',len(expected),'sourcecases;',len(names),'emptydeclarations')
