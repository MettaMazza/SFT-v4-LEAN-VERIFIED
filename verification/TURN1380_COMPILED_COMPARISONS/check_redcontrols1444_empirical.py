from pathlib import Path
import os,sys,subprocess,json,hashlib
from types import SimpleNamespace
w=Path('work');r=w/'turn1064_recovery';env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
subprocess.run([sys.executable,'work/prepare_redcontrols1444_native1380.py'],check=True)
p=subprocess.run([sys.executable,'work/prepare_redcontrols1444_native1380.py','--execute'],env=env,capture_output=True,text=True)
(w/'redcontrols1444_empirical_execution.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout[-1500:]+p.stderr[-500:]
actual=json.loads(p.stdout);sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft;sft.__path__.insert(0,str((w/'pinned1444/sft').resolve()))
from sft.consciousness_cognitive_science.empirical_program import CONSCIOUSNESS_SPECS,BlindConsciousnessBoundaryValidator
from sft.engine.canonical import canonical_value
spec=next(s for s in CONSCIOUSNESS_SPECS if s.claim_id=='SFT-CONSC-RED-CONTROLS-001');expected=canonical_value(BlindConsciousnessBoundaryValidator(w/'pinned1444',spec).validate(SimpleNamespace(seal_hash='native-redcontrols1444')))
assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
(w/'redcontrols1444_empirical_output.json').write_text(json.dumps(actual,indent=2)+'\n')
mods=['StructuralModel','Source','RedControls','RedControlsGrammar','RedControlsEvidence','RedControlsExperiment','RedControlsValidation']
(w/'redcontrols1444_empirical_report.json').write_text(json.dumps(dict(status='PASS',fields=len(actual),messages=len(actual['measurements']),fresh_original=True,fresh_native=True,all_fields_and_hashes=True,source_sha256={str(p.relative_to(r)):hashlib.sha256(p.read_bytes()).hexdigest()for p in [r/'SFT/Consciousness'/(m+'.lean')for m in mods]}),indent=2)+'\n');print('PASS full native/original empirical12fields5messages',flush=True)
