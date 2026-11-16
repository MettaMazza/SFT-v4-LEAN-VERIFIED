from pathlib import Path
import sys,json,subprocess,os,hashlib,re
w=Path('work');r=w/'turn1064_recovery';runtime=(w/'v3-runtime500').resolve();sys.path.insert(0,str(runtime))
from sft.chemistry import conjugated_support_validation_v1 as src
rows=src._identities(runtime);expected=src.prediction_program_document(runtime);q=lambda x:json.dumps(str(x),ensure_ascii=False)
leanRows=['⟨'+','.join(q(row[k])for k in src.IDENTITY_KEYS)+'⟩'for row in rows]
p=w/'ConjugatedPredictionProgram1078.lean';p.write_text('import SFT.Chemistry.ConjugatedSupportPrediction\nopen SFT.Chemistry.ConjugatedSupportPrediction\ndef main : IO Unit := IO.println (SFT.Host.Canonical.render (programDocument ['+','.join(leanRows)+']))\n')
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(p)]
with (w/'conjugated1078_prediction_output.json').open('w')as out,(w/'conjugated1078_prediction_execution.log').open('w')as err:run=subprocess.run(cmd,env=env,stdout=out,stderr=err)
assert run.returncode==0,run.returncode
actual=json.loads((w/'conjugated1078_prediction_output.json').read_text());assert actual==expected
log=(w/'conjugated1078_prediction_build2.log').read_text();names=re.findall(r"'([^']+)' does not depend on any axioms",log);assert len(names)==3 and 'depends on axioms:'not in log
report=dict(status='PASS',registered_identities=len(rows),instructions=len(expected['instructions']),all_fields_match=True,axioms=[],declarations=names,source_sha256=hashlib.sha256((r/'SFT/Chemistry/ConjugatedSupportPrediction.lean').read_bytes()).hexdigest())
(w/'conjugated1078_prediction_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS complete',len(expected['instructions']),'instruction original programme; three declarations zero axioms')
