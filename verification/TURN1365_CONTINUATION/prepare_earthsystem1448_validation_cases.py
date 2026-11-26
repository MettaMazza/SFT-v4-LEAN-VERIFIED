from pathlib import Path
import json,sys,ast
from types import SimpleNamespace
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.earth_environment import empirical_program as e
spec=next(x for x in e.EARTH_SPECS if x.claim_id=='SFT-EARTH-SYSTEM-001');root=w/'pinned1448';d=json.loads((w/'earth1448_source_inputs.json').read_text())[0];row=next(x for x in d['targets']['targets']if x['claim_id']==spec.claim_id);seal=e.validate_pre_source_seal(root)
try:
 out=e.BlindEarthBoundaryValidator(root,spec).validate(SimpleNamespace(seal_hash='native-earthsystem1448'));raise AssertionError('Unexpected success: retain full result before adapting expectation')
except ValueError as ex:error=str(ex)
expected={'program':e.prediction_program_document(spec),'registration':json.loads((w/'earthsystem1448_registration_constructor.json').read_text()),'validation':{'error':error}}
d.update(row=row,preseal_hash=seal,extraction='extraction-placeholder',derivation='native-earthsystem1448');(w/'earthsystem1448_validation_input.json').write_text(json.dumps(d));(w/'earthsystem1448_validation_expected.json').write_text(json.dumps(expected))
s=(w/'EarthSourceCases1448.lean').read_text();s=s[:s.index('set_option maxRecDepth')].replace('import SFT.EarthEnvironment.Source','import SFT.EarthEnvironment.EarthSystemValidation')
s+='''set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/earthsystem1448_validation_input.json"
 let row ← IO.ofExcept (Lean.Json.parse raw)
 let entries ← IO.ofExcept (items row "files")
 let files ← entries.mapM fun entry => do
  let path ← IO.ofExcept (text entry "path")
  let localPath ← IO.ofExcept (text entry "local")
  let bytes ← IO.FS.readBinFile localPath
  return SFT.Materials.MaterialSource.Snapshot.mk path bytes
 let get (key : String) := IO.ofExcept (field row key >>= convert (raw.utf8ByteSize+1))
 let sealValue ← get "seal"
 let audit ← get "audit"
 let targets ← get "targets"
 let bindings ← get "bindings"
 let first ← get "first"
 let holdout ← get "holdout"
 let targetRow ← get "row"
 let extraction ← IO.ofExcept (text row "extraction")
 let preSeal ← IO.ofExcept (text row "preseal_hash")
 let derivation ← IO.ofExcept (text row "derivation")
 let registration ← IO.ofExcept (SFT.EarthEnvironment.EarthSystemExperiment.registration targetRow extraction preSeal)
 -- This case must return the original source guard error before snapshots are used.
 let unusedSnapshot : SFT.EarthEnvironment.EarthSystemValidation.Snapshot := ⟨"", [], ""⟩
 let result := SFT.EarthEnvironment.EarthSystemValidation.validate sealValue audit targets bindings first holdout files derivation "Darwin" "CPython" unusedSnapshot unusedSnapshot
 let wrapped : CJ := match result with
  | .ok v => SFT.Host.Canonical.Value.object [("ok",v)]
  | .error e => SFT.Host.Canonical.Value.object [("error",.text e)]
 IO.println (SFT.Host.Canonical.render (.object [("program",SFT.EarthEnvironment.EarthSystemExperiment.predictionDocument),("registration",registration),("validation",wrapped)]))
''';(w/'EarthSystemValidationCases1448.lean').write_text(s)
s=(w/'check_observation1374_experiment.py').read_text().replace('ObservationActExperimentProgram1374','EarthSystemValidationCases1448').replace('observation1374_experiment','earthsystem1448_validation_cases').replace('SFT/Consciousness','SFT/EarthEnvironment').replace("['ObservationActExperiment']","['EarthSystemExperiment','EarthSystemValidation']")
a=s.index('actual=json.loads');b=s.index("(w/'earthsystem1448_validation_cases_report",a);s=s[:a]+"actual=json.loads(p.stdout);expected=json.loads((w/'earthsystem1448_validation_expected.json').read_text());assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]\n"+s[b:];s=s.replace('original consciousness prediction and registration','original Earth constructor and guarded outcome');(w/'check_earthsystem1448_validation_cases.py').write_text(s)
s=(w/'build_observation1374_rest.py').read_text().replace('Consciousness','EarthEnvironment').replace('ObservationAct','EarthSystem').replace('ObservationFullAudit1374','EarthFullAudit1448').replace('observation1374','earthsystem1448').replace('1374','1448').replace('check_earthsystem1448_experiment.py','check_earthsystem1448_validation_cases.py');idx=s.index('for module in ')
s=s[:idx]+'''import time
while True:
 ready=True
 for tag in ['earth1448_source','earthsystem1448_core']:
  ap=Path('work/'+tag+'_entry_audit_report.json')
  if not ap.exists():ready=False;continue
  a=json.loads(ap.read_text())
  ready &= a['status']=='PASS' and all(hashlib.sha256((root/'SFT/EarthEnvironment'/(m+'.lean')).read_bytes()).hexdigest()==h for m,h in a['source_sha256'].items())
 if ready:break
 time.sleep(15)
'''+s[idx:];(w/'build_earthsystem1448_rest.py').write_text(s);print('Prepared original17-field constructor,4instruction document and exact guardedvalidator outcome:',error)
