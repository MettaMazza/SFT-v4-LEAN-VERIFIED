from pathlib import Path
import sys,json
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.medicine
sft.medicine.__path__=[str((w/'pinned1271/sft/medicine').resolve())]+list(sft.medicine.__path__)
from sft.medicine.sources import MEDICINE_AUTHORITY_SOURCES
from sft.medicine.external_bindings import BINDING_BY_CLAIM
from sft.medicine.empirical_program import MEDICINE_SPECS
spec=next(x for x in MEDICINE_SPECS if x.claim_id=='SFT-MED-DOSE-001');q=lambda x:json.dumps(x,ensure_ascii=False);option=lambda x:'none'if x is None else 'some '+q(x)
fields=['source_id','body','source_uri','snapshot_path','snapshot_hash','text_path','text_hash','evidence_scope','transport_status','failure_path','failure_hash'];optional={'snapshot_path','snapshot_hash','text_path','text_hash','failure_path','failure_hash'}
s='''import SFT.Biology.LifeOrganizationSource
namespace SFT.Medicine.DoseSource
open SFT.Host SFT.Host.Canonical
abbrev Snapshot := SFT.Materials.MaterialSource.Snapshot
abbrev readSnapshot := SFT.Materials.MaterialSource.readSnapshot
abbrev bytesHash := SFT.Materials.MaterialSource.bytesHash
structure Source where
 sourceId : String
 body : String
 uri : String
 snapshotPath : Option String
 snapshotHash : Option String
 textPath : Option String
 textHash : Option String
 scope : String
 transportStatus : String
 failurePath : Option String
 failureHash : Option String
structure Requirement where
 sourceId : String
 fragment : String
'''
s+='def sources : List Source := ['+','.join('⟨'+','.join(('('+option(getattr(x,f))+')')if f in optional else q(getattr(x,f))for f in fields)+'⟩'for x in MEDICINE_AUTHORITY_SOURCES)+']\n'
s+='def requirements : List Requirement := ['+','.join('⟨'+q(x.source_id)+','+q(x.fragment)+'⟩'for x in BINDING_BY_CLAIM[spec.claim_id].requirements)+']\n'
s+='def expectedLabel : String := '+q(spec.expected_observation_label)+'\n'
s+='''def lookup (sourceId : String) : Except String Source :=
 match sources.find? (fun s => Text.equal s.sourceId sourceId) with
 | none => .error (Text.intercalate "" ["'",sourceId,"'"])
 | some s => .ok s
-- Original source_corpus reads the registered text file directly, with UTF-8
-- replacement and casefold; it does not perform the Biology HTML extraction.
def sourceCorpus (files : List Snapshot) (sourceId : String) : Except String String := do
 let source ← lookup sourceId
 if !Text.equal source.transportStatus "captured" then
  throw (Text.append "Medicine source is unavailable and may not support a passing comparison: " sourceId)
 let path ← match source.textPath with
  | some p => .ok p
  | none => .error (Text.append "Medicine source is unavailable and may not support a passing comparison: " sourceId)
 let bytes ← readSnapshot files path
 let decoded := Text.chars (SFT.Biology.LifeOrganizationSource.decodeReplace bytes)
 let normalized := (decoded.foldl (fun (state : List Char × Bool) c =>
  if c.toNat==13 then ('\\n'::state.1,true)
  else if c.toNat==10 && state.2 then (state.1,false)
  else (c::state.1,false)) ([],false)).1.reverse
 return SFT.Chemistry.SourceText.casefold (String.ofList normalized)
def validateSources (files : List Snapshot) : Except String Unit := do
 if sources.length==13 && !(SFT.Biology.LifeOrganizationSource.distinctIds (sources.map Source.sourceId)) then
  throw "Medicine source identities repeat or are incomplete"
 let mut capturedCount := 0
 let mut failedCount := 0
 for source in sources do
  if Text.equal source.transportStatus "captured" then
   capturedCount := capturedCount+1
   let (sp,sh,tp,th) ← match source.snapshotPath,source.snapshotHash,source.textPath,source.textHash with
    | some sp,some sh,some tp,some th => .ok (sp,sh,tp,th)
    | _,_,_,_ => .error (Text.append "Medicine captured source lacks immutable paths: " source.sourceId)
   let snapshot ← readSnapshot files sp
   if !Text.equal (bytesHash snapshot) sh then
    throw (Text.append "Medicine snapshot changed: " source.sourceId)
   let text ← readSnapshot files tp
   if !Text.equal (bytesHash text) th then
    throw (Text.append "Medicine snapshot changed: " source.sourceId)
  else if Text.equal source.transportStatus "failed" then
   failedCount := failedCount+1
   let (fp,fh) ← match source.failurePath,source.failureHash with
    | some fp,some fh => .ok (fp,fh)
    | _,_ => .error (Text.append "Medicine failed-transport receipt changed: " source.sourceId)
   let failure ← readSnapshot files fp
   if !Text.equal (bytesHash failure) fh then
    throw (Text.append "Medicine failed-transport receipt changed: " source.sourceId)
  else throw (Text.append "Medicine source has unknown transport status: " source.sourceId)
 if capturedCount != 11 || failedCount != 2 then
  throw "Medicine source transport census changed"
 return ()
def extractRequirements (files : List Snapshot) : Except String (String × String) := do
 let receipts ← requirements.mapM fun requirement => do
  let source ← lookup requirement.sourceId
  let corpus ← sourceCorpus files requirement.sourceId
  let folded := SFT.Chemistry.SourceText.casefold requirement.fragment
  if !(Text.contains corpus folded) then
   throw (Text.intercalate "" ["required Medicine feature absent: ",requirement.sourceId," :: ",requirement.fragment])
  let snapshotHash := match source.snapshotHash with
   | some digest => Value.text digest
   | none => Value.null
  return Value.array [.text requirement.sourceId,snapshotHash,.text requirement.fragment,
   .text (identity (.array [.text requirement.sourceId,.text folded]))]
 return (expectedLabel,identity (.array receipts))
def sourceDerivedTarget (files : List Snapshot) : Except String (String × String) := do
 validateSources files
 extractRequirements files
end SFT.Medicine.DoseSource
'''
(r/'SFT/Medicine/DoseSource.lean').write_text(s)
print('Translated all13 original source records,11captured/2failed guards,plain-text corpus and exactthree Dose requirements; native build pending.')
