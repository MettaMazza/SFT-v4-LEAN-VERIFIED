from pathlib import Path
import sys,os,json,subprocess,re,hashlib,copy
w=Path('work');root=(w/'turn1064_recovery').resolve()
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(root)+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean',LEAN_NUM_THREADS='1')
native_receipt=Path('work/heatwork1331_program_native_build1413.json')
native_build=json.loads(native_receipt.read_text());assert native_build['status']=='PASS'
for record in native_build['modules']:
 assert hashlib.sha256(Path(record['source']).read_bytes()).hexdigest()==record['source_sha256'],record['module']
assert hashlib.sha256((root/'HeatWorkTransferPartitionProgram1331.lean').read_bytes()).hexdigest()==native_build['runner_sha256']
assert hashlib.sha256(Path(native_build['executable']).read_bytes()).hexdigest()==native_build['executable_sha256']
lean=[sys.executable,'work/run_lean_guarded.py',native_build['executable']]
sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned1331/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.heat_work_transfer_partition_batch_v1 import HEAT_WORK_TRANSFER_PARTITION_SPEC as spec
from sft.chemistry.generated_observational_law import GeneratedObservationalChemistryProgram
from sft.engine.source import build_source_manifest
from sft.engine.canonical import canonical_value
cid=spec.claim_id
certificate=json.loads((w/'pinned1331/claims'/cid/'certificate.json').read_text());source=certificate['source_manifest_hash']
stage=w/'pinned1331'
fixed=('sft/chemistry/heat_work_transfer_partition_law_v1.py', 'sft/chemistry/heat_work_transfer_partition_batch_v1.py', 'sft/chemistry/heat_work_transfer_partition_validation_v1.py', 'sft/chemistry/internal_energy_composition_batch_v1.py', 'sft/chemistry/internal_energy_composition_validation_v1.py', 'sft/chemistry/generated_law.py', 'sft/chemistry/generated_observational_law.py', 'sft/physics/generated_empirical_law.py', 'tools/capture_chemistry_thermophysical_state_sources_v1.py', 'experiments/external_sources/chemistry/snapshots/thermo-shared-water-isobar-v1/nist-webbook-water-isobar-1bar-300-400K.html', 'experiments/external_sources/chemistry/snapshots/thermo-shared-water-isobar-v1/thermophysical-state-primary-records-v1.json', 'experiments/external_sources/chemistry/thermophysical_state_target_identities_v1.json', 'experiments/external_sources/chemistry/thermophysical_state_withheld_targets_v1.json', 'claims/SFT-CHEM-HEAT-WORK-TRANSFER-PARTITION-004/execution.py')
manifest=build_source_manifest(stage,[stage/p for p in fixed]);assert manifest.manifest_hash==source

p=subprocess.run(lean+[source],env=env,capture_output=True,text=True)
(w/'heatwork1331_program_execution.log').write_text(p.stdout+p.stderr)
assert p.returncode==0,p.stdout[-1200:]+p.stderr[-500:]
actual=json.loads(p.stdout);(w/'heatwork1331_program_output.json').write_text(json.dumps(actual,indent=2)+'\n')
program=GeneratedObservationalChemistryProgram(spec,source);census=program.generate_candidates();decisions=tuple(program.decide_candidate(c) for c in census.candidates)
expected=canonical_value(dict(registration=program.registration,census=census,decisions=decisions,closure=program.closure_evidence(decisions),controls=program.run_controls(),unknown_id='StopIteration'))
assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
(w/'heatwork1331_program_report.json').write_text(json.dumps(dict(status='PASS',source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',source_manifest_hash=source,candidates=len(census.candidates),all_fields_and_hashes=True,fresh_native=True,fresh_original=True),indent=2)+'\n')
validator=(w/'pinned1331/claims'/cid/'independent_validator.py').resolve();cases=[]
for case in ['original','omitted_candidate','additional_survivor','failed_control']:
 sealed=copy.deepcopy(dict(actual,claim_id=cid,seal_hash='native-heatwork1331'))
 if case=='omitted_candidate':sealed['census']['candidates']=sealed['census']['candidates'][1:]
 if case=='additional_survivor':sealed['decisions'][0]['survives']=True
 if case=='failed_control':sealed['controls'][0]['passed']=False
 f=w/('heatwork1331_independent_'+case+'.json');f.write_text(json.dumps(sealed))
 p=subprocess.run([sys.executable,str(validator),str(f.resolve())],capture_output=True,text=True,check=True)
 result=json.loads(p.stdout);assert result['passed']==(case=='original'),result
 cases.append(dict(case=case,result=result))
(w/'heatwork1331_independent_report.json').write_text(json.dumps(cases,indent=2)+'\n')
print('PASS complete256 programme, fresh V3 comparison, retained grammar/evidence audit and original independent validator with three adverse cases',flush=True)

p=Path('work/heatwork1331_program_report.json');d=json.loads(p.read_text());d['compiled_executable_build_receipt']=str(native_receipt);d['compiled_executable_sha256']=native_build['executable_sha256'];p.write_text(json.dumps(d,indent=2)+'\n')
