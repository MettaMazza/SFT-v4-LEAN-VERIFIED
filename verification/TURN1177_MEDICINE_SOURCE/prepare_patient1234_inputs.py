from pathlib import Path
import sys,json,subprocess,hashlib
w=Path('work');stage=w/'pinned1234';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';repo='/Volumes/One Touch/ernos-labs-sft-platform';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.medicine;sft.medicine.__path__=[str((stage/'sft/medicine').resolve())]+list(sft.medicine.__path__)
from sft.medicine.sources import MEDICINE_AUTHORITY_SOURCES
rows=[]
def retain(rel,expected=None):
 p=stage/rel
 if not p.exists():
  b=subprocess.check_output(['git','-C',repo,'show',pin+':'+rel]);p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(b)
 b=p.read_bytes();h=hashlib.sha256(b).hexdigest();row=dict(path=rel,git_blob=hashlib.sha1(b'blob '+str(len(b)).encode()+b'\0'+b).hexdigest(),actual_sha256=h)
 if expected is not None:row.update(registered_execution_sha256=expected,matches_registered=('sha256:'+h==expected))
 rows.append(row)
for rel in ['sft/medicine/'+n+'.py'for n in ['obligations','structural_counts','generated_law','empirical_program','external_bindings','sources']]+['claims/SFT-MED-PATIENT-IDENTITY-001/'+n for n in ['execution.py','certificate.json','independent_validator.py']]:retain(rel)
for rel in ['sft/physics/generated_empirical_law.py','sft/claim_evidence/fold_language.py','sft/claim_evidence/custody.py','sft/claim_evidence/hostile.py','sft/engine/isolation.py','sft/engine/empirical.py']:retain(rel)
for x in MEDICINE_AUTHORITY_SOURCES:
 for path_attr,hash_attr in [('snapshot_path','snapshot_hash'),('text_path','text_hash'),('failure_path','failure_hash')]:
  rel=getattr(x,path_attr)
  if rel is not None:retain(rel,getattr(x,hash_attr))
seal='experiments/sealed_predictions/medicine_foundation_complete_pre_source.json';retain(seal);payload=json.loads((stage/seal).read_text())
for pk,hk in [('inventory_path','inventory_file_hash'),('obligations_path','obligations_hash'),('generated_law_path','generated_law_hash'),('structural_counts_path','structural_counts_hash')]:
 if not any(x['path']==payload[pk]for x in rows):retain(payload[pk],payload[hk])
 else:
  x=next(x for x in rows if x['path']==payload[pk]);x.update(registered_execution_sha256=payload[hk],matches_registered='sha256:'+x['actual_sha256']==payload[hk])
(w/'patient1234_source_pin.json').write_text(json.dumps(dict(commit=pin,files=rows),indent=2)+'\n')
bad=[x['path']for x in rows if x.get('matches_registered')is False]
print(json.dumps(dict(files=len(rows),registered_mismatches=bad)))
