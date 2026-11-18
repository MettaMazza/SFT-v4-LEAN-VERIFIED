from pathlib import Path
import sys,os,json,subprocess,re,hashlib,copy
w=Path('work');root=(w/'turn1064_recovery').resolve()
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(root)+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean',LEAN_NUM_THREADS='1')
lean=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned1307/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.equilibrium_bond_length_batch_v1 import EQUILIBRIUM_BOND_LENGTH_SPEC as spec
from sft.chemistry.equilibrium_bond_length_batch_v1 import GeneratedFiniteQuantitativeChemistryProgram as GeneratedObservationalChemistryProgram
from sft.engine.source import build_source_manifest
from sft.engine.canonical import canonical_value
cid=spec.claim_id
certificate=json.loads((w/'pinned1307/claims'/cid/'certificate.json').read_text());source=certificate['source_manifest_hash']
stage=w/'pinned1307'
fixed=('sft/chemistry/equilibrium_bond_length_law_v1.py', 'sft/chemistry/equilibrium_bond_length_batch_v1.py', 'sft/chemistry/equilibrium_bond_length_validation_v1.py', 'sft/chemistry/generated_law.py', 'sft/chemistry/generated_observational_law.py', 'sft/physics/generated_empirical_law.py', 'sft/physics/atomic_constants.py', 'sft/physics/molecular_spectroscopy_successor_laws_v1.py', 'sft/physics/molecular_spectroscopy_successor_validation_v1.py', 'claims/SFT-CHEM-EQUILIBRIUM-BOND-LENGTH-001/execution.py')
manifest=build_source_manifest(stage,[stage/p for p in fixed]);assert manifest.manifest_hash==source

expected=json.loads((w/'bondlength1307_core_expected.json').read_text())
p=subprocess.run(lean+['--run','work/EquilibriumBondLengthCoreProgram1307.lean'],env=env,capture_output=True,text=True)
(w/'bondlength1307_core_execution.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout[-1000:]+p.stderr[-500:]
actual=json.loads(p.stdout);assert actual==expected
(w/'bondlength1307_core_report.json').write_text(json.dumps(dict(status='PASS',original_cases=len(expected),all_fields_match=True,source_sha256={str(p.relative_to(root)):hashlib.sha256(p.read_bytes()).hexdigest()for p in [root/'SFT/Chemistry/EquilibriumBondLength.lean',root/'SFT/Chemistry/EquilibriumBondLengthSource.lean']}),indent=2)+'\n')
print('PASS14original isotope/fraction domain and normalization cases',flush=True)
