import SFT.Physics.LyapunovKSCorrespondenceCertificate
import SFT.Physics.CapabilityDocuments
import SFT.Physics.CapabilityExecution
namespace SFT.Physics.LyapunovPrediction
open SFT.Host SFT.Host.Canonical LyapunovKSCorrespondenceCertificate LeptonIntervals
set_option maxRecDepth 20000
def formalPredictionInputs : Except String (List (String × CapabilityValues.Value)) := do
 let c ← carrierCertificate
 if !(c.supportIsPower && c.localSeparationMultiplier && c.commonCarrier) then throw "formal carrier certificate failed"
 pure [("domain_relation",.label (← CapabilityValues.heldLabel "rate-domain" "complete-generated-positive-m-label-support")),("separation_relation",.label (← CapabilityValues.heldLabel "separation-growth" "one-Fold-step-multiplies-by-m")),("support_relation",.label (← CapabilityValues.heldLabel "support-growth" "one-depth-successor-multiplies-by-m")),("carrier_relation",.label (← CapabilityValues.heldLabel "common-carrier" "same-generated-m-for-expansion-and-information")),("analytic_relation",.label (← CapabilityValues.heldLabel "analytic-boundary" "external-symbolic-correspondence-only")),("scope_relation",.label (← CapabilityValues.heldLabel "entropy-correspondence" "retain-source-hypotheses"))]
def experimentId : String := "SFT-EXP-PHYS-LYAPUNOV-KS-CORRESPONDENCE-TERMINAL-008"
def predictionProgram : Except String CapabilityAdmission.Program := do
 let keys := (← formalPredictionInputs).map Prod.fst
 pure ⟨Text.append experimentId "-exact-prediction",keys.map (fun key => ⟨.input,key,[key]⟩) ++ [⟨.word,"prediction",keys⟩,⟨.emit,"",["prediction"]⟩]⟩
def predictionProgramDocument : Except String Value := do
 let program ← predictionProgram
 pure (.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))])
def outputMapping (output : CapabilityValues.Value) (orderedKeys : List String) : Except String (List (String × CapabilityValues.Value)) :=
 match output with
 | .word cells => if cells.length != orderedKeys.length then .error "PH2 prediction has wrong Fold shape" else .ok (orderedKeys.zip cells)
 | .emptyOne _ => .error "PH2 prediction has wrong Fold shape"
 | .count _ => .error "PH2 prediction has wrong Fold shape"
 | .ratio _ _ => .error "PH2 prediction has wrong Fold shape"
 | .label _ => .error "PH2 prediction has wrong Fold shape"
 | .pair _ _ => .error "PH2 prediction has wrong Fold shape"
 | .table _ => .error "PH2 prediction has wrong Fold shape"
end SFT.Physics.LyapunovPrediction
