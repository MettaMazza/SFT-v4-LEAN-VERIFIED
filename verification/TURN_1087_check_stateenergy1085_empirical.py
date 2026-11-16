from pathlib import Path
import sys,json,hashlib,subprocess,os,platform
w=Path('work');r=w/'turn1064_recovery';runtime=(w/'v3-runtime500').resolve();sys.path.insert(0,str(runtime))
from sft.chemistry import state_energy_order_validation_v1 as src
from sft.claim_evidence import snapshot_protected_tree
from sft.engine.canonical import canonical_value
expected=json.loads((w/'stateenergy1084_original_empirical.json').read_text());assert expected['passed'] and expected['validated_seal_hash']=='native-stateenergy1084'
before=snapshot_protected_tree(runtime);data=json.loads((w/'stateenergy1084_targets_input.json').read_text())
for path,want in [(src.IDENTITY_PATH,src.IDENTITY_HASH),(src.TARGET_PATH,src.TARGET_HASH)]:assert 'sha256:'+hashlib.sha256((runtime/path).read_bytes()).hexdigest()==want
for row in data['snapshots']:assert 'sha256:'+hashlib.sha256((runtime/row['path']).read_bytes()).hexdigest()==row['hash']
first=(runtime/src.STATE_ENERGY_ORDER_SPEC.target_rows[0].snapshot_path).read_bytes()
data.update(before=canonical_value(before),after=canonical_value(before),derivation_seal='native-stateenergy1084',host=platform.system(),implementation=platform.python_implementation(),first_hash='sha256:'+hashlib.sha256(first).hexdigest(),changed_hash='sha256:'+hashlib.sha256(first+b'tampered').hexdigest());inp=w/'stateenergy1085_empirical_input.json';inp.write_text(json.dumps(data))
modules=['StateEnergyOrder','StateEnergyOrderWitnesses','StateEnergyOrderPrediction','StateEnergyOrderExperiment','StateEnergySourceTables','StateEnergyInscription','StateEnergyTargets','StateEnergyComparison','StateEnergyControls','StateEnergyValidation'];digests={n:hashlib.sha256((r/'SFT/Chemistry'/(n+'.lean')).read_bytes()).hexdigest()for n in modules};(w/'stateenergy1085_empirical_start.json').write_text(json.dumps(dict(source_sha256=digests,input_sha256=hashlib.sha256(inp.read_bytes()).hexdigest()),indent=2)+'\n')
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean');cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run','work/StateEnergyValidationProgram1085.lean',str(inp)]
with(w/'stateenergy1085_empirical_output_raw.json').open('w')as out,(w/'stateenergy1085_empirical_execution.log').open('w')as err:run=subprocess.run(cmd,env=env,stdout=out,stderr=err)
assert run.returncode==0,run.returncode
assert snapshot_protected_tree(runtime)==before
for n,h in digests.items():assert hashlib.sha256((r/'SFT/Chemistry'/(n+'.lean')).read_bytes()).hexdigest()==h
actual=json.loads((w/'stateenergy1085_empirical_output_raw.json').read_text());assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
(w/'stateenergy1085_empirical_output.json').write_text(json.dumps(actual,indent=2)+'\n');report=dict(status='PASS',fields=len(actual),messages=len(actual['measurements']),all_fields_and_hashes_match=True,protected_tree_unchanged=True,source_sha256=digests,source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1');(w/'stateenergy1085_empirical_report.json').write_text(json.dumps(report,indent=2)+'\n');print(report['status'],report['fields'],'fields',report['messages'],'messages;all certificate and measurement hashes')
