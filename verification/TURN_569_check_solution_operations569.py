from pathlib import Path
import json,subprocess,os
cases=[('liquid',['p','p'],['solvent','solute']),('solid',['p','p'],['solvent','solute']),('gas',['p','p'],['solvent','solute']),('unclassified',['p','p'],['solvent','solute']),('liquid',['p','q'],['solvent','solute']),('liquid',['p','p'],['solvent','solvent']),('liquid',['p','p'],['solute','solute'])]
expected=[True,True,False,False,False,False,False]
s='import SFT.Chemistry.SolutionSupport\nopen SFT.Chemistry.SolutionSupport\ndef half : SFT.Foundation.ExactPartCarrier.Part := SFT.Foundation.ExactOperations.normalizePart 1 2 (by decide) (by decide)\ndef main : IO Unit := do\n'
for kind,phases,roles in cases:
 rows='['+','.join('⟨⟨'+json.dumps(label)+',half,(by decide)⟩,'+json.dumps(phase)+',.'+role+'⟩' for label,phase,role in zip(['A','B'],phases,roles))+']'
 s+=' IO.println (toString (admitted ⟨'+rows+',"p",'+json.dumps(kind)+',.text "context",.text "portion",[]⟩))\n'
r=Path('work/constants-recovery').resolve();(r/'SolutionOperations569.lean').write_text(s);p=subprocess.run(['/Users/dolltrading/.elan/bin/lean','--run','SolutionOperations569.lean'],cwd=r,env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),capture_output=True,text=True);Path('work/solution_operations569.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout+p.stderr;actual=[x=='true' for x in p.stdout.splitlines()];assert actual==expected,(actual,expected)
Path('work/solution_operations569_report.json').write_text(json.dumps(dict(status='PASS',cases=len(cases),results=actual,fresh_native_execution=True,compares='source-stated solution phase, common-phase and solvent/solute partition boundaries; generic native proofs provide the universal checks; source has no separate executable solution helper'),indent=2));print('PASS',len(cases),'source-stated solution boundary cases')
