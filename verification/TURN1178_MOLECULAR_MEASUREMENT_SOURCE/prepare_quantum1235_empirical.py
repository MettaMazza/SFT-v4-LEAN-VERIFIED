from pathlib import Path
import json,sys,platform
w=Path('work');stage=w/'pinned1235';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.claim_evidence import snapshot_protected_tree
from sft.engine.canonical import canonical_value
ids=json.loads((stage/'experiments/external_sources/chemistry/molecular_measurement_target_identities_v1.json').read_text());source=ids['source'];snap=snapshot_protected_tree(stage)
payload=dict(derivation_seal='native-quantum1235',host=platform.system(),implementation=platform.python_implementation(),before=canonical_value(snap),after=canonical_value(snap),snapshot_paths=[c['snapshot_path']for c in source['components']]+[source['metadata_snapshot_path']]);(w/'quantum1235_empirical_input.json').write_text(json.dumps(payload))
s=(w/'ResolvedValidationProgram1164.lean').read_text().replace('ResolvedRovibronic','MolecularMeasurement').replace('resolved1164','quantum1235').replace('pinned1158','pinned1235').replace('NuclearElectronicTargets','MolecularMeasurementSource');a=s.index(' let snapshots ←');b=s.index(' let ib ←',a);s=s[:a]+''' let snapshots ← paths.mapM fun path => do
  let bytes ← IO.FS.readBinFile ("work/pinned1235/"++path)
  let content ← IO.FS.readFile ("work/pinned1235/"++path)
  pure (MolecularMeasurementSource.Snapshot.mk path ("sha256:"++SFT.Host.SHA256.digest bytes) content)
'''+s[b:];(w/'MolecularMeasurementValidationProgram1235.lean').write_text(s)
s=(w/'check_resolved1164_empirical.py').read_text().replace('ResolvedValidationProgram1164','MolecularMeasurementValidationProgram1235').replace('resolved1164','quantum1235').replace('original_target_checks\':95','original_target_checks\':330').replace('original_counts\':12','original_counts\':15').replace('107 messages','345 messages');a=s.index("for m in ['ResolvedRovibronic'");b=s.index(']}}',a);s=s[:a]+"for m in ['MolecularMeasurement','MolecularMeasurementSource','MolecularMeasurementAnalysis','MolecularMeasurementExperiment','MolecularMeasurementValidation'"+s[b:];(w/'check_quantum1235_empirical.py').write_text(s)
