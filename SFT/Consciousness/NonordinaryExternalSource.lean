import SFT.Biology.LifeOrganizationSource
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
def observationPaths : List String := ["evidence/external/consciousness/nonordinary_2026-07-28/observations.json", "evidence/external/consciousness/nonordinary_2026-07-28_retry_1/observations.json"]
def expectedLabel : String := "stable-directed-inducer-concurrent-observed-with-heterogeneity__multidimensional-nonordinary-report-and-neural-correspondence-observed-with-ontology-separate__nrem-rem-alternation-observed-with-local-global-and-duration-heterogeneity__lost-integrated-function-distinct-from-retained-living-components__favorable-adverse-absent-nonpurpose-and-unresolved-rows-retained"
def classes : Value := .object [("favorable",.array [.text "cross-modal inducer evokes a specific concurrent",.text "altered-state reports covary with measured neural dynamics",.text "NREM and REM recur in organized alternation",.text "integrated organismal function can end while isolated organs and cells remain viable"]),("heterogeneous_or_adverse",.array [.text "consistency thresholds can be diagnostically circular and language-dependent",.text "competing synaesthesia mechanisms remain unresolved",.text "global sleep labels can dissociate across behavioral, phenomenological and physiological dimensions",.text "brain-death diagnosis has pharmacologic confounders and movement ambiguity"]),("absent_or_nonpurpose_matched",.array [.text "five first-batch cessation results are retained despite not testing the registered cessation question",.text "one self-report-only synaesthesia survey remains distinct from objective mechanism evidence"]),("unresolved",.array [.text "specific ontology of nonordinary reports is not established by correlation",.text "REM transition mechanism and universal cycle duration remain undetermined",.text "the clinical and ontological integration boundary remains contested"])]
def required : List (String × List String) := [("31630652",["stimulation of one sensory modality evokes additional experiences in another modality","sounds evoking colours"]),("39922140",["automatic, specific and consistent nature","inherent circularity"]),("36707026",["systematically induce specific colour concurrents","neural mechanisms remain largely unresolved"]),("39191666",["subjective experiences were associated with increased neural Lempel-Ziv complexity"]),("41451954",["multidimensional feature of human experience","neural marker"]),("42030660",["multidimensional subjective experience","brain network dynamics"]),("39280264",["alternate multiple times between rapid-eye-movement","mechanisms for REM homeostatic pressure remain undetermined"]),("37972882",["behavioral, phenomenological, physiological","they can also dissociate"]),("39400423",["orderly progression through wakefulness","non-rapid eye movement","rapid eye movement"]),("31696418",["loss of integrated functioning as a unified organism","physiologically maintained for prolonged periods"]),("41401968",["brain death","maintained stable levels of plasma membrane repair proteins","no evidence of pyroptosis activation"]),("41878502",["donation after brain death","islet yield, viability, and function remained high"]),("41559743",["Pharmacologic confounders","diagnostic accuracy"]),("42135815",["spinal-mediated movements","movements of unclear neuroanatomic origin"])]
structure Target where
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
