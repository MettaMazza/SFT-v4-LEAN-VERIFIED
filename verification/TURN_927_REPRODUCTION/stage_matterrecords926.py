from pathlib import Path
import json,sys
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import matter_flavour_validation_v1 as src
q=lambda x:json.dumps(x,ensure_ascii=False)
def cv(x):
 if x is None:return '.null'
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,(list,tuple)):return '.array ['+','.join(cv(v) for v in x)+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+cv(v)+')' for k,v in x.items())+']'
 raise TypeError(x)
s='''import SFT.Physics.RunningConvergenceMeasurement
import SFT.Host.SHA256Chunks
namespace SFT.Physics.MatterAuthoritativeRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
'''
s+='def componentHashes : List (String × String) := ['+','.join('('+q(k)+','+q(v)+')' for k,v in src.COMPONENT_HASHES.items())+']\n'
s+='def sourceHash : String := '+q(src.SOURCE_HASH)+'\n'
s+='''def payloadBoundary (payload : Value) : Except String Value := do
 let custody := (field payload "custody").toOption.getD (.object [])
 let sealed := (field custody "formal_seal_completed_before_source_open").toOption.getD .null
 if !sameValue sealed (.boolean true) then throw "matter/flavour post-seal custody changed"
 let sources ← (do array (← field payload "sources")).mapError (fun _ => "matter/flavour source vector is incomplete")
 if sources.length != 6 then throw "matter/flavour source vector is incomplete"
 pure payload

def lastPathPartChars (current : List Char) : List Char → List Char
 | [] => current.reverse
 | ch::tail => if ch == '/' then lastPathPartChars [] tail else lastPathPartChars (ch::current) tail

def lastPathPart (path : String) : String := String.ofList (lastPathPartChars [] (Text.chars path))

def checkComponents (files : List (String × ByteArray)) (payload : Value) : Except String Unit := do
 let sources ← array (← field payload "sources")
 let _ ← sources.foldlM (fun (_ : Unit) source => do
  let path ← text ((field source "snapshot_path").toOption.getD (.text ""))
  let snapshot := lastPathPart path
  match componentHashes.find? (fun p => Text.equal p.1 snapshot) with
  | none => pure ()
  | some (_,hash) =>
   let bytes ← match files.find? (fun p => Text.equal p.1 path) with
    | none => .error (Text.append "FileNotFoundError: " path)
    | some p => .ok p.2
   if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) hash then
    throw "matter/flavour component identity changed"
   pure ()) ()
 pure ()

def authoritativeRecord (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) sourceHash then
  throw "matter/flavour source record identity changed"
 let record ← payloadBoundary payload
 checkComponents files record
 pure record

def findSourceRows (sourceId : String) : List Value → Except String Value
 | [] => .error (Text.append "missing registered source " sourceId)
 | item::tail => do
   let id ← text (← field item "source_id")
   if Text.equal id sourceId then field item "rows" else findSourceRows sourceId tail

def sourceRowsFromRecord (record : Value) (sourceId : String) : Except String Value := do
 findSourceRows sourceId (← array (← field record "sources"))
def sourceRows (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) (sourceId : String) : Except String Value := do
 sourceRowsFromRecord (← authoritativeRecord bytes files payload) sourceId
end SFT.Physics.MatterAuthoritativeRecords
'''
for root in [r,c]:(root/'SFT/Physics/MatterAuthoritativeRecords.lean').write_text(s)
s='''import SFT.Physics.MatterAuthoritativeRecords
import SFT.Physics.QuarkComparison
namespace SFT.Physics.QuarkComparisonMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals QuarkComparison MatterAuthoritativeRecords
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
'''
s+='def quarkLabel : String := '+q(src.QUARK_CKM_LABEL)+'\n'
s+='''def quarkClassificationRows (quark ckm : Value) : Except String String := do
 let predictions ← quarkPredictionIntervals
 let ms ← field quark "ms_MeV_MSbar_2GeV"
 let md ← field quark "md_MeV_MSbar_2GeV"
 let msv ← decimalField ms "value"
 let msu ← decimalField ms "total_uncertainty"
 let mdv ← decimalField md "value"
 let mdu ← decimalField md "total_uncertainty"
 let sdl ← LeptonRatios.divide (subtract msv msu) (add mdv mdu)
 let sdu ← LeptonRatios.divide (add msv msu) (subtract mdv mdu)
 let mcms ← field quark "mc_over_ms"
 let mbmc ← field quark "mb_over_mc"
 let cv ← decimalField mcms "value"
 let cu ← decimalField mcms "total_uncertainty"
 let bv ← decimalField mbmc "value"
 let bu ← decimalField mbmc "total_uncertainty"
 let bsTarget := (multiply (subtract cv cu) (subtract bv bu),multiply (add cv cu) (add bv bu))
 if !overlaps predictions.sOverD (sdl,sdu) || !overlaps predictions.bOverS bsTarget then
  throw "sealed dressed quark ratios miss complete PDG intervals"
 let tc ← field quark "top_over_charm"
 if !Text.equal (← text (← field tc "measurement_status")) "no exact scheme-matched direct measurement registered" then
  throw "top/charm direct-measurement status changed"
 if !Text.equal (← text (← field tc "formal_status_consequence")) "the independently sealed SFT value remains a prediction" then
  throw "top/charm prediction status changed"
 let cp ← ckmPredictionIntervals
 let checks ← [(cp.s12Squared,"sin_theta12"),(cp.s23Squared,"sin_theta23"),(cp.s13Squared,"sin_theta13"),(cp.jarlskogSquared,"jarlskog")].mapM fun (prediction,key) => do
  let row ← field ckm key
  let centre ← decimalField row "value"
  let low ← decimalField row "lower_uncertainty"
  let high ← decimalField row "upper_uncertainty"
  let three := normalize 3 1 (by decide)
  let target := (square (subtract centre (multiply three low)),square (add centre (multiply three high)))
  pure (overlaps prediction target)
 let s12 ← LeptonRatios.atIndex checks 0
 let s23 ← LeptonRatios.atIndex checks 1
 let s13 ← LeptonRatios.atIndex checks 2
 let j ← LeptonRatios.atIndex checks 3
 if !(s12 && s13 && j && !s23) then throw "complete CKM support/tension pattern changed"
 pure quarkLabel

def quarkClassificationFromRecord (record : Value) : Except String String := do
 let quark ← sourceRowsFromRecord record "PDG-2025-QUARK-MASSES"
 let ckm ← sourceRowsFromRecord record "PDG-2025-CKM-MATRIX"
 quarkClassificationRows quark ckm

def quarkClassification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := do
 let quark ← sourceRows bytes files payload "PDG-2025-QUARK-MASSES"
 let ckm ← sourceRows bytes files payload "PDG-2025-CKM-MATRIX"
 quarkClassificationRows quark ckm
end SFT.Physics.QuarkComparisonMeasurement
'''
for root in [r,c]:(root/'SFT/Physics/QuarkComparisonMeasurement.lean').write_text(s)
payload=json.loads((w/'mattervalidation926_original_record.json').read_text())
s='''import SFT.Physics.QuarkComparisonMeasurement
namespace SFT.Physics.MatterAuthoritativeWitnesses
open SFT.Host.Canonical MatterAuthoritativeRecords QuarkComparisonMeasurement
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
'''
s+='def registeredRecord : Value := '+cv(payload)+'\n'
s+='''theorem originalPayloadBoundary : payloadBoundary registeredRecord = .ok registeredRecord := rfl
def quarkCheck : Bool := match quarkClassificationFromRecord registeredRecord with
 | .ok label => SFT.Host.Text.equal label quarkLabel
 | .error _ => false
theorem quarkOriginalClassification : quarkClassificationFromRecord registeredRecord = .ok quarkLabel := rfl
theorem quarkCheckPassed : quarkCheck = true := rfl
end SFT.Physics.MatterAuthoritativeWitnesses
'''
for root in [r,c]:(root/'SFT/Physics/MatterAuthoritativeWitnesses.lean').write_text(s)
print('Staged exact source custody, source-row lookup, all quark/CKM comparison branches and full original record witness')
