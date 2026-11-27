import SFT.Materials.BulkWaterEvidence
import SFT.Materials.BulkWaterSource
import SFT.Chemistry.SourceExtraction
import SFT.Physics.ObservationPrediction
namespace SFT.Materials.BulkWaterExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
def claimId : String := "SFT-MAT-BULK-WATER-RESPONSE-002"
def experimentId : String := "SFT-EXP-MAT-BULK-WATER-RESPONSE-002"
def subbranch : String := "material_classes_bulk"
def targetId : String := "sft-mat-bulk-water-response-002-external"
def frozenRelation : String := "molecular-network-and-bulk-specimen-carrier__intermolecular-organization-to-bulk-response-relation__phase-density-boiling-and-heat-capacity-records-retained__identity-condition-method-and-uncertainty-bounded__complete-state-transition-boundary-trace__root-bound-forward-forcing__positive-finite-successor-closure__no-extra-rule"
def expectedLabel : String := "molecular-network-and-bulk-specimen-carrier__intermolecular-organization-to-bulk-response-relation__phase-density-boiling-and-heat-capacity-records-retained__identity-condition-method-and-uncertainty-bounded__complete-state-transition-boundary-trace__root-bound-forward-forcing__positive-finite-successor-closure__no-extra-rule"
def falsification : String := "The claim fails if any registered carrier, relation, organization or observation feature is absent, any required external row fails, or any tampered row is accepted."
def sourceIds : List String := ["NIST-WATER-THERMOPHYSICAL-2026-07-27","NIST-LIQUID-WATER-DENSITY-2026-07-27","NIST-ICE-DENSITY-2026-07-27"]
def registeredSubbranches : List String := ["measurement_identity","crystal_quasicrystal","defects_microstructure","electronic_semiconductor","superconducting_superfluid_topological","mechanical","thermal_magnetic_optical","material_classes_bulk","processing_degradation","advanced_functional_sustainable"]
def dimensions : List (String × List (String × Bool)) := [("carrier",[("carrier-erased-or-answer-only",false),("molecular-network-and-bulk-specimen-carrier",true)]),("relation",[("relation-imported-fitted-or-erased",false),("intermolecular-organization-to-bulk-response-relation",true)]),("organization",[("organization-collapsed",false),("phase-density-boiling-and-heat-capacity-records-retained",true)]),("observation",[("observation-boundary-unrecorded",false),("identity-condition-method-and-uncertainty-bounded",true)]),("record",[("result-without-transition-trace",false),("complete-state-transition-boundary-trace",true)]),("provenance",[("authority-or-target-selected-law",false),("root-bound-forward-forcing",true)]),("generality",[("finite-answer-lookup",false),("positive-finite-successor-closure",true)]),("extension",[("free-fit-exception-or-extra-rule",false),("no-extra-rule",true)])]
def preservingNames : List (String × List (String × Bool)) → Except String (List String)
 | [] => .ok []
 | (key,choices)::rest => do
   if !(choices.length == 2) then .error "each Materials dimension must exhaust two registered forms"
   else
    let held := choices.filter (fun c => c.2)
    if !(held.length == 1) then .error (Text.intercalate "" ["dimension ",key," requires one preserving form"])
    else do
     let tail ← preservingNames rest
     .ok ((held.headD ("",false)).1::tail)

def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-MAT-").isPrefixOf (Text.chars claimId) then .error "Materials blueprint claim identity is invalid"
 else if !(Text.chars "SFT-EXP-MAT-").isPrefixOf (Text.chars experimentId) then .error "Materials blueprint experiment identity is invalid"
 else if !(registeredSubbranches.any (fun name => Text.equal name subbranch)) then .error "Materials blueprint subbranch is unregistered"
 else if BulkWaterEvidence.dependencies.isEmpty || !(dimensions.length == 8) then .error "Materials blueprint requires dependencies and eight dimensions"
 else if !(SFT.Chemistry.SourceExtraction.unique (dimensions.map (fun d => d.1))) then .error "Materials blueprint dimensions repeat"
 else do
  let names ← preservingNames dimensions
  if !(Text.equal frozenRelation (Text.intercalate "__" names)) then .error "Materials exact result is not the unique preservation survivor"
  else if !SFT.Chemistry.SourceText.nonblank expectedLabel || !SFT.Chemistry.SourceText.nonblank falsification then .error "Materials blueprint lacks prediction or falsification boundary"
  else if !(BulkWater.witness) then .error "Materials operational witness failed"
  else if sourceIds.isEmpty || sourceIds.any (fun id => !(BulkWaterSource.sources.any (fun row => Text.equal row.sourceId id))) then
   .error "invalid successor source binding"
  else .ok ()
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def program : CapabilityAdmission.Program :=
 ⟨Text.append experimentId "-prediction",[
  ⟨.input,"premise",["registered-premise"]⟩,
  ⟨.label,"prediction",["materials-observation",expectedLabel]⟩,
  ⟨.emit,"",["prediction"]⟩]⟩
def programFields : List (String × Value) := [
 ("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),
 ("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def programDocument : Value := .object programFields
def registrationHash (preSourceSeal : String) (receipts : List Value) : String :=
 identity (.array [.text claimId,.text preSourceSeal,.array receipts])
def envelope (registryHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array [.text targetId]),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registryHash)]
#print axioms claimId
#print axioms experimentId
#print axioms subbranch
#print axioms targetId
#print axioms frozenRelation
#print axioms expectedLabel
#print axioms falsification
#print axioms sourceIds
#print axioms registeredSubbranches
#print axioms dimensions
#print axioms preservingNames
#print axioms validateSpec
#print axioms labelValue
#print axioms program
#print axioms programFields
#print axioms programDocument
#print axioms registrationHash
#print axioms envelope
end SFT.Materials.BulkWaterExperiment
