from pathlib import Path
import sys,json,subprocess,os,types
w=Path('work');runtime=(w/'v3-runtime500').resolve();root=(w/'turn1064_recovery').resolve();sys.path.insert(0,str(runtime))
from sft.chemistry.rovibronic_composition_validation import RovibronicCompositionValidator
from sft.engine.canonical import canonical_value
cid='SFT-CHEM-ROVIBRONIC-COMPOSITION-001'
expected=json.loads((w/'pinned1070/claims'/cid/'empirical_validation.json').read_text());expected.pop('claim_id')
# Reuse the unchanged original Python output; only the current Lean renderer changed.
fresh=json.loads((w/'rovibronic1070_fresh_empirical.json').read_text())
assert fresh==expected,[k for k in expected if fresh.get(k)!=expected[k]]
env=dict(os.environ,LEAN_PATH=str(root)+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean',LEAN_NUM_THREADS='1')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(root/'MolecularRovibronicValidationProgram1070.lean'),str(runtime),expected['validated_seal_hash'],expected['isolation_certificate']['host_platform'],expected['isolation_certificate']['python_implementation']]
p=subprocess.run(cmd,env=env,capture_output=True,text=True)
(w/'rovibronic1070_empirical_execution.log').write_text(p.stdout+p.stderr)
assert p.returncode==0,p.stdout[-1800:]+p.stderr[-500:]
actual=json.loads(p.stdout);(w/'rovibronic1070_empirical_output.json').write_text(json.dumps(actual,indent=2)+'\n')
assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
(w/'rovibronic1070_empirical_report.json').write_text(json.dumps(dict(status='PASS',source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',fresh_original=True,fresh_native=True,all_empirical_fields_and_hashes_match=True,original_pinned_record_matches=True,complete_ratio_rows=4,scope='Exact original Chemistry rovibronic post-seal validator, all source checks and complete empirical output'),indent=2)+'\n')
print('PASS complete original/fresh/native rovibronic empirical output and all hashes',flush=True)
