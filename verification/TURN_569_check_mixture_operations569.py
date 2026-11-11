from pathlib import Path
import json,subprocess,os
ns={};exec(Path('work/mixture_spec569.py').read_text(),ns);sc=ns['namespace'];cases=[[],[('A',1,1)],[('A',1,2),('B',1,2)],[('A',1,3),('B',2,3)],[('A',1,3),('B',1,3)],[('A',1,2),('A',1,2)],[('A',1,4),('B',1,4),('C',1,2)]];expected=[];expr=[]
for rows in cases:
 try:
  result=sc['exact_composition'](tuple(sc['CompositionComponent'](label,sc['ExactPart'].from_pair(n,d)) for label,n,d in rows));expected.append(len(rows)>=2)
 except sc['InadmissibleExactValue']:expected.append(False)
 expr.append('['+','.join('⟨'+json.dumps(label)+',SFT.Foundation.ExactOperations.normalizePart '+str(n)+' '+str(d)+' (by decide) (by decide),(by decide)⟩' for label,n,d in rows)+']')
s='import SFT.Chemistry.MixtureSupport\nopen SFT.Chemistry.MixtureSupport\ndef main : IO Unit := do\n'+'\n'.join(' IO.println (toString (admitted ⟨⟨'+e+',.text "portion",[]⟩,.text "recorded phases"⟩))' for e in expr)+'\n'
r=Path('work/constants-recovery').resolve();(r/'MixtureOperations569.lean').write_text(s);p=subprocess.run(['/Users/dolltrading/.elan/bin/lean','--run','MixtureOperations569.lean'],cwd=r,env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),capture_output=True,text=True);Path('work/mixture_operations569.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout+p.stderr;actual=[x=='true' for x in p.stdout.splitlines()];assert actual==expected,(actual,expected);Path('work/mixture_operations569_report.json').write_text(json.dumps(dict(status='PASS',source_commit=ns['pin'],cases=len(cases),results=actual,fresh_native_execution=True,compares='original exact_composition operation plus source-stated multiple-constituent requirement; unchanged exact composition proof reused'),indent=2));print('PASS',len(cases),'mixture cases')
