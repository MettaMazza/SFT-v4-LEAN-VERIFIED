import SFT.Materials.MaterialSource
namespace SFT.AstronomyCosmology.Source
open SFT.Host SFT.Host.Canonical SFT.Materials.MaterialSource
abbrev Snapshot := SFT.Materials.MaterialSource.Snapshot
-- Pinned V3 astronomy_cosmology/empirical_program.py; decoded JSON and file bytes
-- are the existing host boundary, with original keys and failure order retained.
def preSourcePath : String := "experiments/sealed_predictions/astronomy_cosmology_foundation_complete_pre_source.json"
def targetsPath : String := "experiments/astronomy_cosmology/external_targets.json"
private def objectEntries : Value → Except String (List (String × Value))
 | .object xs => .ok xs
 | .null | .text _ | .boolean _ | .integer _ | .array _ => .error "source object expected"
private def required (payload : Value) (key : String) : Except String Value := do
 let entries ← objectEntries payload
 match entries.find? (fun pair => Text.equal pair.1 key) with
 | some pair => pure pair.2
 | none => throw (Text.append "KeyError: " key)
private def isTrue : Value → Bool
 | .boolean b => b
 | .null | .text _ | .integer _ | .array _ | .object _ => false

def verifiedPayload (payload : Value) (key relative : String) : Except String Value := do
 let claimed ← required payload key
 let entries ← objectEntries payload
 let content := Value.object (entries.filter (fun pair => !Text.equal pair.1 key))
 if !Text.equal (identity content) (string claimed) then
  throw (Text.append "Astronomy evidence identity mismatch: " relative)
 return payload

-- Initial portion of build_specs, through sealed-file verification. Unlike
-- Earth, the original Astronomy code does not add census/feature-audit checks.
def validatePreSourceSeal (payload : Value) (files : List Snapshot) : Except String Value := do
 let sealRecord ← verifiedPayload payload "complete_branch_pre_source_seal_hash" preSourcePath
 let _ ← ["external_source_identities_selected","external_source_content_opened","external_outcomes_opened"].mapM fun key => do
  let value ← required sealRecord key
  if !(isFalse value) then throw "Astronomy pre-source order changed"
  pure ()
 let sealed ← required sealRecord "sealed_files" >>= objectEntries
 let _ ← sealed.mapM fun (relative,wanted) => do
  let bytes ← readSnapshot files relative
  if !Text.equal (bytesHash bytes) (string wanted) then
   throw (Text.append "Astronomy pre-source file changed: " relative)
  pure ()
 return sealRecord

-- The adapter-specific suffix of AstronomySpec.validate, after blueprint.validate.
-- Blueprint validation and build_specs assembly remain at their entry bindings.
def validateTargetRecord (dimensionCount : Nat) (targetRows : List Value)
 (claimId expectedLabel relative : String) (payload : Value) : Except String Unit := do
 if !(dimensionCount == 8) || targetRows.isEmpty then
  throw "Astronomy adapter lost grammar or evidence"
 let row ← verifiedPayload payload "target_row_hash" relative
 let actualClaim ← required row "claim_id"
 if !Text.equal (string actualClaim) claimId then throw "Astronomy target record changed"
 let observed ← required row "observed_label"
 if !Text.equal (string observed) expectedLabel then throw "Astronomy target record changed"
 let matched ← required row "exact_match"
 if !(isTrue matched) then throw "Astronomy target record changed"
 let selected ← required row "external_evidence_selected_survivor"
 if !(isFalse selected) then throw "Astronomy evidence selected the structural survivor"
 let numeric := field row "numeric_comparison"
 match numeric with
 | .null => pure ()
 | .boolean _ | .integer _ | .text _ | .array _ | .object _ =>
  let _ ← objectEntries numeric
  if !(isFalse (field numeric "first_adverse_result_reclassified")) then
   throw "Astronomy first adverse result was reclassified"
  pure ()

structure Choice where
 name : String
 properties : List String
 explanation : String
structure Dimension where
 key : String
 requiredProperty : String
 choices : List Choice
structure Blueprint where
 claimId : String
 title : String
 family : String
 statement : String
 dependencies : List String
 generationRule : String
 grammarBoundary : String
 dimensions : List Dimension
 exactResult : String
 inductionBase : String
 inductionStep : String
 exclusions : List String
 operationalWitnesses : List (String × String × Bool)
 experimentId : String
 predictedObservationLabel : String
 falsificationCondition : String

def validateDimension (d : Dimension) : Except String Unit := do
 let names := d.choices.map Choice.name
 if !(d.choices.length == 2) || !(names.eraseDups.length == 2) then
  throw "Astronomy dimension is not a binary exhaustive registration"
 if !((d.choices.filter (fun c => c.properties.any (Text.equal d.requiredProperty))).length == 1) then
  throw "Astronomy dimension does not have one preserving form"

def candidateForms (bp : Blueprint) : List (List Choice) :=
 bp.dimensions.foldr (fun d tails => d.choices.flatMap (fun c => tails.map (fun tail => c::tail))) [[]]
def candidatePreserves (bp : Blueprint) (form : List Choice) : Bool :=
 form.length == 8 && (bp.dimensions.zip form).all (fun (d,c) => c.properties.any (Text.equal d.requiredProperty))
def uniqueSurvivor (bp : Blueprint) : Except String (List Choice) :=
 match (candidateForms bp).filter (candidatePreserves bp) with
 | [form] => .ok form
 | [] | _::_::_ => .error "Astronomy grammar did not yield exactly one preserving form"
def validateBlueprint (bp : Blueprint) : Except String Unit := do
 if !(Text.isPrefix "SFT-ASTRO-".toUTF8.data.toList bp.claimId.toUTF8.data.toList) || !(bp.dimensions.length == 8) then
  throw "Astronomy blueprint identity or arity is invalid"
 let _ ← bp.dimensions.mapM validateDimension
 if !(bp.operationalWitnesses.all (fun (_,_,ok) => ok)) then
  throw "Astronomy operational witness failed"
 let survivor ← uniqueSurvivor bp
 if !Text.equal bp.exactResult (Text.intercalate "__" (survivor.map Choice.name)) then
  throw "Astronomy registered result differs from reconstructed survivor"

structure AdaptedChoice where
 name : String
 preserves : Bool
 explanation : String
structure AdaptedDimension where
 key : String
 choices : List AdaptedChoice
structure ExternalTarget where
 targetId : String
 sourceId : String
 registeredLocator : String
 observedLabel : String
structure Spec where
 blueprint : Blueprint
 dimensions : List AdaptedDimension
 targetRows : List ExternalTarget
 sourceSnapshotPath : String
 sourceSnapshotHash : String
 empiricalDisposition : String
 directness : String

def adapt (bp : Blueprint) : List AdaptedDimension :=
 bp.dimensions.map fun d => ⟨d.key,d.choices.map fun c =>
  ⟨c.name,c.properties.any (Text.equal d.requiredProperty),c.explanation⟩⟩
private def arrayEntries : Value → Except String (List Value)
 | .array xs => .ok xs
 | .null | .text _ | .boolean _ | .integer _ | .object _ => .error "source array expected"
private def decodedRecord (records : List (String × Value)) (relative : String) : Except String Value :=
 match records.find? (fun pair => Text.equal pair.1 relative) with
 | some pair => .ok pair.2
 | none => .error (Text.append "FileNotFoundError: " relative)

-- records are the decoded JSON view of the same supplied snapshot files.
def buildSpecs (blueprints : List Blueprint) (records : List (String × Value))
 (files : List Snapshot) : Except String (List Spec) := do
 let sealPayload ← decodedRecord records preSourcePath
 let _ ← validatePreSourceSeal sealPayload files
 let targetPayload ← decodedRecord records targetsPath
 let targets ← verifiedPayload targetPayload "targets_hash" targetsPath
 let rows ← required targets "targets" >>= arrayEntries
 -- Python's dictionary comprehension keeps the last row for a repeated claim key.
 let indexed ← rows.mapM fun row => do
  let claim ← required row "claim_id"
  pure (string claim,row)
 blueprints.mapM fun bp => do
  let row ← match indexed.reverse.find? (fun pair => Text.equal pair.1 bp.claimId) with
   | some pair => pure pair.2
   | none => throw (Text.append "KeyError: " bp.claimId)
  let relative := string (← required row "target_record_path")
  let payload ← decodedRecord records relative
  let target ← verifiedPayload payload "target_row_hash" relative
  let evidence ← required target "source_evidence" >>= arrayEntries
  let first ← match evidence with
   | [] => throw "IndexError: list index out of range"
   | first::_ => pure first
  let targetId := string (← required target "target_id")
  let sourceId := string (← required first "source_id")
  let locator := string (← required first "registered_locator")
  let observed := string (← required target "observed_label")
  let bytes ← readSnapshot files relative
  let disposition := string (← required target "empirical_disposition")
  let directness := string (← required target "directness")
  pure ⟨bp,adapt bp,[⟨targetId,sourceId,locator,observed⟩],relative,bytesHash bytes,disposition,directness⟩

def validateSpec (spec : Spec) (records : List (String × Value)) : Except String Unit := do
 validateBlueprint spec.blueprint
 -- The original arity/nonempty guard precedes reading the target record.
 if !(spec.dimensions.length == 8) || spec.targetRows.isEmpty then
  throw "Astronomy adapter lost grammar or evidence"
 let payload ← decodedRecord records spec.sourceSnapshotPath
 validateTargetRecord spec.dimensions.length (spec.targetRows.map (fun _ => .null))
  spec.blueprint.claimId spec.blueprint.predictedObservationLabel spec.sourceSnapshotPath payload

end SFT.AstronomyCosmology.Source
