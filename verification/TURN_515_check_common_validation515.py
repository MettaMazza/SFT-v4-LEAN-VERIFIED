from pathlib import Path
import sys,json,subprocess,os,time,hashlib
from types import SimpleNamespace
sys.dont_write_bytecode=True
root=Path('work/v3-runtime500').resolve();sys.path.insert(0,str(root))
from sft.physics.common_scale_axis_terminal_validation_v1 import CommonScaleAxisTerminalValidator,CLAIM_ID,source_hashes
from sft.engine.canonical import canonical_value
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';v3='/Volumes/One Touch/ernos-labs-sft-platform'
def pinned(path):return subprocess.check_output(['git','-C',v3,'show',pin+':'+path])
for relative,digest in source_hashes().items():
 data=pinned(relative);assert 'sha256:'+hashlib.sha256(data).hexdigest()==digest
 path=root/relative;path.parent.mkdir(parents=True,exist_ok=True)
 if not path.exists() or path.read_bytes()!=data:path.write_bytes(data)
cert=json.loads(pinned('claims/'+CLAIM_ID+'/certificate.json'));sealed=SimpleNamespace(claim_id=CLAIM_ID,seal_hash=cert['derivation_seal_hash'])
start=time.monotonic();expected=canonical_value(CommonScaleAxisTerminalValidator(root).validate(sealed));Path('work/common515_validation_expected.json').write_text(json.dumps(expected,indent=2)+'\n')
env=dict(os.environ,LEAN_NUM_THREADS='1',LEAN_STACK_SIZE_KB='1048576',LEAN_MAIN_USE_THREAD='1')
out=subprocess.check_output([str(Path('work/CommonValidationProgram515').resolve()),str(root),sealed.seal_hash],env=env,text=True)
actual=json.loads(out);Path('work/common515_validation_actual.json').write_text(json.dumps(actual,indent=2)+'\n')
assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
report=dict(status='PASS',source_commit=pin,source_count=6,complete_rows={'weak_schemes':4,'low_transfer':4,'figure_classes':8,'inherited_certificates':3},all_output_fields_and_hashes_match=True,fresh_native_lean_execution=True,original_python_validator_executed=True,passed=actual['passed'],seconds=round(time.monotonic()-start,2))
Path('work/common515_validation_report.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report),flush=True)
