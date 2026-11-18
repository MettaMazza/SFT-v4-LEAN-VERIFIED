from pathlib import Path
import json,sys,dataclasses
from types import SimpleNamespace
w=Path('work');stage=w/'pinned1321';cid='SFT-CHEM-MOLECULAR-ELECTRON-AFFINITY-008';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry;sft.chemistry.__path__=[str((stage/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.molecular_electron_affinity_batch_v1 import MOLECULAR_ELECTRON_AFFINITY_SPEC as spec
from sft.chemistry.generated_observational_law import GeneratedObservationalChemistryProgram
from sft.chemistry.molecular_electron_affinity_validation_v1 import MolecularElectronAffinityValidator
from sft.claim_evidence import snapshot_protected_tree
from sft.engine.canonical import canonical_value
from sft.engine.source import build_source_manifest
pin=json.loads((w/'electronaffinity1321_source_pin.json').read_text());source=build_source_manifest(stage,[stage/p for p in pin['execution_files']]).manifest_hash;certificate=json.loads((stage/'claims'/cid/'certificate.json').read_text());assert source==certificate['source_manifest_hash'];p=GeneratedObservationalChemistryProgram(spec,source);c=p.generate_candidates();d=tuple(p.decide_candidate(x)for x in c.candidates)
out=canonical_value(dict(registration=p.registration,census=c,decisions=d,closure=p.closure_evidence(d),controls=p.run_controls(),unknown_id='StopIteration'))
(w/'electronaffinity1321_spec.json').write_text(json.dumps(dataclasses.asdict(spec),indent=2)+'\n');(w/'electronaffinity1321_original_program.json').write_text(json.dumps(out,indent=2)+'\n')
for rel in ['census','receipts/engine/model_admitted']:
 p=stage/rel
 if not p.exists():
  p.parent.mkdir(parents=True,exist_ok=True);p.symlink_to((w/'v3-runtime500'/rel).resolve(),target_is_directory=True)
before=snapshot_protected_tree(stage);result=MolecularElectronAffinityValidator(stage).validate(SimpleNamespace(seal_hash='native-electronaffinity1321'));after=snapshot_protected_tree(stage);assert result.passed and before==after
out=canonical_value(result);(w/'electronaffinity1321_original_empirical.json').write_text(json.dumps(out,indent=2)+'\n');(w/'electronaffinity1321_original_report.json').write_text(json.dumps(dict(status='PASS',candidates=len(c.candidates),fields=len(out),messages=len(result.measurements),protected_tree_unchanged=True,source_manifest_hash=source),indent=2)+'\n');print('PASS original',len(c.candidates),'candidates,',len(out),'empirical fields,',len(result.measurements),'messages')
