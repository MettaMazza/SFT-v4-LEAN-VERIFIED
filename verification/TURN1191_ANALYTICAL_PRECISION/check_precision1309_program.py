from pathlib import Path
import sys,os,json,subprocess,re,hashlib,copy
w=Path('work');root=(w/'turn1064_recovery').resolve()
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(root)+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean',LEAN_NUM_THREADS='1')
lean=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned1309/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.anal_performance_batch_v1 import PRECISION_SPEC as spec
from sft.chemistry.generated_observational_law import GeneratedObservationalChemistryProgram
from sft.engine.source import build_source_manifest
from sft.engine.canonical import canonical_value
cid=spec.claim_id
certificate=json.loads((w/'pinned1309/claims'/cid/'certificate.json').read_text());source=certificate['source_manifest_hash']
stage=w/'pinned1309'
fixed=('sft/chemistry/anal_performance_batch_v1.py', 'sft/chemistry/anal_performance_validation_v1.py', 'sft/chemistry/generated_law.py', 'sft/chemistry/generated_observational_law.py', 'sft/physics/generated_empirical_law.py', 'audits/CHEMISTRY_ANAL_001_022_FAMILY_BOUNDARY_2026-07-28.json', 'experiments/external_sources/chemistry/anal_001_005_family_source_identity_registry_v1.json', 'sft/chemistry/analytical_accuracy_trueness_law_v1.py', 'sft/chemistry/analytical_precision_repeatability_law_v1.py', 'sft/chemistry/analytical_sensitivity_law_v1.py', 'sft/chemistry/analytical_detection_quantification_law_v1.py', 'sft/chemistry/analytical_selectivity_interference_law_v1.py', 'experiments/external_sources/chemistry/anal_001_target_identities_v1.json', 'experiments/external_sources/chemistry/anal_002_target_identities_v1.json', 'experiments/external_sources/chemistry/anal_003_target_identities_v1.json', 'experiments/external_sources/chemistry/anal_004_target_identities_v1.json', 'experiments/external_sources/chemistry/anal_005_target_identities_v1.json', 'experiments/sealed_predictions/chemistry_anal_001_pre_source_v1.json', 'experiments/sealed_predictions/chemistry_anal_002_pre_source_v1.json', 'experiments/sealed_predictions/chemistry_anal_003_pre_source_v1.json', 'experiments/sealed_predictions/chemistry_anal_004_pre_source_v1.json', 'experiments/sealed_predictions/chemistry_anal_005_pre_source_v1.json', 'experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/source-inventory-v1.json', 'experiments/external_sources/chemistry/anal_001_srm1959_certificate_addendum_identity_v1.json', 'experiments/sealed_predictions/chemistry_anal_001_certificate_addendum_pre_capture_v1.json', 'experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/anal-001-srm1959-certificate-addendum-inventory-v1.json', 'experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/complete-postseal-analysis-v1.json', 'tools/seal_chemistry_anal_001_005_predictions_v1.py', 'tools/capture_chemistry_anal_001_005_sources_v1.py', 'tools/seal_chemistry_anal_001_certificate_addendum_v1.py', 'tools/capture_chemistry_anal_001_certificate_addendum_v1.py', 'tools/build_chemistry_anal_001_005_external_v1.py', 'claims/SFT-CHEM-ANALYTICAL-PRECISION-REPEATABILITY-002/execution.py')
manifest=build_source_manifest(stage,[stage/p for p in fixed]);assert manifest.manifest_hash==source

p=subprocess.run(lean+['--run',str(root/'AnalyticalPrecisionProgram1309.lean'),source],env=env,capture_output=True,text=True)
(w/'precision1309_program_execution.log').write_text(p.stdout+p.stderr)
assert p.returncode==0,p.stdout[-1200:]+p.stderr[-500:]
actual=json.loads(p.stdout);(w/'precision1309_program_output.json').write_text(json.dumps(actual,indent=2)+'\n')
program=GeneratedObservationalChemistryProgram(spec,source);census=program.generate_candidates();decisions=tuple(program.decide_candidate(c) for c in census.candidates)
expected=canonical_value(dict(registration=program.registration,census=census,decisions=decisions,closure=program.closure_evidence(decisions),controls=program.run_controls(),unknown_id='StopIteration'))
assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
(w/'precision1309_program_report.json').write_text(json.dumps(dict(status='PASS',source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',source_manifest_hash=source,candidates=len(census.candidates),all_fields_and_hashes=True,fresh_native=True,fresh_original=True),indent=2)+'\n')
validator=(w/'pinned1309/claims'/cid/'independent_validator.py').resolve();cases=[]
for case in ['original','omitted_candidate','additional_survivor','failed_control']:
 sealed=copy.deepcopy(dict(actual,claim_id=cid,seal_hash='native-precision1309'))
 if case=='omitted_candidate':sealed['census']['candidates']=sealed['census']['candidates'][1:]
 if case=='additional_survivor':sealed['decisions'][0]['survives']=True
 if case=='failed_control':sealed['controls'][0]['passed']=False
 f=w/('precision1309_independent_'+case+'.json');f.write_text(json.dumps(sealed))
 p=subprocess.run([sys.executable,str(validator),str(f.resolve())],capture_output=True,text=True,check=True)
 result=json.loads(p.stdout);assert result['passed']==(case=='original'),result
 cases.append(dict(case=case,result=result))
(w/'precision1309_independent_report.json').write_text(json.dumps(cases,indent=2)+'\n')
print('PASS complete256 programme, fresh V3 comparison, retained grammar/evidence audit and original independent validator with three adverse cases',flush=True)
