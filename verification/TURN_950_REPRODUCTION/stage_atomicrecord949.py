from pathlib import Path
import json,sys
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import atomic_spectra_postseal_validation_v1 as src
record=src.source_record(w/'v3-runtime500');q=lambda x:json.dumps(x,ensure_ascii=False)
def cv(x):
 if x is None:return '.null'
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,list):return '.array ['+','.join(map(cv,x))+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+cv(v)+')' for k,v in x.items())+']'
 raise TypeError(x)
s='''import SFT.Physics.MatterAuthoritativeRecords
namespace SFT.Physics.AtomicPostsealRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
'''
s+='def sourceHash : String := '+q(src.SOURCE_RECORD_HASH)+'\ndef componentHashes : List (String × String) := ['+','.join('('+q(k)+','+q(v)+')' for k,v in src.EXPECTED_SOURCE_HASHES.items())+']\n'
s+='''def sourceId (row : Value) : Value := (field row "source_id").toOption.getD .null
def sourceById (rows : List Value) (key : String) : Except String Value :=
 match rows.reverse.find? (fun row => sameValue (sourceId row) (.text key)) with
 | none => .error (Text.append "missing source: " key)
 | some row => .ok row
def payloadBoundary (payload : Value) : Except String Value := do
 if !sameValue ((field payload "schema").toOption.getD .null) (.text "sft-v3-atomic-spectra-postseal-source-record/1") then
  throw "atomic-spectrum source schema changed"
 let custody := (field payload "custody").toOption.getD .null
'''
for k in ['development_targets_already_known','target_inaccessible_during_prediction_execution','engine_prediction_sealed_before_target_release_within_run','complete_reported_uncertainties_retained','unfavorable_molecular_ratio_retained']:
 s+=' if !sameValue ((field custody '+q(k)+').toOption.getD .null) (.boolean true) then throw "atomic-spectrum custody disclosure is incomplete"\n'
for k,msg in [('formal_relations_contain_measurement','formal atomic relation improperly contains a measurement'),('measurements_select_formal_survivors','measurement improperly selects a formal atomic survivor')]:
 s+=' if !sameValue ((field custody '+q(k)+').toOption.getD .null) (.boolean false) then throw '+q(msg)+'\n'
s+=''' let sources ← (do array (← field payload "sources")).mapError (fun _ => "atomic-spectrum source vector is incomplete")
 if sources.length != componentHashes.length then throw "atomic-spectrum source vector is incomplete"
 if !(componentHashes.all (fun pair => sources.any (fun row => sameValue (sourceId row) (.text pair.1)))) then
  throw "atomic-spectrum source identities changed"
 pure payload

def authoritativeRecord (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) sourceHash then
  throw "atomic-spectrum source record differs from registration"
 let record ← payloadBoundary payload
 let sources ← array (← field record "sources")
 let _ ← componentHashes.foldlM (fun (_ : Unit) pair => do
  let row ← sourceById sources pair.1
  if !sameValue ((field row "snapshot_hash").toOption.getD .null) (.text pair.2) then
   throw (Text.append "registered source hash changed: " pair.1)
  let path ← text (← field row "snapshot_path")
  let bytes ← match files.find? (fun p => Text.equal p.1 path) with
   | none => .error (Text.append "FileNotFoundError: " path)
   | some p => .ok p.2
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) pair.2 then
   throw (Text.append "source snapshot differs from its registered hash: " pair.1)
  pure ()) ()
 pure record

def reportedRow (record : Value) (key : String) : Except String Value := do
 field (← sourceById (← array (← field record "sources")) key) "reported_record"
'''
s+='def registeredRecord : Value := '+cv(record)+'\ntheorem originalPayloadBoundary : payloadBoundary registeredRecord=.ok registeredRecord := rfl\nend SFT.Physics.AtomicPostsealRecords\n'
for root in [w/'constants-recovery',Path('/Volumes/One Touch/SFT v4 Full model LEAN')]:
 (root/'SFT/Physics/AtomicPostsealRecords.lean').write_text(s)
print('Original record/custody translation staged')
