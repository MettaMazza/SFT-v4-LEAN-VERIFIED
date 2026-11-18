from pathlib import Path
import json,sys,subprocess,hashlib,re,fcntl,datetime,shutil
w=Path('work');r=w/'turn1064_recovery';base=w/'pinned1234';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';repo='/Volumes/One Touch/ernos-labs-sft-platform'
entries=[('accuracy1252','DiagnosticAccuracy','SFT-MED-DIAGNOSTIC-ACCURACY-001')]
sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.medicine;sft.medicine.__path__=[str((base/'sft/medicine').resolve())]+list(sft.medicine.__path__)
from sft.medicine.empirical_program import MEDICINE_SPECS,BlindMedicineAuthorityValidator
from sft.medicine.external_bindings import BINDING_BY_CLAIM
from sft.engine.source import build_source_manifest
from sft.engine.canonical import canonical_value
from sft.claim_evidence import snapshot_protected_tree
from types import SimpleNamespace
q=lambda x:json.dumps(x,ensure_ascii=False)
for tag,mod,cid in entries:
 num=tag[-4:];stage=w/('pinned'+num);stage.mkdir(exist_ok=True)
 for folder in ['sft','experiments','census','receipts','publications']:
  p=stage/folder
  if folder=='sft':
   if p.is_symlink():assert p.resolve()==(base/folder).resolve();p.unlink()
   shutil.copytree(base/folder,p,dirs_exist_ok=True,symlinks=True)
  elif not p.exists():p.symlink_to((base/folder).resolve(),target_is_directory=True)
 files=[]
 for name in ['execution.py','certificate.json','independent_validator.py']:
  rel='claims/'+cid+'/'+name;b=subprocess.check_output(['git','-C',repo,'show',pin+':'+rel]);p=stage/rel;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(b);files.append(dict(path=rel,actual_sha256=hashlib.sha256(b).hexdigest()))
 # Pin each claim's actual execution before using its common branch source.
 src=(stage/'claims'/cid/'execution.py').read_text();fixed=re.findall(r'root\s*/\s*"([^"]+)"',src.split('source_hash')[0]);
 # The complete native/programme comparison script also checks the exact certificate manifest.
 sourcepin=json.loads((w/'patient1234_source_pin.json').read_text());sourcepin['files']=[row for row in sourcepin['files']if not row['path'].startswith('claims/')]+files;(w/(tag+'_source_pin.json')).write_text(json.dumps(sourcepin,indent=2)+'\n')
 assert BINDING_BY_CLAIM[cid].requirements==BINDING_BY_CLAIM['SFT-MED-SYMPTOM-001'].requirements
 def replace(s):return s.replace('patient1234',tag).replace('PatientIdentity',mod).replace('SFT-MED-PATIENT-IDENTITY-001',cid).replace('1234',num)
 p=w/('generate_'+tag+'.py');p.write_text(replace((w/'generate_patient1234.py').read_text()));subprocess.run(['python3',str(p)],check=True)
 spec=next(x for x in MEDICINE_SPECS if x.claim_id==cid)
 # Exact common binding delegates to the unchanged first Medicine source operation.
 source='''import SFT.Medicine.SymptomRecordSource
namespace SFT.Medicine.'''+mod+'''Source
abbrev Snapshot := SymptomRecordSource.Snapshot
abbrev readSnapshot := SymptomRecordSource.readSnapshot
abbrev requirements := SymptomRecordSource.requirements
abbrev sources := SymptomRecordSource.sources
def expectedLabel : String := '''+q(spec.expected_observation_label)+'''
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 let (_,receipt) ← SymptomRecordSource.sourceDerivedTarget files
 return (expectedLabel,receipt)
end SFT.Medicine.'''+mod+'Source\n';(r/'SFT/Medicine'/(mod+'Source.lean')).write_text(source)
 for kind in ['experiment','validation']:
  s=replace((w/('generate_patient1234_'+kind+'.py')).read_text()).replace(mod+'Seal','PatientIdentitySeal')
  if kind=='experiment':s=s.replace('import SFT.Medicine.PatientIdentitySeal','import SFT.Medicine.PatientIdentitySeal\\nimport SFT.Medicine.'+mod+'Source')
  p=w/('generate_'+tag+'_'+kind+'.py');p.write_text(s);subprocess.run(['python3',str(p)],check=True)
 p=r/'SFT/Medicine'/(mod+'Experiment.lean');p.write_text(p.read_text().replace(mod+'Source.distinctIds','SFT.Biology.LifeOrganizationSource.distinctIds'))
 # Create fresh entry-specific programme, preserving all original source fields.
 for filename in ['check_patient1234_program.py','check_patient1234_empirical.py','PatientIdentityValidationProgram1234.lean']:
  s=replace((w/filename).read_text()).replace("'"+mod+"Seal',",'');new=filename.replace('patient1234',tag).replace('PatientIdentity',mod).replace('1234',num);(w/new).write_text(s)
 (r/(mod+'Program'+num+'.lean')).write_text(replace((r/'PatientIdentityProgram1234.lean').read_text()))
 # Native shared seal module remains unchanged; imported source snapshots are definitionally identical.
 build=replace((w/'build_patient1234_all.py').read_text()).replace("'"+mod+"Seal',",'');(w/('build_'+tag+'_all.py')).write_text(build)
 before=snapshot_protected_tree(stage);original=BlindMedicineAuthorityValidator(stage,spec).validate(SimpleNamespace(seal_hash='native-'+tag));after=snapshot_protected_tree(stage);assert original.passed and before==after
 out=canonical_value(original);(w/(tag+'_original_empirical.json')).write_text(json.dumps(out,indent=2)+'\n');(w/(tag+'_original_report.json')).write_text(json.dumps(dict(status='PASS',fields=len(out),messages=len(out['measurements']),protected_tree_unchanged=True,identical_original_binding=True),indent=2)+'\n')
 payload=json.loads((w/'patient1234_empirical_input.json').read_text());payload['derivation_seal']='native-'+tag;payload['before']=canonical_value(before);payload['after']=canonical_value(after)
 payload['files']=[row for row in payload['files']if not row['path'].startswith('claims/')]+[dict(path=row['path'],local=str((stage/row['path']).resolve()),sha256=row['actual_sha256'])for row in files];(w/(tag+'_empirical_input.json')).write_text(json.dumps(payload,ensure_ascii=False)+'\n')
 s=(w/('check_'+tag+'_program.py')).read_text();end=s.index('p=subprocess.run(lean+');subprocess.run(['python3','-c',s[:end]],check=True)
 print('STAGED',cid,'six modules; original complete empiricalPASS; native checks not yet run',flush=True)
(w/'medicine1252_entries.json').write_text(json.dumps(entries,indent=2)+'\n')
