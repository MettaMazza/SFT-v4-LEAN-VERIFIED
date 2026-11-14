from pathlib import Path
import sys,os,json,subprocess,hashlib
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import decay_width_branching_lifetime_terminal_validation_v1 as v
from sft.engine.canonical import canonical_value
p=w/'constants-recovery/DecayWidthPredictionCompare971.lean';out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env={**os.environ,'LEAN_PATH':str(c/'.lake/build/lib/lean')},text=True);actual=json.loads(out);expected=canonical_value(dict(inputs=v.formal_prediction_inputs(),program=v.prediction_program_document(),output=v.formal_prediction_inputs()));assert actual==expected
(w/'decaywidth971_prediction_report.json').write_text(json.dumps(dict(status='PASS',inputs=13,complete_document_and_capability_execution=True,lean_sha256=hashlib.sha256((c/'SFT/Physics/DecayWidthPrediction.lean').read_bytes()).hexdigest()),indent=2));print('PASS 13 inputs,document and actual capability execution')
