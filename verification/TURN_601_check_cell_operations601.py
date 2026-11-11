from pathlib import Path
import sys,itertools,json,os,subprocess
sys.path.insert(0,'work')
from cell_spec601 import namespace,q,pin
cases=[];expected=[];terms=[]
for a,b,ep,ip in itertools.product(['','a','b'],['','a','b'],[[],['a'],['a','b'],['a','wire','b'],['b','a']],[[],[''],['b','a'],['x','y']]):
 try:namespace['ElectrochemicalCell'](a,b,tuple(ep),tuple(ip));result='ok'
 except Exception as e:result=str(e)
 cases.append([a,b,ep,ip]);expected.append(result);terms.append('⟨'+q(a)+','+q(b)+',['+','.join(q(x) for x in ep)+'],['+','.join(q(x) for x in ip)+']⟩')
p=Path('work/CellCases601.lean');p.write_text('import SFT.Chemistry.ElectrochemicalCell\nopen SFT.Chemistry.ElectrochemicalCell\ndef cases : List Raw := ['+','.join(terms)+']\ndef main : IO Unit := cases.forM fun x => IO.println (match admit x with | .ok _ => "ok" | .error e => e)\n');env=dict(os.environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve()));o=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','--run',str(p)],env=env,capture_output=True,text=True);Path('work/cell_operations601.log').write_text(o.stdout+o.stderr);assert o.returncode==0,o.stdout+o.stderr;assert o.stdout.splitlines()==expected
Path('work/cell_operations601_report.json').write_text(json.dumps(dict(source_commit=pin,status='PASS',constructor_cases=len(cases),cases=cases,outputs=expected),indent=2));print('PASS',len(cases),'constructor cases')
