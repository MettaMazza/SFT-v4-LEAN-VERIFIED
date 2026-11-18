from pathlib import Path
import sys,os,json,subprocess,re,hashlib,copy
w=Path('work');root=(w/'turn1064_recovery').resolve()
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(root)+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean',LEAN_NUM_THREADS='1')
lean=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned1311/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.bond_dissociation_energy_batch_v1 import BOND_DISSOCIATION_ENERGY_SPEC as spec
from sft.chemistry.bond_dissociation_energy_batch_v1 import GeneratedFiniteDissociationChemistryProgram as GeneratedObservationalChemistryProgram
from sft.engine.source import build_source_manifest
from sft.engine.canonical import canonical_value
cid=spec.claim_id
certificate=json.loads((w/'pinned1311/claims'/cid/'certificate.json').read_text());source=certificate['source_manifest_hash']
stage=w/'pinned1311'
fixed=('sft/chemistry/bond_dissociation_energy_law_v1.py', 'sft/chemistry/bond_dissociation_energy_batch_v1.py', 'sft/chemistry/bond_dissociation_energy_validation_v1.py', 'sft/chemistry/generated_law.py', 'sft/chemistry/generated_observational_law.py', 'sft/physics/generated_empirical_law.py', 'sft/physics/prior_value_laws.py', 'tools/capture_chemistry_bond_dissociation_energy_sources_v1.py', 'experiments/external_sources/chemistry/snapshots/prop-002-atomic-1s-2s-primary-records-v1.json', 'experiments/external_sources/chemistry/snapshots/aps-hydrogen-dissociation-1994.json', 'experiments/external_sources/chemistry/snapshots/prop-002-current-dissociation-primary-records-v1.json', 'experiments/external_sources/chemistry/bond_dissociation_energy_target_identities_v1.json', 'experiments/external_sources/chemistry/bond_dissociation_energy_withheld_targets_v1.json', 'claims/SFT-CHEM-BOND-DISSOCIATION-ENERGY-002/execution.py')
manifest=build_source_manifest(stage,[stage/p for p in fixed]);assert manifest.manifest_hash==source

expected=json.loads((w/'bondenergy1311_source_cases_expected.json').read_text())
p=subprocess.run(lean+['--run','work/BondDissociationEnergySourceCases1311.lean'],env=env,capture_output=True,text=True)
(w/'bondenergy1311_source_cases_execution.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout[-1400:]+p.stderr[-500:]
actual=json.loads(p.stdout);assert actual==expected
(w/'bondenergy1311_source_cases_output.json').write_text(json.dumps(actual,indent=2)+'\n')
(w/'bondenergy1311_source_cases_report.json').write_text(json.dumps(dict(status='PASS',original_cases=len(expected),all_fields_match=True,source_sha256={'SFT/Chemistry/BondDissociationEnergySource.lean':hashlib.sha256((root/'SFT/Chemistry/BondDissociationEnergySource.lean').read_bytes()).hexdigest()}),indent=2)+'\n')
print('PASS20original strict-fraction and interval source cases',flush=True)
