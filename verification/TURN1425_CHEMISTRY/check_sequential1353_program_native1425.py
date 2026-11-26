from pathlib import Path
import sys,os,json,subprocess,re,hashlib,copy
w=Path('work');root=(w/'turn1064_recovery').resolve()
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(root)+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean',LEAN_NUM_THREADS='1')
native_receipt=Path('work/sequential1353_program_native_build1413.json')
native_build=json.loads(native_receipt.read_text());assert native_build['status']=='PASS'
for record in native_build['modules']:
 assert hashlib.sha256(Path(record['source']).read_bytes()).hexdigest()==record['source_sha256'],record['module']
assert hashlib.sha256((root/'SequentialMechanismProgram1353.lean').read_bytes()).hexdigest()==native_build['runner_sha256']
assert hashlib.sha256(Path(native_build['executable']).read_bytes()).hexdigest()==native_build['executable_sha256']
lean=[sys.executable,'work/run_lean_guarded.py',native_build['executable']]
sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned1353/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.sequential_mechanism_batch_v1 import SEQUENTIAL_MECHANISM_SPEC as spec
from sft.chemistry.generated_observational_law import GeneratedObservationalChemistryProgram
from sft.engine.source import build_source_manifest
from sft.engine.canonical import canonical_value
cid=spec.claim_id
certificate=json.loads((w/'pinned1353/claims'/cid/'certificate.json').read_text());source=certificate['source_manifest_hash']
stage=w/'pinned1353'
fixed=('sft/chemistry/sequential_mechanism_law_v1.py', 'sft/chemistry/sequential_mechanism_batch_v1.py', 'sft/chemistry/sequential_mechanism_validation_v1.py', 'sft/chemistry/generated_law.py', 'sft/chemistry/generated_observational_law.py', 'sft/physics/generated_empirical_law.py', 'tools/capture_chemistry_sequential_mechanism_sources_v1.py', 'experiments/external_sources/chemistry/sequential_mechanism_capture_spec_v1.json', 'experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/sequential-mechanism-primary-records-v1.json', 'experiments/external_sources/chemistry/sequential_mechanism_target_identities_v1.json', 'experiments/external_sources/chemistry/sequential_mechanism_withheld_targets_v1.json', 'experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/PMC11217357-full-text.xml', 'experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/PMC11217357-supplementary-files.zip', 'experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/cxidb-221-custody-record-v1.json', 'experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_Fig1_HTML.jpg', 'experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_Fig3_HTML.jpg', 'experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_Fig2_HTML.jpg', 'experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_Fig5_HTML.gif', 'experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_MOESM2_ESM.pdf', 'experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_Fig4_HTML.jpg', 'experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_Fig2_HTML.gif', 'experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_Fig1_HTML.gif', 'experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_Fig4_HTML.gif', 'experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_MOESM1_ESM.pdf', 'experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_Fig3_HTML.gif', 'experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_Fig5_HTML.jpg', 'experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_MOESM3_ESM.pdf', 'experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_MOESM2_ESM.txt', 'experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_MOESM1_ESM.txt', 'experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/41467_2024_49814_MOESM3_ESM.txt', 'experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/8WZF.cif', 'experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/8WZF-rcsb-entry.json', 'experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/8WZG.cif', 'experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/8WZG-rcsb-entry.json', 'experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/8WZR.cif', 'experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/8WZR-rcsb-entry.json', 'experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/8WZT.cif', 'experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/8WZT-rcsb-entry.json', 'experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/8WZV.cif', 'experiments/external_sources/chemistry/snapshots/kin-007-sequential-mechanism-v1/8WZV-rcsb-entry.json', 'claims/SFT-CHEM-SEQUENTIAL-MECHANISM-COMPOSITION-007/execution.py')
manifest=build_source_manifest(stage,[stage/p for p in fixed]);assert manifest.manifest_hash==source

p=subprocess.run(lean+[source],env=env,capture_output=True,text=True)
(w/'sequential1353_program_execution.log').write_text(p.stdout+p.stderr)
assert p.returncode==0,p.stdout[-1200:]+p.stderr[-500:]
actual=json.loads(p.stdout);(w/'sequential1353_program_output.json').write_text(json.dumps(actual,indent=2)+'\n')
program=GeneratedObservationalChemistryProgram(spec,source);census=program.generate_candidates();decisions=tuple(program.decide_candidate(c) for c in census.candidates)
expected=canonical_value(dict(registration=program.registration,census=census,decisions=decisions,closure=program.closure_evidence(decisions),controls=program.run_controls(),unknown_id='StopIteration'))
assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
(w/'sequential1353_program_report.json').write_text(json.dumps(dict(status='PASS',source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',source_manifest_hash=source,candidates=len(census.candidates),all_fields_and_hashes=True,fresh_native=True,fresh_original=True),indent=2)+'\n')
validator=(w/'pinned1353/claims'/cid/'independent_validator.py').resolve();cases=[]
for case in ['original','omitted_candidate','additional_survivor','failed_control']:
 sealed=copy.deepcopy(dict(actual,claim_id=cid,seal_hash='native-sequential1353'))
 if case=='omitted_candidate':sealed['census']['candidates']=sealed['census']['candidates'][1:]
 if case=='additional_survivor':sealed['decisions'][0]['survives']=True
 if case=='failed_control':sealed['controls'][0]['passed']=False
 f=w/('sequential1353_independent_'+case+'.json');f.write_text(json.dumps(sealed))
 p=subprocess.run([sys.executable,str(validator),str(f.resolve())],capture_output=True,text=True,check=True)
 result=json.loads(p.stdout);assert result['passed']==(case=='original'),result
 cases.append(dict(case=case,result=result))
(w/'sequential1353_independent_report.json').write_text(json.dumps(cases,indent=2)+'\n')
print('PASS complete256 programme, fresh V3 comparison, retained grammar/evidence audit and original independent validator with three adverse cases',flush=True)
