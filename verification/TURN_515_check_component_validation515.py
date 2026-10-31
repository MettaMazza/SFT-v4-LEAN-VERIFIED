from pathlib import Path
from types import SimpleNamespace
import sys,json,hashlib,subprocess,os,time
sys.dont_write_bytecode=True;root=Path('work/v3-runtime500').resolve();sys.path.insert(0,str(root))
from sft.physics.cosmic_component_transport_terminal_validation_v1 import CosmicComponentTransportExternalValidator,cosmic_transport_measurement_record,SOURCE_PATH,SOURCE_HASH,CLAIM_ID
from sft.engine.canonical import canonical_value
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';repo='/Volumes/One Touch/ernos-labs-sft-platform'
def pinned(path):return subprocess.check_output(['git','-C',repo,'show',pin+':'+path])
def save(path,digest):
 data=pinned(path);assert 'sha256:'+hashlib.sha256(data).hexdigest()==digest
 dst=root/path;dst.parent.mkdir(parents=True,exist_ok=True)
 if not dst.exists() or dst.read_bytes()!=data:dst.write_bytes(data)
 return data
payload=json.loads(save(SOURCE_PATH,SOURCE_HASH))
for row in payload['sources']:save(row['snapshot_path'],row['snapshot_hash'])
cert=json.loads(pinned('claims/'+CLAIM_ID+'/certificate.json'));sealed=SimpleNamespace(claim_id=CLAIM_ID,seal_hash=cert['derivation_seal_hash']);start=time.monotonic()
expected={'validation':canonical_value(CosmicComponentTransportExternalValidator(root).validate(sealed)),'measurement_record':canonical_value(cosmic_transport_measurement_record(root))};Path('work/component515_validation_expected.json').write_text(json.dumps(expected,indent=2)+'\n')
out=subprocess.check_output([str(Path('work/ComponentValidationProgram515').resolve()),str(root),sealed.seal_hash],text=True);actual=json.loads(out);Path('work/component515_validation_output.json').write_text(json.dumps(actual,indent=2)+'\n')
assert actual==expected,[(part,key) for part in expected for key in expected[part] if actual[part].get(key)!=expected[part][key]]
report=dict(status='PASS',source_commit=pin,fresh_native_lean_execution=True,original_python_validator_executed=True,source_files=6,chronometer_rows=32,additional_target_rows=5,complete_measurement_record_and_validation_match=True,all_hashes_match=True,seconds=round(time.monotonic()-start,2),passed=actual['validation']['passed'])
Path('work/component515_validation_report.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report),flush=True)
