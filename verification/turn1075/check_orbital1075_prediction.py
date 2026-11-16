import sys,json,os,subprocess,re,hashlib
from pathlib import Path
w=Path('work');root=(w/'v3-runtime500').resolve();sys.path.insert(0,str(root))
from sft.chemistry.orbital_support_validation_v1 import prediction_program_document
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str((w/'turn1064_recovery').resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
r=subprocess.run(cmd+['work/orbital1075_prediction_check.lean'],env=env,capture_output=True,text=True);(w/'orbital1075_prediction_check.log').write_text(r.stdout+r.stderr);assert r.returncode==0,r.stdout[-1500:]
actual=json.loads(r.stdout);assert actual==prediction_program_document(root)
p=w/'turn1064_recovery/SFT/Chemistry/OrbitalSupportPrediction.lean';names=['SFT.Chemistry.OrbitalSupportPrediction.'+n for n in re.findall(r'^def (\w+)',p.read_text(),re.M)];audit=w/'orbital1075_prediction_audit.lean';audit.write_text('import SFT.Chemistry.OrbitalSupportPrediction\n'+''.join('#print axioms '+n+'\n'for n in names));a=subprocess.run(cmd+[str(audit)],env=env,capture_output=True,text=True);(w/'orbital1075_prediction_audit.log').write_text(a.stdout+a.stderr);assert a.returncode==0 and a.stdout.count('does not depend on any axioms')==len(names),a.stdout
(w/'orbital1075_prediction_report.json').write_text(json.dumps(dict(status='PASS',all_program_fields_match=True,instructions=len(actual['instructions']),native_electron_predictions=22,axioms=[],declarations=names,source_sha256=hashlib.sha256(p.read_bytes()).hexdigest()),indent=2)+'\n');print('PASS full source prediction program:',len(actual['instructions']),'instructions;',len(names),'zero-axiom declarations')
