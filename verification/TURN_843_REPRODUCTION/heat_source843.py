exec(open('work/heat_spec843.py').read())
from enum import Enum
from html import unescape
import hashlib,re
namespace.update(hashlib=hashlib,json=json,asdict=dataclasses.asdict,is_dataclass=dataclasses.is_dataclass,Enum=Enum,Path=Path,re=re,unescape=unescape)
for src,names in [('sft/engine/canonical.py',{'canonical_value','canonical_json','sha256_identity'}),('sft/engine/source.py',{'hash_file'})]:evaluate([n for n in ast.parse(raw(src)).body if getattr(n,'name',None) in names],src)
for src in ['sft/materials/sources.py','sft/materials/external_bindings.py']:
 evaluate([n for n in ast.parse(raw(src)).body if not isinstance(n,(ast.Import,ast.ImportFrom))],src)
src='sft/materials/generated_law.py';names={'PRE_SOURCE_SEAL_PATH','EmpiricalMaterialsSpec','_spec','MATERIALS_SPECS','validate_pre_source_seal','prediction_program_document','experiment_registration_record','_source_derived_target'}
evaluate([n for n in ast.parse(raw(src)).body if getattr(n,'name',None) in names or (isinstance(n,ast.Assign) and getattr(n.targets[0],'id',None) in names)],src)
spec=namespace['MATERIALS_SPECS'][72];spec.validate();root=Path(repo)
# Verify each source used by the original validation is the pinned byte artifact.
paths=[s.snapshot_path for s in namespace['MATERIALS_AUTHORITY_SOURCES']]+[namespace['PRE_SOURCE_SEAL_PATH'],'sft/materials/obligations.py','sft/materials/structural_counts.py','sft/materials/derivation.py']
for p in paths:assert (root/p).read_bytes()==subprocess.check_output(['git','-C',repo,'show',pin+':'+p]),p
registration=namespace['experiment_registration_record'](root,spec)
label,digest=namespace['_source_derived_target'](root,spec)
assert label==spec.expected_observation_label
binding=namespace['BINDING_BY_CLAIM'][spec.claim_id]
out={'claim_id':spec.claim_id,'source_commit':pin,'original_source_files_and_snapshots_checked':len(paths),'pre_source_seal_hash':registration['pre_source_seal_hash'],'registration':registration,'registration_hash':namespace['sha256_identity'](registration),'source_derived_label':label,'extraction_hash':digest,'requirements':dataclasses.asdict(binding),'corpora':{sid:namespace['source_corpus'](root,sid) for sid in spec.source_ids}}
Path('work/material_source651_output.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({k:v for k,v in out.items() if k in ['claim_id','source_commit','original_source_files_and_snapshots_checked','pre_source_seal_hash','registration_hash','extraction_hash']}))
