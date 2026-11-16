from pathlib import Path
import sys,json,hashlib,subprocess,os
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.chemistry.state_energy_order_validation_v1 import prediction_program_document,_identities
root=(w/'v3-runtime500').resolve();ids=_identities(root);names=[str(x['species_row_id'])for x in ids];expected=prediction_program_document(root)
h=w/'StateEnergyPredictionProgram1082.lean';h.write_text('import SFT.Chemistry.StateEnergyOrderPrediction\nopen SFT.Host SFT.Chemistry.StateEnergyOrderPrediction\ndef main : IO Unit := IO.println (Canonical.render (programDocument ['+','.join(json.dumps(n)for n in names)+']))\n')
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean');cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(h)]
with(w/'stateenergy1082_prediction_output.json').open('w')as out,(w/'stateenergy1082_prediction_execution.log').open('w')as err:run=subprocess.run(cmd,env=env,stdout=out,stderr=err)
assert run.returncode==0
assert json.loads((w/'stateenergy1082_prediction_output.json').read_text())==expected
report=dict(status='PASS',identities=len(ids),species=len(dict.fromkeys(names)),instructions=len(expected['instructions']),source_sha256=hashlib.sha256((r/'SFT/Chemistry/StateEnergyOrderPrediction.lean').read_bytes()).hexdigest());(w/'stateenergy1082_prediction_report.json').write_text(json.dumps(report,indent=2)+'\n');print(report)
