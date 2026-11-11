from pathlib import Path
import sys,itertools,json,os,subprocess
sys.path.insert(0,'work')
from affinity_spec587 import namespace,q,pin
H=namespace['HeldLabel'];cases=[];expected=[];terms=[]
for a,b,p,f in itertools.product(['',' ','a','b'],['a','b'],['a','b','c'],['shared-electron-support','electron-carrier']):
 try:namespace['AffinityComparison'](a,b,H(f,'support'),p);result='ok'
 except Exception as e:result=str(e)
 cases.append([a,b,p,f]);expected.append(result);terms.append('⟨'+q(a)+','+q(b)+',⟨'+q(f)+',"support",rfl,rfl⟩,'+q(p)+'⟩')
s='import SFT.Chemistry.AffinityComparison\nopen SFT.Chemistry.AffinityComparison\ndef cases : List Raw := ['+','.join(terms)+']\ndef main : IO Unit := cases.forM fun x => IO.println (match admit x with | .ok _ => "ok" | .error e => e)\n';p=Path('work/AffinityCases587.lean');p.write_text(s);env=dict(os.environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve()));r=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','--run',str(p)],env=env,capture_output=True,text=True);Path('work/affinity_operations587.log').write_text(r.stdout+r.stderr);assert r.returncode==0,r.stdout+r.stderr;assert r.stdout.splitlines()==expected
Path('work/affinity_operations587_report.json').write_text(json.dumps(dict(source_commit=pin,status='PASS',constructor_cases=len(cases),cases=cases,outputs=expected),indent=2));print('PASS',len(cases),'source constructor cases')
