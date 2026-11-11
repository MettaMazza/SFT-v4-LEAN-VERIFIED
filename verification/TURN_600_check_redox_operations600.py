from pathlib import Path
import sys,itertools,json,os,subprocess
sys.path.insert(0,'work')
from redox_spec600 import namespace,q,pin
H=namespace['HeldLabel'];cases=[];expected=[];terms=[]
for donor,acceptor,family in itertools.product(['',' ','a','b'],['',' ','a','b'],['electron-carrier','other-family']):
 try:namespace['RedoxTransfer'](H(family,'electron-one'),donor,acceptor);result='ok'
 except Exception as e:result=str(e)
 cases.append([donor,acceptor,family]);expected.append(result);terms.append('⟨⟨'+q(family)+',"electron-one",rfl,rfl⟩,'+q(donor)+','+q(acceptor)+'⟩')
p=Path('work/RedoxCases600.lean');p.write_text('import SFT.Chemistry.RedoxTransfer\nopen SFT.Chemistry.RedoxTransfer\ndef cases : List Raw := ['+','.join(terms)+']\ndef main : IO Unit := cases.forM fun x => IO.println (match admit x with | .ok _ => "ok" | .error e => e)\n');env=dict(os.environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve()));o=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','--run',str(p)],env=env,capture_output=True,text=True);Path('work/redox_operations600.log').write_text(o.stdout+o.stderr);assert o.returncode==0,o.stdout+o.stderr;assert o.stdout.splitlines()==expected
Path('work/redox_operations600_report.json').write_text(json.dumps(dict(source_commit=pin,status='PASS',constructor_cases=len(cases),cases=cases,outputs=expected),indent=2));print('PASS',len(cases),'constructor cases')
