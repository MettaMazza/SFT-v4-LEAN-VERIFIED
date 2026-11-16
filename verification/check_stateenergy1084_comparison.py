from pathlib import Path
import json,sys,subprocess,os,hashlib,types
w=Path('work');r=w/'turn1064_recovery';root=(w/'v3-runtime500').resolve();sys.path.insert(0,str(root))
from sft.chemistry import state_energy_order_validation_v1 as src
from sft.engine.canonical import canonical_value
original=src.sha256_identity;captured={}
def capture(value):
 if isinstance(value,dict)and 'pair_count'in value and 'comparisons'in value:captured.update(canonical_value(value))
 return original(value)
src.sha256_identity=capture
try:empirical=src.StateEnergyOrderValidator(root).validate(types.SimpleNamespace(seal_hash='native-stateenergy1084'))
finally:src.sha256_identity=original
assert empirical.passed and captured
(w/'stateenergy1084_original_empirical.json').write_text(json.dumps(canonical_value(empirical),indent=2)+'\n');(w/'stateenergy1084_original_payload.json').write_text(json.dumps(captured,indent=2)+'\n')
rows=json.loads((w/'stateenergy1084_original_targets.json').read_text());species=list(dict.fromkeys(x['species_row_id']for x in src._identities(root)));inp=w/'stateenergy1084_comparison_input.json';inp.write_text(json.dumps(dict(rows=rows,species=species)))
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean');cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run','work/StateEnergyComparisonProgram1084.lean',str(inp)]
with(w/'stateenergy1084_comparison_output.json').open('w')as out,(w/'stateenergy1084_comparison_execution.log').open('w')as err:run=subprocess.run(cmd,env=env,stdout=out,stderr=err)
assert run.returncode==0
actual=json.loads((w/'stateenergy1084_comparison_output.json').read_text());expected={k:captured[k]for k in ['comparisons','pair_count']};assert actual==expected
report=dict(status='PASS',comparison_rows=len(actual['comparisons']),pair_count=actual['pair_count'],species=len(species),all_comparison_fields=True,source_sha256=hashlib.sha256((r/'SFT/Chemistry/StateEnergyComparison.lean').read_bytes()).hexdigest());(w/'stateenergy1084_comparison_report.json').write_text(json.dumps(report,indent=2)+'\n');print(report)
