from pathlib import Path
import json,ast,sys,dataclasses,re,shutil
w=Path('work');r=w/'constants-recovery/SFT/Physics';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import relativistic_field_validation_v1 as src
q=lambda x:json.dumps(x,ensure_ascii=False)
def cv(x):
 if x is None:return '.null'
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,(list,tuple)):return '.array ['+','.join(cv(v) for v in x)+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+cv(v)+')' for k,v in x.items())+']'
 raise TypeError(x)
items=[('DYNAMICS','DynamicsValidation',895,'dynamics','dynamics_and_spectra'),('FIELD','RelativisticFieldValidation',896,'field','relativistic_and_electromagnetic_fields'),('OPTICS','OpticsValidation',897,'optics','optical_operations'),('LOOP','FiniteLoopValidation',898,'loop','finite_loops')]
corr=json.load(open(c/'reference/CORRESPONDENCE.json'));registered={row.get('module') for key in ['modules','evidence_modules'] for row in corr[key]}
for m in ['FieldAuthoritativeRecords','FieldAuthoritativeWitnesses']+[tag+x for _,tag,_,_,_ in items for x in ['Witnesses','Grammar','Evidence','Experiment','Validation']]:assert 'SFT/Physics/'+m+'.lean' not in registered,m
s='''import SFT.Physics.RunningConvergenceMeasurement
import SFT.Host.SHA256Chunks
namespace SFT.Physics.FieldAuthoritativeRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
'''
s+='def componentHashes : List (String × String) := ['+','.join('('+q(k)+','+q(v)+')' for k,v in src.COMPONENTS.items())+']\n'
s+='def sourceHash : String := '+q(src.SOURCE_HASH)+'\n'
s+='''def payloadBoundary (payload : Value) : Except String Value := do
 let id := (field payload "record_id").toOption.getD .null
 let boundary := (field payload "formal_seal_boundary").toOption.getD (.object [])
 let count := (field boundary "sealed_claim_count").toOption.getD .null
 if !sameValue id (.text "RELATIVISTIC-FIELD-AUTHORITATIVE-1971-2026") || !sameValue count (.integer 12) then
  throw "relativistic-field source record boundary changed"
 let sources ← (do array (← field payload "sources")).mapError (fun _ => "complete relativistic-field source vector requires seven sources")
 if sources.length != 7 then throw "complete relativistic-field source vector requires seven sources"
 pure payload

def checkComponents (files : List (String × ByteArray)) (payload : Value) : Except String Unit := do
 let sources ← array (← field payload "sources")
 let _ ← sources.foldlM (fun (_ : Unit) source => do
  let snapshot := (field source "snapshot").toOption.getD .null
  let expected := match snapshot with
   | .text name => componentHashes.find? (fun (p : String × String) => Text.equal p.1 name)
   | .object _ | .boolean _ | .integer _ | .null | .array _ => none
  match expected with
  | none => pure ()
  | some (name,hash) =>
   let bytes ← match files.find? (fun (p : String × ByteArray) => Text.equal p.1 name) with
    | none => .error (Text.append "FileNotFoundError: " name)
    | some p => .ok p.2
   if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) hash then
    throw "relativistic-field component snapshot identity changed"
   pure ()) ()
 pure ()

def controlsBoundary (payload : Value) : Except String Value := do
 let controls ← (do array (← field payload "unfavorable_and_scope_controls")).mapError (fun _ => "complete unfavorable-control vector changed")
 if controls.length != 5 then throw "complete unfavorable-control vector changed"
 pure payload

def authoritativeRecord (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) sourceHash then
  throw "relativistic-field source record identity changed"
 let record ← payloadBoundary payload
 checkComponents files record
 controlsBoundary record

def classificationFromRecord (record : Value) (key : String) : Except String String := do
 let classifications ← field record "complete_classification"
 match (field classifications key).toOption.getD .null with
 | .text label => .ok label
 | .object _ | .boolean _ | .integer _ | .null | .array _ => .error "authoritative classification row is missing"

def classification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) (key : String) : Except String String := do
 classificationFromRecord (← authoritativeRecord bytes files payload) key
'''
for key,tag,n,short,k in items:
 s+='def '+short+'Label : String := '+q(getattr(src,key+'_LABEL'))+'\n'
 s+='def '+short+'Classification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := classification bytes files payload '+q(k)+'\n'
s+='end SFT.Physics.FieldAuthoritativeRecords\n';(r/'FieldAuthoritativeRecords.lean').write_text(s)
payload=json.load(open(w/'fieldvalidation895_original_record.json'))
s='import SFT.Physics.FieldAuthoritativeRecords\nnamespace SFT.Physics.FieldAuthoritativeWitnesses\nopen SFT.Host.Canonical FieldAuthoritativeRecords\nset_option maxRecDepth 20000\ndef registeredRecord : Value := '+cv(payload)+'\n'
s+='theorem originalPayloadBoundary : payloadBoundary registeredRecord=.ok registeredRecord := rfl\ntheorem originalControlsBoundary : controlsBoundary registeredRecord=.ok registeredRecord := rfl\n'
for key,tag,n,short,k in items:
 s+='def '+short+'Check : Bool := match classificationFromRecord registeredRecord '+q(k)+' with | .ok label => SFT.Host.Text.equal label '+short+'Label | .error _ => false\n'
 s+='theorem '+short+'CheckPassed : '+short+'Check=true := rfl\n'
 s+='theorem '+short+'OriginalClassification : classificationFromRecord registeredRecord '+q(k)+'=.ok '+short+'Label := rfl\n'
s+='end SFT.Physics.FieldAuthoritativeWitnesses\n';(r/'FieldAuthoritativeWitnesses.lean').write_text(s)
# Adapt the existing complete empirical-program generator, retaining this source metadata.
gen=(w/'prepare_vacuum_validations879.py').read_text();a=gen.index('items=');b=gen.index('\nq=',a);gen=gen[:a]+'items='+repr([(key,tag,n,[short+'Check'],short+'Classification') for key,tag,n,short,k in items])+gen[b:]
gen=gen.replace('VacuumAuthoritative','FieldAuthoritative').replace("f'SFT-PHYS-VALIDATION-VACUUM-{key}-003_spec879.json'","f'fieldvalidation{key}_spec895.json'").replace('authoritative vacuum classification differs from registration','authoritative relativistic-field classification changed')
for spec,(key,tag,n,short,k) in zip(src.VALIDATION_SPECS,items):
 d=dataclasses.asdict(spec);dims=d.pop('dimensions');witnesses=d.pop('operational_witnesses');d['target_rows']=[list(row.values()) for row in d['target_rows']];(w/f'fieldvalidation{key}_spec895.json').write_text(json.dumps(dict(values=d,dimensions=dims,witnesses=witnesses),indent=2))
exec(compile(gen,'field-validation-original-generator','exec'))
for m in ['FieldAuthoritativeRecords','FieldAuthoritativeWitnesses']+[tag+x for _,tag,_,_,_ in items for x in ['Witnesses','Grammar','Evidence','Experiment','Validation']]:shutil.copy2(r/(m+'.lean'),c/'SFT/Physics'/(m+'.lean'))
