from pathlib import Path
import sys,json,subprocess
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');runtime=w/'v3-runtime500';sys.path.insert(0,str(runtime.resolve()))
from sft.physics import matter_flavour_terminal_anomaly_validation_v1 as src
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
def pinned(rel):return subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':'+rel])
data=pinned(src.SOURCE_PATH);p=runtime/src.SOURCE_PATH;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(data)
for row in json.loads(data)['sources'].values():
 p=runtime/row['snapshot_path'];data=pinned(row['snapshot_path'])
 if p.exists():assert p.read_bytes()==data
 else:p.write_bytes(data)
record=src.authoritative_record(runtime);(w/'terminalanomaly942_original_record.json').write_text(json.dumps(record,indent=2));q=lambda x:json.dumps(x,ensure_ascii=False)
def cv(x):
 if x is None:return '.null'
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,list):return '.array ['+','.join(cv(y) for y in x)+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+cv(v)+')' for k,v in x.items())+']'
 raise TypeError(x)
s='''import SFT.Physics.MatterAuthoritativeRecords
namespace SFT.Physics.TerminalAnomalyRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
''';s+='def sourceHash : String := '+q(src.SOURCE_HASH)+'\ndef componentHashes : List (String × String) := ['+','.join('('+q(k)+','+q(v)+')' for k,v in src.COMPONENT_HASHES.items())+']\n'
s+='''def payloadBoundary (payload : Value) : Except String Value := do
 let custody := (field payload "custody").toOption.getD (.object [])
'''
required={'development_target_already_known':True,'classification':'observational_derivation','protocol_classification':'observational-data-informed_target-inaccessible_sealed-prediction','empirical_prediction_protocol':True,'target_inaccessible_during_prediction_execution':True,'formal_relation_contains_measurement':False,'measurement_selects_formal_survivor':False,'engine_prediction_sealed_before_target_release_within_run':True,'earlier_unfavorable_receipt_preserved':True,'complete_uncertainties_retained':True}
s+=''.join(' if !sameValue ((field custody '+q(k)+').toOption.getD .null) ('+cv(v)+') then throw "terminal anomaly custody disclosure changed"\n' for k,v in required.items())
s+=''' let sources := (field payload "sources").toOption.getD (.object [])
 let pairs ← match sources with
  | .object xs => .ok xs
  | .text _ => .error "terminal anomaly source set changed"
  | .boolean _ => .error "terminal anomaly source set changed"
  | .integer _ => .error "terminal anomaly source set changed"
  | .null => .error "terminal anomaly source set changed"
  | .array _ => .error "terminal anomaly source set changed"
 if !(pairs.all (fun p => Text.equal p.1 "electron" || Text.equal p.1 "muon")) ||
    !(pairs.any (fun p => Text.equal p.1 "electron")) || !(pairs.any (fun p => Text.equal p.1 "muon")) then
  throw "terminal anomaly source set changed"
 pure payload

def authoritativeRecord (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) sourceHash then
  throw "terminal anomaly source record identity changed"
 let record ← payloadBoundary payload
 let sources ← field record "sources"
 let _ ← componentHashes.foldlM (fun (_ : Unit) (pair : String × String) => do
  let source ← field sources pair.1
  let path ← text ((field source "snapshot_path").toOption.getD (.text "missing"))
  if !sameValue ((field source "snapshot_hash").toOption.getD .null) (.text pair.2) then
   throw (Text.append (Text.append "terminal " pair.1) " anomaly source identity changed")
  let component ← match files.find? (fun p => Text.equal p.1 path) with
   | none => .error (Text.append "FileNotFoundError: " path)
   | some p => .ok p.2
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest component)) pair.2 then
   throw (Text.append (Text.append "terminal " pair.1) " anomaly source identity changed")
  pure ()) ()
 pure record
'''
s+='def componentFiles : List (String × String) := ['+','.join('('+q(x['snapshot_path'].split('/')[-1])+','+q(x['snapshot_hash'])+')' for x in record['sources'].values())+']\n'
s+='def registeredRecord : Value := '+cv(record)+'\ntheorem originalPayloadBoundary : payloadBoundary registeredRecord=.ok registeredRecord := rfl\nend SFT.Physics.TerminalAnomalyRecords\n'
for root in [r,c]:(root/'SFT/Physics/TerminalAnomalyRecords.lean').write_text(s)
