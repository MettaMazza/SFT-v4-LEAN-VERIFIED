from pathlib import Path
import subprocess,os,json
w=Path('work').resolve();r=w/'constants-recovery';env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'),LEAN_NUM_THREADS='1');reports=[]
for m in ['SuperconductivityLabelClosure','SuperconductivityRecurrenceProofs','CollectiveSuperconductivity','SuperconductivityJointHistory','SuperconductivityGrammar','SuperconductivityEvidence','SuperconductivityExperiment','SuperconductivityValidation','SuperconductivityValidationProofs']:
 cmd=['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','-o',str(r/'.lake/build/lib/lean/SFT/Physics'/(m+'.olean')),'-c',str(r/'.lake/build/ir/SFT/Physics'/(m+'.c')),'SFT/Physics/'+m+'.lean'];p=subprocess.run(cmd,cwd=r,env=env,text=True,capture_output=True);(w/('build552_'+m+'.log')).write_text(p.stdout+p.stderr);reports.append(dict(module=m,command=cmd,exit=p.returncode));assert p.returncode==0,p.stdout+p.stderr
 if m != 'SuperconductivityValidationProofs':subprocess.run(['/Users/dolltrading/.elan/bin/leanc','-O2','-c',str(r/'.lake/build/ir/SFT/Physics'/(m+'.c')),'-o',str(r/'.lake/build/ir/SFT/Physics'/(m+'.c.o.export'))],check=True)
 print(m,'built',flush=True)
(w/'build_collective552_report.json').write_text(json.dumps(reports,indent=2))
