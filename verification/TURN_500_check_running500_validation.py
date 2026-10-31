from pathlib import Path
import sys,json,subprocess,os,platform
from types import SimpleNamespace
sys.dont_write_bytecode=True
root=Path('work/v3-runtime500').resolve();sys.path.insert(0,str(root))
from sft.physics.coupling_running_convergence_terminal_validation_v1 import CouplingRunningConvergenceValidator,CLAIM_ID
from sft.engine.canonical import canonical_value
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';cert=json.loads(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':claims/'+CLAIM_ID+'/certificate.json']))
sealed=SimpleNamespace(claim_id=CLAIM_ID,seal_hash=cert['derivation_seal_hash'])
expected=canonical_value(CouplingRunningConvergenceValidator(root).validate(sealed));Path('work/running500_validation_expected.json').write_text(json.dumps(expected,indent=2)+'\n')
env=dict(os.environ,LEAN_NUM_THREADS='1',LEAN_STACK_SIZE_KB='1048576',LEAN_MAIN_USE_THREAD='1')
out=subprocess.check_output([str(Path('work/RunningValidationProgram500').resolve()),str(root),sealed.seal_hash],env=env,text=True)
actual=json.loads(out);Path('work/running500_validation_actual.json').write_text(json.dumps(actual,indent=2)+'\n')
assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
report=dict(status='PASS',source_commit=pin,source_count=4,complete_rows={'qcd_table':7,'qcd_figure_classes':9,'strong_multiscale':2,'alpha_zero':5,'delta_alpha':11,'prior_em_endpoints':2},all_output_fields_and_hashes_match=True,fresh_native_lean_execution=True,original_python_validator_executed=True,passed=actual['passed'])
Path('work/running500_validation_report.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report))
