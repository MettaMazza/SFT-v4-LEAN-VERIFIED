from pathlib import Path
import sys,os,json,re,subprocess,tempfile,concurrent.futures,dataclasses
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.mathematics.calculator_complete.explorer import RegisteredMathematicsExplorer
from sft.mathematics.catalog import SPECS
from sft.mathematics.generated_law import survivor_id
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')}
def q(x):return json.dumps(x,ensure_ascii=False)
def ls(xs):return '['+','.join(q(x)for x in xs)+']'
head='''import SFT.Mathematics.CalculatorCompleteExplorer
open SFT.Mathematics SFT.Host SFT.Host.Canonical CalculatorCompleteExplorer
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def product : List (List String) → List (List String)
 | [] => [[]]
 | x::xs => x.flatMap fun a => (product xs).map fun rest => a::rest
def result : Except String Value → Value | .ok v => .object [("ok",v)] | .error e => .object [("error",.text e)]
'''
specs=[]
for s in SPECS:
 fields=[('claimId',q(s.claim_id)),('title',q(s.title)),('statement',q(s.statement)),('dependencies',ls(s.dependencies)),('grammarBoundary',q(s.grammar_boundary)),('exactResult',q(s.exact_result)),('laws',ls(s.laws)),('limitations',q(s.limitations)),('dimensionSizes',str([len(d.choices)for d in s.dimensions])),('candidateIds','(product ['+','.join(ls([c.name for c in d.choices])for d in s.dimensions)+']).map (Text.intercalate "__")'),('survivorId',q(survivor_id(s))),('witnesses','['+','.join('('+q(x.name)+','+str(x.passed).lower()+')'for x in s.witnesses)+']')]
 specs.append('{'+','.join(k+' := '+v for k,v in fields)+'}')
base=head+''.join('def spec'+str(i)+' : Spec := '+s+'\n'for i,s in enumerate(specs))+'def explorer : Explorer := {specs := ['+','.join('spec'+str(i)for i in range(len(specs)))+']}\n'
# Root absent: exact source fallback through catalog dependencies, no made-up graph.
with tempfile.TemporaryDirectory() as d:
 py=RegisteredMathematicsExplorer(Path(d));expected=[]
 for s in SPECS:
  expected.append([dataclasses.asdict(py.summary(s.claim_id)),dataclasses.asdict(py.replay(s.claim_id)),py.replay(s.claim_id).to_json()])
 expected=json.loads(json.dumps(expected))
def batch(i):
 id=q(SPECS[i].claim_id);code=base+'#eval IO.println (render (result (do\n let a ← summary explorer '+id+'\n let b ← replay explorer '+id+'\n let c ← replayJSON explorer '+id+'\n pure (.array [a,b,.text c]))))\n';p=w/f'calculator1024_explorer_check{i}.lean';p.write_text(code);x=subprocess.run([lean,'-j1','-M12288',str(p)],env=env,capture_output=True,text=True);(w/f'calculator1024_explorer_check{i}.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];assert json.loads(x.stdout)=={'ok':expected[i]},i;return i
with concurrent.futures.ThreadPoolExecutor(max_workers=12)as pool:done=list(pool.map(batch,range(len(SPECS))))
s=(r/'SFT/Mathematics/CalculatorCompleteExplorer.lean').read_text();names=re.findall(r'^def (\w+)',s,re.M);p=w/'calculator1024_explorer_audit.lean';p.write_text('import SFT.Mathematics.CalculatorCompleteExplorer\n'+''.join('#print axioms SFT.Mathematics.CalculatorCompleteExplorer.'+n+'\n'for n in names));x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'calculator1024_explorer_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
report=dict(status='PASS',complete_summaries=25,complete_replays=25,complete_JSON=25,axioms=[],declarations=names,scope='Exact explorer operations on all original catalog projections and full candidate records. Native catalog integration remains separately staged.');(w/'calculator1024_explorer_report.json').write_text(json.dumps(report,indent=2));print(report)
