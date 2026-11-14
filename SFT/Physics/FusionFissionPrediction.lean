import SFT.Physics.FusionFissionTerminalProofs
import SFT.Physics.CapabilityDocuments
import SFT.Physics.CapabilityExecution
namespace SFT.Physics.FusionFissionPrediction
open SFT.Host SFT.Host.Canonical FusionFissionTerminal LeptonIntervals
set_option maxRecDepth 20000
def positiveRatio (q : Rat) : Except String CapabilityValues.Value := do
 if !zero.blt q then throw "a formal prediction ratio must remain positive"
 let n ← CapabilityValues.count q.num.toNat
 let d ← CapabilityValues.count q.den
 pure (.ratio n d)
def countValue (n : Nat) : Except String CapabilityValues.Value := do pure (.count (← CapabilityValues.count n))
def formalPredictionInputs : Except String (List (String × CapabilityValues.Value)) := do
 let fusion ← fusionTrace "binary-junction"
 let fission ← fissionTrace "binary-decomposition"
 let peak := NuclearBindingPeakClosure.originalCertificate
 let d ← NuclearBindingRadius.bindingScoreEnclosure (.integer 2) (.integer 1) (.integer 16)
 let h ← NuclearBindingRadius.bindingScoreEnclosure (.integer 4) (.integer 2) (.integer 16)
 let u ← NuclearBindingRadius.bindingScoreEnclosure (.integer 238) (.integer 92) (.integer 16)
 let p ← NuclearBindingRadius.bindingScoreEnclosure (.integer 119) (.integer 46) (.integer 16)
 let fg ← bindingGainEnclosure fusion
 let sg ← bindingGainEnclosure fission
 let (fg,sg) ← match fg,sg with
  | none,_ => .error "formal fusion/fission prediction lacks a positive gain"
  | some _,none => .error "formal fusion/fission prediction lacks a positive gain"
  | some a,some b => .ok (a,b)
 let half := SFT.Foundation.HalfOneDerivation.halfOne
 let barrier := normalize (.ofNat half.numerator) half.denominator (SFT.Foundation.ExactPartCarrier.denominatorPositive half)
 let direction ← CapabilityValues.heldLabel "binding-order" "toward-higher-binding"
 let release ← CapabilityValues.heldLabel "mass-energy-accounting" "complete-held-positive-release"
 pure [("fusion_incident_mass",← countValue 2),("fusion_incident_charge",← countValue 1),("fusion_incident_multiplicity",← countValue 2),("fusion_product_mass",← countValue 4),("fusion_product_charge",← countValue 2),("fusion_incident_score_upper",← positiveRatio d.2),("fusion_product_score_lower",← positiveRatio h.1),("fusion_total_gain_lower",← positiveRatio fg.1),("fission_parent_mass",← countValue 238),("fission_parent_charge",← countValue 92),("fission_product_mass",← countValue 119),("fission_product_charge",← countValue 46),("fission_product_multiplicity",← countValue 2),("fission_parent_score_upper",← positiveRatio u.2),("fission_product_score_lower",← positiveRatio p.1),("fission_total_gain_lower",← positiveRatio sg.1),("peak_mass",← countValue peak.massNumber),("peak_charge",← countValue peak.chargeCount),("peak_neutron",← countValue peak.neutronCount),("normalized_barrier",← positiveRatio barrier),("binding_direction",.label direction),("release_record",.label release)]
def experimentId : String := "SFT-EXP-PHYS-NUCLEAR-FUSION-FISSION-TERMINAL-005"
def predictionProgram : Except String CapabilityAdmission.Program := do
 let keys := (← formalPredictionInputs).map Prod.fst
 pure ⟨Text.append experimentId "-exact-prediction",keys.map (fun key => ⟨.input,key,[key]⟩) ++ [⟨.word,"prediction",keys⟩,⟨.emit,"",["prediction"]⟩]⟩
def predictionProgramDocument : Except String Value := do
 let program ← predictionProgram
 pure (.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))])
def outputMapping (output : CapabilityValues.Value) (orderedKeys : List String) : Except String (List (String × CapabilityValues.Value)) :=
 match output with
 | .word cells => if cells.length != orderedKeys.length then .error "fusion/fission prediction output has the wrong exact Fold shape" else .ok (orderedKeys.zip cells)
 | .emptyOne _ => .error "fusion/fission prediction output has the wrong exact Fold shape"
 | .count _ => .error "fusion/fission prediction output has the wrong exact Fold shape"
 | .ratio _ _ => .error "fusion/fission prediction output has the wrong exact Fold shape"
 | .label _ => .error "fusion/fission prediction output has the wrong exact Fold shape"
 | .pair _ _ => .error "fusion/fission prediction output has the wrong exact Fold shape"
 | .table _ => .error "fusion/fission prediction output has the wrong exact Fold shape"
end SFT.Physics.FusionFissionPrediction
