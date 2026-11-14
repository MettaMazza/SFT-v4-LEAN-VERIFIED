from pathlib import Path
import sys,json,subprocess
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');runtime=w/'v3-runtime500';sys.path.insert(0,str(runtime.resolve()))
from sft.physics import matter_flavour_terminal_proton_validation_v1 as src
p=runtime/src.SOURCE_PATH;data=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show','76f1b34e9e9682989adcbb088797b4ae4ce4fcf1:'+src.SOURCE_PATH]);p.parent.mkdir(parents=True,exist_ok=True)
if p.exists():assert p.read_bytes()==data
else:p.write_bytes(data)
record=src.authoritative_record(runtime);(w/'terminalproton940_original_record.json').write_text(json.dumps(record,indent=2));q=lambda x:json.dumps(x,ensure_ascii=False)
def cv(x):
 if x is None:return '.null'
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,list):return '.array ['+','.join(cv(y) for y in x)+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+cv(v)+')' for k,v in x.items())+']'
 raise TypeError(x)
s='''import SFT.Physics.MatterAuthoritativeRecords
namespace SFT.Physics.TerminalProtonRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
''';s+='def sourceHash : String := '+q(src.SOURCE_HASH)+'\ndef componentHash : String := '+q(src.COMPONENT_HASH)+'\ndef componentHashes : List (String × String) := [("nist-codata-2022-allascii.txt",componentHash)]\n'
s+='''def payloadBoundary (payload : Value) : Except String Value := do
 let custody := (field payload "custody").toOption.getD (.object [])
'''
required={'development_target_already_known':True,'classification':'observational_derivation','protocol_classification':'observational-data-informed_target-inaccessible_sealed-prediction','empirical_prediction_protocol':True,'target_inaccessible_during_prediction_execution':True,'formal_relation_contains_measurement':False,'measurement_selects_formal_survivor':False,'engine_prediction_sealed_before_target_release_within_run':True,'earlier_unfavorable_receipt_preserved':True,'complete_uncertainty_retained':True}
s+=''.join(' if !sameValue ((field custody '+q(k)+').toOption.getD .null) ('+cv(v)+') then throw "terminal proton custody disclosure changed"\n' for k,v in required.items())+' pure payload\n'
s+='''def authoritativeRecord (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) sourceHash then
  throw "terminal proton source record identity changed"
 let record ← payloadBoundary payload
 let source := (field record "source").toOption.getD (.object [])
 let path ← text ((field source "snapshot_path").toOption.getD (.text "missing"))
 if !sameValue ((field source "snapshot_hash").toOption.getD .null) (.text componentHash) then
  throw "terminal proton component identity changed"
 let component ← match files.find? (fun p => Text.equal p.1 path) with
  | none => .error (Text.append "FileNotFoundError: " path)
  | some p => .ok p.2
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest component)) componentHash then
  throw "terminal proton component identity changed"
 pure record
'''
s+='def registeredRecord : Value := '+cv(record)+'\ntheorem originalPayloadBoundary : payloadBoundary registeredRecord=.ok registeredRecord := rfl\nend SFT.Physics.TerminalProtonRecords\n'
for root in [r,c]:(root/'SFT/Physics/TerminalProtonRecords.lean').write_text(s)
