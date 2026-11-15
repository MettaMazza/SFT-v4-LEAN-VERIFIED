from pathlib import Path
import sys,json,os,subprocess,tempfile,dataclasses
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.mathematics.calculator_complete import evidence as e
from sft.mathematics.calculator_complete.explorer import RegisteredMathematicsExplorer
from sft.mathematics.calculator import values as v
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')}
def q(x):return json.dumps(x,ensure_ascii=False)
head='''import SFT.Mathematics.CalculatorCompleteExplorer
open SFT.Mathematics SFT.Host.Canonical CalculatorCompleteEvidence
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def result : Except String Value → Value | .ok v => .object [("ok",v)] | .error e => .object [("error",.text e)]
'''
# Original validation inspects certificates, but does not add an interval-order test.
empty=v.EMPTY_ONE if hasattr(v,'EMPTY_ONE')else v.EmptyOne()
from fractions import Fraction
invalid=object.__new__(v.CertifiedInterval);object.__setattr__(invalid,'lower',empty);object.__setattr__(invalid,'upper',empty);object.__setattr__(invalid,'certificate',())
reversed=object.__new__(v.CertifiedInterval);object.__setattr__(reversed,'lower',v.forward(2));object.__setattr__(reversed,'upper',v.forward(1));object.__setattr__(reversed,'certificate',('held',))
inputs=[(1.0,'.other true'),(object(),'.other false'),(invalid,'.value (.interval ⟨.emptyOne,.emptyOne,[]⟩)'),(reversed,'.value (.interval ⟨.positive .forward ⟨2,1,by decide,by decide,by decide⟩,.positive .forward ⟨1,1,by decide,by decide,by decide⟩,["held"]⟩)')]
expected=[];codes=[]
for py,le in inputs:
 try:expected.append({'ok':e.validate_value(py)})
 except TypeError as ex:expected.append({'error':str(ex)})
 codes.append('result (validateInput ('+le+'))')
code=head+'#eval IO.println (render (.array ['+','.join(codes)+']))\n'
graphs=[{'a':['b','c'],'b':['d'],'c':['d'],'d':[]},{'a':['b'],'b':['a']},{'a':['a','b','b'],'b':[]},{'a':[]},{'a':['missing']},{}];chains=[]
with tempfile.TemporaryDirectory()as d:
 root=Path(d)
 for graph in graphs:
  import shutil
  shutil.rmtree(root/'claims',ignore_errors=True)
  for name,deps in graph.items():
   path=root/'claims'/name;path.mkdir(parents=True);(path/'registration.json').write_text(json.dumps({'dependencies':deps}))
  py=RegisteredMathematicsExplorer(root);chains.append(list(py.dependency_chain('a')))
  regs='['+','.join('('+q(k)+',['+','.join(q(x)for x in ds)+'])'for k,ds in graph.items())+']'
  code+='#eval IO.println (render (.array ((CalculatorCompleteExplorer.dependencyChain {specs:=[],registrations:='+regs+'} "a").map Value.text)))\n'
p=w/'calculator1024_boundaries.lean';p.write_text(code);x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'calculator1024_boundaries.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-4000:];rows=[json.loads(x)for x in x.stdout.splitlines()];assert rows[0]==expected;assert rows[1:]==chains
(w/'calculator1024_boundaries_report.json').write_text(json.dumps(dict(status='PASS',runtime_boundary_cases=4,dependency_graph_cases=6,source_order_and_cycles=True),indent=2));print('PASS4runtimeboundaries and6dependencygraphs')
