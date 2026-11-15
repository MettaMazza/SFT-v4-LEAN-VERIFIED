from pathlib import Path
import sys,os,json,subprocess
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import parker_proton_energy_terminal_validation_v1 as v
from sft.engine.canonical import canonical_value,sha256_identity
from sft.engine.empirical import PredictionEnvelope
seals=['sha256:source-test','retained-seal','entry661'];inputs=v.formal_prediction_inputs();reg=v.experiment_registration_record()
expected=canonical_value(dict(inputs=inputs,program=v.prediction_program_document(),output=inputs,registration=reg,envelopes=[PredictionEnvelope(v.EXPERIMENT_ID,{k:sha256_identity(x) for k,x in inputs.items()},v.TARGET_IDS,sha256_identity((s,reg['frozen_relation'])),sha256_identity(reg)) for s in seals]))
s=Path('work/constants-recovery/StrongFieldPredictionCompare987.lean').read_text().replace('StrongFieldPrediction','ParkerPrediction').replace('import SFT.Physics.ParkerPrediction','import SFT.Physics.ParkerExperiment').replace('open SFT.Physics SFT.Host.Canonical ParkerPrediction','open SFT.Physics SFT.Host.Canonical ParkerPrediction ParkerExperiment').replace('  pure (.object','  let reg ← registrationRecord\n  let rh := SFT.Foundation.AdmissionControls.admissionIdentity reg\n  pure (.object').replace('[("inputs",','[("registration",reg),("envelopes",.array ['+','.join('envelope '+json.dumps(seal)+' inputs rh' for seal in seals)+']),("inputs",')
p=w/'constants-recovery/ParkerMetadata1008.lean';p.write_text(s)
x=subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env={**os.environ,'LEAN_PATH':str(c/'.lake/build/lib/lean')},capture_output=True,text=True);(w/'parker1008_metadata_lean.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];actual=json.loads(x.stdout);assert actual==expected,[(k,actual[k],e) for k,e in expected.items() if actual[k]!=e];(w/'parker1008_metadata_report.json').write_text(json.dumps(dict(status='PASS',inputs=6,complete_program_execution=True,registration=True,envelopes=3),indent=2));print('PASS original inputs, document, execution, registration and three envelopes')
