import SFT.Physics.QuadrupoleRadiatedPowerCertificate
import SFT.Physics.CapabilityDocuments
import SFT.Physics.CapabilityExecution
namespace SFT.Physics.QuadrupolePrediction
open SFT.Host SFT.Host.Canonical QuadrupoleRadiatedPowerCertificate
set_option maxRecDepth 20000
def formalPredictionInputs : Except String (List (String × CapabilityValues.Value)) := do
 pure [("moment_relation",.label (← CapabilityValues.heldLabel "radiative-moment" "held-monopole-and-dipole-leave-quadrupole-first")),("rate_relation",.label (← CapabilityValues.heldLabel "radiative-rate" "third-generated-quadrupole-difference")),("energy_relation",.label (← CapabilityValues.heldLabel "radiative-energy" "positive-third-rate-square")),("coupling_relation",.label (← CapabilityValues.heldLabel "radiative-coupling" "binary-half-One")),("static_relation",.label (← CapabilityValues.heldLabel "static-control" "empty-radiation-record")),("scaling_relation",.label (← CapabilityValues.heldLabel "amplitude-control" "power-scales-as-rate-paired-with-itself")),("shell_relation",.label (← CapabilityValues.heldLabel "outward-transport" "rank-two-density-retains-total-power"))]
def experimentId : String := "SFT-EXP-PHYS-QUADRUPOLE-RADIATED-POWER-TERMINAL-012"
def predictionProgram : Except String CapabilityAdmission.Program := do
 let keys := (← formalPredictionInputs).map Prod.fst
 pure ⟨Text.append experimentId "-exact-prediction",keys.map (fun key => ⟨.input,key,[key]⟩) ++ [⟨.word,"prediction",keys⟩,⟨.emit,"",["prediction"]⟩]⟩
def predictionProgramDocument : Except String Value := do
 let program ← predictionProgram
 pure (.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))])
def outputMapping (output : CapabilityValues.Value) (orderedKeys : List String) : Except String (List (String × CapabilityValues.Value)) :=
 match output with
 | .word cells => if cells.length != orderedKeys.length then .error "D9q prediction shape changed" else .ok (orderedKeys.zip cells)
 | .emptyOne _ => .error "D9q prediction shape changed"
 | .count _ => .error "D9q prediction shape changed"
 | .ratio _ _ => .error "D9q prediction shape changed"
 | .label _ => .error "D9q prediction shape changed"
 | .pair _ _ => .error "D9q prediction shape changed"
 | .table _ => .error "D9q prediction shape changed"
end SFT.Physics.QuadrupolePrediction
