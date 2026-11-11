from pathlib import Path
import sys,itertools,json,os,subprocess
sys.path.insert(0,'work')
from proton_spec583 import namespace,q,pin
cases=[];expected=[];terms=[]
for a,b,f in itertools.product(['',' ','a','b','\u2003','é'],['','a','b','\u2003'],['proton-carrier','electron-carrier']):
 p=namespace['HeldLabel'](f,'p')
 try: namespace['CarrierTransfer'](p,a,b); result='ok'
 except Exception as e:result=str(e)
 cases.append([a,b,f]);expected.append(result)
 terms.append('⟨⟨'+q(f)+',"p",rfl,rfl⟩,'+q(a)+','+q(b)+'⟩')
s='import SFT.Chemistry.ProtonTransfer\nopen SFT.Chemistry.ProtonTransfer\ndef cases : List Raw := ['+','.join(terms)+']\ndef main : IO Unit := cases.forM fun x => IO.println (match admit x with | .ok _ => "ok" | .error e => e)\n'
p=Path('work/ProtonCases583.lean');p.write_text(s)
env=dict(os.environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve()))
r=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','--run',str(p)],env=env,capture_output=True,text=True)
Path('work/proton_operations583.log').write_text(r.stdout+r.stderr)
assert r.returncode==0,r.stdout+r.stderr
assert r.stdout.splitlines()==expected
Path('work/proton_operations583_report.json').write_text(json.dumps(dict(source_commit=pin,status='PASS',constructor_cases=len(cases),cases=cases,outputs=expected),indent=2))
print('PASS',len(cases),'original constructor cases')
