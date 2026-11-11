from pathlib import Path
import sys,itertools,json,os,subprocess
sys.path.insert(0,'work')
from amphoteric_spec585 import namespace,q,pin
H=namespace['HeldLabel'];C=namespace['CarrierTransfer'];cases=[];expected=[];terms=[]
p=H('proton-carrier','one');events=[C(p,a,b) for a,b in itertools.permutations(['a','b','c'],2)]
def term(e):return '⟨⟨⟨"proton-carrier","one",rfl,rfl⟩,'+q(e.donor_identity)+','+q(e.acceptor_identity)+'⟩,rfl⟩'
for s,d,a in itertools.product(['',' ','a','b'],events,events):
 try:namespace['AmphotericRecord'](s,d,a);result='ok'
 except Exception as e:result=str(e)
 cases.append([s,d.donor_identity,d.acceptor_identity,a.donor_identity,a.acceptor_identity]);expected.append(result);terms.append('⟨'+q(s)+','+term(d)+','+term(a)+'⟩')
s='import SFT.Chemistry.Amphoteric\nopen SFT.Chemistry.Amphoteric\ndef cases : List Raw := ['+','.join(terms)+']\ndef main : IO Unit := cases.forM fun x => IO.println (match admit x with | .ok _ => "ok" | .error e => e)\n';p=Path('work/AmphotericCases585.lean');p.write_text(s);env=dict(os.environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve()));r=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','--run',str(p)],env=env,capture_output=True,text=True);Path('work/amphoteric_operations585.log').write_text(r.stdout+r.stderr);assert r.returncode==0,r.stdout+r.stderr;assert r.stdout.splitlines()==expected
Path('work/amphoteric_operations585_report.json').write_text(json.dumps(dict(source_commit=pin,status='PASS',constructor_cases=len(cases),cases=cases,outputs=expected),indent=2));print('PASS',len(cases),'original constructor cases')
