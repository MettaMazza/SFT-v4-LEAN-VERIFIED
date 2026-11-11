from pathlib import Path
import json,subprocess,os
ns={};exec(Path('work/composition_spec565.py').read_text(),ns);scope=ns['namespace'];F=scope['Fraction'];Component=scope['CompositionComponent'];Part=scope['ExactPart'];q=lambda x:json.dumps(x,ensure_ascii=False)
cases=[[], [('A',1,1)],[('A',1,3),('B',2,3)],[('A',1,2),('B',1,2)],[('A',1,2),('A',1,2)],[('A',1,3),('B',1,3)],[('A',1,1),('B',1,1)],[('',1,1)],[(' \t\n',1,1)],[('\u2003',1,1)],[(' A ',1,2),('A',1,2)],[('a',1,2),('A',1,2)],[('A',1,1000000007),('B',1000000006,1000000007)]]
expected=[];expressions=[]
for rows in cases:
 try:out=scope['exact_composition'](tuple(Component(i,Part.from_pair(n,d)) for i,n,d in rows));expected.append({'ok':[[x.identity,x.part.value.numerator,x.part.value.denominator] for x in out]})
 except scope['InadmissibleExactValue'] as e:expected.append({'error':str(e)})
 terms=[]
 for i,n,d in rows:
  f=F(n,d);terms.append('('+q(i)+',(⟨'+str(f.numerator)+','+str(f.denominator)+',by decide,by decide,by decide,by decide⟩ : SFT.Foundation.ExactPartCarrier.Part))')
 expressions.append('['+','.join(terms)+']')
s='import SFT.Chemistry.ExactComposition\nopen SFT.Chemistry.ExactComposition SFT.Host.Canonical\ndef run (xs : List (String × SFT.Foundation.ExactPartCarrier.Part)) : Value :=\n let result := xs.mapM (fun x => makeComponent x.1 x.2) >>= exactComposition\n match result with\n | .error e => .object [("error",.text e)]\n | .ok rows => .object [("ok",.array (rows.map fun c => .array [.text c.identity,.integer (Int.ofNat c.part.numerator),.integer (Int.ofNat c.part.denominator)]))]\ndef main : IO Unit := do\n'
s+='\n'.join(' IO.println (render (run '+x+'))' for x in expressions)+'\n';r=Path('work/constants-recovery').resolve();(r/'CompositionOperations565.lean').write_text(s);env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'));p=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','--run','CompositionOperations565.lean'],cwd=r,env=env,text=True,capture_output=True);Path('work/composition_operations565.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout+p.stderr;actual=[json.loads(x) for x in p.stdout.splitlines()];assert actual==expected,(actual,expected);Path('work/composition_operations565_report.json').write_text(json.dumps({'status':'PASS','source_commit':ns['pin'],'cases':len(cases),'results':actual,'fresh_native_execution':True},indent=2));print('PASS',len(cases),'exact pinned-source operation cases')
