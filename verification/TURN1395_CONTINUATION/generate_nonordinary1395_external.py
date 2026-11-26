from pathlib import Path
import sys,json,ast
w=Path('work');r=w/'turn1064_recovery/SFT/Consciousness';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.consciousness import nonordinary_external_v1 as src
q=lambda x:json.dumps(x,ensure_ascii=False)
def cv(x):
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,(tuple,list)):return '.array ['+','.join(cv(y)for y in x)+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+cv(v)+')'for k,v in x.items())+']'
 raise TypeError(x)
classes=json.loads((w/'nonordinary1395_target_expected.json').read_text())['classes']
s='''import SFT.Biology.LifeOrganizationSource
import SFT.Chemistry.JointCorrelationTargets
import SFT.Chemistry.HalfReactionOrientationAnalysis
namespace SFT.Consciousness.NonordinaryExternalSource
open SFT.Host SFT.Host.Canonical
set_option maxRecDepth 50000
set_option maxHeartbeats 100000000
abbrev field := SFT.Chemistry.JointCorrelationTargets.field
abbrev text := SFT.Chemistry.JointCorrelationTargets.text
abbrev get := SFT.Materials.MaterialSource.field
abbrev array := SFT.Physics.RunningConvergenceMeasurement.array
structure File where
 path : String
 bytes : ByteArray
 document : Value

def fileAt (files : List File) (path : String) : Except String File :=
 match files.find? (fun f => Text.equal f.path path) with
 | some file => .ok file
 | none => .error (Text.append "source file unavailable: " path)
def hashBytes (bytes : ByteArray) : String := Text.append "sha256:" (SHA256Window.digest bytes)
def normalize (bytes : ByteArray) : String :=
 let cs := Text.chars (SFT.Biology.LifeOrganizationSource.decodeReplace bytes)
 let stripped := SFT.Materials.SourceText.stripTags cs.length cs
 let unescaped := SFT.Materials.SourceText.unescapeChars stripped.length stripped
 String.ofList (SFT.Materials.SourceText.collapseSpace
  (unescaped.dropWhile SFT.Chemistry.SourceText.whitespace) false)
'''
s+='def observationPaths : List String := '+repr([src.ROOT_DIR+'/'+x for x in src.OBSERVATION_FILES]).replace("'",'"')+'\n'
s+='def expectedLabel : String := '+q(src.PREDICTION_LABEL)+'\ndef classes : Value := '+cv(classes)+'\n'
s+='def required : List (String × List String) := ['+','.join('('+q(p)+',['+','.join(q(f)for f in fs)+'])'for p,fs in src.REQUIRED.items())+']\n'
s+='''structure Target where
 label : String
 extractionHash : String
 sourceIds : List String
 resultClasses : Value

def sourceTarget (files : List File) : Except String Target := do
 let batches ← observationPaths.mapM fun path => do
  let payload ← fileAt files path
  let identityPath ← field payload.document "target_identity_registration_path" >>= text
  let identity ← fileAt files identityPath
  let expectedHash ← field payload.document "target_identity_registration_hash" >>= text
  if !Text.equal (hashBytes identity.bytes) expectedHash then throw "Consciousness target identity registration changed"
  let contentAbsent := match get identity.document "target_content_present" with
   | .boolean false => true
   | .boolean true | .null | .text _ | .integer _ | .array _ | .object _ => false
  if !contentAbsent then throw "Consciousness target content was present in identity registration"
  let selected ← field identity.document "selected" >>= array
  let identities ← selected.mapM fun row => field row "pmid" >>= text
  let rows ← field payload.document "documents" >>= array
  let documents ← rows.mapM fun row => do
   let pmid ← field row "pmid" >>= text
   if !(identities.any (Text.equal pmid)) then throw "Consciousness source not pre-registered"
   let path ← field row "snapshot_path" >>= text
   let snapshot ← fileAt files path
   let expectedHash ← field row "snapshot_hash" >>= text
   if !Text.equal (hashBytes snapshot.bytes) expectedHash then throw "Consciousness source bytes changed"
   pure (row,normalize snapshot.bytes)
  pure (hashBytes payload.bytes,documents)
 let registryHashes := batches.map Prod.fst
 let documents := batches.flatMap Prod.snd
 let _ ← required.mapM fun (pmid,fragments) => do
  let found := documents.reverse.find? (fun row => Text.equal (SFT.Materials.MaterialSource.string (get row.1 "pmid")) pmid)
  match found with
  | none => throw (Text.append "required Consciousness observation absent: " pmid)
  | some (_,body) =>
   let folded := SFT.Chemistry.HalfReactionOrientationAnalysis.casefold body
   if !(fragments.all fun fragment => Text.contains folded
     (SFT.Chemistry.HalfReactionOrientationAnalysis.casefold fragment)) then
    throw (Text.append "required Consciousness observation absent: " pmid)
   pure ()
 let rows ← documents.mapM fun (row,_) => do
  let pmid ← field row "pmid"
  let digest ← field row "snapshot_hash"
  let resultClass ← field row "class"
  pure (.array [pmid,digest,resultClass])
 let ids ← documents.mapM fun (row,_) => do
  let pmid ← field row "pmid" >>= text
  pure (Text.append "PMID:" pmid)
 pure ⟨expectedLabel,identity (.array [.array (registryHashes.map Value.text),.array rows,classes]),ids,classes⟩
end SFT.Consciousness.NonordinaryExternalSource
''';(r/'NonordinaryExternalSource.lean').write_text(s)
s='''import SFT.Consciousness.NonordinaryExternalSource
import SFT.Physics.CapabilityDocuments
namespace SFT.Consciousness.NonordinaryExternalExperiment
open SFT.Host SFT.Host.Canonical
'''
s+='def experimentId : String := '+q(src.EXPERIMENT_ID)+'\ndef claimId : String := '+q(src.CLAIM_ID)+'\ndef targetId : String := '+q(src.TARGET_ID)+'\ndef expectedLabel : String := '+q(src.PREDICTION_LABEL)+'\n'
s+='def registration : Value := '+cv(src.external_registration_record())+'\ndef predictionDocument : Value := '+cv(src.prediction_program_document())+'\n'
old=(r/'RedControlsExperiment.lean').read_text();a=old.index('def programFields');b=old.index('def registration (row',a);s+=old[a:b];s+='end SFT.Consciousness.NonordinaryExternalExperiment\n';(r/'NonordinaryExternalExperiment.lean').write_text(s)
print('Staged exact source-target reconstruction and original four-instruction experiment')
