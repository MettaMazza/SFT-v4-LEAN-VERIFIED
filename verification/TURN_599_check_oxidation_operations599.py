from pathlib import Path
import sys,itertools,json,os,subprocess
sys.path.insert(0,'work')
from oxidation_spec599 import namespace,q,pin
H=namespace['HeldLabel'];P=namespace['PositiveCount'];cases=[];expected=[];terms=[]
for atom,family,traceFamily,count in itertools.product(['',' ','atom-a','atom-b'],['oxidation-orientation','other-family'],['empty','bond-electron-assignment','other-family'],[1,3]):
 trace=[] if traceFamily=='empty' else [H(traceFamily,'bond-electron-one')]
 try:namespace['OxidationAssignment'](atom,P(count),H(family,'held'),tuple(trace));result='ok'
 except Exception as e:result=str(e)
 cases.append([atom,family,traceFamily,count]);expected.append(result)
 tr='[]' if not trace else '[⟨'+q(traceFamily)+',"bond-electron-one",rfl,rfl⟩]'
 terms.append('⟨'+q(atom)+',⟨'+str(count)+',by decide⟩,⟨'+q(family)+',"held",rfl,rfl⟩,'+tr+'⟩')
p=Path('work/OxidationCases599.lean');p.write_text('import SFT.Chemistry.OxidationAssignment\nopen SFT.Chemistry.OxidationAssignment\ndef cases : List Raw := ['+','.join(terms)+']\ndef main : IO Unit := cases.forM fun x => IO.println (match admit x with | .ok _ => "ok" | .error e => e)\n');env=dict(os.environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve()));o=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','--run',str(p)],env=env,capture_output=True,text=True);Path('work/oxidation_operations599.log').write_text(o.stdout+o.stderr);assert o.returncode==0,o.stdout+o.stderr;assert o.stdout.splitlines()==expected
Path('work/oxidation_operations599_report.json').write_text(json.dumps(dict(source_commit=pin,status='PASS',constructor_cases=len(cases),cases=cases,outputs=expected),indent=2));print('PASS',len(cases),'constructor cases')
