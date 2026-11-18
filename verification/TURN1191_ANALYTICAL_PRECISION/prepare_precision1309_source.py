from pathlib import Path
import json,hashlib,shutil,subprocess,sys,dataclasses
w=Path('work');r=w/'turn1064_recovery';stage=w/'pinned1309';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';repo='/Volumes/One Touch/ernos-labs-sft-platform';cid='SFT-CHEM-ANALYTICAL-PRECISION-REPEATABILITY-002'
a=json.loads((r/'verification/TURN1162_ACCURACY_COMPLETION.json').read_text())
for rel,h in a['lean_source_sha256'].items():assert hashlib.sha256((r/rel).read_bytes()).hexdigest()==h,rel
old=json.loads((w/'accuracy1162_source_pin.json').read_text());rows=[]
for row in old['files']:
 rel=row['path'];p=w/'pinned1162'/rel;assert hashlib.sha256(p.read_bytes()).hexdigest()==row['sha256'],rel
 q=stage/rel;q.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(p,q);rows.append(row)
for name in ['execution.py','certificate.json','independent_validator.py','WHY_DERIVATION_CHECK.md','STATUS.md']:
 rel='claims/'+cid+'/'+name;b=subprocess.check_output(['git','-C',repo,'show',pin+':'+rel]);p=stage/rel;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(b);rows.append(dict(path=rel,sha256=hashlib.sha256(b).hexdigest()))
p=stage/'sft/experiments'
if not p.exists():p.symlink_to('../experiments',target_is_directory=True)
sys.path[:0]=[str((w/'v3-runtime500').resolve()),str((w/'radiochemical1122_pdf6142').resolve()),str((w/'accuracy1162_testdeps').resolve())];import sft.chemistry
sft.chemistry.__path__=[str((stage/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.anal_performance_batch_v1 import PRECISION_SPEC as spec,AUTHORITIES
from sft.chemistry.generated_observational_law import GeneratedObservationalChemistryProgram
from sft.engine.source import build_source_manifest
from sft.engine.canonical import canonical_value
fixed=['sft/chemistry/anal_performance_batch_v1.py','sft/chemistry/anal_performance_validation_v1.py','sft/chemistry/generated_law.py','sft/chemistry/generated_observational_law.py','sft/physics/generated_empirical_law.py']+[p for p,_ in AUTHORITIES]+['claims/'+cid+'/execution.py'];fixed=list(dict.fromkeys(fixed));cert=json.loads((stage/'claims'/cid/'certificate.json').read_text());assert build_source_manifest(stage,[stage/f for f in fixed]).manifest_hash==cert['source_manifest_hash']
program=GeneratedObservationalChemistryProgram(spec,cert['source_manifest_hash']);census=program.generate_candidates();decisions=tuple(program.decide_candidate(c)for c in census.candidates)
expected=canonical_value(dict(registration=program.registration,census=census,decisions=decisions,closure=program.closure_evidence(decisions),controls=program.run_controls(),unknown_id='StopIteration'))
for suffix,obj in [('spec',dataclasses.asdict(spec)),('original_program',expected),('source_pin',dict(commit=pin,execution_files=fixed,files=rows)),('shared_source_receipt',dict(status='PASS',prior_completion='verification/TURN1162_ACCURACY_COMPLETION.json',unchanged_native=a['lean_source_sha256'],unchanged_files=len(old['files']),source_pages=83,html_documents=1,characters=180366))]:
 (w/('precision1309_'+suffix+'.json')).write_text(json.dumps(obj,indent=2)+'\n')
print('Verified unchanged Accuracy native/source evidence; pinned Precision original programme with256candidates.')
