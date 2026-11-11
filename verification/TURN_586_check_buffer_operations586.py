from pathlib import Path
import sys,itertools,json,os,subprocess
sys.path.insert(0,'work')
from buffer_spec586 import namespace,pin
cases=list(itertools.product(range(1,6),repeat=2));expected=[];terms=[]
for a,b in cases:
 row=namespace['BufferReservoir'](namespace['_PAIR'],namespace['PositiveCount'](a),namespace['PositiveCount'](b))
 expected.append('|'.join(x.family+':'+x.label for x in row.response_modes))
 terms.append('⟨initial.pair,⟨'+str(a)+',by decide⟩,⟨'+str(b)+',by decide⟩⟩')
s='import SFT.Chemistry.BufferReservoir\nopen SFT.Chemistry.BufferReservoir\ndef cases : List Reservoir := ['+','.join(terms)+']\ndef main : IO Unit := cases.forM fun x => do\n let modes := responseModes x\n IO.println (modes.1.family++":"++modes.1.label++"|"++modes.2.family++":"++modes.2.label)\n'
p=Path('work/BufferCases586.lean');p.write_text(s);env=dict(os.environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve()));r=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','--run',str(p)],env=env,capture_output=True,text=True);Path('work/buffer_operations586.log').write_text(r.stdout+r.stderr);assert r.returncode==0,r.stdout+r.stderr;assert r.stdout.splitlines()==expected
Path('work/buffer_operations586_report.json').write_text(json.dumps(dict(source_commit=pin,status='PASS',response_mode_cases=len(cases),cases=cases,outputs=expected),indent=2));print('PASS',len(cases),'source response-mode cases')
