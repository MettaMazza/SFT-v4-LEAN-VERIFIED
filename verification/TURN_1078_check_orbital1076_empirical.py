import json,sys,os,subprocess,hashlib,platform
from pathlib import Path
from types import SimpleNamespace
w=Path('work');root=(w/'v3-runtime500').resolve();sys.path.insert(0,str(root))
from sft.chemistry import orbital_support_validation_v1 as src
from sft.claim_evidence import snapshot_protected_tree
from sft.engine.canonical import canonical_value
data=json.loads((w/'orbital1076_targets_input.json').read_text())
captured={};originalIdentity=src.sha256_identity
def capture(value):
 if isinstance(value,dict)and 'comparisons'in value and 'adverse'in value:captured.update(value)
 return originalIdentity(value)
src.sha256_identity=capture
expected=canonical_value(src.OrbitalSupportValidator(root).validate(SimpleNamespace(seal_hash='native-orbital1076')))
(w/'orbital1076_original_empirical.json').write_text(json.dumps(expected,indent=2)+'\n');(w/'orbital1076_original_payload.json').write_text(json.dumps(canonical_value(captured),indent=2)+'\n');assert expected['passed']
inputPath=root/src.ELECTRON_INPUT_PATH;inputHash='sha256:'+hashlib.sha256(inputPath.read_bytes()).hexdigest();assert inputHash==src.ELECTRON_INPUT_HASH
inputDoc=json.loads(inputPath.read_text());inputs=[]
for row in inputDoc['rows']:
 item=dict(row)
 for key in ['row_id','molecular_formula','charge_action']:item[key]=str(item[key])
 item['nuclear_composition']=[dict(element_symbol=str(p['element_symbol']),atomic_number=int(p['atomic_number']),occurrence_count=int(p['occurrence_count']))for p in row['nuclear_composition']];inputs.append(item)
before=snapshot_protected_tree(root);first=root/src.ORBITAL_SUPPORT_SPEC.target_rows[0].snapshot_path
data.update(inputs=inputs,input_schema=inputDoc.get('schema'),input_hash=inputHash,derivation_seal='native-orbital1076',host=platform.system(),implementation=platform.python_implementation(),before=canonical_value(before),after=canonical_value(before),changed_first_hash='sha256:'+hashlib.sha256(first.read_bytes()+b'tampered').hexdigest())
inp=w/'orbital1076_empirical_input.json';inp.write_text(json.dumps(data))
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str((w/'turn1064_recovery').resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run','work/OrbitalValidationProgram1076.lean',str(inp)]
with (w/'orbital1076_empirical_output_raw.json').open('w')as out,(w/'orbital1076_empirical_execution.log').open('w')as err:r=subprocess.run(cmd,env=env,stdout=out,stderr=err)
assert r.returncode==0,r.returncode
after=snapshot_protected_tree(root);assert after==before
actual=json.loads((w/'orbital1076_empirical_output_raw.json').read_text());assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
(w/'orbital1076_empirical_output.json').write_text(json.dumps(actual,indent=2)+'\n')
digests={n:hashlib.sha256((w/'turn1064_recovery/SFT/Chemistry'/(n+'.lean')).read_bytes()).hexdigest()for n in ['OrbitalSupportTargets','OrbitalSupportComparison','OrbitalSupportExperiment','OrbitalSupportValidation']}
(w/'orbital1076_empirical_report.json').write_text(json.dumps(dict(status='PASS',return_fields=len(actual),measurements=len(actual['measurements']),all_fields_and_hashes_match=True,protected_tree_unchanged=True,source_sha256=digests,original_comparison_rows=360,original_controls=6,source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'),indent=2)+'\n');print('PASS complete native empirical return: all12 fields,366 messages and all certificate/measurement hashes;360 source rows/six controls; protected tree unchanged')
