from pathlib import Path
import json,sys,copy,hashlib,subprocess
from types import SimpleNamespace
w=Path('work');stage=w/'pinned_conformerpopulation1495';cid='SFT-CHEM-CONFORMER-POPULATION-ORDERING-006'
pin=json.loads((w/'conformerpopulation1495_source_pin.json').read_text());rows=pin['files'];source_paths=pin['source_manifest_files']
for row in rows: assert hashlib.sha256((stage/row['path']).read_bytes()).hexdigest()==row['sha256']
sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__.insert(0,str((stage/'sft/chemistry').resolve()))
from sft.chemistry.conformer_population_ordering_batch_v1 import CONFORMER_POPULATION_ORDERING_SPEC as spec
from sft.chemistry.generated_observational_law import GeneratedObservationalChemistryProgram
from sft.chemistry.conformer_population_ordering_validation_v1 import ConformerPopulationOrderingValidator
from sft.engine.source import build_source_manifest
from sft.engine.canonical import canonical_value
from sft.claim_evidence import snapshot_protected_tree
source=build_source_manifest(stage,[stage/p for p in source_paths]).manifest_hash
execution_comparison=json.loads((w/'conformerpopulation1495_execution_manifest_comparison.json').read_text())
assert source==execution_comparison['stage_hash']==execution_comparison['original_hash']
assert set(source_paths)==set(execution_comparison['original_paths'])
p=GeneratedObservationalChemistryProgram(spec,source);c=p.generate_candidates();dec=tuple(p.decide_candidate(x)for x in c.candidates)
out=canonical_value(dict(registration=p.registration,census=c,decisions=dec,closure=p.closure_evidence(dec),controls=p.run_controls(),unknown_id='StopIteration'))
(w/'conformerpopulation1495_original_program.json').write_text(json.dumps(out,indent=2)+'\n')
before=snapshot_protected_tree(stage);report=canonical_value(ConformerPopulationOrderingValidator(stage).validate(SimpleNamespace(seal_hash='native-conformerpopulation1495')));assert report['passed'] and before==snapshot_protected_tree(stage)
(w/'conformerpopulation1495_original_empirical.json').write_text(json.dumps(report,indent=2)+'\n');cases=[]
for case in ['original','omitted_candidate','additional_survivor','failed_control']:
 sealed=copy.deepcopy(dict(out,claim_id=cid,seal_hash='native-conformerpopulation1495'))
 if case=='omitted_candidate':sealed['census']['candidates']=sealed['census']['candidates'][1:]
 if case=='additional_survivor':sealed['decisions'][0]['survives']=True
 if case=='failed_control':sealed['controls'][0]['passed']=False
 f=w/('conformerpopulation1495_independent_'+case+'.json');f.write_text(json.dumps(sealed));q=subprocess.run([sys.executable,str((stage/'claims'/cid/'independent_validator.py').resolve()),str(f.resolve())],capture_output=True,text=True,check=True);value=json.loads(q.stdout);assert value['passed']==(case=='original');cases.append({'case':case,'result':value})
(w/'conformerpopulation1495_original_independent.json').write_text(json.dumps(cases,indent=2)+'\n')
a={'status':'PASS','source_manifest_hash':source,'source_files':len(rows),'candidates':len(c.candidates),'survivors':sum(x.survives for x in dec),'controls':len(out['controls']),'empirical_fields':len(report),'measurements':len(report['measurements']),'independent_cases':len(cases),'protected_tree_unchanged':True};(w/'conformerpopulation1495_original_report.json').write_text(json.dumps(a,indent=2)+'\n');print(a)
