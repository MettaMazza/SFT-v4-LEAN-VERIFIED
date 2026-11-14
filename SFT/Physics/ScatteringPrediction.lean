import SFT.Physics.ScatteringRutherfordComptonProofs
import SFT.Physics.CapabilityDocuments
import SFT.Physics.CapabilityExecution
namespace SFT.Physics.ScatteringPrediction
open SFT.Host SFT.Host.Canonical ScatteringRutherfordCompton LeptonIntervals
set_option maxRecDepth 20000
def positiveRatio (q : Rat) : Except String CapabilityValues.Value := do
 if q.num < 1 then throw "scattering prediction input must remain exact and positive"
 let n ← CapabilityValues.count q.num.toNat
 let d ← CapabilityValues.count q.den
 pure (.ratio n d)
def formalPredictionInputs : Except String (List (String × CapabilityValues.Value)) := do
 let c ← formalCertificate
 let angular ← [0,1,2,3].mapM (fun n => LeptonRatios.atIndex c.angularDensity n)
 let shifts ← [0,1,2,3].mapM (fun n => LeptonRatios.atIndex c.photonShifts n)
 let angularInputs ← ([("coulomb_part_one_quarter",0),("coulomb_part_one_half",1),("coulomb_part_three_quarters",2),("coulomb_part_one",3)] : List (String × Nat)).mapM (fun (key,n) => do pure (key,← positiveRatio (← LeptonRatios.atIndex angular n).2))
 let shiftInputs ← ([("shift_one_quarter",0),("shift_one_half",1),("shift_three_quarters",2),("shift_one",3)] : List (String × Nat)).mapM (fun (key,n) => do pure (key,← positiveRatio (← LeptonRatios.atIndex shifts n).2))
 pure (angularInputs ++ [("charge_doubling",← positiveRatio c.chargeDoublingRatio),("energy_doubling",← positiveRatio c.energyDoublingRatio)] ++ shiftInputs ++ [("right_angle_ceiling",← positiveRatio c.rightAngleCeiling),("backscatter_ceiling",← positiveRatio c.backscatterCeiling),("forward_transfer",.label (← CapabilityValues.heldLabel "direction-transfer" "structural-empty-form")),("rutherford_scope",.label (← CapabilityValues.heldLabel "scattering-scope" "coulomb-point-boundary")),("compton_scope",.label (← CapabilityValues.heldLabel "scattering-scope" "free-held-electron-closed-transfer"))])
def experimentId : String := "SFT-EXP-PHYS-SCATTERING-RUTHERFORD-COMPTON-TERMINAL-006"
def predictionProgram : Except String CapabilityAdmission.Program := do
 let keys := (← formalPredictionInputs).map Prod.fst
 pure ⟨Text.append experimentId "-exact-prediction",keys.map (fun key => ⟨.input,key,[key]⟩) ++ [⟨.word,"prediction",keys⟩,⟨.emit,"",["prediction"]⟩]⟩
def predictionProgramDocument : Except String Value := do
 let program ← predictionProgram
 pure (.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))])
def outputMapping (output : CapabilityValues.Value) (orderedKeys : List String) : Except String (List (String × CapabilityValues.Value)) :=
 match output with
 | .word cells => if cells.length != orderedKeys.length then .error "scattering prediction has the wrong exact Fold shape" else .ok (orderedKeys.zip cells)
 | .emptyOne _ => .error "scattering prediction has the wrong exact Fold shape"
 | .count _ => .error "scattering prediction has the wrong exact Fold shape"
 | .ratio _ _ => .error "scattering prediction has the wrong exact Fold shape"
 | .label _ => .error "scattering prediction has the wrong exact Fold shape"
 | .pair _ _ => .error "scattering prediction has the wrong exact Fold shape"
 | .table _ => .error "scattering prediction has the wrong exact Fold shape"
end SFT.Physics.ScatteringPrediction
