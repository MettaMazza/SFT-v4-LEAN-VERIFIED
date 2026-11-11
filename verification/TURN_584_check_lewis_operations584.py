from pathlib import Path
import sys,itertools,json,os,subprocess
sys.path.insert(0,'work')
from lewis_spec584 import namespace,q,pin
H=namespace['HeldLabel'];cases=[];expected=[];terms=[]
labels=[H('electron-carrier','one'),H('electron-carrier','two'),H('proton-carrier','one')]
lists=[(),(labels[0],),(labels[2],)]+list(itertools.product(labels,repeat=2))+[(labels[0],labels[1],labels[0])]
for a,b,es in itertools.product(['',' ','a','b'],['a','b'],lists):
 try:namespace['LewisPairRelation'](a,b,es);result='ok'
 except Exception as e:result=str(e)
 cases.append([a,b,[(e.family,e.label) for e in es]]);expected.append(result)
 terms.append('⟨'+q(a)+','+q(b)+',['+','.join('⟨'+q(e.family)+','+q(e.label)+',rfl,rfl⟩' for e in es)+']⟩')
s='import SFT.Chemistry.LewisPair\nopen SFT.Chemistry.LewisPair\ndef cases : List Raw := ['+','.join(terms)+']\ndef main : IO Unit := cases.forM fun x => IO.println (match admit x with | .ok _ => "ok" | .error e => e)\n'
p=Path('work/LewisCases584.lean');p.write_text(s);env=dict(os.environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve()))
r=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','--run',str(p)],env=env,capture_output=True,text=True);Path('work/lewis_operations584.log').write_text(r.stdout+r.stderr);assert r.returncode==0,r.stdout+r.stderr;assert r.stdout.splitlines()==expected
Path('work/lewis_operations584_report.json').write_text(json.dumps(dict(source_commit=pin,status='PASS',constructor_cases=len(cases),cases=cases,outputs=expected),indent=2));print('PASS',len(cases),'original constructor cases')
