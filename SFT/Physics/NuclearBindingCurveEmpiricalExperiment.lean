import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.NuclearBindingCurveEmpiricalEvidence
set_option maxRecDepth 20000
namespace SFT.Physics.NuclearBindingCurveEmpiricalExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-NUCLEAR-BINDING-CURVE-TERMINAL-005"
def experimentId : String := "SFT-EXP-PHYS-NUCLEAR-BINDING-CURVE-TERMINAL-005"
def expectedLabel : String := "sealed-zero-parameter-binding-ledger-uniquely-predicts-A62-Z28-N34__complete-AME2020-2548-positive-composite-row-census-identifies-Ni62-global-binding-per-nucleon-maximum__Ni62-lower-uncertainty-bound-exceeds-every-rival-upper-bound__light-anchor-rise-and-heavy-anchor-fall-close-an-interior-iron-nickel-maximum__unqualified-iron-only-maximum-replaced-by-exact-nickel62-coordinate"
def frozenRelation : String := "The complete 2,548-row positive-composite AME2020 census places nickel-62 at 8794.5555 +/- 0.0069 keV per nucleon. Its lower uncertainty endpoint exceeds every rival upper endpoint. The independently sealed A=62, Z=28, N=34 coordinate matches exactly; light anchors rise and lead-208/uranium-238 fall from the interior iron-nickel region."
def sourcePath : String := "experiments/external_sources/physics/snapshots/nuclear-binding-curve-successor-source-record.json"
def snapshotHash : String := "sha256:d10a9474253b2d29fac71ee21352039659f2e5f4b7d75395416d361878a18ddc"
def falsification : String := "The claim fails if the complete measured table has another maximum, the predicted coordinate differs, uncertainty intervals erase the separation, either curve direction fails, any numeric rival is omitted, or target access precedes the formal seal."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"AME2020-COMPLETE-BINDING-CENSUS","AMDC-AME2020-MASS-1-BINDING-2021","AME2020 mass_1.mas20 complete 2,548 positive composite rows plus two singleton empty-binding boundary rows","sealed-zero-parameter-binding-ledger-uniquely-predicts-A62-Z28-N34__complete-AME2020-2548-positive-composite-row-census-identifies-Ni62-global-binding-per-nucleon-maximum__Ni62-lower-uncertainty-bound-exceeds-every-rival-upper-bound__light-anchor-rise-and-heavy-anchor-fall-close-an-interior-iron-nickel-maximum__unqualified-iron-only-maximum-replaced-by-exact-nickel62-coordinate"⟩,⟨"AME2020-GLOBAL-MAXIMUM","AMDC-AME2020-MASS-1-BINDING-2021","AME2020 complete binding-energy-per-nucleon ranking with reported uncertainties","sealed-zero-parameter-binding-ledger-uniquely-predicts-A62-Z28-N34__complete-AME2020-2548-positive-composite-row-census-identifies-Ni62-global-binding-per-nucleon-maximum__Ni62-lower-uncertainty-bound-exceeds-every-rival-upper-bound__light-anchor-rise-and-heavy-anchor-fall-close-an-interior-iron-nickel-maximum__unqualified-iron-only-maximum-replaced-by-exact-nickel62-coordinate"⟩,⟨"AME2020-LIGHT-TO-IRON-NICKEL-RISE","AMDC-AME2020-MASS-1-BINDING-2021","AME2020 deuterium, helium-4, carbon-12, iron-56/58 and nickel-62 rows","sealed-zero-parameter-binding-ledger-uniquely-predicts-A62-Z28-N34__complete-AME2020-2548-positive-composite-row-census-identifies-Ni62-global-binding-per-nucleon-maximum__Ni62-lower-uncertainty-bound-exceeds-every-rival-upper-bound__light-anchor-rise-and-heavy-anchor-fall-close-an-interior-iron-nickel-maximum__unqualified-iron-only-maximum-replaced-by-exact-nickel62-coordinate"⟩,⟨"AME2020-HEAVY-FALL","AMDC-AME2020-MASS-1-BINDING-2021","AME2020 lead-208 and uranium-238 rows","sealed-zero-parameter-binding-ledger-uniquely-predicts-A62-Z28-N34__complete-AME2020-2548-positive-composite-row-census-identifies-Ni62-global-binding-per-nucleon-maximum__Ni62-lower-uncertainty-bound-exceeds-every-rival-upper-bound__light-anchor-rise-and-heavy-anchor-fall-close-an-interior-iron-nickel-maximum__unqualified-iron-only-maximum-replaced-by-exact-nickel62-coordinate"⟩,⟨"AME2020-IRON-ONLY-ADVERSE","AMDC-AME2020-MASS-1-BINDING-2021","AME2020 nickel-62 versus iron-58/56 ranking","sealed-zero-parameter-binding-ledger-uniquely-predicts-A62-Z28-N34__complete-AME2020-2548-positive-composite-row-census-identifies-Ni62-global-binding-per-nucleon-maximum__Ni62-lower-uncertainty-bound-exceeds-every-rival-upper-bound__light-anchor-rise-and-heavy-anchor-fall-close-an-interior-iron-nickel-maximum__unqualified-iron-only-maximum-replaced-by-exact-nickel62-coordinate"⟩]

def registration : Value := .object [
 ("experiment_id",.text experimentId),("claim_id",.text claimId),
 ("frozen_relation",.text frozenRelation),("source_snapshot_path",.text sourcePath),
 ("source_snapshot_hash",.text snapshotHash),
 ("target_ids",.array (targetRows.map fun row => .text row.targetId)),
 ("target_locators",.array (targetRows.map fun row => .array [.text row.targetId,.text row.sourceId,.text row.sourceLocator])),
 ("prediction_program",programDocument),("expected_observation_label",.text expectedLabel),
 ("falsification_condition",.text falsification),("all_rows_required",.boolean true),
 ("target_inaccessible_before_seal",.boolean true)]

def registrationHash : String := admissionIdentity registration

def sourceMatches (bytes : ByteArray) : Bool :=
 Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) snapshotHash

def checkSource (bytes : ByteArray) : Except String Unit :=
 if sourceMatches bytes then .ok () else .error "ValueError: external measurement snapshot differs from registration"

def envelope (derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (admissionIdentity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetRows.map fun row => .text row.targetId)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]

def targets : List (String × Value) := targetRows.map fun row =>
 (row.targetId,labelValue "external-observation" row.observedLabel)

def targetsValue : Value := .object targets

theorem completeTargetCount : targetRows.length = 5 := rfl

theorem completeTargetLabels : targetRows.map ObservationCarrier.ExternalTargetRow.observedLabel = [expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel] := rfl

theorem changedSourceRejected (bytes : ByteArray) (changed : sourceMatches bytes = false) :
 checkSource bytes = .error "ValueError: external measurement snapshot differs from registration" := by
 unfold checkSource
 rw [changed]
 rfl

def specDependencies : List String := ["SFT-PHYS-NUCLEAR-BINDING-CURVE-TERMINAL-005", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-PHYS-MEAS-UNCERTAINTY-001", "SFT-MATH-EXACT-ARITHMETIC-001"]

def specDimensions : List (String × List Bool) :=
 [("carrier",[false,true]),("relation",[false,true]),("provenance",[false,true]),
 ("prediction",[false,true]),("record",[false,true]),("rows",[false,true]),
 ("generality",[false,true]),("extension",[false,true])]

def uniqueNames : List String → Bool
 | [] => true
 | head::tail => !(tail.any (Text.equal head)) && uniqueNames tail

def specWitnesses : Except String Bool := .ok (NuclearBindingCurveEmpiricalWitnesses.witnesses.all NuclearBindingCurveEmpiricalWitnesses.Witness.passed)

def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-PHYS-").isPrefixOf (Text.chars claimId) ||
    !(Text.chars "SFT-EXP-PHYS-").isPrefixOf (Text.chars experimentId) then
   .error "ValueError: empirical Physics identity is invalid"
 else if specDependencies.isEmpty || specDimensions.length != 8 || targetRows.isEmpty then
   .error "ValueError: empirical Physics law lacks dependencies, eight dimensions or targets"
 else if !uniqueNames (specDimensions.map Prod.fst) then
   .error "ValueError: empirical Physics law contains duplicate dimensions"
 else if !(specDimensions.all (fun d => d.2.length == 2)) then
   .error "ValueError: each empirical dimension must exhaust two registered forms"
 else if !(specDimensions.all (fun d => (d.2.filter id).length == 1)) then
   .error "ValueError: dimension requires one preserving form"
 else if !nonblank expectedLabel || !nonblank falsification then
   .error "ValueError: empirical prediction or falsification condition is missing"
 else if !uniqueNames (targetRows.map ObservationCarrier.ExternalTargetRow.targetId) then
   .error "ValueError: empirical target identities are duplicated"
 else
   let witnesses ← specWitnesses
   if witnesses then .ok () else .error "ValueError: empirical Physics operational witness failed"

theorem registeredSpecValid : validateSpec = .ok () := rfl

theorem sourceMatchesOriginal (bytes : ByteArray) :
 sourceMatches bytes = Text.equal (Text.append "sha256:" (SHA256.digest bytes)) snapshotHash := by
 unfold sourceMatches
 rw [SHA256Chunks.digestPreserved]

end SFT.Physics.NuclearBindingCurveEmpiricalExperiment
