from pathlib import Path
import sys,os,json,subprocess,hashlib,itertools,dataclasses
w=Path('work');r=w/'turn1064_recovery';source=w/'pinned1120/sft/chemistry/isotope_exchange_law_v1.py'
assert hashlib.sha256(source.read_bytes()).hexdigest()=='8020c83a3cd234074d80695493dd9b615671030fce80bead491fbc26a03a81d4'
sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry
sft.chemistry.__path__=[str(source.parent.resolve())]+list(sft.chemistry.__path__)
from sft.chemistry import isotope_exchange_law_v1 as v
from sft.engine.exact import HeldLabel,PositiveCount
from sft.claim_evidence import EMPTY_ONE
def output(fn):
 try:
  x=fn()
  if isinstance(x,v.IsotopeExchangeState):y=[x.quotient.numerator,x.quotient.denominator]
  elif x==EMPTY_ONE:y='empty-One'
  elif isinstance(x,tuple):y=[x[0].family,x[0].label,x[1].value]
  else:y=[x.family,x.label]
  return {'ok':y}
 except v.InadmissibleExactValue as e:return {'error':str(e)}
constructors=[]
for mask in range(32):
 for si in [False,True]:
  for sc in [False,True]:
   families=['element','isotope','isotope','chemical-carrier','chemical-carrier'];labels=['oxygen','light','light'if si else'heavy','A','A'if sc else'B']
   constructors.append(output(lambda:v.IsotopeExchangeState(*[HeldLabel('wrong'if mask&(1<<i)else f,l)for i,(f,l)in enumerate(zip(families,labels))],*[PositiveCount(x)for x in [4,2,3,1]])))
states=[v._before,v._after]+[v._state(*x)for x in itertools.product([1,2],repeat=4)]
transitions=[output(lambda:v.exchange_transition(a,b))for a in states for b in states]
transitions.append(output(lambda:v.exchange_transition(v._before,dataclasses.replace(v._after,element=HeldLabel('element','other')))))
expected=dict(constructors=constructors,states=[output(lambda:s)for s in states],transitions=transitions,events=[output(lambda:v.event_balance(PositiveCount(f),PositiveCount(r)))for f in range(1,5)for r in range(1,5)],witnesses=[x[2]for x in v.OPERATIONAL_WITNESSES])
(w/'isotopeexchange1124_expected.json').write_text(json.dumps(expected))
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run','work/IsotopeExchangeProgram1124.lean']
with(w/'isotopeexchange1124_output.json').open('w')as out,(w/'isotopeexchange1124_execution.log').open('w')as err:subprocess.run(cmd,env=env,stdout=out,stderr=err,check=True)
actual=json.loads((w/'isotopeexchange1124_output.json').read_text());assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
report=dict(status='PASS',cases={k:len(v)for k,v in actual.items()},source_sha256=hashlib.sha256((r/'SFT/Chemistry/IsotopeExchange.lean').read_bytes()).hexdigest(),original_sha256=hashlib.sha256(source.read_bytes()).hexdigest(),all_fields_and_errors_match=True)
(w/'isotopeexchange1124_report.json').write_text(json.dumps(report,indent=2)+'\n');print(report)
