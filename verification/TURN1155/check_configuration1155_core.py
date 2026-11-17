from pathlib import Path
import sys,json,subprocess,os,itertools,hashlib
w=Path('work');root=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned1155/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry import configuration_order_law_v1 as m
from sft.claim_evidence.fold_language import EMPTY_ONE,EmptyOne
from sft.claim_evidence import PositiveRatio
from sft.engine.exact import HeldLabel
heights=[EMPTY_ONE,EmptyOne('other'),PositiveRatio.from_pair(1,1),PositiveRatio.from_pair(1,2),PositiveRatio.from_pair(2,1),PositiveRatio.from_pair(3,2)]
hs=['.emptyOne','(.otherEmptyOne "other")','(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩)','(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩)','(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩)','(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩)']
lean=['import SFT.Chemistry.ConfigurationOrder','open SFT.Chemistry.ConfigurationOrder','def display : Except String Bool → String',' | .error e => "error:"++e',' | .ok b => toString b','def main : IO Unit := do'];expected=[]
for indices in itertools.product(range(len(heights)),repeat=3):
 nodes=tuple(m.ConfigurationNode(HeldLabel('molecular-carrier','ethanol'),HeldLabel('configuration-coordinate',str(i)),heights[x],HeldLabel('configuration-record',str(i)))for i,x in enumerate(indices));path=m.ConfigurationPath(nodes)
 for method,native in [('local_minimum','localMinimum'),('local_barrier','localBarrier')]:
  for pos in [-1,0,1,2,3]:
   try:result=str(getattr(path,method)(pos)).lower()
   except Exception as e:result='error:'+str(e)
   expected.append(result)
 # Generate loops separately to keep Lean source compact.
lean+=[' let heights : List Height := ['+','.join(hs)+']',' for a in heights do','  for b in heights do','   for c in heights do','    let x ← IO.ofExcept (witnessNode "0" a)','    let y ← IO.ofExcept (witnessNode "1" b)','    let z ← IO.ofExcept (witnessNode "2" c)','    for kind in [true,false] do','     for pos in ([-1,0,1,2,3] : List Int) do','      IO.println (display (localComparison kind [x,y,z] pos))']
p=w/'ConfigurationParity1155.lean';p.write_text('\n'.join(lean)+'\n');env=dict(os.environ,LEAN_PATH=str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean')+':'+str(root.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
a=subprocess.run([sys.executable,'work/run_lean_guarded.py',str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean'),'-j1','-M8192','--run',str(p)],env=env,capture_output=True,text=True);(w/'configuration1155_parity.log').write_text(a.stdout+a.stderr);assert a.returncode==0,a.stdout[-1500:];actual=a.stdout.splitlines();assert actual==expected,[(i,x,y)for i,(x,y)in enumerate(zip(actual,expected))if x!=y][:5]
h=lambda p:hashlib.sha256(p.read_bytes()).hexdigest();(w/'configuration1155_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expected),native_sha256=h(root/'SFT/Chemistry/ConfigurationOrder.lean'),source_sha256=h(w/'pinned1155/sft/chemistry/configuration_order_law_v1.py')),indent=2)+'\n');print('PASS',len(expected),'original path method outcomes including exact ratios, structural singleton/non-singleton and position guards')
