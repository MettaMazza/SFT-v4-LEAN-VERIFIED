from pathlib import Path
import sys,json,subprocess,os,hashlib,itertools,re
w=Path('work');root=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.chemistry import conjugated_support_law_v1 as src
q=lambda x:json.dumps(x,ensure_ascii=False)
ls=lambda xs:'['+','.join(q(x)for x in xs)+']'
expected=[];expr=[]
def label(x):return [x.family,x.label]
def norm(x):
 if isinstance(x,src.ExactConjugatedSupport):return [label(x.carrier),[label(v)for v in x.atoms],[label(v)for v in x.support_fibres]]
 if isinstance(x,src.HeldLabel):return label(x)
 if isinstance(x,src.PositiveCount):return x.value
 if isinstance(x,tuple):return [norm(v)for v in x]
 return x
def add(name,e,fn):
 try:out={'ok':norm(fn())}
 except(ValueError,IndexError)as err:out={'error':str(err)}
 expected.append([name,out]);expr.append('('+q(name)+','+e+')')
for f in ['fold-fibre-one','fold-fibre-two','one','',' ']:add('fibre-'+f,'result labelValue (fibre '+q(f)+')',lambda f=f:src.fibre(f))
for n in range(8):
 atoms=[str(i+1)for i in range(n)]
 variants=[['fold-fibre-one'if i%2==0 else'fold-fibre-two'for i in range(max(0,n-1))],['fold-fibre-two'if i%2==0 else'fold-fibre-one'for i in range(max(0,n-1))],['fold-fibre-one']*max(0,n-1),['fold-fibre-one']*n,['bad']*max(0,n-1)]
 for j,fs in enumerate(variants):
  call='conjugatedSupport "carrier" '+ls(atoms)+' '+ls(fs)
  add(f'construct-{n}-{j}','result supportValue ('+call+')',lambda atoms=atoms,fs=fs:src.conjugated_support('carrier',tuple(atoms),tuple(fs)))
  try:support=src.conjugated_support('carrier',tuple(atoms),tuple(fs))
  except ValueError:continue
  for op,fn,ser in [('atomCount',lambda s:s.atom_count,'countValue'),('supportCount',lambda s:s.support_count,'countValue'),('incidences',lambda s:s.incidences,'incidenceValues')]:
   add(f'{op}-{n}-{j}','result '+ser+' (do let support ← '+call+'; '+op+' support)',lambda support=support,fn=fn:fn(support))
  for fresh in ['new',atoms[0],'']:
   add(f'append-{n}-{j}-{fresh}','result supportValue (do let support ← '+call+'; appendOpposedFibre support '+q(fresh)+')',lambda support=support,fresh=fresh:src.append_opposed_fibre(support,fresh))
for atoms,fs,carrier in [(['a','a','b'],['fold-fibre-one','fold-fibre-two'],'carrier'),(['a','','b'],['fold-fibre-one','fold-fibre-two'],'carrier'),(['a','b','c'],['fold-fibre-one','fold-fibre-two'],'')]:
 add('guard-'+repr(atoms)+carrier,'result supportValue (conjugatedSupport '+q(carrier)+' '+ls(atoms)+' '+ls(fs)+')',lambda atoms=atoms,fs=fs,carrier=carrier:src.conjugated_support(carrier,tuple(atoms),tuple(fs)))
harness='''import SFT.Chemistry.ConjugatedSupport
open SFT.Host SFT.Physics.CapabilityValues SFT.Chemistry.ConjugatedSupport
abbrev V := Canonical.Value
def labelValue (x : HeldLabel) : V := .array [.text x.family,.text x.label]
def countValue (x : PositiveCount) : V := .integer (.ofNat x.value)
def supportValue (x : ExactConjugatedSupport) : V := .array [labelValue x.carrier,.array (x.atoms.map labelValue),.array (x.supportFibres.map labelValue)]
def incidenceValues (xs : List (HeldLabel × HeldLabel × HeldLabel)) : V := .array (xs.map (fun (a,b,c) => .array [labelValue a,labelValue b,labelValue c]))
def result {α : Type} (f : α → V) : Except String α → V
 | .error e => .object [("error",.text e)]
 | .ok x => .object [("ok",f x)]
def main : IO Unit := IO.println (Canonical.render (.array (rows.map (fun (name,value) => .array [.text name,value]))))
'''
harness=harness.replace('def main :','def rows : List (String × V) := [\n'+',\n'.join(expr)+'\n]\ndef main :')
hp=w/'ConjugatedProgram1077.lean';hp.write_text(harness)
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(root.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(hp)]
with (w/'conjugated1077_core_output.json').open('w')as out,(w/'conjugated1077_core_execution.log').open('w')as err:r=subprocess.run(cmd,env=env,stdout=out,stderr=err)
assert r.returncode==0,r.returncode
actual=json.loads((w/'conjugated1077_core_output.json').read_text());assert actual==expected,[(a,b)for a,b in zip(actual,expected)if a!=b][:2]
log=(w/'conjugated1077_core.log').read_text();names=re.findall(r"'([^']+)' does not depend on any axioms",log);assert len(names)==10 and 'depends on axioms:'not in log
report=dict(status='PASS',source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',cases=len(expected),declarations=names,axioms=[],source_sha256=hashlib.sha256((root/'SFT/Chemistry/ConjugatedSupport.lean').read_bytes()).hexdigest())
(w/'conjugated1077_core_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS',len(expected),'fresh original source operations;10 declarations empty axioms')
