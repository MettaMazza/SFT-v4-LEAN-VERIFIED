from pathlib import Path
import subprocess,json,hashlib,re,sys,dataclasses
w=Path('work');stage=w/'pinned1311';repo='/Volumes/One Touch/ernos-labs-sft-platform';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';cid='SFT-CHEM-BOND-DISSOCIATION-ENERGY-002';rows={}
def fetch(rel):
 b=subprocess.check_output(['git','-C',repo,'show',pin+':'+rel]);p=stage/rel;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(b);rows[rel]={'path':rel,'sha256':hashlib.sha256(b).hexdigest()};return p
for name in ['execution.py','certificate.json','independent_validator.py']:fetch('claims/'+cid+'/'+name)
src=(stage/'claims'/cid/'execution.py').read_text().split('source_hash =')[0];files=re.findall(r'root\s*/\s*[\"\']([^\"\']+)[\"\']',src)
for rel in files:fetch(rel)
for rel in ['census','receipts/engine/model_admitted']:
 p=stage/rel
 if not p.exists():p.parent.mkdir(parents=True,exist_ok=True);p.symlink_to((w/'v3-runtime500'/rel).resolve(),target_is_directory=True)
p=stage/'sft/experiments'
if not p.exists():p.symlink_to('../experiments',target_is_directory=True)
sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry,sft.physics
sft.chemistry.__path__=[str((stage/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
sft.physics.__path__=[str((stage/'sft/physics').resolve())]+list(sft.physics.__path__)
from sft.chemistry.bond_dissociation_energy_batch_v1 import BOND_DISSOCIATION_ENERGY_SPEC as spec,GeneratedFiniteDissociationChemistryProgram
from sft.chemistry.bond_dissociation_energy_validation_v1 import BondDissociationEnergyValidator
from sft.engine.source import build_source_manifest
from sft.engine.canonical import canonical_value
from sft.claim_evidence import snapshot_protected_tree
from types import SimpleNamespace
spec.validate();cert=json.loads((stage/'claims'/cid/'certificate.json').read_text());assert build_source_manifest(stage,[stage/f for f in files]).manifest_hash==cert['source_manifest_hash']
(w/'bondenergy1311_spec.json').write_text(json.dumps(dataclasses.asdict(spec),indent=2)+'\n')
before=snapshot_protected_tree(stage);result=BondDissociationEnergyValidator(stage).validate(SimpleNamespace(seal_hash='native-bondenergy1311'));after=snapshot_protected_tree(stage);assert result.passed and before==after
(w/'bondenergy1311_original_empirical.json').write_text(json.dumps(canonical_value(result),indent=2)+'\n')
program=GeneratedFiniteDissociationChemistryProgram(spec,cert['source_manifest_hash']);census=program.generate_candidates();decisions=tuple(program.decide_candidate(c)for c in census.candidates)
expected=canonical_value(dict(registration=program.registration,census=census,decisions=decisions,closure=program.closure_evidence(decisions),controls=program.run_controls(),unknown_id='StopIteration'));(w/'bondenergy1311_original_program.json').write_text(json.dumps(expected,indent=2)+'\n');assert len(census.candidates)==256
(w/'bondenergy1311_source_pin.json').write_text(json.dumps(dict(commit=pin,execution_files=files,files=list(rows.values())),indent=2)+'\n')
(w/'bondenergy1311_original_report.json').write_text(json.dumps(dict(status='PASS',candidates=256,empirical_fields=len(canonical_value(result)),messages=len(result.measurements),protected_tree_unchanged=True),indent=2)+'\n')
print('PASS original source manifest,256candidate programme,full empirical validator',len(result.measurements),'messages',flush=True)
